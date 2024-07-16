import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';

succestoast(BuildContext context, msg) {
  return CherryToast.success(
          title: Text(msg, style: TextStyle(color: Colors.black)))
      .show(context);
}

warnintoast(BuildContext context, msg) {
  return CherryToast.warning(
    description: Text("All information may be deleted after this action",
        style: TextStyle(color: Colors.black)),
    action: Text("Backup data", style: TextStyle(color: Colors.black)),
    actionHandler: () {
      print("Hello World!!");
    },
  ).show(context);
}

errortoast(BuildContext context, String msg) {
  return CherryToast.error(
          description: Text(msg, style: TextStyle(color: Colors.black)),
          animationDuration: Duration(milliseconds: 1000),
          autoDismiss: true)
      .show(context);
}
