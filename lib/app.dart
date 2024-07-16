import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logitrack/modules/admin/view/dashboard_home/add_company.dart';
import 'package:logitrack/modules/admin/view/dashboard_home/dashboard_home.dart';
import 'package:logitrack/modules/company/screens/auth_service/Loggin_screen.dart';
import 'package:logitrack/modules/company/screens/bottom_navbar.dart';
import 'package:logitrack/modules/company/widgets/text_style.dart';
import 'package:logitrack/modules/deliveryboy/screens/auth_service/Loggin_screen.dart';
import 'package:logitrack/modules/deliveryboy/screens/bottom_navbar.dart';
import 'package:logitrack/modules/user/screens/auth_service/checkuser.dart';
import 'package:logitrack/modules/user/screens/pages/routes/home/courier_services.dart';

import 'package:logitrack/services/controller.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/services/paymentcontroller.dart';
import 'package:logitrack/services/user_controller.dart';
import 'package:logitrack/utils/responsivesize.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => FirebaseController()),
        ChangeNotifierProvider(create: (_) => Controller()),
        ChangeNotifierProvider(create: (_) => PaymentController())
      ],
      child: MaterialApp(
        scrollBehavior:
            const MaterialScrollBehavior().copyWith(scrollbars: false),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: BottomnavCompany(
        //   selectedindex: 0,
        // )

        // delivery
        // home: LogginScreenDelivery()

        // logitrack user
        // home: Checkuserhere(),

        //admin
        // home: DashboardHome(),

        home:
            // BottomnavDelivery(
            //   selectedindex: 0,
            // ),
            Userprf(),
      ),
    );
  }
}

class Userprf extends StatelessWidget {
  const Userprf({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Helper.W(context) * .20,
              vertical: Helper.W(context) * .060,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                      text: 'SELECT TYPE',
                      style: TextStyle(
                        fontSize: Helper.W(context) * .050,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Checkuserhere(),
                          ));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: Helper.W(context) * .50,
                      height: Helper.H(context) * .10,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            BorderRadius.circular(Helper.W(context) * .030),
                      ),
                      child: Text('USER',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                    ),
                  ),
                  SizedBox(
                    height: Helper.H(context) * .040,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogginScreenDelivery(),
                          ));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: Helper.W(context) * .50,
                      height: Helper.H(context) * .10,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius:
                            BorderRadius.circular(Helper.W(context) * .030),
                      ),
                      child: Text('DELIVERY BOY',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                    ),
                  ),
                  SizedBox(
                    height: Helper.H(context) * .040,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogginScreenCompany(),
                          ));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: Helper.W(context) * .50,
                      height: Helper.H(context) * .10,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius:
                            BorderRadius.circular(Helper.W(context) * .030),
                      ),
                      child: Text('COMPANY',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                    ),
                  ),
                  SizedBox(
                    height: Helper.H(context) * .040,
                  ),
                  if (constraints.maxWidth > 600)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardHome(),
                            ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: Helper.W(context) * .50,
                        height: Helper.H(context) * .10,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius:
                              BorderRadius.circular(Helper.W(context) * .030),
                        ),
                        child: Text('admin'),
                      ),
                    ),
                  if (constraints.maxWidth < 600)
                    Container(
                      alignment: Alignment.center,
                      width: Helper.W(context) * .50,
                      height: Helper.H(context) * .10,
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius:
                            BorderRadius.circular(Helper.W(context) * .030),
                      ),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ADMIN',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                          Text("Access only through web")
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
