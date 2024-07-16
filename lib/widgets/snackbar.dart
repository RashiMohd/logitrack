import 'package:flutter/material.dart';
 
showLoadingIndicator(context, String data) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            data,
          ),
          const SizedBox(
            width: 20,
          ),
          const CircularProgressIndicator(
            color: Color.fromRGBO(97, 139, 255, 1),
          ),
        ],
      ),
    ),
  );
}

// class ReusableToast {
//   static void showToast(
//     BuildContext context,
//     String message, {
//     double fontSize = 16.0,
//     Color backgroundColor = Colors.red,
//     Color textColor = Colors.white,
//   }) async {
//     // Ensure context is available (consider using a global navigation key if needed)
//     if (context == null) return; // Handle null context gracefully

//     await Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER, // Consider customizing gravity if needed
//       timeInSecForIosWeb: 1,
//       backgroundColor: backgroundColor,
//       textColor: textColor,
//       fontSize: fontSize,
//     );
//   }
// }
