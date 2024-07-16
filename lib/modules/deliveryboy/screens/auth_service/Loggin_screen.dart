import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:logitrack/modules/deliveryboy/screens/auth_service/signup.dart';
import 'package:logitrack/modules/deliveryboy/screens/bottom_navbar.dart';
import 'package:logitrack/modules/deliveryboy/screens/pages/home_page.dart';

import 'package:logitrack/modules/deliveryboy/widgets/container.dart';
import 'package:logitrack/modules/deliveryboy/widgets/textformwidget.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/services/user_controller.dart';
import 'package:logitrack/utils/responsivesize.dart';
import 'package:logitrack/widgets/textwidget.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors.dart';

class LogginScreenDelivery extends StatelessWidget {
  LogginScreenDelivery({super.key});

  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Helper.W(context) * .080,
            // vertical: ResponsiveHelper.getHeight(context) * .080,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: Helper.H(context) * .040,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome',
                        style: GoogleFonts.heebo(
                          fontSize: Helper.W(context) * .080,
                        ),
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
                        controller: _nameController,
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
                        controller: _passwordController,
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
                      TExtWidget(
                        text: 'Forgot Password?',
                        style: GoogleFonts.heebo(
                          color: ColorsClass.SplashScreenbg,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Helper.H(context) * .080,
                  ),
                  Consumer<AuthController>(
                    builder: (context, instance, _) {
                      return GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await instance.Deliveryloggin(
                              context,
                              _nameController.text,
                              _passwordController.text,
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
                                builder: (context) => SignupScreenDelivery(),
                              ));
                        },
                        child: TExtWidget(
                          text: 'Sign up',
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
