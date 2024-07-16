import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logitrack/modules/user/screens/pages/bottom_bar.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/utils/responsivesize.dart';
import 'package:logitrack/utils/strings.dart';
import 'package:provider/provider.dart';

class TrackOrderScreen extends StatefulWidget {
  TrackOrderScreen({super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  bool? _loading;

  double? _progressValue;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 20;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tracking'),
        ),
        body: Consumer<FirebaseController>(
          builder: (context, instance, child) {
            return FutureBuilder(
              future: instance.fetchtracking(),
              builder: (context, snapshot) {
                final prdctdt = instance.productmodl;
                return prdctdt.isEmpty
                    ? Center(
                        child: Text('no track order'),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Helper.W(context) * .050,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
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
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Order id'),
                                                  Text(
                                                    prdctdt[index].productid,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(prdctdt[index]
                                                      .orderdate
                                                      .toString()),
                                                  Text(prdctdt[index]
                                                      .Pickupaddress),
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
                                                    height: Helper.H(context) *
                                                        .020,
                                                  ),
                                                  Text('16 march 2024'),
                                                  Text(prdctdt[index]
                                                      .Deliveryadress),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: LinearProgressIndicator(
                                            backgroundColor: Colors.cyanAccent,
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                    Color>(Colors.blue),
                                            value: _progressValue,
                                          ),
                                        ),
                                        Text(auth.currentUser!.uid)
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: Helper.H(context) * .040,
                                  );
                                },
                                itemCount: instance.productmodl.length,
                              ),
                            ),
                          ],
                        ),
                      );
              },
            );
          },
        )

        // bottomNavigationBar: mynav(
        //   index: 0,
        //   onTap: (index) {
        //     if (index == 0) {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => Bottomnav(selectedindex: 0),
        //           ));
        //     } else if (index == 1) {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => Bottomnav(selectedindex: 1),
        //           ));
        //     } else if (index == 2) {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => Bottomnav(selectedindex: 2),
        //           ));
        //     } else if (index == 3) {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => Bottomnav(selectedindex: 3),
        //           ));
        //     } else if (index == 4) {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => Bottomnav(selectedindex: 3),
        //           ));
        //     }
        //   },
        // ),
        );
  }
}
