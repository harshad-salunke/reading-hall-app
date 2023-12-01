import 'package:flutter/material.dart';
import 'package:kjcoemr_reading_hall/AdminSite/Widgets/small_screen.dart';

import 'Widgets/large_screen.dart';
import 'Widgets/side_menu.dart';
import 'Widgets/top_nav.dart';
import 'helpers/local_navigator.dart';
import 'helpers/responsiveness.dart';
class SiteLayout extends StatelessWidget {
final GlobalKey<ScaffoldState> scaffoldKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: toNavigationBar(context,scaffoldKey),
      extendBodyBehindAppBar: true,

      drawer: Drawer(
        child: SideMenu(),
      ),
      body: ResponsiveWidget(
          largeScreen: LargeScreen(),
          smallScreen: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: localNavigator(),
          ), mediumScreen: LargeScreen(),
        customScreen: LargeScreen(),
      ),
    );
  }
}
