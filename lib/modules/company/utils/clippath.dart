
import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();
    path.lineTo(0, size.height);
    var firststart = Offset(size.width / 6, size.height);
    var firstend = Offset(size.width / 2.10, size.height - 30.0);

    path.quadraticBezierTo(
        firststart.dx, firststart.dy, firstend.dx, firstend.dy);

    var secondStart =
        Offset(size.width - (size.width / 25.24), size.height - 80);

    var secondEnd = Offset(size.width, size.height - 80);

    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy,);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
