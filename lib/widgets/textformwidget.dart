import 'package:flutter/material.dart';
import 'package:logitrack/utils/colors.dart';
import 'package:logitrack/utils/responsivesize.dart';

class Textformwidget extends StatelessWidget {
  final String? hint;
  final double radius;
  final TextEditingController controller;
  String? Function(String?)? validator;
  final IconButton? suffix;
  final bool? obscure;
  Textformwidget({
    super.key,
    required this.validator,
    this.hint,
    required this.radius,
    required this.controller,
    this.suffix,
    this.obscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure ?? false,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffix,
        contentPadding: EdgeInsets.all(
          Helper.W(context) * .010,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(Helper.W(context) * .020),
          borderSide: BorderSide(
            color: ColorsClass.SplashScreenbg,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(Helper.W(context) * .020),
          borderSide: BorderSide(
            color: ColorsClass.SplashScreenbg,
            width: 1.0,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
