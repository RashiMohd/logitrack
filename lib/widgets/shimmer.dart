import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerEffect({required Widget child}) {
  return Shimmer.fromColors(
    baseColor: Colors.green.shade100,
    highlightColor: Colors.green.shade100,
    enabled: true,
    child: child,
  );
}

Container shimmerPlaceholder({double? height, double? width}) {
  return Container(
    color: Colors.white,
    height: height,
    width: width,
  );
}
