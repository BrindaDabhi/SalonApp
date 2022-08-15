import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_salon/constant/color_const.dart';
import 'package:my_salon/home_page.dart';

class OrderConfirm extends StatefulWidget {
  OrderConfirm({Key? key}) : super(key: key);

  @override
  _OrderConfirmState createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backwardsCompatibility: true,
          title: Text(
            "Order Confirm",
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
            GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 45,
                    width: size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: lightPurple),
                    child: Text("Go To HomePage",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.white)),
                  ),
                ),
          ],
        ),
    );
  }
}
