import 'package:flutter/material.dart';
import 'package:kjcoemr_reading_hall/AdminSite/Widgets/vertical_menu_item.dart';

import '../helpers/responsiveness.dart';
import 'horizontal_menu_item.dart';



class SideMenuItem extends StatelessWidget {
  final String itemName;
  final Function() onTap;

  const SideMenuItem({ Key ?key, required this.itemName,required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(ResponsiveWidget.isCustomSize(context)){
      return VertticalMenuItem(itemName: itemName, onTap: onTap,);
    }else{
      return HorizontalMenuItem(itemName: itemName, onTap: onTap,);
    }
  }
}