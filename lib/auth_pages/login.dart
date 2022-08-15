import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_salon/auth_pages/change_password.dart';
import 'package:my_salon/auth_pages/sign_up.dart';
import 'package:my_salon/constant/color_const.dart';
import 'package:my_salon/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController eMailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isObscure = true;

  bool _isChecked = false;

  SignInDatabaseData() async {
    if (globalKey.currentState!.validate()) {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: eMailController.text, password: passwordController.text)
          .catchError((errordata) {
        print(errordata.toString());
        Fluttertoast.showToast(
            msg: errordata.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });

      String uid = FirebaseAuth.instance.currentUser!.uid.toString();

      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("Users").doc(uid);

      documentReference.update({
        "Password": passwordController.text,
      }).whenComplete(() {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      });

      Fluttertoast.showToast(
          msg: "Signed In",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Invalid Data",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  _handleRememberme(value) {
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value!);
        prefs.setString('email', eMailController.text);
        prefs.setString('password', passwordController.text);
      },
    );
    setState(() {
      _isChecked = value!;
    });
  }

  void _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;
      print(_remeberMe);
      print(_email);
      print(_password);
      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        eMailController.text = _email;
        passwordController.text = _password;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
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
                  'Welcome Back !!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      color: Colors.black),
                ),
                SizedBox(height: 30),
                Container(
                    height: 300,
                    child: Image.asset("images/loginimg.webp",
                        fit: BoxFit.fitHeight)),
                SizedBox(height: 20),
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  // padding: EdgeInsets.only(left: 5, top: 30, bottom: 10),
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
                      if (!value!.contains('@gmail.com')) {
                        return "Enter valid e-mail";
                      } else if (value.isEmpty) {
                        return "Please enter e-mail";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
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
                        hintText: 'Enter Password Here',
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
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Row(
                    children: [
                      Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                            SizedBox(
                                height: 24.0,
                                width: 24.0,
                                child: Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor:
                                          Color(0xff00C8E8) // Your color
                                      ),
                                  child: Checkbox(
                                      activeColor: Color(0xff00C8E8),
                                      checkColor: Colors.white,
                                      value: _isChecked,
                                      onChanged: (value) {
                                        _handleRememberme(value);
                                      }),
                                )),
                            SizedBox(width: 10.0),
                            Text("Remember Me",
                                style: TextStyle(
                                    color: Color(0xff646464),
                                    fontSize: 12,
                                    fontFamily: 'Rubic'))
                          ])),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePassword()));
                        },
                        child: Text(
                          "Forgot Password ?",
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
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    SignInDatabaseData();
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
                      'Login',
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
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text(
                    "Don't have an Account ? SignUp",
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
