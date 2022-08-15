import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_salon/constant/color_const.dart';

class MyOrder extends StatefulWidget {
  MyOrder({Key? key}) : super(key: key);

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: true,
        title: Text(
          "Your Order",
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
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Your Order",
              style: GoogleFonts.openSans(
                  fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(thickness: 2),
            ),
            SizedBox(height: 20),
            Container(
              height: size.height - 178,
              width: size.width,
              child: ListView.separated(
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         SalonDetail(imgUrl: imgList[index]),
                      //   ),
                      // );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.white,
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, right: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Ganesh Hair Art",
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.grey[900],
                                              fontSize: 15)),
                                      Text("Hair cutting, wash and spa",
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey,
                                              fontSize: 12))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset("images/salon1.jpg"),
                                ),
                              ],
                            )),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
