import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kjcoemr_reading_hall/Models/AttendanceModle.dart';
class RecordCardView extends StatefulWidget {
  AttendanceModle attendanceModle;
  RecordCardView(this.attendanceModle);

  @override
  State<RecordCardView> createState() => _RecordCardViewState();
}

class _RecordCardViewState extends State<RecordCardView> {
  @override
  Widget build(BuildContext context) {
    List<String>? date=widget.attendanceModle.date?.split(' ');
    return Container(
      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
     child: Row(
       children: [

         Column(children: [
           Text(date![0], style:  GoogleFonts.acme(
               fontWeight: FontWeight.w500,
               color: Colors.black,
               fontSize: 25),),
           Text(date[1], style:  GoogleFonts.acme(
               fontWeight: FontWeight.w500,
               color: Colors.black,
               fontSize: 12),),
         ],),
         SizedBox(width: 8,),
         Container(
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(50), // Set the radius to half of the width/height to make it circular
             color: Colors.amber,
           ),
           height: 20,
           width: 20,
           child: Icon(Icons.arrow_forward_ios,size: 10,),
         ),
         SizedBox(width: 8,),

         Expanded(
           child: Container(

             padding: EdgeInsets.all(15),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10), // Set the radius to half of the width/height to make it circular
               color: Colors.white,
             ),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Image.asset("assets/images/checkin.png",height: 20,width: 20,),
                         SizedBox(width: 8,),
                         Text(widget.attendanceModle.checkin.toString(),
                             style: TextStyle(fontWeight: FontWeight.bold))
                       ],
                     ),
                     Row(
                       children: [
                         Image.asset("assets/images/checkout.png",height: 20,width: 20,),
                         SizedBox(width: 8,),

                         Text(widget.attendanceModle.checkout.toString(),
                           style: TextStyle(fontWeight: FontWeight.bold),)
                       ],
                     ),
                   ],
                 ),
                 SizedBox(height: 3,),
                 Container(
                   margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                   child: Text("Total Study - ${widget.attendanceModle.total_study}",
                     style:  GoogleFonts.kaiseiTokumin(
                         fontWeight: FontWeight.w700,
                         color: Colors.black,
                         fontSize: 15),
                   ),
                 )


               ],
             ),
           ),
         ),




       ],
     ),

    );
  }
}
