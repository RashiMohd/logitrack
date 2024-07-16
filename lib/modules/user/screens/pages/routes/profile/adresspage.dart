import 'package:flutter/material.dart';
import 'package:logitrack/models/addressmodel.dart';
import 'package:logitrack/modules/company/utils/responsivesize.dart';
import 'package:logitrack/modules/company/widgets/textformwidget.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/utils/strings.dart';
import 'package:provider/provider.dart';

class AdressPage extends StatelessWidget {
  AdressPage({super.key});

  final formkey = GlobalKey<FormState>();

  final adrescontrol = TextEditingController();
  final city = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.getWidth(context) * .050,
          ),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(
                  height: ResponsiveHelper.getHeight(context) * .150,
                ),
                Textformwidget(
                  controller: adrescontrol,
                  radius: 10,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter value';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: ResponsiveHelper.getHeight(context) * .050,
                ),
                Textformwidget(
                  controller: city,
                  radius: 10,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter value';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: ResponsiveHelper.getHeight(context) * .050,
                ),
                Consumer<FirebaseController>(
                  builder: (context, instance, _) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          instance.addadres(
                            AddresModel(
                              adress: adrescontrol.text,
                              city: city.text,
                            ),
                            auth.currentUser!.uid,
                          );
                        }
                      },
                      child: Text('Add address'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
