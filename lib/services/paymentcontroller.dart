import 'package:flutter/cupertino.dart';
import 'package:upi_india/upi_india.dart';

class PaymentController with ChangeNotifier {
  UpiIndia _upiIndia = UpiIndia();
  UpiApp app = UpiApp.googlePay;

  Future<UpiApp> appopen() async {
    return UpiApp.googlePay;
  }

  Future<UpiResponse> initiateTransaction({
    // required UpiApp app,
    // required String reciverUpiid,
    required double amout,
    required String recivename,
  }) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: ' upiid',
      receiverName: recivename,
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount: amout,
    );
  }
}
