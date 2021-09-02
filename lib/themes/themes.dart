import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier{
  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme?  ThemeMode.dark: ThemeMode.light;

  void toggleTheme(){
    _isDarkTheme =! _isDarkTheme;
    notifyListeners();
  }
  static ThemeData get lightTheme{
    return ThemeData(
      primaryColor: Colors.lightBlue,
      accentColor: Colors.black,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme (
        headline1: TextStyle(color: Colors.white, fontSize: 22.0),
        //headline2: TextStyle(color: Colors.grey),
        //bodyText1: TextStyle(color: Colors.white),
        //bodyText2: TextStyle(color: Colors.grey),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.grey,
        backgroundColor: Colors.grey,
        scaffoldBackgroundColor: Colors.grey,
        // textTheme: TextTheme(
        //   headline1: TextStyle(color: Colors.black),
        //   headline2: TextStyle(color: Colors.black),
        //   bodyText1: TextStyle(color: Colors.black),
        //   bodyText2: TextStyle(color: Colors.black),
        // )
    );
  }
}