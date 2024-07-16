import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logitrack/modules/user/screens/auth_service/Loggin_screen.dart';
import 'package:logitrack/modules/user/screens/pages/bottom_bar.dart';
import 'package:logitrack/modules/user/screens/splash_screen/splash.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/utils/strings.dart';
import 'package:logitrack/utils/toast.dart';

import 'package:provider/provider.dart';

class Checkuserhere extends StatelessWidget {
  const Checkuserhere({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SplashScreenUser()),
            (route) => false);
      } else {
        Provider.of<FirebaseController>(context, listen: false)
            .fetchSelectedUSerdata(
          auth.currentUser!.uid,
        )
            .then((value) {
          if (value == true) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => BottomnavUser(
                          selectedindex: 0,
                        )),
                (route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LogginScreenUser()),
                (route) => false);

            succestoast(context, 'loggin expered');
          }
        });
      }
    });

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
