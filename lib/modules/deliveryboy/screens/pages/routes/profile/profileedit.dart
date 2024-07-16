import 'package:flutter/material.dart';
 
import 'package:logitrack/modules/deliveryboy/widgets/bordernonetextform.dart';
import 'package:logitrack/modules/deliveryboy/widgets/container.dart';
import 'package:logitrack/modules/deliveryboy/widgets/text_style.dart';
import 'package:logitrack/utils/colors.dart';
import 'package:logitrack/utils/responsivesize.dart';
 
class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _adressController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: Helper.H(context) * .00,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: Helper.W(context) * .090,
                            backgroundImage:
                                AssetImage('assets/images/deliveryboy.png'),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Manu',
                      style: AppTextStyles.regularText(
                        fontSize: Helper.W(context) * .050,
                      ),
                    ),
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
                        controller: _nameController,
                      ),
                      SizedBox(
                        height: Helper.H(context) * .030,
                      ),
                      Text('Email'),
                      BorderNoneetextformwidget(
                        controller: _emailController,
                      ),
                      SizedBox(
                        height: Helper.H(context) * .030,
                      ),
                      Text('Adress'),
                      BorderNoneetextformwidget(
                        controller: _adressController,
                      ),
                      SizedBox(
                        height: Helper.H(context) * .030,
                      ),
                      Text('Number'),
                      BorderNoneetextformwidget(
                        controller: _nameController,
                      ),
                      SizedBox(
                        height: Helper.H(context) * .030,
                      ),
                      Text('Password'),
                      BorderNoneetextformwidget(
                        controller: _passwordController,
                      ),
                      SizedBox(
                        height: Helper.H(context) * .030,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {}
                            },
                            child: ContainerWidget(
                              color: ColorsClass.SplashScreenbg,
                              width: Helper.W(context) * .700,
                              height:
                                  Helper.H(context) * .060,
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
        ));
  }
}
