import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherDetails {
  bool dataFetched = false;
  String givenLocation;
  String apiGivenLocation = '-';
  String lat = '-';
  String lon = '-';
  String weatherMain = '-';
  String weatherDescription = '-';
  String icon = '-';
  String temp = '-';
  String humidity = '-';
  String pressure = '-';
  String feelsLike = '-';
  String windSpeed = '-';
  String cloud = '-';
  String name = '-';

  String NO = '-', NO2 = '-',O3= '-',SO2 = '-',NH3 = '-';
  var CO;
  String _apiKey = '8c9b30bf9341117c2a9a15c7546b2be0';

  WeatherDetails({required this.givenLocation});

  Future<void> loadData() async{
    Map map = {};

    var response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$givenLocation&appid=$_apiKey'));
    map = jsonDecode(response.body);





    apiGivenLocation = map['name'];
    lat = map['coord']['lat'].toString();
    lon = map['coord']['lon'].toString();
    weatherMain = map['weather'][0]['main'];
    weatherDescription = map['weather'][0]['description'];
    icon = map['weather'][0]['icon'];
    temp = map['main']['temp'].toString(); //F
    feelsLike = map['main']['feels_like'].toString();
    humidity = map['main']['humidity'].toString(); //%
    pressure = map['main']['pressure'].toString(); //hPa
    windSpeed = map['wind']['speed'].toString(); //m/s
    cloud = map['clouds']['all'].toString(); //%

    var airQualityResponse = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=$lat&lon=$lon&appid=$_apiKey'));
    Map airQualityMap = jsonDecode(airQualityResponse.body);

    CO = airQualityMap['list'][0]['components']['co'].toString();
    NO = airQualityMap['list'][0]['components']['no'].toString();
    NO2= airQualityMap['list'][0]['components']['no2'].toString();
    O3 = airQualityMap['list'][0]['components']['o3'].toString();
    SO2= airQualityMap['list'][0]['components']['so2'].toString();
    NH3= airQualityMap['list'][0]['components']['nh3'].toString();
    print(NH3);
    if(map['name']== this.givenLocation){
      dataFetched = true;
    }
  }
}
