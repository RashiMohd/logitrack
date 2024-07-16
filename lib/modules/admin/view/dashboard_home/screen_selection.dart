import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:logitrack/app.dart';
import 'package:logitrack/modules/admin/view/screens/aboutus.dart';
import 'package:logitrack/modules/admin/view/screens/company.dart';
import 'package:logitrack/modules/admin/view/screens/deliveryboys.dart';
import 'package:logitrack/modules/admin/view/screens/notification.dart';
import 'package:logitrack/modules/admin/view/screens/user.dart';

import '../screens/dashboard.dart';

class ScreenSelection extends StatelessWidget {
  final String selectedNavItem;

  const ScreenSelection({super.key, required this.selectedNavItem});

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (selectedNavItem == 'Dashboard') {
      content = dashboard(context);
    } else if (selectedNavItem == 'Company') {
      content = Companyscreen(context);
    } else if (selectedNavItem == 'Delivery Boys') {
      content = DeliveryBoys(context);
    } else if (selectedNavItem == 'Notification') {
      content = notification(context);
    } else if (selectedNavItem == 'About us') {
      content = aboutus(context);
    } else if (selectedNavItem == 'user') {
      content = userView(context);
    } else {
      content = AlertDialog(
        title: Text('Logout'),
        content: Text('admin logout .'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Navigator.of(context).pop();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Userprf(),
                  ),
                  (route) => false);
            },
            child: Text('OK'),
          ),
        ],
      );
    }

    return content;
  }
}
