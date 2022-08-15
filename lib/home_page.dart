import 'dart:io';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_salon/auth_pages/welcome.dart';
import 'package:my_salon/constant/color_const.dart';
import 'package:my_salon/details/salon_detail.dart';
import 'package:my_salon/drawer_pages/my_account.dart';
import 'package:my_salon/drawer_pages/my_order.dart';
import 'package:my_salon/drawer_pages/upload_data.dart';
import 'package:my_salon/notifier/sp_notifier.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'drawer_pages/setting.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeIndex = 0;

  final iconList = <IconData>[
    Icons.home,
    Icons.search,
    Icons.shopping_cart_rounded,
    Icons.person
  ];

  final iconNameList = <String>["Home", "Search", "Order", "Account"];

  final imgList = <String>[
    "images/salon1.jpg",
    "images/salon2.jpg",
    "images/salon3.jpg",
    "images/salon4.jpg",
    "images/salon5.jpg"
  ];

  final url = FirebaseStorage.instance
      .ref()
      .child('salon1')
      .getDownloadURL()
      .toString();

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    SPNotifier spNotifier =
        Provider.of<SPNotifier>(this.context, listen: false);
    getSps(spNotifier);
  }

  @override
  Widget build(BuildContext context) {
    SPNotifier spNotifier = Provider.of<SPNotifier>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 50),
            CircleAvatar(
              radius: 32,
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(thickness: 3),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("My Account"),
              trailing: IconButton(
                icon: Icon(Icons.arrow_right_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyAccount(),
                    ),
                  );
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag_outlined),
              title: Text("My Order"),
              trailing: IconButton(
                icon: Icon(Icons.arrow_right_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyOrder(),
                    ),
                  );
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share"),
              trailing: IconButton(
                icon: Icon(Icons.arrow_right_outlined),
                onPressed: () {
                  Share.share('Look my New App : ', subject: 'sdfghjukl');
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Setting"),
              trailing: IconButton(
                icon: Icon(Icons.arrow_right_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Setting(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(thickness: 3),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log Out"),
              trailing: IconButton(
                icon: Icon(Icons.arrow_right_outlined),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Welcome(),
                    ),
                  );
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.cloud_upload_outlined),
              title: Text("Upload Data"),
              trailing: IconButton(
                icon: Icon(Icons.arrow_right_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadData(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [lightPurple, darkPurple],
            ),
          ),
        ),
        title: Text('Hair Salon'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: size.height - 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.location_on, color: Colors.black),
                        hintText: 'Enter the location type',
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 170,
                  width: size.width,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.7,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: spNotifier.spList
                        .map((item) => ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              item.image!,
                              fit: BoxFit.fill,
                              width: size.width,
                            )))
                        .toList(),
                  ),
                ),
                SizedBox(height: 10),
                Text("Hair Art around you",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: Colors.black)),
                SizedBox(height: 10),
                Container(
                  height: size.height - 422,
                  width: size.width,
                  child: ListView.separated(
                    itemCount: spNotifier.spList.length, //imgList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SalonDetail(
                                  imgUrl: spNotifier.spList[index].image!,
                                  currIndex: index),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 250,
                              width: double.infinity,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Image.network(
                                    spNotifier.spList[0].image!,
                                    fit: BoxFit.fill,
                                    width: size.width,
                                    height: 170,
                                  ),
                                  SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              spNotifier
                                                  .spList[index].shopName!,
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              spNotifier
                                                  .spList[index].subtitleName!,
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              spNotifier.spList[index].address!,
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                        Container(
                                          height: 24,
                                          width: 64,
                                          color: Colors.green,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("4.5",
                                                    style: GoogleFonts.openSans(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 16,
                                                        color: Colors.white)),
                                                Icon(
                                                  Icons.star_border,
                                                  color: Colors.white,
                                                  size: 20,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.calendar_today),
        backgroundColor: darkPurple,
        elevation: 2.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 24,
                color: index == activeIndex ? darkPurple : Colors.black54,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  iconNameList[index],
                  maxLines: 1,
                  style: TextStyle(
                      color:
                          index == activeIndex ? darkPurple : Colors.black54),
                ),
              )
            ],
          );
        },
        backgroundColor: Colors.white,
        activeIndex: activeIndex,
        splashColor: lightPurple,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => activeIndex = index),
      ),
    );
  }
}
