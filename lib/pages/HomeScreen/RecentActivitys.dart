import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kjcoemr_reading_hall/Models/AttendanceModle.dart';
import 'package:shimmer/shimmer.dart';

class RecentActivitys extends StatefulWidget {
  AttendanceModle attendanceModle;
  bool isLoading;
  Function() callback;
  RecentActivitys(this.attendanceModle,this.isLoading,this.callback);

  @override
  State<RecentActivitys> createState() => _RecentActivitysState();
}

class _RecentActivitysState extends State<RecentActivitys> {

  @override
  Widget build(BuildContext context) {

    return Container(
        margin: EdgeInsets.only(top: 15),
        height: 350,
      color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("Recent Activity",
                      style: GoogleFonts.castoro(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),

                  TextButton(onPressed: (){
                    widget.callback();
                  },
                      child: Text("See more",style:  GoogleFonts.ebGaramond(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),))
                ],
              ),
            ),

             widget.attendanceModle.checkin==''?_noDataAvailable() :Container(
              margin: EdgeInsets.fromLTRB(20, 20, 10, 10),
              // margin: EdgeInsets.fromLTRB(left, top, right, bottom),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row
                    (
                    children: [
                    Image.asset("assets/images/checkin.png",height: 40,width: 40,),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Check in",style: GoogleFonts.castoro(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18)),
                      SizedBox(height: 3,),
                      Text(widget.attendanceModle.month.toString(),
                        style: GoogleFonts.ebGaramond(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),

                    ],),
                  ],),
                  Text(widget.attendanceModle.checkin.toString(),
                    textAlign: TextAlign.start,
                    style: GoogleFonts.castoro(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
            ),

            widget.attendanceModle.checkin==''?_DataLoading(): Container(
              margin: EdgeInsets.fromLTRB(20, 20, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset("assets/images/checkout.png",height: 40,width: 40,),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                      Text("Check out",style: GoogleFonts.castoro(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18)),
                      SizedBox(height: 3,),
                      Text(widget.attendanceModle.month.toString(),
                        style: GoogleFonts.ebGaramond(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),

                    ],),
                  ],),
                  Text(widget.attendanceModle.checkout.toString(),
                    textAlign: TextAlign.start,
                    style: GoogleFonts.castoro(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
            ),

            widget.attendanceModle.checkin==''?_DataLoading():    Container(
              margin: EdgeInsets.fromLTRB(20, 20, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset("assets/images/book_finished.png",height: 40,width: 40,),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Total Study",style: GoogleFonts.castoro(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18)),
                      SizedBox(height: 3,),
                        Text(widget.attendanceModle.month.toString(),
                        style: GoogleFonts.quicksand(
                            color: CupertinoColors.inactiveGray,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),

                    ],),
                  ],),
                  Text(widget.attendanceModle.total_study.toString(),
                    textAlign: TextAlign.start,
                    style: GoogleFonts.castoro(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
            ),

          ],
        ),

    );
  }
  _noDataAvailable() {
    return Expanded(
      child: Container(
        child:widget.isLoading? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  'No  Data \n at the  moment',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ),
            )
          ],
        ):Container(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Shimmer.fromColors(
                baseColor: Colors.grey[200] as Color,
                highlightColor: Colors.yellow[100] as Color,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // Set the radius to half of the width/height to make it circular
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(5),
                    height: 80)
            ),
          ),
        )  ,
      ),
    );
  }

  _DataLoading() {
    return Expanded(
      child: Container(
        child:widget.isLoading? Container():
        Container(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Shimmer.fromColors(
                baseColor: Colors.grey[200] as Color,
                highlightColor: Colors.yellow[100] as Color,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Set the radius to half of the width/height to make it circular
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.all(5),
                  height: 80)
            ),
          ),
        ),
      ),
    );
  }


}
