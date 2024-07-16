import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logitrack/models/addproductorder.dart';
import 'package:logitrack/models/prductmodel.dart';
import 'package:logitrack/modules/user/screens/pages/bottom_bar.dart';
import 'package:logitrack/modules/user/screens/pages/home_page.dart';
import 'package:logitrack/modules/user/screens/pages/routes/home/orderplaced.dart';
import 'package:logitrack/services/controller.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/services/paymentcontroller.dart';
import 'package:logitrack/utils/responsivesize.dart';
import 'package:logitrack/utils/toast.dart';
import 'package:logitrack/widgets/container.dart';
import 'package:logitrack/widgets/text_style.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:upi_india/upi_india.dart';

class PaymentUser extends StatelessWidget {
  final Company? Selectedindex;

  PaymentUser({this.Selectedindex, super.key});

  Widget dividerwidget() {
    return const Divider(
      thickness: 1,
      color: Colors.grey,
    );
  }

  int fee = 10;
  // UpiIndia _upiIndia = UpiIndia();
  // UpiApp app = UpiApp.googlePay;

  @override
  Widget build(BuildContext context) {
    Future<UpiResponse>? transaction;
    final serchController = Provider.of<FirebaseController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
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
                  SizedBox(
                    height: Helper.H(context) * .030,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(
                      Helper.W(context) * .030,
                    ),
                    elevation: 4,
                    child: Container(
                      width: double.infinity,
                      height: Helper.H(context) * .130,
                      child: Row(
                        children: [
                          SizedBox(
                            width: Helper.W(context) * .050,
                          ),
                          Container(
                            width: Helper.W(context) * .150,
                            height: Helper.H(context) * .080,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/Wallet.png',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Helper.W(context) * .050,
                          ),
                          Text(
                            'My Wallet',
                            style: TextStyle(
                              fontSize: Helper.W(context) * .060,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Helper.H(context) * .030,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Helper.W(context) * .060,
                      ),
                      const Text(
                        'Choose Payment',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Helper.H(context) * .030,
                  ),
                  FutureBuilder(
                    future: PaymentController().appopen(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Placeholder for loading state
                      }
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                child: Icon(Icons.payment),
                              ),
                              title: Text(snapshot.data!.name),
                              onTap: () {
                                var j = serchController.prdctprice(
                                    int.parse(Selectedindex!.CompanyCharge));
                                transaction =
                                    PaymentController().initiateTransaction(
                                  // app: snapshot.data![index],
                                  // reciverUpiid: reciverUpiid,
                                  amout: double.parse(j.toString()),
                                  recivename: 'logitrack',
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: Helper.H(context) * .050,
                              ),
                          itemCount: 1);
                    },
                  ),
                  FutureBuilder(
                    future: transaction,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text(
                              _upiErrorHandler(snapshot.error.runtimeType));
                        }
                      }
                      if (snapshot.hasData) {
                        UpiResponse upiResponse = snapshot.data!;

                        String txnId = upiResponse.transactionId ?? 'N/A';
                        String resCode = upiResponse.responseCode ?? 'N/A';
                        String txnRef = upiResponse.transactionRefId ?? 'N/A';
                        String status = upiResponse.status ?? 'N/A';
                        String approvalRef = upiResponse.approvalRefNo ?? 'N/A';
                        _checkTxnStatus(status);
                        return Text('data');
                      }
                      return Text('');
                    },
                  ),
                  SizedBox(
                    height: Helper.H(context) * .050,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Helper.W(context) * .060,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Price Details',
                              style: AppTextStyles.boldText(
                                fontSize: Helper.W(context) * .040,
                              ),
                            ),
                          ],
                        ),
                        dividerwidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Package Price',
                              style: AppTextStyles.regularText(
                                fontSize: Helper.W(context) * .050,
                              ),
                            ),
                            Text(
                              '\$ ${serchController.prdctprice(int.parse(Selectedindex!.CompanyCharge))}',
                              style: AppTextStyles.regularText(
                                fontSize: Helper.W(context) * .050,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Helper.H(context) * .020,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Taxes',
                              style: AppTextStyles.regularText(
                                fontSize: Helper.W(context) * .040,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '\$8.3',
                              style: AppTextStyles.regularText(
                                fontSize: Helper.W(context) * .040,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Helper.H(context) * .020,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery changes',
                              style: AppTextStyles.regularText(
                                color: Colors.grey,
                                fontSize: Helper.W(context) * .040,
                              ),
                            ),
                            Text(
                              '15',
                              style: AppTextStyles.regularText(
                                color: Colors.grey,
                                fontSize: Helper.W(context) * .040,
                              ),
                            ),
                          ],
                        ),
                        dividerwidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Package Total',
                              style: AppTextStyles.regularText(
                                fontSize: Helper.W(context) * .040,
                              ),
                            ),
                            Text(
                              '${serchController.prdctprice(int.parse(Selectedindex!.CompanyCharge))}',
                              style: AppTextStyles.regularText(
                                fontSize: Helper.W(context) * .040,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Helper.H(context) * .040,
                        ),
                        GestureDetector(
                          onTap: () {
                            log(Selectedindex.toString());

                            log(Selectedindex!.CompanyCharge.toString());
                            String prodid = randomAlpha(5);
                            String date =
                                DateFormat("dd/MM/yyyy").format(DateTime.now());

                            serchController
                                .addorderdetail(Addproductmodel(
                                    // id: Controller.auth.currentUser!.uid,
                                    userid:
                                        serchController.auth.currentUser!.uid,
                                    Pickupfromname:
                                        serchController.Pickeupname.text,
                                    Pickupfromnumber:
                                        serchController.pickupnumber.text,
                                    Pickupaddress:
                                        serchController.pickupadress.text,
                                    Deliveryname:
                                        serchController.deliveryname.text,
                                    Deliveryadress:
                                        serchController.deliveryadress.text,
                                    Deliverynumber:
                                        serchController.deliverynumber.text,
                                    Producttype:
                                        serchController.producttype.text,
                                    Prductweight:
                                        serchController.prodcutweight.text,
                                    productid: prodid,
                                    payment: true,
                                    orderdate: date,
                                    orderstatus: 'orderconfirmed'))
                                .then((value) {
                              serchController.clearcontroller();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderConformed()),
                              );

                              succestoast(context, 'Product added successfully');
                            });
                          },
                          child: ContainerWidget(
                            width: double.infinity,
                            height: Helper.H(context) * .060,
                            text: 'Place Order',
                            radius: Helper.W(context) * .050,
                          ),
                        ),
                        SizedBox(
                          height: Helper.H(context) * .040,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }
}

class PaymentListtilewidget extends StatelessWidget {
  final String image;
  final VoidCallback ontap;
  const PaymentListtilewidget({
    super.key,
    required this.image,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      leading: SizedBox(
        width: Helper.W(context) * .180,
        height: Helper.H(context) * .080,
        child: Image.asset(image),
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}










   // // PaymentListtilewidget(
                  //   image: 'assets/images/payment/paytm.png',
                  //   ontap: () {},
                  // ),
                  // PaymentListtilewidget(
                  //   image: 'assets/images/payment/phonepay.png',
                  //   ontap: () {},
                  // ),
                  // PaymentListtilewidget(
                  //   image: 'assets/images/payment/paypal.png',
                  //   ontap: () {},
                  // ),
                  // PaymentListtilewidget(
                  //   image: 'assets/images/payment/bank.png',
                  //   ontap: () {},
                  // ),
                  // SizedBox(
                  //   height: Helper.H(context) * .050,
                  // ),