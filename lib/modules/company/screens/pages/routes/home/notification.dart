 
import 'package:flutter/material.dart';

import '../../../../../../utils/responsivesize.dart';

class NotificationHome extends StatelessWidget {
  const NotificationHome({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> notification = [
      'assets/images/notification_status/Card Payment.png',
      'assets/images/notification_status/Portraits.png',
      'assets/images/notification_status/Unavailable.png',
      'assets/images/notification_status/Portraits.png',
      'assets/images/notification_status/Unavailable.png',
    ];

    List<String> notifstatus = [
      'New order has been places',
      'New order has been placed',
      'New order has been placed',
      'Thw order has been cancelled',
      'Payment successful',
      'New order been placed',
      'Thw order has been cancelled',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Helper.W(context) * .050,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: Helper.H(context) * .120,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(
                        Helper.W(context) * .030,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Helper.W(context) * .020,
                        ),
                        Image.asset(notification[index]),
                        SizedBox(
                          width: Helper.W(context) * .020,
                        ),
                        Text(notifstatus[index])
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
              itemCount: 5,
            ),
          ],
        ),
      ),
    );
  }
}
