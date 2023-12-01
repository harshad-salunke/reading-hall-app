import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomAppBar extends StatefulWidget {
  String name;
  String gender;
  CustomAppBar(this.name,this.gender);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM y').format(now);

    return formattedDate;
  }
  String getTimeOfDay() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm').format(now); // format the time as HH:mm
    int hour = int.parse(formattedTime.split(":")[0]); // extract the hour from the formatted time
    if (hour >= 5 && hour < 12) {
      return "Morning"; // between 5am and 12pm
    } else if (hour >= 12 && hour < 17) {
      return "Afternoon"; // between 12pm and 5pm
    } else {
      return "Evening"; // after 5pm
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${getTimeOfDay()}, "+widget.name,
                  style: GoogleFonts.lobster(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 23)),
              SizedBox(height: 5,),
              Text(_getCurrentDate(),
                style: GoogleFonts.ebGaramond(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),

          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: CircleAvatar(

              radius: 30, // set the radius of the circle
              backgroundImage: AssetImage(widget.gender=="Female"? 'assets/images/college_girl.png':'assets/images/college_boy.png'),
              backgroundColor: Colors.transparent,

            ),
          )

        ],
      ),
    );
  }
}
