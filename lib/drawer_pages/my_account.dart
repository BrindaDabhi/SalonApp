import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_salon/constant/color_const.dart';
import 'package:my_salon/home_page.dart';
import 'package:my_salon/notifier/user_notifier.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatefulWidget {
  MyAccount({Key? key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController eMailController = TextEditingController();

  UpdateDataInFirebase() async {
    if (globalKey.currentState!.validate()) {
      String uid = FirebaseAuth.instance.currentUser!.uid.toString();

      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("Users").doc(uid);

      documentReference.update({
        "Name": nameController.text,
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
  void initState() {
    // TODO: implement initState
    UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);
    getUsers(userNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);

    nameController.text = userNotifier.userList
        .where(
            (element) => element.uid == FirebaseAuth.instance.currentUser!.uid)
        .first
        .name
        .toString();

    eMailController.text = userNotifier.userList
        .where(
            (element) => element.uid == FirebaseAuth.instance.currentUser!.uid)
        .first
        .email
        .toString();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: true,
        title: Text(
          "My Account",
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
              CircleAvatar(
                radius: 64,
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: darkPurple),
                    hintText: "Name",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: eMailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail, color: darkPurple),
                    hintText: "Email",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.calendar_today_rounded, color: darkPurple),
                    hintText: "Date Of Birth",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Other", suffixIcon: Icon(Icons.arrow_drop_down)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => HomePage(),
                  //   ),
                  // );
                  UpdateDataInFirebase();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 120, right: 120),
                  height: 45,
                  width: size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: lightPurple),
                  child: Text("Save",
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
