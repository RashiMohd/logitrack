import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logitrack/models/prductmodel.dart';
import 'package:logitrack/modules/admin/view/dashboard_home/dashboard_home.dart';
import 'package:logitrack/modules/company/widgets/container.dart';
import 'package:logitrack/modules/company/widgets/textformwidget.dart';
import 'package:logitrack/services/firebase_controller.dart';
import 'package:logitrack/utils/responsivesize.dart';
import 'package:logitrack/utils/toast.dart';
import 'package:provider/provider.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({super.key});

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  String imageUrl = '';
  var profileImage;
  XFile? pickedFile;
  File? image;
  Uint8List webImage = Uint8List(8);

  final CompanyName = TextEditingController();
  final CompanyCharge = TextEditingController();
  bool selectd = false;

  final firebaseStorage = FirebaseStorage.instance;

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    if (kIsWeb) {
      final XFile? returnImage =
          await picker.pickImage(source: ImageSource.gallery);
      if (returnImage != null) {
        var f = await returnImage.readAsBytes();
        setState(() {
          webImage = f;
        });
      } else {
        errortoast(context, 'Error picking image');
      }
    } else {
      final XFile? returnImage =
          await picker.pickImage(source: ImageSource.gallery);
      if (returnImage != null) {
        setState(() {
          image = File(returnImage.path);
        });
      } else {
        errortoast(context, 'Error picking image');
      }
    }
  }

  Future<void> _addProduct() async {
    if (image == null && webImage.isEmpty) {
      errortoast(context, 'Please select an image');
      return;
    }

    try {
      final now = DateTime.now();
      String url;
      if (kIsWeb) {
        UploadTask uploadTask = firebaseStorage
            .ref('productimg/$now')
            .putData(webImage, SettableMetadata(contentType: 'image/jpeg'));
        TaskSnapshot snapshot = await uploadTask;
        url = await snapshot.ref.getDownloadURL();
      } else {
        UploadTask uploadTask = firebaseStorage
            .ref('productimg')
            .putFile(image!, SettableMetadata(contentType: 'image/jpeg'));
        TaskSnapshot snapshot = await uploadTask;
        url = await snapshot.ref.getDownloadURL();
      }

      log('Image URL: $url');

      await Provider.of<FirebaseController>(context, listen: false)
          .addcompanyies(
              Company(
                CompanyName: CompanyName.text,
                imageurl: url,
                CompanyCharge: CompanyCharge.text,
                wdwide: selectd,
              ),
              context);
      log('Add product success');
      succestoast(context, 'Add product success');
    } catch (e) {
      errortoast(context, 'Failed to add product');
      log('Error: $e');
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: Helper.H(context) * .050,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await _pickImageFromGallery();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: Helper.W(context) * .50,
                  height: Helper.H(context) * .20,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: image != null || webImage.isNotEmpty
                      ? (kIsWeb
                          ? Image.memory(
                              webImage,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ))
                      : Icon(Icons.camera_alt_outlined),
                ),
              ),
              SizedBox(
                height: Helper.H(context) * .050,
              ),
            ],
          ),
          SizedBox(
            height: Helper.H(context) * .050,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Helper.W(context) * .200,
                child: Textformwidget(
                    controller: CompanyName,
                    hint: 'Company name',
                    radius: Helper.W(context) * .020),
              ),
              SizedBox(
                width: Helper.W(context) * .050,
              ),
              SizedBox(
                width: Helper.W(context) * .200,
                child: Textformwidget(
                  controller: CompanyCharge,
                  hint: 'Shiping charge ',
                  radius: Helper.W(context) * .020,
                ),
              ),
            ],
          ),
          SizedBox(
            height: Helper.H(context) * .050,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: Helper.W(context) * .50,
                  child: Row(
                    children: [
                      Text('Add worl wide courier'),
                      Checkbox(
                        value: selectd,
                        onChanged: (bool? value) {
                          setState(() {
                            selectd = value!;
                          });
                        },
                      )
                    ],
                  )),
            ],
          ),
          SizedBox(
            height: Helper.H(context) * .050,
          ),
          Consumer<FirebaseController>(
            builder: (context, instance, _) {
              return GestureDetector(
                onTap: () async {
                  if ((image != null || webImage.isNotEmpty) &&
                      CompanyName.text.isNotEmpty &&
                      CompanyCharge.text.isNotEmpty) {
                    return _addProduct().then((value) {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardHome(),
                          ));
                    });
                  } else {
                    errortoast(context, 'Please fill the field');
                  }
                },
                child: ContainerWidget(
                  width: Helper.W(context) * .200,
                  height: Helper.H(context) * .050,
                  text: 'Add prodcut',
                  radius: Helper.W(context) * .020,
                  color: Colors.blue,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
