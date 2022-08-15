import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_salon/constant/color_const.dart';
import 'package:my_salon/details/appot_booking.dart';
import 'package:my_salon/home_page.dart';
import 'package:my_salon/notifier/sp_notifier.dart';
import 'package:provider/provider.dart';

class SalonDetail extends StatefulWidget {
  String? imgUrl;
  int? currIndex;

  SalonDetail({this.imgUrl, this.currIndex});

  @override
  _SalonDetailState createState() => _SalonDetailState();
}

class _SalonDetailState extends State<SalonDetail> {
  bool _isSelected = false;
  int _selectedIndex = -1;
  int _lastSelectedIndex = -2;

  @override
  void initState() {
    // TODO: implement initState
    SPNotifier spNotifier = Provider.of<SPNotifier>(context, listen: false);
    getSps(spNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SPNotifier spNotifier = Provider.of<SPNotifier>(context);

    var serviceKeys =
        spNotifier.spList[widget.currIndex!].serviceMap!.keys.toList();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Stack(
              children: [
                Image.network('${widget.imgUrl}',
                    fit: BoxFit.fill, height: 300, width: size.width),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: IconButton(
                      iconSize: 25,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_back_rounded)),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      Text(
                          spNotifier.spList[widget.currIndex!].shopName
                              .toString(),
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Colors.black)),
                      Text(
                          spNotifier.spList[widget.currIndex!].subtitleName
                              .toString(),
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.black)),
                      Text(
                          spNotifier.spList[widget.currIndex!].address
                              .toString(),
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.black)),
                    ],
                  ),
                ),
                Divider(thickness: 3),
                Container(
                  height: size.height - 60 - 364 - 16,
                  width: size.width,
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: ListView.separated(
                      itemCount: spNotifier
                          .spList[widget.currIndex!].serviceMap!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => SalonDetail(),
                            //   ),
                            // );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            elevation: 3,
                            child: Container(
                              height: 70,
                              margin: EdgeInsets.only(left: 15, right: 15),
                              padding: EdgeInsets.only(left: 20, right: 60),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(serviceKeys[index],
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12,
                                              color: Colors.black)),
                                      SizedBox(height: 10),
                                      Text(spNotifier.spList[widget.currIndex!]
                                          .serviceMap![serviceKeys[index]])
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.network(
                                        '${widget.imgUrl}',
                                        fit: BoxFit.fill,
                                        height: 50,
                                        width: 40,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _isSelected = true;
                                            _lastSelectedIndex = _selectedIndex;
                                            _selectedIndex = index;
                                            if (_lastSelectedIndex ==
                                                _selectedIndex) {
                                              _isSelected = false;
                                              _lastSelectedIndex = -2;
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 15,
                                          width: 60,
                                          alignment: Alignment.center,
                                          child: Text(
                                              _isSelected &&
                                                      index == _selectedIndex
                                                  ? "Remove"
                                                  : "Add",
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: _isSelected &&
                                                          index ==
                                                              _selectedIndex
                                                      ? Colors.red[800]
                                                      : Colors.white)),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: _isSelected &&
                                                      index == _selectedIndex
                                                  ? Colors.pink[50]
                                                  : lightPurple),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(height: 0)),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppotBooking(),
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
                child: Text("Go To Bag",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
