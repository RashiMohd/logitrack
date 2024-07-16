import 'package:flutter/material.dart';

class ColorsClass {
  static Color SplashScreenbg = Color.fromRGBO(13, 71, 161, 1);
  static Color whiteColor = Color(0xFFFFFFFF);
  static Color redcolor = Color.fromRGBO(244, 67, 54, 1);

  //
  static Color SplashScreenbgdelivery = Color.fromRGBO(13, 71, 161, 1);
  
   static const Color blueshade = Color(0xFFD3EBF7);

  static Color selectedvehicle = Color.fromRGBO(0, 32, 63, 1);

  static Color greenColor = Color.fromRGBO(33, 216, 62, 1);

  static TextStyle appBarTitle(Color color, double fontsize) {
    return const TextStyle().copyWith(
      color: color,
      fontSize: fontsize,
      fontWeight: FontWeight.bold,
    );
  }
}
