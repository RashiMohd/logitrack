import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'package:logitrack/modules/user/screens/pages/bottom_bar.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/services/user_controller.dart';
import 'package:logitrack/utils/responsivesize.dart';
import 'package:logitrack/utils/strings.dart';
import 'package:logitrack/widgets/bordernonetextform.dart';
import 'package:logitrack/widgets/container.dart';
import 'package:provider/provider.dart';

class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameeditController = TextEditingController();
  TextEditingController _emaileditController = TextEditingController();
  TextEditingController _adresseditController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // File? selectedimage;

  // Future<File?> _pickimage()async{
  //   final returnImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (returnImage != null) {

  //   }
  //   return selectedImage;
  // }

  @override
  Widget build(BuildContext context) {
    final profilecontroller =
        Provider.of<AuthController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<FirebaseController>(
        builder: (context, instance, _) {
          return FutureBuilder(
            future: instance.fetchSelectedUSerdata(auth.currentUser!.uid),
            builder: (context, snapshot) {
              _emaileditController.text = instance.userModel!.email;
              _nameeditController.text = instance.userModel!.name;
              _passwordController.text = instance.userModel!.password;

              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: Helper.H(context) * .100,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: Helper.H(context) * .00,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: Helper.W(context) * .120,
                                        backgroundImage: NetworkImage(
                                          instance.userModel!.imageurl,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: Helper.H(context) * .050,
                                left: Helper.W(context) * .55,
                                child: CircleAvatar(
                                  radius: Helper.W(context) * .040,
                                  child: Icon(Icons.camera_alt_outlined),
                                ),
                              )
                            ],
                          ),
                          Text(instance.userModel!.name),
                        ],
                      ),
                      SizedBox(
                        height: Helper.H(context) * .060,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Helper.W(context) * .050,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name'),
                            BorderNoneetextformwidget(
                              controller: _nameeditController,
                              context: context,
                            ),
                            SizedBox(
                              height: Helper.H(context) * .030,
                            ),
                            Text('Email'),
                            BorderNoneetextformwidget(
                              controller: _emaileditController,
                              context: context,
                            ),
                            SizedBox(
                              height: Helper.H(context) * .030,
                            ),
                            Text('Adress'),
                            Consumer<FirebaseController>(
                              builder: (context, instance, _) {
                                return FutureBuilder(
                                  future: instance.fetchadress(),
                                  builder: (context, snapshot) {
                                    if (snapshot.data != null) {
                                      var addressModel = snapshot.data!;

                                      final split = (addressModel.adress +
                                              ',' +
                                              addressModel.city)
                                          .split(',');
                                      _adresseditController.text =
                                          split.join(',');
                                    }
                                    return BorderNoneetextformwidget(
                                      controller: _adresseditController,
                                      context: context,
                                    );
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: Helper.H(context) * .030,
                            ),
                            // Text('Number'),
                            // BorderNoneetextformwidget(
                            //   controller: _numberController,
                            //   context: context,
                            // ),
                            SizedBox(
                              height: Helper.H(context) * .030,
                            ),
                            Text('Password'),
                            BorderNoneetextformwidget(
                              controller: _passwordController,
                              context: context,
                            ),
                            SizedBox(
                              height: Helper.H(context) * .030,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      profilecontroller.updateprofile(
                                          _nameeditController.text);
                                    }
                                  },
                                  child: ContainerWidget(
                                    width: Helper.W(context) * .700,
                                    height: Helper.H(context) * .060,
                                    text: 'Conform',
                                    radius: Helper.W(context) * .050,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Helper.H(context) * .030,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: mynav(
        index: 3,
        onTap: (index) {
          if (index == 0 || index == 1 || index == 2 || index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomnavUser(selectedindex: index),
              ),
            );
          }
        },
      ),
    );
  }
}
