import 'package:flutter/material.dart';
import 'package:logitrack/modules/deliveryboy/screens/bottom_navbar.dart';
import 'package:logitrack/modules/deliveryboy/widgets/text_style.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/utils/responsivesize.dart';
import 'package:provider/provider.dart';

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
          child: Consumer<FirebaseController>(
            builder: (context, instance, _) {
              return StreamBuilder(
                stream: instance.fetchingorderstatus('Complete').asStream(),
                builder: (context, snapshot) {
                  final complete = instance.orderstatus;
                  final sineldocdata = instance.orderstatus;
                  return sineldocdata.isEmpty
                      ? Center(
                          child: Text('no order'),
                        )
                      : ListView.separated(
                          itemCount: complete.length,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                text: sineldocdata[index]
                                                    .Deliveryname,
                                                style: AppTextStyles.boldText(
                                                  fontSize:
                                                      Helper.W(context) * .050,
                                                ),
                                              ),
                                              TextWidget(
                                                text: sineldocdata[index]
                                                    .orderdate
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize:
                                                      Helper.W(context) * .030,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              TextWidget(
                                                text: 'Address',
                                                style:
                                                    AppTextStyles.regularText(),
                                              ),
                                              TextWidget(
                                                text: sineldocdata[index]
                                                    .Deliveryadress,
                                                style:
                                                    AppTextStyles.regularText(
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
                        );
                },
              );
            },
          )),
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
                builder: (context) => BottomnavDelivery(selectedindex: index),
              ),
            );
          }
        },
      ),
    );
  }
}
