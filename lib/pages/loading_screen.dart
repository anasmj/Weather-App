import 'package:flutter/material.dart';
import 'package:app/services/weather_details.dart';

class Loading extends StatefulWidget{
  final String location;
  Loading({required this.location});

  State<StatefulWidget> createState (){
    return LoadingState(location: this.location);
  }
}
class LoadingState extends State<Loading>{
  LoadingState({required this.location});
  bool readyToDisplayData = false ;
  String location;
  String displayText = 'loading..';

  void setupWeatherData() async {
    WeatherDetails currentWeatherDetails = WeatherDetails(givenLocation: location); ///Given location should match apiLocation attribute in 'WeatherDetails' class
    try{
      await currentWeatherDetails.loadData();
      if(currentWeatherDetails.dataFetched) {
        readyToDisplayData = true;
        Navigator.pushReplacementNamed(context, '/home', arguments: {
          'apiGivenLocation': currentWeatherDetails.apiGivenLocation,
          'weatherMain': currentWeatherDetails.weatherMain,
          'weatherDescription': currentWeatherDetails.weatherDescription,
          'temp': currentWeatherDetails.temp,
          'windSpeed': currentWeatherDetails.windSpeed,
          'cloud': currentWeatherDetails.cloud,
          'humidity': currentWeatherDetails.humidity,
          'pressure': currentWeatherDetails.pressure,

          'CO' : currentWeatherDetails.CO,
          'NO' : currentWeatherDetails.NO,
          'NO2' : currentWeatherDetails.NO2,
          'O3' : currentWeatherDetails.O3,
          'SO2' : currentWeatherDetails.SO2,
          'NH3' : currentWeatherDetails.NH3,
        });
        print(currentWeatherDetails.NH3);

      }
      else {
        setState(() {
          displayText = 'Location is not found\nPlease go back and try again';
        });
      }
      readyToDisplayData = true;
    }catch(e){
       setState(() {
         displayText = 'Location is not found\nPlease go back and try again';
       });
    }
  }

  void initState(){
    try{
      setupWeatherData();
    }catch(e){
      setState(() {
        displayText = 'could not fetch data from $location';
      });
    }
    super.initState();
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Loading(location: 'Bangladesh',),
              ),
            );
          },
            icon: Icon(Icons.arrow_back)
        ),
      ),
        backgroundColor: Theme.of(context).backgroundColor,
        body:Center(
          child: Text(displayText),
        ),
    );
  }
}


