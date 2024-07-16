import 'package:flutter/material.dart';
import 'package:logitrack/models/deliveryboys.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/tsetssss.dart';
import 'package:logitrack/utils/toast.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/responsivesize.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  List<String> deliveryboys = [
    'assets/images/delivery_boys/1.png',
    'assets/images/delivery_boys/2.png',
    'assets/images/delivery_boys/3.png',
    'assets/images/delivery_boys/4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Delivery Boys'),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<FirebaseController>(
                builder: (context, instance, child) {
                  return StreamBuilder(
                    stream: instance.getAllDeliveryboys(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      List<DeliveryBoysModel> list = [];

                      list = snapshot.data!.docs.map((e) {
                        return DeliveryBoysModel.fromJson(
                            e.data() as Map<String, dynamic>);
                      }).toList();

                      if (snapshot.hasData) {
                        return list.isEmpty
                            ? Center(
                                child: Text("NO DELIVERY BOY ASSIGNED"),
                              )
                            : ListView.separated(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          AssetImage(deliveryboys[index]),
                                    ),
                                    title: Text(list[index].Name),
                                    subtitle: Text(
                                      list[index].DLNumber,
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        db
                                            .collection('DeliveryBoys')
                                            .doc(list[index].id)
                                            .delete()
                                            .then((value) {
                                          succestoast(
                                              context, 'DELETE DELIVERY BOY');
                                        });
                                      },
                                      child: Container(
                                        width: Helper.W(context) * .150,
                                        height: Helper.H(context) * .030,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(
                                                Helper.W(context) * .020)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Remove',
                                              style: TextStyle(
                                                  color:
                                                      ColorsClass.whiteColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: Helper.W(context) * .020,
                                  );
                                },
                              );
                      }
                      return Container();
                    },
                  );
                },
              )
            ],
          ),
        ));
  }
}
