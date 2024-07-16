 
import 'package:flutter/material.dart';
import 'package:logitrack/modules/company/widgets/text_style.dart';

import '../../../../../../utils/responsivesize.dart';
 
class Completed extends StatelessWidget {
  const Completed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed'),
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
    );
  }
}
