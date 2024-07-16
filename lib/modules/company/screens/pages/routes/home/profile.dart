import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logitrack/app.dart';
import 'package:logitrack/models/company.dart';
import 'package:logitrack/models/deliveryboys.dart';
import 'package:logitrack/modules/company/screens/auth_service/Loggin_screen.dart';
import 'package:logitrack/modules/company/widgets/container.dart';
import 'package:logitrack/modules/company/widgets/textformwidget.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/utils/strings.dart';
import 'package:logitrack/utils/toast.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/responsivesize.dart';
import '../../../../../../widgets/textwidget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'),
        actions: [
          Consumer<FirebaseController>(
            builder: (context, insatnce, _) {
              return IconButton(
                onPressed: () async {
                  insatnce.logout(context).then((value) {
                    succestoast(context, 'Logout sucess');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Userprf(),
                        ),
                        (route) => false);
                  });
                },
                icon: Icon(Icons.logout),
              );
            },
          )
        ],
      ),
      body: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Helper.W(context) * .080,
            // vertical: ResponsiveHelper.getHeight(context) * .080,
          ),
          child: SingleChildScrollView(
            child: Form(child: Consumer<FirebaseController>(
              builder: (context, helper, child) {
                return FutureBuilder(
                  future: helper.getProfiel(auth.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final data = helper.companyModel;

                    final name = TextEditingController(text: data!.companyname);
                    final email = TextEditingController(text: data.email);
                    final license =
                        TextEditingController(text: data.companylisence);
                    final location =
                        TextEditingController(text: data.CompanyLocation);

                    final password = TextEditingController(text: data.password);

                    return Column(
                      children: [
                        SizedBox(
                          height: Helper.H(context) * .020,
                        ),
                        // CircleAvatar(
                        //   radius: 50,
                        //   backgroundColor: Colors.white,
                        //   child: Image.asset(
                        //     'assets/images/Ellipse 26.png',
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        SizedBox(
                          height: Helper.H(context) * .020,
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
                              controller: name,
                              hint: 'Name',
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
                              controller: email,
                              hint: 'abcd45@gmail.com',
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
                          height: Helper.H(context) * .020,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TExtWidget(
                              text: 'Company  license',
                              style: GoogleFonts.heebo(
                                fontSize: Helper.W(context) * .040,
                              ),
                            ),
                            Textformwidget(
                              controller: license,
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
                          height: Helper.H(context) * .030,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TExtWidget(
                              text: 'Company location',
                              style: GoogleFonts.inter(
                                fontSize: Helper.W(context) * .040,
                              ),
                            ),
                            Textformwidget(
                              controller: location,
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
                          height: Helper.H(context) * .030,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TExtWidget(
                              text: 'Password',
                              style: GoogleFonts.inter(
                                fontSize: Helper.W(context) * .040,
                              ),
                            ),
                            Textformwidget(
                              controller: password,
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
                          height: Helper.H(context) * .030,
                        ),
                        GestureDetector(
                          onTap: () {
                            // if (_formKey.currentState!.validate()) {
                            //   context.goNamed('home');
                            // } else {
                            //   print('object');
                            // }
                          },
                          child: ContainerWidget(
                            color: ColorsClass.SplashScreenbg,
                            width: Helper.W(context) * .600,
                            height: Helper.H(context) * .070,
                            text: 'Update',
                            radius: Helper.W(context) * .050,
                          ),
                        ),
                        SizedBox(
                          height: Helper.H(context) * .030,
                        ),
                      ],
                    );
                  },
                );
              },
            )),
          ),
        ),
      ),
    );
  }
}
