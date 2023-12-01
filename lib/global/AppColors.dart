import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/SettingScreen/Txt.dart';
const app_bar_color=Color(0xffEAE8E8FF);
const gray_color=Color(0x000000FF);
const color=Colors.black;
const light_green=Color(0xB4B2FAA6);

const kPrimaryColor = Color(0xFFFF8084);
const kAccentColor = Color(0xFFF1F1F1);
const kWhiteColor = Color(0xFFFFFFFF);
const kLightColor = Color(0xFF808080);
const kDarkColor = Color(0xFF303030);
const kTransparent = Colors.transparent;

const kDefaultPadding = 24.0;
const kLessPadding = 10.0;
const kFixPadding = 16.0;
const kLess = 4.0;
const String manShoes = 'assets/images/manShoes.jpg';


const kShape = 30.0;

const kRadius = 0.0;
const kAppBarHeight = 56.0;

const kHeadTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
);

const kSubTextStyle = TextStyle(
  fontSize: 18.0,
  color: kLightColor,
);

const kTitleTextStyle = TextStyle(
  fontSize: 20.0,
  color: kPrimaryColor,
);

const kDarkTextStyle = TextStyle(
  fontSize: 20.0,
  color: kDarkColor,
);

const kDivider = Divider(
  color: kAccentColor,
  thickness: kLessPadding,
);
const double largePadding = 40;

Widget verticalBox(double height) => SizedBox(height: height);
Widget horizontalBox(double width) => SizedBox(width: width);

const double smallPadding = 12;
const double mediumPadding = 20;
double getDeviceWidth(BuildContext context) =>
    MediaQuery.of(context).size.width;
const kSmallDivider = Divider(
  color: kAccentColor,
  thickness: 5.0,
);
 Widget loadingCircle({Color? color, double size = 26}) {
return Material(
type: MaterialType.circle,
color: color,
elevation: 0,
child: SizedBox(
height: size,
width: size,
child: FittedBox(
fit: BoxFit.scaleDown,
child: CircularProgressIndicator(
strokeWidth: 5,
valueColor: AlwaysStoppedAnimation(Colors.white),
),
),
),
);
}

class Widgets {
  Widgets._privateConstructor();

  static final Widgets _instance = Widgets._privateConstructor();

  static Widgets get instance => _instance;
  static String timeAgo(
      dynamic input, {
        String? prefix,
      }) {
    DateTime? finalDateTime;

    if (input is DateTime) finalDateTime = input;
    if (input is int) finalDateTime = DateTime.fromMillisecondsSinceEpoch(input);

    ///If the input is not valid, then just return ''
    if (finalDateTime == null) return '';

    final Duration difference = DateTime.now().difference(finalDateTime);
    bool isPast = finalDateTime.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch;
    String ago;

    if (difference.inDays > 8) {
      ago = finalDateTime.toString().substring(0, 10);
    } else if ((difference.inDays / 7).floor() >= 1) {
      ago = isPast ? '1 week ago' : '1 week';
    } else if (difference.inDays >= 2) {
      ago = isPast ? '${difference.inDays} days ago' : '${difference.inDays} days';
    } else if (difference.inDays >= 1) {
      ago = isPast ? 'Yesterday' : 'Tomorrow';
    } else if (difference.inHours >= 2) {
      ago = '${difference.inHours} hours ${isPast ? 'ago' : ''}';
    } else if (difference.inHours >= 1) {
      ago = '1 hour ${isPast ? 'ago' : ''}';
    } else if (difference.inMinutes >= 2) {
      ago = '${difference.inMinutes} minutes ${isPast ? 'ago' : ''}';
    } else if (difference.inMinutes >= 1) {
      ago = '1 minute ${isPast ? 'ago' : ''}';
    } else if (difference.inSeconds >= 3) {
      ago = '${difference.inSeconds} seconds ${isPast ? 'ago' : ''}';
    } else {
      ago = '${isPast ? 'Just now' : 'now'}';
    }
    return prefix == null ? ago : '$prefix $ago';
  }
}