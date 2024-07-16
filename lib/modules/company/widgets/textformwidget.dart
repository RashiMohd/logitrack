import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/colors.dart';
import '../../../utils/responsivesize.dart';

class Textformwidget extends StatelessWidget {
  final String? hint;
  final double radius;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validation;
  final int? maxlenght;
  const Textformwidget({
    super.key,
    this.hint,
    required this.radius,
    this.controller,
    this.validation,
    this.maxlenght,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      inputFormatters: [LengthLimitingTextInputFormatter(maxlenght)],
      decoration: InputDecoration(
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
          borderRadius: BorderRadius.circular(Helper.W(context) * .020),
          borderSide: BorderSide(
            color: ColorsClass.SplashScreenbg,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Helper.W(context) * .020),
          borderSide: BorderSide(
            color: ColorsClass.SplashScreenbg,
            width: 1.0,
          ),
        ),
      ),
      validator: validation,
    );
  }
}
