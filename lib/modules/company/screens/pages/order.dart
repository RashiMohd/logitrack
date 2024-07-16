import 'package:flutter/material.dart';
import 'package:logitrack/models/addproductorder.dart';
import 'package:logitrack/modules/company/widgets/container.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/responsivesize.dart';
import '../../../deliveryboy/widgets/text_style.dart';

class OrderbottomCompany extends StatelessWidget {
  const OrderbottomCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Orders'),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Helper.W(context) * .050,
          ),
          child: Consumer<FirebaseController>(
            builder: (context, helper, child) {
              return StreamBuilder(
                stream: helper.fetchingproductorder(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<Addproductmodel> list = [];
                  list = snapshot.data!.docs.map((e) {
                    return Addproductmodel.fromJson(
                        e.data() as Map<String, dynamic>);
                  }).toList();
                  if (snapshot.hasData) {
                    return list.isEmpty
                        ? Center(
                            child: Text('NO ORDER'),
                          )
                        : ListView.separated(
                            itemCount: list.length,
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
                                                text: list[index].Deliveryname,
                                                style: AppTextStyles.boldText(
                                                  fontSize:
                                                      Helper.W(context) * .050,
                                                ),
                                              ),
                                              TextWidget(
                                                text: list[index]
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
                                                text: list[index].Pickupaddress,
                                                style:
                                                    AppTextStyles.regularText(
                                                  fontSize:
                                                      Helper.W(context) * .025,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ContainerWidget(
                                                color: ColorsClass.greenColor,
                                                width: Helper.W(context) * .250,
                                                height:
                                                    Helper.H(context) * .030,
                                                text: list[index].orderstatus,
                                                radius:
                                                    Helper.W(context) * .030,
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
                          );
                  }
                  return Container();
                },
              );
            },
          )),
    );
  }
}
