import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

addUser() async {
//   CollectionReference collectionReference = db.collection("user");

//   DocumentReference docReference = collectionReference.doc("123456789");
//   final docSnapshot = await docReference.get();
//   final dara = docSnapshot.data();
//   print(docSnapshot.data());

// /////////////////////
  final querySnapshot = await db.collection("user").get();

  final listofData = querySnapshot.docs;

  listofData.map((e) => e["name"]);
  // for (var i in listofData) {
  //   i["name"];
  // }

  // final snapshot = await db.collection("collectionPath").doc("124").get();
  // // if (snapshot.exists) {
  // final data = snapshot.data();
  // print(data!["name"]);
  // // }
}









// import 'package:flutter/material.dart';

// class MyWidget extends StatelessWidget {
//    MyWidget({super.key});
//   car obj = car();
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//     +
//   }
// }

// class car {}




  // Addproductmodel? singleProduct;
// List <Addproductmodel>
  // fetchproduct() async {
//    final a=await db.collection('addNewOrder').get();
// a.docs.map((e){
//   return
// })

//     final snapshotSingleProduct =
//         await db.collection('addNewOrder').doc("123456").get();
//  final name=   snapshotSingleProduct.data()!["name"];
//   final age=   snapshotSingleProduct.data()!["age"];

//    Addproductmodel.fromJson(snapshotSingleProduct.data()!);
//   }

  //   Future addNewReview(postId, CommentModel reviewModel) async {
  //   final reviwdoc = db.collection("Comment").doc();
  //   reviwdoc.set(reviewModel.toJson(reviwdoc.id));
  // }