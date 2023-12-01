import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kjcoemr_reading_hall/pages/LoginPage/LoginPage.dart';
 import 'package:kjcoemr_reading_hall/pages/SettingScreen/library_corner.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Models/UserModle.dart';
import '../../global/AppColors.dart';
import '../../global/CustomAppbar.dart';
import 'PersonalData.dart';
import 'Txt.dart';

class SettingScreen extends StatefulWidget {
  UserModel userModel;

  SettingScreen({required this.userModel});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(widget.userModel.name!.split(' ')[0].toString(),
            widget.userModel.gender.toString()),
        toolbarHeight: 76,
        elevation: 0,
        backgroundColor: app_bar_color,
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        physics: BouncingScrollPhysics(), //use this for a bouncing experience
        children: [
          Container(height: 35),
          colorTiles(),
          divider(),
          bwTiles(),
        ],
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(
        thickness: 1.5,
      ),
    );
  }

  Widget colorTiles() {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return PersonalScreen(widget.userModel);
              }));
            },
            child: colorTile(
                Icons.person_outline, Colors.deepPurple, "Personal data")),
        GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return LibraryCorner();
              }));
            },
            child: colorTile(
                Icons.menu_book_sharp, Colors.orange, "Library Corner")),
        GestureDetector(
          child: colorTile(
              Icons.contact_emergency_rounded, Colors.blue, "Contact"),
          onTap: () async {
            var url =
                'https://www.kjei.edu.in/kjcoemr/New_Kjcoemr_contact_us.php';
            if (await canLaunch(url)) {
              await launch(url, forceWebView: false);
            }
          },
        ),
        GestureDetector(
          child: colorTile(Icons.local_police, Colors.pink, "Privacy Policy"),
          onTap: () async {
            var url = 'https://doc-hosting.flycricket.io/kjei-reading-hall/3c88a75d-e6a5-4dc6-b6ae-2b78b6644975/privacy';
            if (await canLaunch(url)) {
              await launch(url, forceWebView: false);
            }
          },
        ),
        GestureDetector(
            onTap: () {
              logoutUser();
            },
            child: colorTile(Icons.logout, Colors.orange, "Logout")),
      ],
    );
  }

  Widget bwTiles() {
    // Color color = Colors.blueGrey.shade800; not satisfied, so let us pick it
    return Column(
      children: [
        bwTile(Icons.star_rate_outlined, "Rate Us"),
        GestureDetector(
            onTap: () {
              exit(0);
            },
            child: bwTile(Icons.exit_to_app, "Exit")),
      ],
    );
  }

  Widget bwTile(IconData icon, String text) {
    return colorTile(icon, Colors.black, text, blackAndWhite: true);
  }

  Widget colorTile(IconData icon, Color color, String text,
      {bool blackAndWhite = false}) {
    Color pickedColor = Color(0xfff3f4fe);
    return ListTile(
      leading: Container(
        child: Icon(icon, color: color),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: blackAndWhite ? pickedColor : color.withOpacity(0.09),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      title: Txt(
        text: text,
        fontWeight: FontWeight.w500,
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
    );
  }

  void logoutToast() {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Hii, there!',
        message: 'Logout Successfully',
        contentType: ContentType.success,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void logoutUser() async {
    await FirebaseAuth.instance.signOut();
    logoutToast();
    Navigator.popUntil(context, (route) => false);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
