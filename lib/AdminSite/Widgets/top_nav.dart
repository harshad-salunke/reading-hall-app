import 'package:flutter/material.dart';
import 'package:kjcoemr_reading_hall/AdminSite/helpers/responsiveness.dart';

import '../constants/style.dart';
import 'custom_text.dart';

AppBar toNavigationBar(BuildContext context,GlobalKey<ScaffoldState> key)=>
    AppBar(

      leading: !ResponsiveWidget.isSmallScreen(context)?
      Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 14),
            child: Image.asset('assets/images/trinitylogo.png',width: 40,height: 40,),
          )
        ],

      )
          :IconButton(onPressed: (){
        key.currentState?.openDrawer();
      }, icon: Icon(Icons.menu,color: Colors.black,)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Container(
        child: Row(
          children: [
            Visibility(
                visible: !ResponsiveWidget.isSmallScreen(context),
                child: CustomText(text: "KJEI Admin", color: lightGrey, size: 20, weight: FontWeight.bold,)),
            Expanded(child: Container()),
            IconButton(icon: Icon(Icons.settings, color: dark,), onPressed: (){}),

            Stack(
              children: [
                IconButton(icon: Icon(Icons.notifications, color: dark.withOpacity(.7),), onPressed: (){}),
                Positioned(
                  top: 7,
                  right: 7,
                  child: Container(
                    width: 12,
                    height: 12,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: active,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: light, width: 2)
                    ),
                  ),
                )
              ],
            ),

            Container(
              width: 1,
              height: 22,
              color: lightGrey,
            ),
            SizedBox(width: 24,),
            CustomText(text: "Reading Hall", color: lightGrey,),
            SizedBox(width: 16,),
            Container(
              decoration: BoxDecoration(
                  color: active.withOpacity(.5),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                ),
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundColor: light,
                  child: Icon(Icons.person_outline, color: dark,),
                ),
              ),
            )
          ],
        ),
      ),
      iconTheme: IconThemeData(color: dark),
    );