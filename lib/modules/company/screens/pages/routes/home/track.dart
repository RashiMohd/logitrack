import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logitrack/modules/company/screens/bottom_navbar.dart';
import 'package:logitrack/modules/company/widgets/text_style.dart';

import '../../../../../../utils/responsivesize.dart';

class Tracking extends StatelessWidget {
  const Tracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Helper.W(context) * .050,
        ),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              height: Helper.H(context) * .200,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(
                  Helper.W(context) * .030,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Helper.W(context) * .020,
                  horizontal: Helper.W(context) * .030,
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: '#2019567',
                              style: AppTextStyles.boldText(
                                fontSize:
                                    Helper.W(context) * .050,
                              ),
                            ),
                            TextWidget(
                              text: '12 march 2024 on 3:00 pm',
                              style: TextStyle(
                                fontSize:
                                    Helper.W(context) * .030,
                                color: Colors.grey,
                              ),
                            ),
                            TextWidget(
                              text: '58 min left',
                              style: AppTextStyles.regularText(),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Container(
                              width: Helper.W(context) * .250,
                              // height:
                              //     ResponsiveHelper.getHeight(context) * .200,
                              decoration: BoxDecoration(
                                  // color: ColorsClass.greenColor,
                                  ),
                              child: Image.asset(
                                  'assets/images/vehicle/ns200.png'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: Helper.H(context) * .030,
            );
          },
          itemCount: 5,
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
                builder: (context) => BottomnavCompany(selectedindex: index),
              ),
            );
          }
        },
      ),
    );
  }
}
