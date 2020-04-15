import 'package:covid_stats/ui/shared/colors.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool isDarkTheme;

  ThemeProvider({this.isDarkTheme});

  ThemeData get getThemeData => isDarkTheme ? darkTheme : lightTheme;

  set setThemeData(bool val) {
    if (val) {
      isDarkTheme = true;
    } else {
      isDarkTheme = false;
    }
    notifyListeners();
  }
}

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
//  primaryColor: Colors.black,
  primaryColor: darkColor,
  brightness: Brightness.dark,
//  backgroundColor: Color(0xFF000000),
  backgroundColor: darkColor,
  accentColor: Colors.white,
//  accentIconTheme: IconThemeData(color: Colors.black),
  accentIconTheme: IconThemeData(color: darkColor),
  dividerColor: Colors.black54,
  textTheme: TextTheme(
    body1: TextStyle(color: Colors.white)
  )
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
  textTheme: TextTheme(
    body1: TextStyle(),
    body2: TextStyle(),
  ).apply(
    bodyColor: Colors.black,
    displayColor: Colors.blue,
  ),
);