import 'package:app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/loading_screen.dart';


void main() {
  runApp(WeatherApp());
}
class WeatherApp extends StatelessWidget{
  Widget build (BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
         //brightness: Brightness.dark,
         backgroundColor: Colors.lightBlue[300],
         textTheme: TextTheme(
            bodyText2: TextStyle(color: Colors.white),
           // bodyText1: TextStyle(color: Colors.white),
         ),
      ),
      //initialRoute: '/loading',
      debugShowCheckedModeBanner: false ,
      routes: {
        '/': (context) => Loading(location: 'Bangladesh',),
        '/home': (context) => HomePage(),
      },
    );
  }
}




