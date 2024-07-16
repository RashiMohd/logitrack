import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logitrack/utils/colors.dart';

import '../../../../utils/responsivesize.dart';

Widget aboutus(context) {
  return SingleChildScrollView(
      child: Padding(
    padding: EdgeInsets.symmetric(
      horizontal: Helper.W(context) * .030,
      vertical: Helper.H(context) * .020,
    ),
    child: Column(children: [
      Container(
        width: double.infinity,
        height: Helper.H(context) * .950,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Helper.W(context) * .030,
          ),
          color: ColorsClass.blueshade,
        ),
        child: Column(
          children: [
            SizedBox(
              height: Helper.H(context) * .050,
            ),
            Column(
              children: [
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(
                    Helper.W(context) * .030,
                  ),
                  child: Container(
                    width: Helper.W(context) * .750,
                    height: Helper.H(context) * .800,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(0, 255, 255, 255),
                      borderRadius: BorderRadius.circular(
                        Helper.W(context) * .030,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Helper.W(context) * .060,
                        horizontal: Helper.W(context) * .060,
                      ),
                      child: Column(
                        children: [
                          listtile(
                              context,
                              'asset/Vector.png',
                              'Courier &Delivery',
                              ' A rapid door to door service that picks your order and delivers it to the\n customers doorstep for a  sum of money'),
                          SizedBox(
                            height: Helper.H(context) * .020,
                          ),
                          listtile(
                              context,
                              'asset/local_shipping.png',
                              'Transportation services',
                              'Transportation services can help ensure that your products arrive at their destination on time, in good condition, and with accurate tracking information'),
                          SizedBox(
                            height: Helper.H(context) * .020,
                          ),
                          listtile(
                              context,
                              'asset/arming_countdown.png',
                              'Safe & Secure ',
                              'Arapid door to door service that picks your order and delivers it to thecustomers doorstep for a small sum of mone'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )
    ]),
  ));
}

Widget listtile(context, String image, String name, String subtitile) {
  return ListTile(
    leading: SizedBox(
      width: Helper.W(context) * .080,
      height: Helper.H(context) * .050,
      child: Image.asset(image),
    ),
    title: Text(
      name,
      style: ColorsClass.appBarTitle(
          Colors.black, Helper.W(context) * .020),
    ),
    subtitle: Text(
      subtitile,
      style: ColorsClass.appBarTitle(
          Colors.black, Helper.W(context) * .010),
    ),
  );
}
