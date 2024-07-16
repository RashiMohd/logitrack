import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logitrack/models/addproductorder.dart';

import 'package:logitrack/modules/deliveryboy/screens/pages/order.dart';
import 'package:logitrack/modules/deliveryboy/screens/pages/routes/home/cenceled.dart';
import 'package:logitrack/modules/deliveryboy/screens/pages/routes/home/completed.dart';
import 'package:logitrack/modules/deliveryboy/screens/pages/routes/home/pending.dart';

import 'package:logitrack/modules/deliveryboy/widgets/container.dart';
import 'package:logitrack/modules/deliveryboy/widgets/text_style.dart';
import 'package:logitrack/modules/deliveryboy/widgets/textformwidget.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/utils/responsivesize.dart';
import 'package:logitrack/utils/strings.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors.dart';

class HomepageDelivery extends StatefulWidget {
  const HomepageDelivery({super.key});

  @override
  State<HomepageDelivery> createState() => _HomepageDeliveryState();
}

class _HomepageDeliveryState extends State<HomepageDelivery> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Consumer<FirebaseController>(
      builder: (context, instancedeli, child) {
        return
          FutureBuilder(
          future: instancedeli.fetchigdelivery(auth.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final dat = instancedeli.deliveryboy;

            log(snapshot.data.toString());

            return Column(
              children: [
                SizedBox(
                  height: Helper.H(context) * .080,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    // vertical: ResponsiveHelper.getWidth(context) * .180,
                    horizontal: Helper.W(context) * .110,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: Helper.W(context) * .080,
                          //   backgroundImage:
                          //       AssetImage('assets/images/userimg.png'),
                          ),
                          SizedBox(
                            width: Helper.W(context) * .050,
                          ),
                          Column(
                            children: [
                              TextWidget(
                                  text: 'HI',
                                  style: TextStyle(
                                    fontSize: Helper.W(context) * .080,
                                  )),
                              TextWidget(
                                  text: dat!.Name,
                                  style: TextStyle(
                                    fontSize: Helper.W(context) * .050,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Helper.H(context) * .050,
                      ),
                      Textformwidget(
                        hint: 'Enter tracking id number',
                        radius: Helper.W(context) * .020,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Helper.W(context) * .020,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Helper.H(context) * .050,
                      ),
                      //first row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Mainscreencontainer(
                            ontap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Orderbottomdelivery(),
                                  ));
                            },
                            width: Helper.W(context) * .280,
                            height: Helper.H(context) * .110,
                            image: 'assets/images/newordercont.png',
                          ),
                          Mainscreencontainer(
                            ontap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PendingScreenDelivery(),
                                ),
                              );
                            },
                            width: Helper.W(context) * .280,
                            height: Helper.H(context) * .110,
                            image: 'assets/imagesdelivery/Clock.png',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Helper.H(context) * .020,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('OrderRequest'),
                          Text('Pending'),
                        ],
                      ),
                      SizedBox(
                        height: Helper.H(context) * .050,
                      ),

                      //second row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Mainscreencontainer(
                            ontap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Completed(),
                                ),
                              );
                            },
                            width: Helper.W(context) * .280,
                            height: Helper.H(context) * .110,
                            image: 'assets/imagesdelivery/Check All.png',
                          ),
                          Mainscreencontainer(
                            ontap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Canceled(),
                                ),
                              );
                            },
                            width: Helper.W(context) * .280,
                            height: Helper.H(context) * .110,
                            image: 'assets/imagesdelivery/Unavailable.png',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Helper.H(context) * .020,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Completed'),
                          Text('Cancelled'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Helper.H(context) * .050,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Helper.W(context) * .040,
                    ),
                    child: Consumer<FirebaseController>(
                      builder: (context, instance, _) {
                        return StreamBuilder(
                          stream: instance.fetchingproductorder(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            // final sineldocdata = instance.deliveryaccesprdoct;

                            List<Addproductmodel> list = [];

                            list = snapshot.data!.docs.map((e) {
                              return Addproductmodel.fromJson(
                                  e.data() as Map<String, dynamic>);
                            }).toList();

                            if (snapshot.hasData) {
                              return list.isEmpty
                                  ? Center(
                                      child: Text('No order this time'),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: list.length,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: double.infinity,
                                            // height: Helper.H(context) * .200,
                                            decoration: BoxDecoration(
                                              color: Colors.blue.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                Helper.W(context) * .030,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    Helper.W(context) * .020,
                                                horizontal:
                                                    Helper.W(context) * .030,
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          TextWidget(
                                                            text: list[index]
                                                                .Deliveryname,
                                                            style: AppTextStyles
                                                                .boldText(
                                                              fontSize: Helper.W(
                                                                      context) *
                                                                  .050,
                                                            ),
                                                          ),
                                                          TextWidget(
                                                            text:
                                                                '12 march 2024 on 3:00 pm',
                                                            style: TextStyle(
                                                              fontSize: Helper.W(
                                                                      context) *
                                                                  .030,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          TextWidget(
                                                            text: list[index]
                                                                .Deliveryadress,
                                                            style: AppTextStyles
                                                                .regularText(),
                                                          ),

                                                          // TextWidget(
                                                          //   text:
                                                          //       '54 W Nob Hill Blvd City/Town Yakima State/\n Postal Code98902',
                                                          //   style: AppTextStyles
                                                          //       .regularText(
                                                          //     fontSize:
                                                          //         Helper.W(context) *
                                                          //             .025,
                                                          //     color: Colors.grey,
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ContainerWidget(
                                                            color: ColorsClass
                                                                .greenColor,
                                                            width: Helper.W(
                                                                    context) *
                                                                .250,
                                                            height: Helper.H(
                                                                    context) *
                                                                .030,
                                                            text: 'Accept',
                                                            radius: Helper.W(
                                                                    context) *
                                                                .030,
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
                            }
                            return Container();
                          },
                        );
                      },
                    ))
              ],
            );
          },
        );
      },
    ));
  }
}

class Mainscreencontainer extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final VoidCallback ontap;
  const Mainscreencontainer({
    super.key,
    required this.image,
    required this.width,
    required this.height,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(
            Helper.W(context) * .030,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: Helper.H(context) * .020,
            ),
            Image.asset(image),
          ],
        ),
      ),
    );
  }
}
