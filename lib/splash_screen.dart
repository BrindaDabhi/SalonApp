import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_salon/auth_pages/welcome.dart';
import 'package:my_salon/constant/color_const.dart';
import 'package:my_salon/home_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  Widget? firstWidget;

  @override
  void initState() {
    super.initState();

    if (firebaseUser != null) {
      firstWidget = HomePage();
    } else {
      firstWidget = Welcome();
    }

    Timer(
        Duration(seconds: 10),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => firstWidget!)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: darkPurple,
        child: Center(
            child: Image.asset("images/salonIcon.png",
                width: 200, fit: BoxFit.fitWidth, color: Colors.blueGrey[50])),
      ),
    );
  }
}
