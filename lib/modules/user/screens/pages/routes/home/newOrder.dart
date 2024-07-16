import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logitrack/models/addproductorder.dart';

import 'package:logitrack/modules/user/screens/pages/bottom_bar.dart';
import 'package:logitrack/modules/user/screens/pages/routes/home/courier_services.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/services/user_controller.dart';
import 'package:logitrack/utils/responsivesize.dart';
import 'package:logitrack/utils/strings.dart';
import 'package:logitrack/utils/toast.dart';
import 'package:logitrack/widgets/container.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:intl/intl.dart';

class NewOrderScreen extends StatelessWidget {
  NewOrderScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  var value = ['gm', 'kg'];
  DateTime selectedDate = DateTime.now();

  DateTime _selectedDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  void _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: _selectedDate,
      lastDate: _selectedDate,
      helpText: 'Select Today\'s Date',
    );
    // if (picked != null && picked != _selectedDate) {
    //   setState(() {
    //     _selectedDate = picked;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final firebasecontrl = Provider.of<FirebaseController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('New Order'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Helper.W(context) * .040,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //

                Padding(
                  padding: EdgeInsets.only(
                    bottom: Helper.H(context) * .020,
                  ),
                  child: Text(
                    'Pickup Form',
                    style: TextStyle(
                      fontSize: Helper.W(context) * .050,
                    ),
                  ),
                ),
                NewOrderTextformwidget(
                  controller: firebasecontrl.Pickeupname,
                  context: context,
                  hint: 'Enter name',
                ),
                SizedBox(
                  height: Helper.H(context) * .020,
                ),
                NewOrderTextformwidget(
                  controller: firebasecontrl.pickupnumber,
                  context: context,
                  hint: 'Number',
                  maxlenght: 10,
                ),
                SizedBox(
                  height: Helper.H(context) * .020,
                ),
                NewOrderTextformwidget(
                  controller: firebasecontrl.pickupadress,
                  context: context,
                  hint: 'Address',
                ),
                SizedBox(
                  height: Helper.H(context) * .030,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: Helper.H(context) * .020,
                  ),
                  child: Text(
                    'Delivery TO',
                    style: TextStyle(
                      fontSize: Helper.W(context) * .050,
                    ),
                  ),
                ),
                NewOrderTextformwidget(
                  controller: firebasecontrl.deliveryname,
                  context: context,
                  hint: 'Enter name',
                ),
                SizedBox(
                  height: Helper.H(context) * .020,
                ),
                NewOrderTextformwidget(
                  controller: firebasecontrl.deliverynumber,
                  context: context,
                  hint: 'Number',
                  maxlenght: 10,
                ),
                SizedBox(
                  height: Helper.H(context) * .020,
                ),
                NewOrderTextformwidget(
                  controller: firebasecontrl.deliveryadress,
                  context: context,
                  hint: 'Address',
                ),
                SizedBox(
                  height: Helper.H(context) * .010,
                ),
                //

                //
                Padding(
                  padding: EdgeInsets.only(
                    bottom: Helper.H(context) * .020,
                  ),
                  child: Text(
                    'Product Details',
                    style: TextStyle(
                      fontSize: Helper.W(context) * .050,
                    ),
                  ),
                ),
                NewOrderTextformwidget(
                  controller: firebasecontrl.producttype,
                  context: context,
                  hint: 'Product Type',
                ),
                SizedBox(
                  height: Helper.H(context) * .020,
                ),
                Text('Weight'),

                NewOrderTextformwidget(
                  controller: firebasecontrl.prodcutweight,
                  keytype: TextInputType.number,
                  context: context,
                  maxlenght: 5,
                ),
                SizedBox(
                  height: Helper.H(context) * .030,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<FirebaseController>(
                      builder: (context, Controller, _) {
                        return GestureDetector(
                          onTap: () {
                            //

                            String prodid = randomAlpha(5);
                            if (_formKey.currentState!.validate()) {
                              (
                                Addproductmodel(
                                  // id: Controller.auth.currentUser!.uid,
                                  userid: auth.currentUser!.uid,
                                  Pickupfromname:
                                      firebasecontrl.Pickeupname.text,
                                  Pickupfromnumber:
                                      firebasecontrl.pickupnumber.text,
                                  Pickupaddress:
                                      firebasecontrl.pickupadress.text,
                                  Deliveryname:
                                      firebasecontrl.deliveryname.text,
                                  Deliveryadress:
                                      firebasecontrl.deliveryadress.text,
                                  Deliverynumber:
                                      firebasecontrl.deliverynumber.text,
                                  Producttype: firebasecontrl.producttype.text,
                                  Prductweight:
                                      firebasecontrl.prodcutweight.text,
                                  productid: prodid,
                                  orderdate: _dateFormat.format(_selectedDate),
                                  orderstatus: 'orderconformed',
                                ),
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CourierServicesUser(),
                                ),
                              );
                            }
                          },
                          child: ContainerWidget(
                            width: Helper.W(context) * .700,
                            height: Helper.H(context) * .060,
                            text: 'NEXT',
                            radius: Helper.W(context) * .050,
                          ),
                        );
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: Helper.H(context) * .030,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: mynav(
        index: 0,
        onTap: (index) {
          if (index == 0 ||
              index == 1 ||
              index == 2 ||
              index == 3 ||
              index == 4) {
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

Widget NewOrderTextformwidget({
  String? hint,
  required BuildContext context,
  required TextEditingController controller,
  TextInputType? keytype,
  final int? maxlenght,
  final String? sufix,
}) {
  return TextFormField(
    textInputAction: TextInputAction.next,
    keyboardType: keytype,
    inputFormatters: [LengthLimitingTextInputFormatter(maxlenght)],
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller,
    decoration: InputDecoration(
      suffixText: sufix,
      contentPadding: EdgeInsets.symmetric(
          vertical: Helper.W(context) * 0.050,
          horizontal: Helper.W(context) * 0.020),
      fillColor: Colors.blue.shade50,
      filled: true,
      // contentPadding: EdgeInsets.all(ResponsiveHelper.getWidth(context) * .010),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      hintText: hint,
    ),
    validator: (value) {
      if (value!.isEmpty || value == null) {
        return 'please enter the field';
      }
      return null;
    },
  );
}
