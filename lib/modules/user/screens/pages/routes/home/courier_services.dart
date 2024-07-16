import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:logitrack/models/addproductorder.dart';
import 'package:logitrack/models/prductmodel.dart';
import 'package:logitrack/modules/company/utils/colors.dart';

import 'package:logitrack/modules/user/screens/pages/bottom_bar.dart';
import 'package:logitrack/modules/user/screens/pages/routes/home/shipway.dart';
import 'package:logitrack/modules/user/screens/pages/routes/profile/payment.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/utils/responsivesize.dart';
import 'package:provider/provider.dart';

class CourierServicesUser extends StatelessWidget {
  CourierServicesUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courier Services'),
      ),
      body: Consumer<FirebaseController>(
        builder: (context, instance, child) {
          return StreamBuilder(
            stream: instance.companyfetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<Company> list = [];

              list = snapshot.data!.docs.map((docs) {
                return Company.fromJson(docs.data() as Map<String, dynamic>);
              }).toList();

              if (snapshot.hasData) {
                return list.isEmpty
                    ? Center(
                        child: Text('NO COURIER SERVICE AVAILABLE'),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: Helper.H(context) * .030,
                                );
                              },
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                // log('${list[index].imageurl}');

                                final img = list[index].imageurl;

                                return GestureDetector(
                                  onTap: () {
                                    if (list[index].wdwide) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Shipway(
                                            Selectedindex: list[index],
                                          ),
                                        ),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PaymentUser(
                                            Selectedindex: list[index],
                                          ),
                                        ),
                                      );
                                    }

                                    // log('delivery charge ${instance.prdctprice(int.parse(list[index].CompanyCharge))}');
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Helper.W(context) * .040,
                                    ),
                                    child: Material(
                                      elevation: 4,
                                      borderRadius: BorderRadius.circular(
                                        Helper.W(context) * .030,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        height: Helper.H(context) * .160,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 90,
                                                    height: 70,
                                                    decoration: BoxDecoration(
                                                        // color: Colors.red,
                                                        // image: DecorationImage(
                                                        //   image:
                                                        //       list[index].imageurl
                                                        //           ? Icon(Icons.image)
                                                        //           : NetworkImage(
                                                        //               list[index]
                                                        //                   .imageurl,
                                                        //             ),
                                                        // ),
                                                        image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                        img,
                                                      ),
                                                    )),
                                                  ),
                                                  SizedBox(
                                                    width: Helper.W(context) *
                                                        .030,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        list[index].CompanyName,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: Helper.W(
                                                                  context) *
                                                              .050,
                                                        ),
                                                      ),
                                                      Text('Estimated'),
                                                      Text('Shipping Charge'),
                                                    ],
                                                  ),
                                                  Spacer(), // Add spacer to push the next widget to the end
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .yellow),
                                                          Text('4.0'),
                                                        ],
                                                      ),
                                                      Text('1 March'),
                                                      // Text('\$ ${shpingfee[index]}'),
                                                      Text(list[index]
                                                          .CompanyCharge)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: Helper.H(context) * .020,
                                            ),
                                            // if (index == 4)
                                            Visibility(
                                              visible: list[index].wdwide,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: ColorsClass.redcolor,
                                                  ),
                                                ),
                                                child: Text(
                                                    'This is worl wide courier'),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
              }
              return Container();
            },
          );
        },
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
                builder: (context) => BottomnavUser(selectedindex: index),
              ),
            );
          }
        },
      ),
    );
  }
}
