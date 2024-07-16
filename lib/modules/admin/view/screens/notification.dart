import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logitrack/models/reviewmodel.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../../utils/responsivesize.dart';

Widget notification(context) {
  List<String> notification = [
    'New order has been placed',
    'New order has been placed',
    'New order has been placed',
    'The order has been cancelled',
    'Payment succesful',
    'New order has been placed',
    'The order has been canceled',
    'New order has been canceled',
    'Payment succesful',
    'New order has been placed',
  ];

  return SingleChildScrollView(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: Helper.W(context) * .020,
            horizontal: Helper.W(context) * .020,
          ),
          child: Container(
            width: double.infinity,
            height: Helper.H(context) * .920,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Helper.W(context) * .030,
              ),
              color: ColorsClass.blueshade,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: ResponsiveHelper.getHeight(context) * .050,
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Helper.W(context) * .010,
                      horizontal: Helper.W(context) * .020),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(
                      Helper.W(context) * .020,
                    ),
                    child: Container(
                      width: Helper.W(context) * .800,
                      height: Helper.H(context) * .800,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          Helper.W(context) * .020,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Consumer<FirebaseController>(
                              builder: (context, controler, child) {
                                return StreamBuilder(
                                  stream: controler.getAllReview(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    List<ReviewModel> list = [];

                                    list = snapshot.data!.docs.map((e) {
                                      return ReviewModel.fromjsone(
                                          e.data() as Map<String, dynamic>);
                                    }).toList();
                                    if (snapshot.hasData) {
                                      return list.isEmpty
                                          ? Center(
                                              child:
                                                  Text('NO REVIEW THIS TIME!'),
                                            )
                                          : ListView.separated(
                                              itemCount: list.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Material(
                                                  elevation: 4,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    Helper.W(context) * .010,
                                                  ),
                                                  child: Container(
                                                    width: Helper.W(context) *
                                                        .300,
                                                    height: Helper.H(context) *
                                                        .090,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFD3EBF7),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        Helper.W(context) *
                                                            .010,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: Helper.W(
                                                                  context) *
                                                              .020,
                                                        ),
                                                        Container(
                                                          width: Helper.W(
                                                                  context) *
                                                              .050,
                                                          height: Helper.H(
                                                                  context) *
                                                              .030,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                        Text(list[index].review)
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox(
                                                  height:
                                                      Helper.H(context) * .030,
                                                );
                                              },
                                            );
                                    }
                                    return Container();
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: Helper.W(context) * .020,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
