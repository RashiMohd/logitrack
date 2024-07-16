import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle regularText({
    Color? color,
    double? fontSize,
    FontWeight? fontweight,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color ?? Colors.black,
      fontWeight: fontweight,
      
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


class TextWidget extends StatelessWidget {
  final String text;
  final TextStyle style;
  const TextWidget({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}


// TextStyle(
//                                         fontSize:
//                                             ResponsiveHelper.getWidth(context) *
//                                                 .050,
//                                         fontWeight: FontWeight.bold,
//                                       ),