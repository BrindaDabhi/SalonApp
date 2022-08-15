import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_salon/constant/color_const.dart';
import 'package:my_salon/details/order_confirm.dart';

class PaymentMethod extends StatefulWidget {
  PaymentMethod({Key? key}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: true,
        title: Text(
          "Payment Method",
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
          SizedBox(height: 10),
          Text("Choose your payment method",
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.grey[400])),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Divider(thickness: 1),
          ),
          SizedBox(height: 50),
          Container(height: 80, child: Row()),
          Divider(thickness: 1),
          Container(height: 80, child: Row()),
          Divider(thickness: 1),
          Container(height: 80, child: Row()),
          SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderConfirm(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 50, right: 50),
              height: 45,
              width: size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: lightPurple),
              child: Text("Pay",
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
