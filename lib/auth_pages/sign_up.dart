import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_salon/auth_pages/login.dart';
import 'package:my_salon/constant/color_const.dart';
import 'package:my_salon/home_page.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController eMailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isObscure = true;

  signUpDatabaseData() async {
    if (globalKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: eMailController.text, password: passwordController.text)
            .catchError((e) {
          print(e);
        });
      } catch (e) {
        print(e.toString());
      }

      String uid = FirebaseAuth.instance.currentUser!.uid.toString();

      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("Users").doc(uid);

      documentReference.set({
        "Name": nameController.text,
        "Email": eMailController.text,
        "Password": passwordController.text,
        "Uid": uid
      }).whenComplete(() {
        Fluttertoast.showToast(
            msg: "Registered",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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
      body: SingleChildScrollView(
        child: Form(
          key: globalKey,
          autovalidate: true,
          child: Container(
            color: Colors.blueGrey[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Text(
                  'Create New Account',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      color: Colors.black),
                ),
                SizedBox(height: 30),
                Container(
                    height: 300,
                    child: Image.asset("images/signupimg.webp",
                        fit: BoxFit.fitHeight)),
                SizedBox(height: 20),
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: lightPurple),
                        hintText: 'Enter Your Name Here',
                        border: InputBorder.none),
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
                SizedBox(height: 10),
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: TextFormField(
                    controller: eMailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: lightPurple),
                        hintText: 'Enter Your Email Here',
                        border: InputBorder.none),
                    validator: (String? value) {
                      if (!value!.contains('@')) {
                        return "Enter valid e-mail";
                      } else if (value.isEmpty) {
                        return "Please enter e-mail";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: lightPurple),
                        hintText: 'Enter Password',
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                        border: InputBorder.none),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter password";
                      } else if (value.length < 6) {
                        return "Password should be at least 6 characters!";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    signUpDatabaseData();
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
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    "Already have an Account ? Login",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
