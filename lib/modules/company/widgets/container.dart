 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/colors.dart';
 

class ContainerWidget extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final String text;
  final Color color;

  final double? textsize;
  const ContainerWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.text,
      required this.radius,
      this.textsize, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius)),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.heebo(
            fontSize: textsize,
            color: ColorsClass.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
