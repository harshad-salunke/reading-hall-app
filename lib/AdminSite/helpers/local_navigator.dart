import 'package:flutter/widgets.dart';
import 'package:kjcoemr_reading_hall/AdminSite/constants/controllers.dart';

import '../rounting/routers.dart';
import '../rounting/routes.dart';
Navigator localNavigator()=>Navigator(
    key: navigationController.navigatorKey,
    initialRoute: overviewPageRoute,
onGenerateRoute: generateRoute,
  
);