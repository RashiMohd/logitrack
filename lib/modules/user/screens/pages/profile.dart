import 'package:flutter/material.dart';
import 'package:logitrack/app.dart';
import 'package:logitrack/modules/user/screens/auth_service/Loggin_screen.dart';
import 'package:logitrack/modules/user/screens/pages/routes/profile/adresspage.dart';

import 'package:logitrack/modules/user/screens/pages/routes/profile/language.dart';
import 'package:logitrack/modules/user/screens/pages/routes/profile/notification.dart';
import 'package:logitrack/modules/user/screens/pages/routes/profile/payment.dart';
import 'package:logitrack/modules/user/screens/pages/routes/profile/profileedit.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/services/user_controller.dart';

import 'package:logitrack/utils/colors.dart';
import 'package:logitrack/utils/responsivesize.dart';
import 'package:logitrack/utils/strings.dart';
import 'package:logitrack/utils/toast.dart';
import 'package:logitrack/widgets/shimmer.dart';
import 'package:logitrack/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    void alertboxopen(BuildContext context) async {
      return showDialog(
        builder: (context) => AlertDialog(
          content: Text('Are you sure logout'),
          title: Text('Logout'),
          actions: [
            InkWell(
              onTap: () {
                Provider.of<FirebaseController>(context, listen: false)
                    .logout(context)
                    .then((value) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Userprf()),
                      (route) => false);
                });

                succestoast(context, 'logout succes ');
              },
              child: Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                ),
                child: Text('YES'),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey,
              ),
              child: Text('NO'),
            ),
          ],
        ),
        context: context,
      );
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Consumer<FirebaseController>(
            builder: (context, instance, _) {
              return FutureBuilder(
                future: instance.fetchSelectedUSerdata(auth.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return shimmerEffect(
                        child: Row(
                      children: [
                        SizedBox(
                          height: 200,
                        ),
                        Container(
                          height: Helper.H(context) * .01,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        shimmerPlaceholder(
                            height: height * .01, width: width * .5),
                      ],
                    ));
                  }

                  // final data = firecontroller.selectedUserData;
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: Helper.H(context) * .080,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: Helper.W(context) * .120,
                              backgroundImage:
                                  NetworkImage(instance.userModel!.imageurl),
                            ),
                          ],
                        ),
                      ),
                      Text(instance.userModel!.name),
                    ],
                  );
                },
              );
            },
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdressPage(),
                        ));
                  },
                ),
                // ListTile(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => NotificationScreen(),
                //         ));
                //   },
                //   leading: Icon(Icons.notifications_active),
                //   title: Text('notification'),
                // ),
                // // ListTile(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => PaymentUser(),
                //       ),
                //     );
                //   },
                //   leading: Icon(Icons.payment_outlined),
                //   title: Text('Payment'),
                // ),
                ListTile(
                  leading: Icon(Icons.security),
                  title: Text('Security'),
                ),
                // ListTile(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => Language(),
                //       ),
                //     );
                //   },
                //   leading: Icon(Icons.language),
                //   title: Text('Language'),
                // ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help Center'),
                ),
                ListTile(
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    alertboxopen(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
