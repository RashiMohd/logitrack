import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logitrack/models/addproductorder.dart';
import 'package:logitrack/modules/deliveryboy/screens/bottom_navbar.dart';

import 'package:logitrack/modules/deliveryboy/widgets/container.dart';
import 'package:logitrack/modules/deliveryboy/widgets/text_style.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/tsetssss.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/responsivesize.dart';

class ShipmentDetails extends StatefulWidget {
  final Addproductmodel indexdata;
  const ShipmentDetails({super.key, required this.indexdata});

  @override
  State<ShipmentDetails> createState() => _ShipmentDetailsState();
}

class _ShipmentDetailsState extends State<ShipmentDetails> {
  int orderstus = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('shipment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Helper.W(context) * .050,
              ),
              child: Column(
                children: [
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(
                      Helper.W(context) * .050,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: Helper.H(context) * .250,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(
                          Helper.W(context) * .050,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: Helper.W(context) * .030,
                                left: Helper.W(context) * .030,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.indexdata.Deliveryname,
                                    style: AppTextStyles.regularText(
                                      fontSize: Helper.W(context) * .050,
                                    ),
                                  ),
                                  Text(
                                    widget.indexdata.orderdate.toString(),
                                    style: AppTextStyles.regularText(
                                      fontSize: Helper.W(context) * .030,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    'Pickup From',
                                    style: AppTextStyles.regularText(
                                      fontSize: Helper.W(context) * .050,
                                    ),
                                  ),
                                  Text(
                                    widget.indexdata.Pickupaddress,
                                    style: AppTextStyles.regularText(
                                      fontSize: Helper.W(context) * .030,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: Helper.W(context) * .030),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: Helper.W(context) * .030,
                                left: Helper.W(context) * .030,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ContainerWidget(
                                    color: ColorsClass.greenColor,
                                    width: Helper.W(context) * .250,
                                    height: Helper.H(context) * .030,
                                    text: 'Accept',
                                    radius: Helper.W(context) * .030,
                                  ),
                                  SizedBox(
                                    height: Helper.H(context) * .030,
                                  ),
                                  Text(
                                    'Delivery to',
                                    style: AppTextStyles.regularText(
                                      fontSize: Helper.W(context) * .050,
                                    ),
                                  ),
                                  Text(
                                    '${widget.indexdata.Deliveryadress}',
                                    style: AppTextStyles.regularText(
                                      fontSize: Helper.W(context) * .030,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Helper.H(context) * .030,
                  ),

                  Consumer<FirebaseController>(
                    builder: (context, instance, _) {
                      return FutureBuilder(
                          future: instance.deliverystatus(widget.indexdata.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final data = instance.deliverydetails;

                            // log(widget.indexdata.id as String);

                            // log(data!.orderstatus.toString());

                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Order request'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Spacer(),
                                    Consumer<FirebaseController>(
                                      builder: (context, instance, child) {
                                        return IconButton(
                                          onPressed: () {
                                            instance.updateorderstatus(
                                                'order request');
                                            instance.updateconfoorm(
                                              widget.indexdata.id,
                                              'order request',
                                            );
                                          },
                                          icon: Icon(
                                            instance.orderStatus ==
                                                    'order request'
                                                ? Icons.check_box_rounded
                                                : Icons.check_box_outline_blank,
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('order cancel'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Spacer(),
                                    Consumer<FirebaseController>(
                                      builder: (context, instance, child) {
                                        return IconButton(
                                          onPressed: () {
                                            instance.updateorderstatus(
                                                'order cancel');
                                            instance.updateconfoorm(
                                              widget.indexdata.id,
                                              'order cancel',
                                            );
                                          },
                                          icon: Icon(
                                            instance.orderStatus ==
                                                    'order cancel'
                                                ? Icons.check_box_rounded
                                                : Icons.check_box_outline_blank,
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('procesing'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Spacer(),
                                    Consumer<FirebaseController>(
                                      builder: (context, instance, child) {
                                        return IconButton(
                                          onPressed: () {
                                            instance
                                                .updateorderstatus('pending');
                                            instance.updateconfoorm(
                                              widget.indexdata.id,
                                              'pending',
                                            );
                                          },
                                          icon: Icon(
                                            instance.orderStatus == 'pending'
                                                ? Icons.check_box_rounded
                                                : Icons.check_box_outline_blank,
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Complete order'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Spacer(),
                                    Consumer<FirebaseController>(
                                      builder: (context, instance, child) {
                                        return IconButton(
                                            onPressed: () {
                                              instance.updateorderstatus(
                                                  'Complete');
                                              instance.updateconfoorm(
                                                widget.indexdata.id,
                                                'Complete',
                                              );
                                            },
                                            icon: Icon(instance.orderStatus ==
                                                    'Complete'
                                                ? Icons.check_box
                                                : Icons
                                                    .check_box_outline_blank));
                                      },
                                    ),
                                  ],
                                ),
                                Text(data!.orderstatus.toString()),
                              ],
                            );
                          });
                    },
                  ),
                  // Text(widget.indexdata.orderstatus)
                ],
              ),
            )
          ],
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
                builder: (context) => BottomnavDelivery(selectedindex: index),
              ),
            );
          }
        },
      ),
    );
  }
}

class MyCheckboxListTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const MyCheckboxListTile({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
