import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var uId;

class MyColor {
  static Color red = Color.fromRGBO(255, 28, 39, 1);
  static Color white = Color.fromRGBO(255, 255, 255, 1);
  static Color black = Color.fromRGBO(5, 5, 5, 1);
}

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: MyColor.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 0.0,
    ),
    appBarTheme: AppBarTheme(actionsIconTheme:IconThemeData(color: Colors.black) ,
        titleTextStyle: TextStyle(color: Colors.black,fontSize: 30),
        color: MyColor.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: MyColor.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,statusBarColor: MyColor.white),
        backwardsCompatibility: false),
    inputDecorationTheme: InputDecorationTheme(
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.9)),
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
        focusColor: Colors.white,
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red))));
