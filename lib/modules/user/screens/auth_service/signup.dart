import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:logitrack/modules/company/utils/colors.dart';
import 'package:logitrack/services/controller.dart';

import 'package:logitrack/services/user_controller.dart';

import 'package:logitrack/utils/responsivesize.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/textformwidget.dart';
import '../../../../widgets/textwidget.dart';
import '../../../company/widgets/container.dart';

class SignupScreenUser extends StatefulWidget {
  const SignupScreenUser({super.key});

  @override
  State<SignupScreenUser> createState() => _SignupScreenUserState();
}

class _SignupScreenUserState extends State<SignupScreenUser> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final helpercontrl = Provider.of<Controller>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Helper.W(context) * .050),
        child: SingleChildScrollView(child: Consumer<AuthController>(
          builder: (context, authcontroller, _) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: Helper.H(context) * .080,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        style: GoogleFonts.heebo(
                          fontSize: Helper.W(context) * .060,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: Helper.W(context) * .30,
                          height: Helper.H(context) * .10,
                          child: Stack(
                            children: [
                              Consumer<Controller>(
                                builder: (context, contrl, child) {
                                  return Container(
                                    width: Helper.W(context) * .20,
                                    height: Helper.H(context) * .10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(),
                                        image: DecorationImage(
                                            image: FileImage(
                                          File(contrl.selectedimage.toString()),
                                        ))),
                                  );
                                },
                              ),
                              Positioned(
                                  top: Helper.W(context) * .12,
                                  left: Helper.W(context) * .12,
                                  child: Consumer<Controller>(
                                    builder: (context, controler, child) {
                                      return IconButton(
                                        onPressed: () async {
                                          controler.imagepicker();
                                        },
                                        icon: Icon(
                                          Icons.camera_alt_outlined,
                                        ),
                                      );
                                    },
                                  )),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: Helper.H(context) * .050,
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
                        controller: authcontroller.nameController,
                        hint: 'Name',
                        radius: Helper.W(context) * .020,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter the required field";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Helper.H(context) * .030,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TExtWidget(
                        text: 'Email',
                        style: GoogleFonts.heebo(
                          fontSize: Helper.W(context) * .040,
                        ),
                      ),
                      Textformwidget(
                        controller: authcontroller.emailcontroller,
                        hint: 'abcd45@gmail.com',
                        radius: Helper.W(context) * .080,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter the required field";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Helper.H(context) * .020,
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
                        controller: authcontroller.passwordcontroller,
                        radius: Helper.W(context) * .020,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter the required field";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Helper.H(context) * .030,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TExtWidget(
                        text: 'Conform password',
                        style: GoogleFonts.heebo(
                          fontSize: Helper.W(context) * .040,
                        ),
                      ),
                      Consumer<AuthController>(
                        builder: (context, controller, _) {
                          return Textformwidget(
                            controller:
                                authcontroller.confirmPasswordcontroller,
                            hint: 'conform password',
                            radius: Helper.W(context) * .080,
                            obscure: authcontroller.obscureText,
                            suffix: IconButton(
                                onPressed: () {
                                  authcontroller.isTextvisible();
                                },
                                icon: Icon(controller.obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter the required field";
                              } else if (value !=
                                  controller.passwordcontroller.text) {
                                return 'password does note match';
                              } else {
                                return null;
                              }
                            },
                          );
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: Helper.H(context) * .120,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        authcontroller.signup(
                          authcontroller.emailcontroller.text.trim(),
                          authcontroller.passwordcontroller.text.trim(),
                          authcontroller.nameController.text.trim(),
                          context,
                          helpercontrl.url,
                        );
                        // helpercontrl.claer();
                      }
                    },
                    child: ContainerWidget(
                      color: ColorsClass.SplashScreenbg,
                      width: Helper.W(context) * .600,
                      height: Helper.H(context) * .070,
                      text: 'Sign up',
                      radius: Helper.W(context) * .050,
                    ),
                  ),
                  SizedBox(
                    height: Helper.H(context) * .030,
                  ),
                ],
              ),
            );
          },
        )),
      ),
    );
  }
}
