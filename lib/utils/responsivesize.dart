import 'package:flutter/material.dart';

class Helper {
  static double W(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double H(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenRatio(BuildContext context) {
    return W(context) / H(context);
  }
}
