import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:app/pages/widgets/search_bar.dart';
import 'package:app/pages/loading_screen.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  Map data = {};

  double minLeftPadding = 20;
  double minTopPadding = 30;
  double titleFontSize = 18.0;
  double infoFontSize = 30.0;
  String _location = '-';
  String _weatherMain = '-';
  String _temp = '-';
  String _windSpeed = '-';

  String _cloudStatus = '-';
  String _humidity = '-';
  String _pressure = '-';
  String _CO = '-', _NO = '-', _NO2 = '-', _O3 = '-', _SO2 = '-', _NH3 = '-';

  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    data =
        data.isEmpty ? ModalRoute.of(context)!.settings.arguments as Map : data;
    _location = data['apiGivenLocation'];
    _weatherMain = data['weatherMain'] == 'Clouds' ? 'Cloudy' : 'Cloudy';

    /// convert m/s to km/h
    _windSpeed = (double.parse(data['windSpeed']) * 3.6).toStringAsFixed(2);
    _temp = ((double.parse(data['temp']) - 273)).toStringAsFixed(1);
    _cloudStatus = data['cloud'];
    _humidity = data['humidity'];
    _pressure = data['pressure'];

    _CO = data['CO'];
    _NO = data['NO'];
    _NO2 = data['NO2'];
    _O3 = data['O3'];
    _SO2 = data['SO2'];
    _NH3 = data['NH3'];

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        /// full container
        color: Theme.of(context).primaryColor,
        //color: Theme.of(context).backgroundColor,
        child: ListView(
          children: [
            SizedBox(
              height: 3.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Weather Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 82),
                Text(
                  _location,
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                    onPressed: () async {
                      final String newLocation = (await showSearch(
                          context: context, delegate: SearchBar()))!;
                      if (newLocation.isNotEmpty) {
                        if (SearchBar.existInSearchList) {
                          replacePage(newLocation);
                        } else {
                          tryUnknownLocation(newLocation);
                        }
                      }
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.white,
                    )),
              ],
            ),
            Container(
              ///1st container that holds upper part
              padding: EdgeInsets.only(
                left: 12.0,
                top: 0,
                right: 12.0,
                bottom: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      weatherWidget(screenHeight, screenWidth),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          tempWidget(screenHeight, screenWidth),
                          SizedBox(
                            height: 20,
                          ),
                          cloudinessWidget(screenHeight, screenWidth),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: screenWidth * 1,
                    margin: EdgeInsets.only(top: 12.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Theme.of(context).primaryColorDark, Colors.blue],),
                      //color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Air Pollution',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Table(
                          children: [
                            TableRow(children: [
                              makeTitle('Carbon Monoxide(CO)'),
                              Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  _CO,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ]),
                            TableRow(children: [
                              makeTitle('Nitric Oxide (NO)'),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    _NO,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ]),
                            TableRow(children: [
                              makeTitle('Nitrogen Dioxide (NO2)'),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    _NO2,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ]),
                            TableRow(children: [
                              makeTitle('Ozone (O3)'),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    _O3,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ]),
                            TableRow(children: [
                              makeTitle('Sulfur Dioxide (SO2)'),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    _SO2,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ]),
                            TableRow(children: [
                              makeTitle('Ammonia (NH3)'),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    _NH3,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void replacePage(String newLocation) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Loading(location: newLocation),
      ),
    );
  }

  void pushPage(String newLocation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Loading(location: newLocation),
      ),
    );
  }

  void tryUnknownLocation(String newLocation) {
    String s = newLocation.toLowerCase();
    s = s[0].toUpperCase() + s.substring(1);
    print(s);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Loading(location: s),
      ),
    );
  }

  Widget weatherWidget(
    double screenHeight,
    double screenWidth,
  ) {
    DateTime dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
    String dateTodayString = dateToday.toString();
    dateTodayString = dateTodayString.substring(0,10);
    print(dateTodayString);

    double titleFontSize = 18.0;
    return Container(
      padding: EdgeInsets.only(left: minLeftPadding, top: minTopPadding),
      decoration: BoxDecoration(
        //color: Theme.of(context).primaryColorDark,
          gradient: LinearGradient(
              colors: [Theme.of(context).primaryColorDark, Colors.blue],
            begin: Alignment(-1.0, -2.0),
            end: Alignment(1.0, 2.0),
          ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      //width: 180,
      width: screenWidth * 0.5,
      height: screenHeight * 0.6,
      //height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            ///current time
            children: [
              Text(
                'Today, $dateTodayString',
                style: TextStyle(
                  fontSize: titleFontSize,
                ),
              ),
            ],
          ),
          Text(
            _weatherMain,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            thickness: 2,
            color: Colors.white,
            indent: 20,
            endIndent: 40,
          ),
          SizedBox(height: 15),
          makeTitle('Wind'),
          showInfo(_windSpeed, ' Kph'),
          SizedBox(height: 20),
          makeTitle('Humidity'),
          showInfo(_humidity, ' %'),
          SizedBox(height: 20),
          makeTitle('Pressure'),
          showInfo(_pressure, ' hPa'),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Divider(
            thickness: 2,
            color: Colors.white,
            indent: 50,
            endIndent: 80,
          ),
        ],
      ),
    );
  }

  Widget tempWidget(double screenHeight, double screenWidth) {
    return Container(
      padding: EdgeInsets.only(left: minLeftPadding, top: minTopPadding),
      decoration: BoxDecoration(

        //color: Colors.deepOrangeAccent,
        borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: 25.0 > double.parse(_temp) ? LinearGradient(colors: [Colors.lightBlue, Colors.white60])  : LinearGradient(colors: [Colors.red, Colors.orange])
      ),
      height: screenHeight * .23,
      width: screenWidth * .36,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Temp',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text('$_temp° C',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          const Divider(
            thickness: 2,
            color: Colors.white,
            indent: 30,
            endIndent: 50,
          ),
        ],
      ),
    );
  }

  Widget cloudinessWidget(double screenHeight, double screenWidth) {
    return Container(
      padding: EdgeInsets.only(left: minLeftPadding, top: minTopPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      width: screenWidth * .36,
      height: screenHeight * .33,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          makeTitle('Cloudiness'),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                  text: _cloudStatus,
                  style: const TextStyle(
                      fontSize: 48.0, fontWeight: FontWeight.bold)),
              TextSpan(text: ' %', style: const TextStyle(fontSize: 22.0))
            ],
          )),
          makeTitle(measureCloudiness(_cloudStatus)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const Divider(
            thickness: 2,
            color: Colors.white,
            indent: 28,
            endIndent: 42,
          ),
        ],
      ),
    );
  }

  Widget makeTitle(String text) {
    double titleFontSize = 16.0;
    return Text(
      text,
      style: TextStyle(
        fontSize: titleFontSize,
      ),
    );
  }

  Widget showInfo(String info, String unit) {
    //double bodyFontSize = 30.0;
    return RichText(
        text: TextSpan(
      children: [
        TextSpan(
            text: info,
            style:
                const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
        TextSpan(text: unit, style: TextStyle(fontSize: 18.0))
      ],
    ));
  }

  String measureCloudiness(String cloud) {
    double cloudiness = double.parse(cloud);
    if (cloudiness > 0 && cloudiness <= 20) {
      return 'Clear';
    } else if (cloudiness > 20 && cloudiness <= 40) {
      return 'Low';
    } else if (cloudiness > 40 && cloudiness <= 60) {
      return 'Moderate';
    } else if (cloudiness > 60 && cloudiness <= 80) {
      return 'Grey';
    } else if (cloudiness > 40 && cloudiness <= 60) {
      return 'Dull';
    } else
      return 'Dark';
  }
}
