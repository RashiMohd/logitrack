import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logitrack/models/company.dart';
import 'package:logitrack/models/prductmodel.dart';
import 'package:logitrack/models/user_model.dart';
import 'package:logitrack/modules/company/screens/bottom_navbar.dart';
import 'package:logitrack/modules/deliveryboy/screens/auth_service/signup.dart';
import 'package:logitrack/modules/deliveryboy/screens/bottom_navbar.dart';
import 'package:logitrack/modules/deliveryboy/screens/pages/home_page.dart';
import 'package:logitrack/modules/user/screens/auth_service/Loggin_screen.dart';
import 'package:logitrack/modules/user/screens/auth_service/checkuser.dart';
import 'package:logitrack/modules/user/screens/pages/bottom_bar.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/utils/strings.dart';
import 'package:logitrack/utils/toast.dart';
import 'package:provider/provider.dart';

class AuthController with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  TextEditingController confirmPasswordcontroller = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool obscureText = true;

  File? selectedimage;

  clearcontroller() {
    emailcontroller.clear();
    passwordcontroller.clear();
    nameController.clear();
    log('=========================controller clear succes=========================');
  }

  isTextvisible() {
    obscureText = !obscureText;
    notifyListeners();
  }

  Future signup(
      String email, String password, String name, context, imageurl) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((credential) {
        Provider.of<FirebaseController>(context, listen: false)
            .adduser(
          credential.user!.uid,
          UserModel(
            email: email,
            password: password,
            name: name,
            imageurl: imageurl,
            address: '',
          ),
        )
            .then((value) {
          clearcontroller();
          succestoast(context, 'Signup succes ');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => BottomnavUser(
                  selectedindex: 0,
                ),
              ),
              (route) => false);
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('error on $e');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Signedup successfully')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${e.code.toString()}')));
      }
    }
  }

  Future signin(String email, String password, context) async {
    try {
      final credential = await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((cred) {
        Provider.of<FirebaseController>(context, listen: false)
            .fetchSelectedUSerdata(cred.user!.uid)
            .then((value) {
          if (value == true) {
            clearcontroller();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => BottomnavUser(
                          selectedindex: 0,
                        )),
                (route) => false);
            succestoast(context, 'Loggin sucess');
          } else {
            showDeleteCredentialmessage(context) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: ContinuousRectangleBorder(),
                  backgroundColor: Colors.white,
                  content: Text(
                    "Your account is deleted by some reason.Please contact with admin for further information\nif delete your old credential by your self you can create a new account with the same email (${FirebaseAuth.instance.currentUser!.email}).",
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.currentUser!
                              .delete()
                              .then((value) {
                            return Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LogginScreenUser()),
                                (route) => false);
                          });
                        },
                        child: Text(
                          "Delete credential",
                          style: TextStyle(color: Colors.red),
                        ))
                  ],
                ),
              );
            }
          }
        });
      });
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        log('error on $e');
        succestoast(context, 'No user found that email');
      } else if (e.code == 'wrong-password') {
        succestoast(context, 'Wrong password entered user');
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${e.code.toString()}')));
      }
    }
  }

  //--------------------------------------------- DATABASE

  Future updateprofile(
    String name,
  ) async {
    try {
      db.collection('Users').doc(auth.currentUser!.uid).update({
        'name': name,
      });
      notifyListeners();
    } catch (e) {
      log('erro edit profile$e');
    }
  }

  //

  Future Deliveryloggin(
      BuildContext context, String emaild, String passwordd) async {
    try {
      log('ith create');
      await auth
          .signInWithEmailAndPassword(email: emaild, password: passwordd)
          .then((value) {
        log('ith navigate');

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomnavDelivery(
                selectedindex: 0,
              ),
            ));
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error')));
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('weak password')));
      } else if (e.code == 'email-already-in-use') {
        errortoast(context, 'error ');
      }
    } catch (e) {
      errortoast(context, 'error ');
      print(e);
    }
  }

  Future<void> companySignup(
    String email,
    String password,
    BuildContext context,
    CompanyModel companyModel,
  ) async {
    try {
      log('try ulllil working');
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        log('try then working');

        final prvdr = Provider.of<FirebaseController>(context, listen: false);

        prvdr.companysignup(auth.currentUser!.uid, companyModel);
        log('add db');
        Future companysignup(String uid, CompanyModel companymodel) async {
          await db
              .collection('CompanyUsers')
              .doc(uid)
              .set(companymodel.toJson(uid));
        }

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomnavCompany(
                selectedindex: 0,
              ),
            ));
        log('navi then');

        succestoast(context, 'company signup sucess');
      });
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    }
  }

  CompanyLoggin(String email, String password, BuildContext context) async {
    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomnavCompany(
                selectedindex: 0,
              ),
            ));
        succestoast(context, 'loggin succes');
      });
    } on FirebaseException catch (e) {
      errortoast(context, 'error ');
      throw e.toString();
    }
  }
}
