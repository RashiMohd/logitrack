import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:logitrack/modules/company/screens/auth_service/signup.dart';
import 'package:logitrack/modules/company/utils/colors.dart';
import 'package:logitrack/modules/company/widgets/container.dart';
import 'package:logitrack/modules/company/widgets/textformwidget.dart';
import 'package:logitrack/modules/company/widgets/textwidget.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/services/user_controller.dart';
import 'package:provider/provider.dart';

import '../../../../utils/responsivesize.dart';

class LogginScreenCompany extends StatelessWidget {
  LogginScreenCompany({super.key});

  @override
  Widget build(BuildContext context) {
    final provdrdata = Provider.of<FirebaseController>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Helper.W(context) * .080,
            // vertical: ResponsiveHelper.getHeight(context) * .080,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: provdrdata.formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: Helper.H(context) * .040,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome company',
                        style: GoogleFonts.heebo(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Helper.H(context) * .080,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TExtWidget(
                        text: 'Username',
                        style: GoogleFonts.heebo(
                          fontSize: Helper.W(context) * .040,
                        ),
                      ),
                      Textformwidget(
                        controller: provdrdata.companylogginemail,
                        hint: 'Name',
                        radius: Helper.W(context) * .020,
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'required';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Helper.H(context) * .050,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TExtWidget(
                        text: 'Password',
                        style: GoogleFonts.heebo(
                          fontSize: Helper.W(context) * .040,
                        ),
                      ),
                      Textformwidget(
                        controller: provdrdata.companypasswordloggin,
                        hint: 'password',
                        radius: Helper.W(context) * .020,
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'required';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Helper.H(context) * .020,
                  ),
                  Row(
                    children: [
                      // TExtWidget(
                      //   text: 'Forgot Password?',
                      //   style: GoogleFonts.heebo(
                      //     color: ColorsClass.SplashScreenbg,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: Helper.H(context) * .080,
                  ),
                  Consumer<AuthController>(
                    builder: (context, insatnce, _) {
                      return GestureDetector(
                        onTap: () {
                          if (provdrdata.formKey.currentState!.validate()) {
                            insatnce.CompanyLoggin(
                              provdrdata.companylogginemail.text,
                              provdrdata.companypasswordloggin.text,
                              context,
                            );
                          }
                        },
                        child: ContainerWidget(
                          color: ColorsClass.SplashScreenbg,
                          width: Helper.W(context) * .600,
                          height: Helper.H(context) * .070,
                          text: 'Login',
                          radius: Helper.W(context) * .050,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: Helper.H(context) * .030,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Helper.W(context) * .030,
                        child: Divider(),
                      ),
                      Text('or'),
                      SizedBox(
                        width: Helper.W(context) * .030,
                        child: Divider(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Helper.H(context) * .040,
                  ),
                  Container(
                    width: Helper.W(context) * .800,
                    height: Helper.H(context) * .080,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Helper.W(context) * .020,
                      ),
                      border: Border.all(color: ColorsClass.SplashScreenbg),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Helper.W(context) * .080,
                        ),
                        Image.asset(
                          'assets/images/Google.png',
                        ),
                        SizedBox(
                          width: Helper.W(context) * .010,
                        ),
                        Text('Continue with google')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Helper.H(context) * .040,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TExtWidget(
                        text: 'Create an account ?',
                        style: GoogleFonts.heebo(),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreenCompany(),
                              ));
                        },
                        child: TExtWidget(
                          text: 'Sign in',
                          style: GoogleFonts.heebo(
                            color: ColorsClass.SplashScreenbg,
                            fontSize: Helper.W(context) * .050,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
