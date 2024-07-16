import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logitrack/models/addproductorder.dart';
import 'package:logitrack/models/addressmodel.dart';
import 'package:logitrack/models/company.dart';
import 'package:logitrack/models/deliveryboys.dart';

import 'package:logitrack/models/prductmodel.dart';
import 'package:logitrack/models/reviewmodel.dart';
import 'package:logitrack/models/user_model.dart';
import 'package:logitrack/utils/strings.dart';

import 'package:logitrack/utils/toast.dart';

class FirebaseController with ChangeNotifier {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  String suffix = 'gm';
  DateTime now = DateTime.now();

  // cntroller

  final formKey = GlobalKey<FormState>();

  final Pickeupname = TextEditingController();
  final pickupnumber = TextEditingController();
  final pickupadress = TextEditingController();
  final deliveryname = TextEditingController();
  final deliverynumber = TextEditingController();
  final deliveryadress = TextEditingController();
  final producttype = TextEditingController();
  final prodcutweight = TextEditingController();

  // company
  TextEditingController companyusernameController = TextEditingController();
  TextEditingController companyemailController = TextEditingController();
  TextEditingController companylisence = TextEditingController();
  TextEditingController companylocation = TextEditingController();
  TextEditingController companypassword = TextEditingController();

  // company login
  TextEditingController companylogginemail = TextEditingController();
  TextEditingController companypasswordloggin = TextEditingController();

  clearcontroller() {
    Pickeupname.clear();
    pickupnumber.clear();
    pickupadress.clear();
    deliveryname.clear();
    deliverynumber.clear();
    deliveryadress.clear();
    producttype.clear();
    prodcutweight.clear();
  }

  // ========create

  Future addReview(ReviewModel reviewModel) async {
    final snapshot = db.collection('Review').doc();

    snapshot.set(reviewModel.tojsone(snapshot.id));
  }

  Stream<QuerySnapshot> getAllReview() {
    return db.collection('Review').snapshots();
  }

  Future adduser(String uid, usermodel) async {
    db.collection('Users').doc(uid).set(usermodel.tojson(uid));
  }

  Future Companysignup(String uid, CompanyModel companymodel) async {
    log('add db');

    await db.collection('CompanyUsers').doc(uid).set(companymodel.toJson(uid));
  }

  Future<void> logout(BuildContext context) async {
    try {
      await auth.signOut();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Loggedout successfully')));
    } catch (e) {
      log('error logout $e');
    }
  }

  UserModel? userModel;
  Future<bool> fetchSelectedUSerdata(uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection('Users').doc(uid).get();

    if (snapshot.exists) {
      userModel = UserModel.fromJson(snapshot.data()!);
      return true;
    } else {
      return false;
    }
  }

  Future addorderdetail(Addproductmodel addpdmodel) async {
    final addorderdet = db.collection('addNewOrder').doc();

    addorderdet.set(addpdmodel.tojson(addorderdet.id));
  }

  Future addadres(AddresModel addresModel, uid) async {
    final docs = db.collection('Users').doc(uid).collection('address').doc(uid);
    await docs.set(addresModel.toJson(docs.id));
    notifyListeners();
  }

  AddresModel? adremodel;
  Future<AddresModel?> fetchadress() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('address')
        .get();

    var data = snapshot.docs.first.data();
    return AddresModel.fromJson(data);
  }

  List<Addproductmodel> productmodl = [];
  Future fetchtracking() async {
    QuerySnapshot<Map<String, dynamic>> snapshotd = await db
        .collection('addNewOrder')
        .where('userid', isEqualTo: auth.currentUser!.uid)
        .get();

    productmodl = snapshotd.docs.map((e) {
      return Addproductmodel.fromJson(e.data());
    }).toList();

    log(' product model    ${productmodl.length.toString()}');
  }

  Stream<QuerySnapshot> companyfetch() {
    return db.collection('Companyies').snapshots();
  }

  Future addcompanyies(
    Company productmodel,
    BuildContext context,
  ) async {
    try {
      final com = await db.collection('Companyies').doc();

      com.set(productmodel.tojson(com.id));
    } catch (e) {
      errortoast(context, "Invalid account information");
    }
  }

  // store provider data

  int prdctprice(int companyPrice) {
    double weight;
    try {
      weight = double.parse(prodcutweight.text);
    } catch (e) {
      print("Invalid weight input");
      return 0;
    }

    int sum = (companyPrice * weight).toInt();

    notifyListeners();

    return sum;
  }

  // delivery boys db

  Future addDelivery(
    DeliveryBoysModel deliveryBoys,
  ) async {
    var snapshot = db.collection('DeliveryBoys').doc(auth.currentUser!.uid);
    snapshot.set(deliveryBoys.tojson(snapshot.id));
  }

  List<Addproductmodel> deliveryaccesprdoct = [];
  Stream<QuerySnapshot> fetchingproductorder() {
    return db.collection('addNewOrder').snapshots();

    // snapshotd.listen((snapshot) {
    //   deliveryaccesprdoct = snapshot.docs.map((doc) {
    //     return Addproductmodel.fromJson(doc.data() as Map<String, dynamic>);
    //   }).toList();
    // }, onError: (error) {
    //   log('Error fetching product orders: $error');
    // });
  }

  Addproductmodel? deliverydetails;
  Future deliverystatus(id) async {
    final snap = await db.collection('addNewOrder').doc(id).get();

    if (snap.exists) {
      deliverydetails = Addproductmodel.fromJson(snap.data()!);
    }
  }

  // fetching were ordertype
  List<Addproductmodel> orderstatus = [];
  Future fetchingorderstatus(String were) async {
    Stream<QuerySnapshot> snapshotd = db
        .collection('addNewOrder')
        .where('orderstatus', isEqualTo: were)
        .snapshots();

    snapshotd.listen((event) {
      orderstatus = event.docs.map((e) {
        return Addproductmodel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
    });

    log(' product model    ${orderstatus.length.toString()}');
  }

  // fetch deliveryboy
  DeliveryBoysModel? deliveryboy;
  Future fetchigdelivery(uid) async {
    final snapshot = await db.collection('DeliveryBoys').doc(uid).get();

    if (snapshot.exists) {
      deliveryboy = DeliveryBoysModel.fromJson(snapshot.data()!);
    }
  }

  //delivery boy

  final isconform = false;

  Future updateconfoorm(userid, String status) async {
    await db.collection('addNewOrder').doc(userid).update({
      'orderstatus': status,
    });
  }

  String? deliverydoc;

  List<DeliveryBoysModel> deliverylist = [];
  Stream<QuerySnapshot> fetchDelivery() {
    return db.collection('DeliveryBoys').snapshots();

    // snapshot.listen((event) {
    //   deliverylist = event.docs.map((e) {
    //     return DeliveryBoys.fromJson(e.data());
    //   }).toList();
    // });
  }

  Stream<QuerySnapshot> getAlluser() {
    return db.collection('Users').snapshots();
  }

  Future remooveDelivery(docid) async {
    try {
      db.collection('DeliveryBoys').doc(docid).delete();
    } catch (e) {
      log(e.toString());
    }
  }

  Future userremove(docid) async {
    try {
      db.collection('Users').doc(docid).delete();
    } catch (e) {
      log(e.toString());
    }
  }

  bool Orderrequst = false;
  void orderrequstclick() {
    Orderrequst = true;
    notifyListeners();
  }

  bool ordercancel = false;
  void ordercancelclick() {
    ordercancel = true;
    notifyListeners();
  }

  bool procesing = false;
  void procesingclik() {
    procesing = true;
    notifyListeners();
  }

  bool complete = false;

  void completeclick() {
    complete = true;
    notifyListeners();
  }

  String _orderStatus = '';

  String get orderStatus => _orderStatus;

  void updateorderstatus(String status) {
    _orderStatus = status;
    notifyListeners();
  }

  List<Addproductmodel> order = [];

  Future getStatus(String uid) async {
    final snapshotd = db
        .collection('addNewOrder')
        .where('userid', isEqualTo: uid)
        .snapshots();

    snapshotd.listen((event) {
      order = event.docs.map((e) {
        return Addproductmodel.fromJson(e.data());
      }).toList();
    });
  }

  int selectedindex = 0;

  void statusupdate(uid) async {
    final querysanp = await db
        .collection('addNewOrder')
        .where('userid', isEqualTo: uid)
        .get();

    if (querysanp.docs.isNotEmpty) {
      final status = querysanp.docs.first.data()['orderstatus'];

      switch (status) {
        case 'order request':
          selectedindex = 1;
          notifyListeners();
        case 'or':
          selectedindex = 2;
          notifyListeners();
          break;
        default:
          log('no status');
      }
    }
  }

  Stream<QuerySnapshot> getAllDeliveryboys() {
    return db.collection('DeliveryBoys').snapshots();
  }

  CompanyModel? companyModel;

  Future<void> getProfiel(String uid) async {
    final snapshot = db.collection('CompanyUsers').doc(uid).snapshots();

    snapshot.listen((event) {
      if (event.exists) {
        companyModel =
            CompanyModel.fromJsone(event.data() as Map<String, dynamic>);
      } else {
         
        companyModel = null;
      }
    });
  }

  Future companysignup(String uid, CompanyModel companymodel) async {
    await db.collection('CompanyUsers').doc(uid).set(companymodel.toJson(uid));
  }
}
