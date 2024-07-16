import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Controller with ChangeNotifier {
  int selectedindex = 0;
  changeIndex(value) {
    selectedindex = value;
    notifyListeners();
  }

  bool _isSelected = false;
  bool get isSelected => _isSelected;
  tickconform(bool value) {
    _isSelected = value;
    notifyListeners();
  }

  int activeindex = 1;
  Activeindex(int newindex) {
    newindex = activeindex;
  }

  int curentindex = 0;
  newindex(value) {
    curentindex = value;
    notifyListeners();
  }

  String imageurl = '';

  File? _file;

  FirebaseStorage storage = FirebaseStorage.instance;

  Future pickimagefromgallery() async {
    ImagePicker imagePicker = ImagePicker();
    SettableMetadata metadata = SettableMetadata(contentType: "image/jpeg");
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print(".................${file?.path}");
    if (file == null) return;
    String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referencRoot = FirebaseStorage.instance.ref();
    Reference referencedirimage = referencRoot.child("images");
    Reference referencetoimageupload = referencedirimage.child(uniquefilename);
    try {
      await referencetoimageupload.putFile(File(file.path), metadata);
      imageurl = await referencetoimageupload.getDownloadURL();
      print(imageurl);
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  File? selectedimage;
  String? url;
  Future imagepicker() async {
    final pickeimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickeimage == null) return;

    selectedimage = File(pickeimage.path);

    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    final curenttime = TimeOfDay.now().toString();

    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('userprofile/$curenttime')
        .putFile(selectedimage!, metadata);
    TaskSnapshot snapshot = await uploadTask;

    url = await snapshot.ref.getDownloadURL();

    notifyListeners();
  }

  claer() {
    url = null;
    notifyListeners();
  }
}
