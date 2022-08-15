import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_salon/auth_pages/change_password.dart';
import 'package:my_salon/constant/color_const.dart';

class Setting extends StatefulWidget {
  Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: true,
        title: Text(
          "Setting",
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
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Account Settings",
            style: GoogleFonts.openSans(
                fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(thickness: 2),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            height: 50,
            width: size.width,
            margin: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: ListTile(
              leading: Icon(Icons.lock, color: lightPurple),
              title: Text("Change Password"),
              trailing: IconButton(
                icon: Icon(Icons.keyboard_arrow_down_rounded),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChangePassword()));
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            height: 50,
            width: size.width,
            margin: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: ListTile(
              leading: Icon(Icons.delete, color: lightPurple),
              title: Text("Delete Account"),
              trailing: IconButton(
                icon: Icon(Icons.keyboard_arrow_down_rounded),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
