import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_salon/constant/color_const.dart';
import 'package:my_salon/details/book_appointment.dart';

class AppotBooking extends StatefulWidget {
  AppotBooking({Key? key}) : super(key: key);

  @override
  _AppotBookingState createState() => _AppotBookingState();
}

class _AppotBookingState extends State<AppotBooking> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: true,
        title: Text(
          "Appointment Booking",
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
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 10),
                Text("Your appointment item",
                    style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black)),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 15, right: 15),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("hair cut",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12,
                                    color: Colors.black)),
                            SizedBox(height: 5),
                            Text("\$500")
                          ],
                        ),
                        Icon(Icons.delete)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                  height: 200,
                  width: size.width,
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Column(children: [
                    Text("Order Summary",
                        style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.black)),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pay to Bill",
                            style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                        Text("\$100.00",
                            style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount%",
                            style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                        Text("-\$10.00",
                            style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                    SizedBox(height: 5),
                    Divider(thickness: 3),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Amount To Pay",
                            style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                        Text("\$90.00",
                            style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    )
                  ]),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookAppointment(),
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
                    child: Text("Book Appointment",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.white)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
