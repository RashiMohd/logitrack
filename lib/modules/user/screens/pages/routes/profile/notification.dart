import 'package:flutter/material.dart';
import 'package:logitrack/utils/responsivesize.dart';

List<String> order = [
  'your order has been cancelled',
  'Your order has been delayed',
  'your order has been delivered',
  'you earned 5% cashback',
  'You order has been conformed',
  'you order has been pending'
];

List<String> orderstatus = [
  'assets/images/notification_status/Assessments.png',
  'assets/images/notification_status/troly.png',
  'assets/images/notification_status/Delivered Box.png',
  'assets/images/notification_status/Discount.png',
  'assets/images/notification_status/Assessments.png',
  'assets/images/notification_status/Assessments.png',
];

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Helper.W(context) * .050,
                  ),
                  child: Container(
                    width: Helper.W(context) * .080,
                    height: Helper.H(context) * .080,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(
                        Helper.W(context) * .030,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Helper.W(context) * .030,
                        ),
                        Image.asset(orderstatus[index]),
                        SizedBox(
                          width: Helper.W(context) * .030,
                        ),
                        Text(
                          order[index],
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
              itemCount: order.length,
            ),
          ),
        ],
      ),
    );
  }
}
