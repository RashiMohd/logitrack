import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle regularText({
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color ?? Colors.black,
    );
  }

  static TextStyle boldText({Color? color, double? fontSize}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }
}
