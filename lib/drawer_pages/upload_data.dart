import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_salon/constant/color_const.dart';
import 'package:my_salon/home_page.dart';

class UploadData extends StatefulWidget {
  UploadData({Key? key}) : super(key: key);

  @override
  _UploadDataState createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController shopNameController = TextEditingController();
  TextEditingController subtitleNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController servicePriceController = TextEditingController();

  var Fluttertoast;

  File? imageFile;
  final ImagePicker picker = ImagePicker();

  Map<String, dynamic> services = Map();

  _getFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile = File(pickedFile!.path);
      print(imageFile);
    });
  }

  uploadServiceProvidersData() async {
    if (globalKey.currentState!.validate()) {
      String uid = FirebaseAuth.instance.currentUser!.uid.toString();

      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("Artists").doc(uid);

      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('uploads/${imageFile.toString().split("cache/")[1]}');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile!);

      var taskSnapshot = await (await uploadTask).ref.getDownloadURL();

      var url = taskSnapshot.toString();

      documentReference.set({
        "Shop Name": shopNameController.text,
        "Subtitle Name": subtitleNameController.text,
        "Address": addressController.text,
        "Services": services,
        "Uid": uid,
        "Image": url.toString()
      }).whenComplete(() {
        Navigator.pop(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      });
    } else {
      Fluttertoast.showToast(
          msg: "Enter Valid Data",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: true,
        title: Text(
          "Upload Data",
          style: GoogleFonts.openSans(
              fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [lightPurple, darkPurple],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: globalKey,
          autovalidate: true,
          child: Column(
            children: [
              SizedBox(height: 40),
              GestureDetector(
                  onTap: () {
                    _getFromGallery();
                  },
                  child: CircleAvatar(
                      radius: 64,
                      child: imageFile == null
                          ? Icon(Icons.camera_alt_rounded, color: Colors.white)
                          : Container(
                              width: 128,
                              height: 128,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FileImage(File(
                                          imageFile!.path.toString()))))))),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: shopNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.shop_rounded, color: darkPurple),
                    hintText: "Shop Name",
                  ),
                  validator: (String? value) {
                    if (value!.contains('@')) {
                      return "Enter valid name";
                    } else if (value.isEmpty) {
                      return "Please enter your name";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: subtitleNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: darkPurple),
                    hintText: "Subtitle Name",
                  ),
                  validator: (String? value) {
                    if (value!.contains('@')) {
                      return "Enter valid name";
                    } else if (value.isEmpty) {
                      return "Please enter your name";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.home, color: darkPurple),
                    hintText: "Address",
                  ),
                  validator: (String? value) {
                    if (value!.contains('@')) {
                      return "Enter valid name";
                    } else if (value.isEmpty) {
                      return "Please enter your name";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: serviceNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.shop_rounded, color: darkPurple),
                    hintText: "Add Service Name",
                  ),
                  validator: (String? value) {
                    if (value!.contains('@')) {
                      return "Enter valid name";
                    } else if (value.isEmpty) {
                      return "Please enter your name";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: servicePriceController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.money_rounded, color: darkPurple),
                    hintText: "Add Service Price",
                  ),
                  validator: (String? value) {
                    if (value!.contains('@')) {
                      return "Enter valid name";
                    } else if (value.isEmpty) {
                      return "Please enter your name";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  services[serviceNameController.text] =
                      servicePriceController.text;
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  height: 30,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: lightPurple),
                  child: Text("Add",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  uploadServiceProvidersData();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 120, right: 120),
                  height: 45,
                  width: size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: lightPurple),
                  child: Text("Save & Exit",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
