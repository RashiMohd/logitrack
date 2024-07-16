import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logitrack/models/prductmodel.dart';
import 'package:logitrack/modules/user/screens/pages/routes/profile/payment.dart';
import 'package:logitrack/utils/responsivesize.dart';
import 'package:logitrack/widgets/container.dart';
import 'package:logitrack/widgets/textformwidget.dart';

class Shipway extends StatelessWidget {
  final Company? Selectedindex;
  Shipway({super.key, this.Selectedindex});

  final licensecont = TextEditingController();
  final s = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Helper.W(context) * .020),
            child: Column(
              children: [
                Textformwidget(
                  hint: 'Lices number',
                  validator: (value) {},
                  radius: Helper.W(context) * .010,
                  controller: licensecont,
                ),
                SizedBox(
                  height: Helper.H(context) * .050,
                ),
                Textformwidget(
                  hint: 'Lices number',
                  validator: (value) {},
                  radius: Helper.W(context) * .010,
                  controller: s,
                ),
                SizedBox(
                  height: Helper.H(context) * .050,
                ),
                ContainerWidget(
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentUser(
                          Selectedindex: Selectedindex,
                        ),
                      ),
                    );
                  },
                  align: Alignment.center,
                  width: Helper.W(context) * .50,
                  height: Helper.W(context) * .10,
                  text: 'Continue payment',
                  radius: Helper.W(context) * .010,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
