import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logitrack/modules/company/widgets/text_style.dart';

import 'package:logitrack/modules/user/screens/pages/routes/home/newOrder.dart';
import 'package:logitrack/modules/user/screens/pages/routes/home/reviews.dart';
import 'package:logitrack/modules/user/screens/pages/track_order.dart';
import 'package:logitrack/services/controller.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/services/user_controller.dart';

import 'package:logitrack/utils/responsivesize.dart';
import 'package:logitrack/utils/strings.dart';
import 'package:logitrack/widgets/textformwidget.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool? _loading;
  double? _progressValue;
  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 20;
  }

  final _formKey = GlobalKey<FormState>();

  final search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final helper = Provider.of<FirebaseController>(context, listen: false);
    return SingleChildScrollView(
        child: FutureBuilder(
      future: helper.fetchSelectedUSerdata(auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: AlertDialog(
                content: CircularProgressIndicator(),
              ),
            ),
          );
        }
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
                        backgroundImage:
                            NetworkImage(helper.userModel!.imageurl),
                      ),
                      SizedBox(
                        width: Helper.W(context) * .050,
                      ),
                      Column(
                        children: [
                          TextWidget(
                              text: 'Hi',
                              style: TextStyle(
                                fontSize: Helper.W(context) * .050,
                              )),
                          TextWidget(
                            text: helper.userModel!.name,
                            style: TextStyle(
                              fontSize: Helper.W(context) * .050,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: Helper.H(context) * .050,
                  ),
                  Textformwidget(
                    controller: search,
                    hint: 'Enter Tracking id number',
                    radius: Helper.W(context) * .020,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the required field";
                      } else {
                        return null;
                      }
                    },
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
                  Container(
                    width: double.infinity,
                    height: Helper.H(context) * .300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Helper.W(context) * .030,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/containerimg.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Helper.H(context) * .050,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Helper.W(context) * .030,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewOrderScreen(),
                              ));
                        },
                        child: MainscreenContainer(
                          image: 'assets/images/newordercont.png',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrackOrderScreen(),
                              ));
                        },
                        child: MainscreenContainer(
                          image: 'assets/images/trackorder.png',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviesScreen(),
                              ));
                        },
                        child: MainscreenContainer(
                          image: 'assets/images/reviews.png',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('New Order'),
                      Text('Track Order'),
                      Text('Reviews'),
                    ],
                  ),
                  SizedBox(
                    height: Helper.H(context) * .050,
                  ),
                  Text('Recent Delivery'),
                  SizedBox(
                    height: Helper.H(context) * .030,
                  ),

                  //  future: instance.fetchingorderstatus('order pending'),
                  // builder: (context, snapshot) {
                  //   final dat = snapshot.data;

                  Consumer<FirebaseController>(
                    builder: (context, instance, child) {
                      return FutureBuilder(
                        future: instance.fetchingorderstatus('Complete'),
                        builder: (context, snapshot) {
                          // final prdctdt = instance.productmodl;.
                          final coutpending = instance.orderstatus;

                          return coutpending.isEmpty
                              ? Center(
                                  child: Text(
                                      'No Recent Delivery \n        Order '),
                                )
                              : ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TrackOrderScreen(),
                                            ));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: Helper.H(context) * .200,
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade50,
                                          borderRadius: BorderRadius.circular(
                                            Helper.W(context) * .030,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Text('Order id'),
                                                      Text(coutpending[index]
                                                          .productid),
                                                      Text('12 march 2024'),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Text('cont'),
                                                      SizedBox(
                                                        height:
                                                            Helper.H(context) *
                                                                .020,
                                                      ),
                                                      Text('16 march 2024'),
                                                      Text(
                                                        coutpending[index]
                                                            .Deliveryadress,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: LinearProgressIndicator(
                                                backgroundColor:
                                                    Colors.cyanAccent,
                                                valueColor:
                                                    new AlwaysStoppedAnimation<
                                                        Color>(Colors.red),
                                                value: _progressValue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: Helper.H(context) * .020,
                                    );
                                  },
                                  itemCount: coutpending.length);
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: Helper.H(context) * .030,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ));
  }
}

class MainscreenContainer extends StatelessWidget {
  final String image;
  const MainscreenContainer({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Helper.W(context) * .280,
      height: Helper.H(context) * .110,
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
    );
  }
}
