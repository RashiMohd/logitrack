import 'package:flutter/material.dart';
import 'package:logitrack/utils/responsivesize.dart';

// class BorderNoneetextformwidget extends StatelessWidget {

Widget BorderNoneetextformwidget({
  required TextEditingController controller,
  required BuildContext context,
  String? initialvalue,
}) {
  return TextFormField(
    initialValue: initialvalue,
    controller: controller,
    decoration: InputDecoration(
      fillColor: Colors.blue.shade50,
      filled: true,
      contentPadding: EdgeInsets.all(Helper.W(context) * .010),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
  );
}
