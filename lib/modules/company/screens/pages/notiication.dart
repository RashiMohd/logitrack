 
import 'package:flutter/material.dart';

import '../../../../utils/responsivesize.dart';
import '../../../deliveryboy/widgets/text_style.dart';
 
class NotificationScreenCompany extends StatelessWidget {
  const NotificationScreenCompany({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> notification = [
      'New ordr has been placed',
      'Order cancelled',
      '5 bonus points for fast delivery',
      'You earned 5% cashback',
      'You order has been conformed',
      'Your order has been conformed'
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('notification'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Helper.W(context) * .050,
              ),
              child: Container(
                width: double.infinity,
                height: Helper.H(context) * .150,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(
                    Helper.W(context) * .030,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      notification[index],
                      style: AppTextStyles.regularText(
                        fontSize: Helper.W(context) * .050,
                        
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: Helper.H(context) * .050,
            );
          },
          itemCount: notification.length),
    );
  }
}
