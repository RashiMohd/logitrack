import 'package:flutter/material.dart';
import 'package:logitrack/modules/company/screens/bottom_navbar.dart';
import 'package:logitrack/modules/company/widgets/text_style.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/responsivesize.dart';

class PendingScreen extends StatelessWidget {
  const PendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending company'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Helper.W(context) * .050,
        ),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: 'Clara',
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
                                text: 'Address',
                                style: AppTextStyles.regularText(),
                              ),
                              TextWidget(
                                text:
                                    '54 W Nob Hill Blvd City/Town Yakima State/\n Postal Code98902',
                                style: AppTextStyles.regularText(
                                  fontSize:
                                      Helper.W(context) * .025,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Pending',
                                style: AppTextStyles.regularText(
                                  color: ColorsClass.redcolor,
                                ),
                              ),
                              Text(
                                ' Request has been\n accepted',
                                style: AppTextStyles.regularText(
                                  color: Colors.grey,
                                  fontSize:
                                      Helper.W(context) * .020,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
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
