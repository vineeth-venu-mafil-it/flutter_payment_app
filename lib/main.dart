import 'package:flutter/material.dart';
import 'package:flutter_payment_app/core/helpers/nav_prevent/prevent_gesture_nav.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'features/bread_crumbs/controller/breadcrumbs_controller.dart';
import 'features/drawer/controller/drawer_controller.dart';
import 'features/home/controller/home_controller.dart';

import 'features/payments/view/report/imps_inquiry/controller/imps_inquiry_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  preventBackNavigation();
  usePathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => DrawerProvider()),
        ChangeNotifierProvider(create: (_) => BreadCrumbsProvider()),
        ChangeNotifierProvider(create: (_) => ImpsInquiryProvider()),
      ],
      child: MyApp(),
    ),
  );
}
