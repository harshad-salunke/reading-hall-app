import 'package:flutter/material.dart';

import '../../global/AppColors.dart';

class NotificationTiles extends StatelessWidget {
  final String title, subtitle;
  final Function() callback;
  final bool enable;

  const NotificationTiles({
    required this.title,
    required this.subtitle,
    required this.callback,
    required this.enable,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          height: 50.0,
          width: 50.0,
          child:  CircleAvatar(
            radius: 25, // set the radius of the circle
            backgroundImage: AssetImage('assets/images/notification.png'),
            backgroundColor: Colors.transparent,

          ),),
      title: Text(title, style: TextStyle(color: kDarkColor)),
      subtitle: Text(subtitle, style: TextStyle(color: kLightColor)),
      onTap: callback,
      enabled: enable,
    );
  }
}
