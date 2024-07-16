import 'dart:developer';

import 'package:google_fonts/google_fonts.dart';
import 'package:logitrack/models/company.dart';
import 'package:logitrack/modules/company/utils/colors.dart';
import 'package:logitrack/modules/company/widgets/container.dart';
import 'package:logitrack/modules/company/widgets/textformwidget.dart';
import 'package:logitrack/modules/company/widgets/textwidget.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/services/user_controller.dart';
import 'package:provider/provider.dart';

import '../../../../utils/responsivesize.dart';

import 'package:flutter/material.dart';

class SignupScreenCompany extends StatefulWidget {
  SignupScreenCompany({super.key});

  @override
  State<SignupScreenCompany> createState() => _SignupScreenCompanyState();
}

class _SignupScreenCompanyState extends State<SignupScreenCompany> {
  int selectedIndex = 0;

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final instance = Provider.of<FirebaseController>(context, listen: false);
    final authcontlr = Provider.of<AuthController>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Helper.W(context) * .080,
          // vertical: ResponsiveHelper.getHeight(context) * .080,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(
                  height: Helper.H(context) * .040,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
                SizedBox(
                  height: Helper.H(context) * .080,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TExtWidget(
                      text: 'Company name',
                      style: GoogleFonts.heebo(
                        fontSize: Helper.W(context) * .040,
                      ),
                    ),
                    Textformwidget(
                      hint: 'Name',
                      radius: Helper.W(context) * .020,
                      controller: instance.companyusernameController,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'please enter value';
                        }
                        return null;
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
                      hint: 'abcd45@gmail.com',
                      radius: Helper.W(context) * .020,
                      controller: instance.companyemailController,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'please enter value';
                        }
                        return null;
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
                      text: 'Company lisences',
                      style: GoogleFonts.heebo(
                        fontSize: Helper.W(context) * .040,
                      ),
                    ),
                    Textformwidget(
                      controller: instance.companylisence,
                      maxlenght: 10,
                      radius: Helper.W(context) * .020,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'please enter value';
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
                      text: 'Company location',
                      style: GoogleFonts.heebo(
                        fontSize: Helper.W(context) * .040,
                      ),
                    ),
                    Textformwidget(
                      radius: Helper.W(context) * .020,
                      controller: instance.companylocation,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'please enter value';
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
                      radius: Helper.W(context) * .020,
                      controller: instance.companypassword,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'please enter value';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: Helper.H(context) * .050,
                ),
                // if (formkey.currentState!.validate()) {
                //           log('on working signup button');
                //           await insatnce.companySignup(
                //             instance.companyemailController.text,
                //             instance.companypassword.text,
                //             context,
                //             CompanyModel(
                //               companyname:
                //                   instance.companyusernameController.text,
                //               email: instance.companyemailController.text,
                //               companylisence: instance.companylisence.text,
                //               CompanyLocation: instance.companylisence.text,
                //               password: instance.companypassword.text,
                //             ),
                //           );
                //         }
                GestureDetector(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      log('on working signup button');
                      await authcontlr.companySignup(
                        instance.companyemailController.text,
                        instance.companypassword.text,
                        context,
                        CompanyModel(
                          companyname: instance.companyusernameController.text,
                          email: instance.companyemailController.text,
                          companylisence: instance.companylisence.text,
                          CompanyLocation: instance.companylisence.text,
                          password: instance.companypassword.text,
                        ),
                      );
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
          ),
        ),
      ),
    );
  }
}
