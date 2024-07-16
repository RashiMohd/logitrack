import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logitrack/models/deliveryboys.dart';
import 'package:logitrack/models/user_model.dart';

import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/utils/colors.dart';
import 'package:logitrack/utils/toast.dart';
import 'package:provider/provider.dart';

import '../../../../utils/responsivesize.dart';

Future<void> _showMyDialog(BuildContext context, UserModel) async {
  final provider = Provider.of<FirebaseController>(context, listen: false);

  final d = provider.deliverylist;

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('are you sure remove '),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              await provider.userremove(UserModel);
              Navigator.of(context).pop();
              succestoast(context, 'Delete User  succes');
            },
          ),
        ],
      );
    },
  );
}

Widget userView(context) {
  final provider = Provider.of<FirebaseController>(context, listen: false);
  return SingleChildScrollView(
      child: Padding(
    padding: EdgeInsets.symmetric(
      horizontal: Helper.W(context) * .030,
      vertical: Helper.H(context) * .020,
    ),
    child: Column(children: [
      Container(
        width: double.infinity,
        height: Helper.H(context) * .950,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Helper.W(context) * .030,
          ),
          color: ColorsClass.blueshade,
        ),
        child: Column(
          children: [
            SizedBox(
              height: Helper.H(context) * .050,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: Helper.W(context) * .300,
                    height: Helper.H(context) * .850,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Helper.W(context) * .030,
                      ),
                      // color: Colors.red,
                    ),
                    child: StreamBuilder(
                      stream: provider.getAlluser(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        List<UserModel> list = [];

                        list = snapshot.data!.docs.map((e) {
                          return UserModel.fromJson(
                              e.data() as Map<String, dynamic>);
                        }).toList();

                        if (snapshot.hasData) {
                          return list.isEmpty
                              ? Center(
                                  child: Text('NO USER '),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.separated(
                                    itemCount: list.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              list[index].imageurl),
                                        ),
                                        title: Text(list[index].name),
                                        subtitle: Text(list[index].email),
                                        trailing: GestureDetector(
                                          onTap: () => _showMyDialog(
                                              context, list[index].uid),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: Helper.W(context) * .050,
                                            height: Helper.H(context) * .030,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF084077),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Helper.W(context) *
                                                            .020)),
                                            child: Text(
                                              'Remove',
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                  ),
                                );
                        }
                        return Container();
                      },
                    )),
                //   Container(
                //     width: Helper.W(context) * .300,
                //     height: Helper.H(context) * .850,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(
                //         Helper.W(context) * .030,
                //       ),
                //       // color: Colors.red,
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: ListView.separated(
                //           shrinkWrap: true,
                //           itemBuilder: (context, index) {
                //             return ListTile(
                //                 leading: CircleAvatar(),
                //                 title: Text('list'),
                //                 subtitle: Text('fayissubsittl'),
                //                 trailing: Containerwidget());
                //           },
                //           separatorBuilder: (context, index) {
                //             return SizedBox(
                //               height: Helper.H(context) * .030,
                //             );
                //           },
                //           itemCount: 30),
                //     ),
                //   ),
              ],
            )
          ],
        ),
      )
    ]),
  ));
}
