import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logitrack/app.dart';
import 'package:logitrack/modules/deliveryboy/screens/auth_service/Loggin_screen.dart';
import 'package:logitrack/modules/deliveryboy/screens/pages/routes/profile/notification.dart';
import 'package:logitrack/modules/deliveryboy/screens/pages/routes/profile/profileedit.dart';
import 'package:logitrack/modules/deliveryboy/widgets/text_style.dart';
import 'package:logitrack/services/firebase_controller.dart';

import 'package:logitrack/utils/responsivesize.dart';
import 'package:logitrack/utils/toast.dart';
import 'package:logitrack/widgets/textwidget.dart';
import 'package:provider/provider.dart';

import '../../../../utils/strings.dart';

class Profiledelivery extends StatelessWidget {
  const Profiledelivery({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> Logoutdilog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Logout'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure logout'),
                ],
              ),
            ),
            actions: <Widget>[
              Consumer<FirebaseController>(
                builder: (context, instance, child) {
                  return TextButton(
                    child: const Text('logout'),
                    onPressed: () {
                      instance.logout(context).then(
                            (value) => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Userprf(),
                              ),
                              (route) => false,
                            ),
                          );
                      succestoast(context, 'Logout success');
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
              TextButton(
                child: const Text('no'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Consumer<FirebaseController>(
        builder: (context, instancedeli, child) {
          return FutureBuilder(
            future: instancedeli.fetchigdelivery(auth.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final dat = instancedeli.deliveryboy;

              log(snapshot.data.toString());
              return Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: Helper.H(context) * .080,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: Helper.W(context) * .100,
                              backgroundImage:
                                  AssetImage('assets/imagesdelivery/deliveryboy.png'),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        dat!.Name,
                        style: AppTextStyles.regularText(
                          fontSize: Helper.W(context) * .050,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Helper.H(context) * .060,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Helper.W(context) * .050,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileEditScreen(),
                              ),
                            );
                          },
                          leading: Icon(Icons.person),
                          title: Text('Edit profile'),
                        ),
                        ListTile(
                          leading: Icon(Icons.location_on_outlined),
                          title: Text('Adress'),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationScreen(),
                              ),
                            );
                          },
                          leading: Icon(Icons.notifications_active),
                          title: Text('notification'),
                        ),
                        ListTile(
                          leading: Icon(Icons.help),
                          title: Text('Help Center'),
                        ),
                        ListTile(
                          iconColor: Colors.red,
                          textColor: Colors.red,
                          leading: Icon(Icons.logout),
                          title: Text('Logout'),
                          onTap: () async => await Logoutdilog(),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          );
        }
      ),
    ));
  }
}
