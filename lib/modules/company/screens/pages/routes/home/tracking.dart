import 'dart:async';
import 'dart:developer';

import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logitrack/models/addproductorder.dart';
import 'package:logitrack/models/company.dart';
import 'package:logitrack/modules/company/utils/responsivesize.dart';
import 'package:logitrack/services/controller.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/tsetssss.dart';
import 'package:logitrack/utils/responsivesize.dart';
import 'package:logitrack/utils/strings.dart';
import 'package:provider/provider.dart';

class Orderbottom extends StatefulWidget {
  const Orderbottom({super.key});

  @override
  State<Orderbottom> createState() => _OrderbottomState();
}

class _OrderbottomState extends State<Orderbottom> {
  int _index = 0;

  int activeIndex = 0;
  final Completer<GoogleMapController> _controller = Completer();

  final google_api_key = "AIzaSyBZHkeiz0Y1kI-xgC4rzrqObBNu_8DEA6I";

  static const LatLng sourceLocation = LatLng(10.98, 76.23);
  static const LatLng destination = LatLng(10.9985, 76.1422);

  List<LatLng> polylineCoordinates = [];

  void getpolyPoint() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(
            point.latitude,
            point.longitude,
          ),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    getpolyPoint();
    super.initState();
  }

  List<StepperData> generateStepperData() {
    return [
      StepperData(
        title: StepperText("Shipment Created"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: const Icon(Icons.check_box, color: Colors.white),
        ),
      ),
      StepperData(
        title: StepperText("Vehicle Assigned"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.check_box, color: Colors.white),
        ),
      ),
      StepperData(
        title: StepperText("Shipment picked"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.check_box, color: Colors.white),
        ),
      ),
      StepperData(
        title: StepperText("In Transit"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.check_box, color: Colors.white),
        ),
      ),
      if (activeIndex == 4)
        StepperData(
          title: StepperText("Shipment Delivered"),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: const Icon(Icons.check_box, color: Colors.white),
          ),
        ),
    ];
  }

  Addproductmodel? addproductmodel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: ResponsiveHelper.getHeight(context) * .040,
            ),
            Container(
              height: ResponsiveHelper.getHeight(context) / 2,
              // color: Colors.red,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 15.0,
                    offset: Offset(0.0, 0.75))
              ]),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: sourceLocation,
                  zoom: 14.5,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                polylines: {
                  if (polylineCoordinates.isNotEmpty)
                    Polyline(
                      polylineId: PolylineId("route"),
                      points: polylineCoordinates,
                      color: Colors.blue,
                      width: 4,
                    )
                },
                markers: {
                  Marker(
                    markerId: MarkerId('Source'),
                    position: sourceLocation,
                  ),
                  Marker(
                    markerId: MarkerId('destination'),
                    position: destination,
                  ),
                },
              ),
            ),
            SizedBox(
              height: ResponsiveHelper.getHeight(context) * .020,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.getWidth(context) * .050,
              ),
              child: Container(
                padding: EdgeInsets.only(
                  left: ResponsiveHelper.getWidth(context) * .050,
                  right: ResponsiveHelper.getWidth(context) * .050,
                ),
                width: double.infinity,
                height: ResponsiveHelper.getHeight(context) * .110,
                decoration: BoxDecoration(
                  color: Color(0xFFD3EBF7),
                  borderRadius: BorderRadius.circular(
                      ResponsiveHelper.getWidth(context) * .010),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: ResponsiveHelper.getWidth(context) * .070,
                    ),
                    Spacer(),
                    Icon(Icons.call),
                    Icon(Icons.message_outlined),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: ResponsiveHelper.getHeight(context) * .030,
            ),
            // Stepper(
            //   physics: BouncingScrollPhysics(),
            //   currentStep: _index,
            //   onStepCancel: () {},
            //   onStepContinue: () {},
            //   onStepTapped: (int index) {},
            //   steps: <Step>[
            //     Step(
            //       title: const Text('Shipment Created'),
            //       content: Text(''),
            //       isActive: true,
            //     ),
            //     const Step(
            //       title: Text('Vehicle Assigned'),
            //       content: Text(' '),
            //     ),
            //     Step(title: const Text('Shipment Picked'), content: Text('')),
            //     Step(title: const Text(' In transit'), content: Text('')),
            //     Step(title: const Text('Shipment Delivered '), content: Text('')),
            //   ],
            // )

            // Padding(
            //   padding: const EdgeInsets.all(20),
            //   child: AnotherStepper(
            //     stepperList: generateStepperData(),
            //     stepperDirection: Axis.vertical,
            //     iconWidth: 40,
            //     iconHeight: 40,
            //     activeBarColor: Colors.blue,
            //     inActiveBarColor: Colors.grey,
            //     inverted: false,
            //     verticalGap: 30,
            //     activeIndex: activeIndex,
            //     barThickness: 8,
            //   ),
            // ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('addNewOrder')
                  .where('userid', isEqualTo: auth.currentUser!.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data != null) {
                    var documents = snapshot.data!.docs;
                    if (documents.isNotEmpty) {
                      // Assuming you want to take the status of the first document
                      var data = documents.first.data() as Map<String, dynamic>;
                      String status = data['orderstatus'] ?? 'default';

                      int activeIndex;
                      switch (status) {
                        case 'order request':
                          activeIndex = 1;
                          break;
                        case 'in_progress':
                          activeIndex = 1;
                          break;
                        case 'cancelled':
                          activeIndex = 2;
                          break;
                        case 'completed':
                          activeIndex = 3;
                          break;
                        default:
                          activeIndex = 0;
                      }

                      return AnotherStepper(
                        stepperList: generateStepperData(),
                        stepperDirection: Axis.vertical,
                        iconWidth: 40,
                        iconHeight: 40,
                        activeBarColor: Colors.blue,
                        inActiveBarColor: Colors.grey,
                        inverted: false,
                        verticalGap: 30,
                        activeIndex: activeIndex,
                        barThickness: 8,
                      );
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Center(child: Text('Document does not exist'));
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            //   Column(
            //     children: [
            //       ElevatedButton(
            //         onPressed: () {
            //           setState(() {
            //             activeIndex = 1;
            //           });
            //         },
            //         child: Text('insta'),
            //       ),
            //       ElevatedButton(
            //         onPressed: () {
            //           setState(() {
            //             activeIndex = 2;
            //           });
            //         },
            //         child: Text('youtube'),
            //       ),
            //       ElevatedButton(
            //         onPressed: () {
            //           setState(() {
            //             activeIndex = 3;
            //           });
            //         },
            //         child: Text('upload'),
            //       ),
            //       ElevatedButton(
            //         onPressed: () {
            //           setState(() {
            //             activeIndex = 4;
            //           });
            //         },
            //         child: Text('refer'),
            //       ),
            //     ],
            //   )
          ],
        ),
      ),
    );
  }
}

// void activeindex(BuildContext context) async {
//   final provdr = Provider.of<Controller>(context);

//   final fetch = Provider.of<FirebaseController>(context);

//   QuerySnapshot<Map<String, dynamic>> dat = await db
//       .collection('addNewOrder')
//       .where('userid', isEqualTo: auth.currentUser!.uid)
//       .get();

//   switch (dat.docs) {
//     case 1:
//       provdr.activeindex;
//     case 2:
//       provdr.activeindex;
//   }
// }

class CompanyOrder extends StatelessWidget {
  const CompanyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = auth.currentUser!.uid;
    log(uid);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<FirebaseController>(
              builder: (context, instance, child) {
                return FutureBuilder(
                  future: instance.getStatus(uid),
                  builder: (context, snapshot) {
                    final data = instance.order;
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: instance.order.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Helper.W(context) * .050,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Orderbottom(),
                                  ));
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(
                                  Helper.W(context) * .020),
                              elevation: 4,
                              child: Container(
                                width: Helper.W(context) * .220,
                                height: Helper.H(context) * .120,
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        Text('TRACK YOUR ORDER'),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Helper.H(context) * .020,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(data[index].Pickupaddress),
                                        Text('<=To=>'),
                                        Text(data[index].Deliveryadress)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: Helper.H(context) * .050,
                        );
                      },
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
