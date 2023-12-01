import 'package:flutter/material.dart';

import '../../Models/UserModle.dart';
import '../../global/AppColors.dart';
import '../../global/CustomAppbar.dart';
import 'NotificationPage.dart';
import 'NotificationTiles.dart';
class NotificationScreen extends StatefulWidget {
  UserModel userModel;
  NotificationScreen({required this.userModel});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: CustomAppBar(widget.userModel.name!.split(' ')[0].toString(),widget.userModel.gender.toString()),
        toolbarHeight: 76,
        elevation: 0,
        backgroundColor: app_bar_color,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.separated(
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: 2,
            itemBuilder: (context, index) {
              return NotificationTiles(
                title: 'Reading hall',
                subtitle: 'Thanks for visiting reading hall .',
                enable: true,
                callback: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NotificationPage())),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            }),
      ),
    );
  }
}
