import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_salon/constant/color_const.dart';
import 'package:my_salon/details/payment_method.dart';

const TIME_SLOT = {
  '09:00-09:30',
  '09:30-10:00',
  '10:00-10:30',
  '10:30-11:00',
  '11:00-11:30',
  '11:30-12:00',
  '12:00-12:30',
  '12:30-13:00',
  '13:00-13:30',
  '13:30-14:00',
  '14:00-14:30',
  '14:30-15:00',
  '15:00-15:30',
  '15:30-16:00',
  '16:00-16:30',
  '16:30-17:00',
  '17:00-17:30',
  '17:30-18:00',
  '18:00-18:30',
  '18:30-19:00',
  '19:00-19:30',
  '19:30-20:00',
};

class SloteSelection extends StatefulWidget {
  SloteSelection({Key? key}) : super(key: key);

  @override
  _SloteSelectionState createState() => _SloteSelectionState();
}

class _SloteSelectionState extends State<SloteSelection> {
  bool _isSelected = false;
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backwardsCompatibility: true,
          title: Text(
            "Slote Selection",
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: size.height - 133,
              width: size.width,
              child: GridView.builder(
                  itemCount: TIME_SLOT.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSelected = !_isSelected;
                            _selectedIndex = index;
                          });
                        },
                        child: Card(
                          color: _isSelected && index == _selectedIndex ? Colors.grey[50] : Colors.white,
                          child: GridTile(
                              child: Center(
                                  child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('${TIME_SLOT.elementAt(index)}'),
                              _isSelected && index == _selectedIndex
                                  ? Text('Not Available')
                                  : Text('Available')
                            ],
                          ))),
                        ),
                      )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentMethod(),
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
                child: Text("Confirm Booking",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.white)),
              ),
            ),
          ],
        ));
  }
}
