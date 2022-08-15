import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_salon/constant/color_const.dart';
import 'package:my_salon/home_page.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController eMailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blueGrey[50],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                'Forgot Your Password',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                    color: Colors.black),
              ),
              SizedBox(height: 40),
              Container(
                  height: 300,
                  child: Image.asset("images/resetpwimg.webp",
                      fit: BoxFit.fitHeight)),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "          Reset password is the action of invalidating the current password for an account on a website, service, or device, and then creating a new one.",
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 80,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 40, right: 40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: TextFormField(
                    controller: eMailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: lightPurple),
                        hintText: 'Enter Your Email',
                        border: InputBorder.none),
                    validator: (String? value) {
                      if (!value!.contains('@')) {
                        return "Enter valid e-mail";
                      } else if (value.isEmpty) {
                        return "Please enter e-mail";
                      } else {
                        return null;
                      }
                    }),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: eMailController.text);
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 50, right: 50),
                  alignment: Alignment.center,
                  height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: lightPurple,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Text(
                    'Send Reset Password Link',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
