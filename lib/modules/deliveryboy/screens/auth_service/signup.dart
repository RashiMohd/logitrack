import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logitrack/models/deliveryboys.dart';
import 'package:logitrack/modules/deliveryboy/screens/bottom_navbar.dart';

import 'package:logitrack/modules/deliveryboy/widgets/container.dart';
import 'package:logitrack/modules/deliveryboy/widgets/textformwidget.dart';
import 'package:logitrack/services/controller.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/utils/colors.dart';
import 'package:logitrack/utils/responsivesize.dart';
import 'package:logitrack/utils/toast.dart';
import 'package:logitrack/widgets/textwidget.dart';
import 'package:provider/provider.dart';

class SignupScreenDelivery extends StatefulWidget {
  SignupScreenDelivery({super.key});

  @override
  State<SignupScreenDelivery> createState() => _SignupScreenDeliveryState();
}

class _SignupScreenDeliveryState extends State<SignupScreenDelivery> {
  int selectedIndex = 0;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _drivinglicenseController = TextEditingController();
  TextEditingController _vehiclenumberController = TextEditingController();
  TextEditingController _passwordcontroler = TextEditingController();

  XFile? xFile;

  String image = '';

  @override
  Widget build(BuildContext context) {
    final fircontro = Provider.of<FirebaseController>(context);

    final provideobj = Provider.of<Controller>(context);
    return Scaffold(
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
                      'Get started',
                      style: GoogleFonts.heebo(
                        fontSize: Helper.W(context) * .080,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: Helper.H(context) * .100,
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: Helper.W(context) * .10,
                            ),
                          ],
                        ),
                        Positioned(
                            left: Helper.W(context) * .45,
                            top: Helper.W(context) * .10,
                            child: IconButton(
                                onPressed: () async {
                                  provideobj.pickimagefromgallery();
                                },
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                )))
                      ],
                    )),
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
                    Container(
                      child: Textformwidget(
                        hint: 'Name',
                        radius: Helper.W(context) * .040,
                        controller: _usernameController,
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
                      ),
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
                    Container(
                      child: Textformwidget(
                        hint: 'Password',
                        radius: Helper.W(context) * .040,
                        controller: _passwordcontroler,
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'please enter value';
                          }
                          return null;
                        },
                      ),
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
                      radius: Helper.W(context) * .040,
                      controller: _emailController,
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
                      text: 'Your Driving license',
                      style: GoogleFonts.heebo(
                        fontSize: Helper.W(context) * .040,
                      ),
                    ),
                    Textformwidget(
                      controller: _drivinglicenseController,
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

                // delivery vehicle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: Container(
                        width: Helper.W(context) * .250,
                        height: Helper.H(context) * .110,
                        decoration: BoxDecoration(
                          color: selectedIndex == 0
                              ? ColorsClass.selectedvehicle
                              : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(
                            Helper.W(context) * .030,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Helper.H(context) * .020,
                            ),
                            Image.asset('assets/images/Quad Bike.png'),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: Container(
                        width: Helper.W(context) * .250,
                        height: Helper.H(context) * .110,
                        decoration: BoxDecoration(
                          color: selectedIndex == 1
                              ? ColorsClass.selectedvehicle
                              : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(
                            Helper.W(context) * .030,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Helper.H(context) * .020,
                            ),
                            Image.asset('assets/images/Truck.png'),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                      child: Container(
                        width: Helper.W(context) * .250,
                        height: Helper.H(context) * .110,
                        decoration: BoxDecoration(
                          color: selectedIndex == 2
                              ? ColorsClass.selectedvehicle
                              : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(
                            Helper.W(context) * .030,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Helper.H(context) * .020,
                            ),
                            Image.asset('assets/images/newordercont.png'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // SizedBox(
                //   height: ResponsiveHelper.getHeight(context) * .120,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Bike'),
                    Text('Car'),
                    Text('Truck'),
                  ],
                ),
                SizedBox(
                  height: Helper.H(context) * .050,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TExtWidget(
                      text: 'Your vehicle number',
                      style: GoogleFonts.heebo(
                        fontSize: Helper.W(context) * .040,
                      ),
                    ),
                    Textformwidget(
                      radius: Helper.W(context) * .020,
                      controller: _vehiclenumberController,
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
                  height: Helper.H(context) * .080,
                ),
                GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordcontroler.text,
                        )
                            .then((value) {
                          fircontro.addDelivery(
                            DeliveryBoysModel(
                              Name: _usernameController.text,
                              Email: _emailController.text,
                              DLNumber: _drivinglicenseController.text,
                              Vehiclenumber: _vehiclenumberController.text,
                              vehicl: selectedIndex.toString(),
                            ),
                          );
                          succestoast(context, 'add delivery ');

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomnavDelivery(
                                  selectedindex: 0,
                                ),
                              ));
                        });
                      }
                    },
                    child: Container(
                      width: Helper.W(context) * .600,
                      height: Helper.H(context) * .070,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              BorderRadius.circular(Helper.W(context) * .050)),
                      child: Center(
                        child: Text(
                          'Sign up',
                          style: GoogleFonts.heebo(
                            color: ColorsClass.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
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
