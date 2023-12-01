import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class StudyCardView extends StatefulWidget {
  String time;
  String text;
  String icon;
  String points;
  StudyCardView(this.time,this.text,this.icon,this.points);

  @override
  State<StudyCardView> createState() => _StudyCardView();
}

class _StudyCardView extends State<StudyCardView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        height: 130,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Row(
                crossAxisAlignment:CrossAxisAlignment.start,

                children: [
                  SizedBox(width: 15,),
                  Image.asset(widget.icon,height:28,width: 28,),
                  SizedBox(width: 15,),
                  Text(widget.text,style:  GoogleFonts.teko(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),)
                ]
            ),
            SizedBox(height: 20,),

            Container(
              margin: EdgeInsets.only(left: 20),

              child: Text(widget.time,
                textAlign: TextAlign.start,
                style: GoogleFonts.bebasNeue(color: Colors.black,fontSize: 26,),),
            ),
            SizedBox(height: 5,),

            Container(
                margin: EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("On Time",style:  GoogleFonts.quicksand(
                        color: CupertinoColors.inactiveGray,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),),
                    Text(widget.points,
                      style:  GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 14),
                    ),
                    SizedBox(width: 0,)
                  ],)
            )

          ],
        ),
      ),
    );
  }
}
