import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:forestore/pages/home.dart';
import 'package:forestore/pages/log_in.dart';
import 'package:forestore/pages/notifications.dart';
import 'package:forestore/pages/search.dart';
import 'package:forestore/pages/sign_in.dart';
import 'package:forestore/pages/slider_new_user.dart';
import 'package:forestore/tokens/forestore_colors.dart';

void main() {
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.doubleBounce
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = MyColors.black200.withOpacity(0.5)
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      initialRoute: '/',
      routes: {
        '/': (ctx) => CarouselWithIndicatorDemo(),
        '/signin': (ctx) => SignInForm(),
        '/login': (ctx) => LogInForm(),
        '/home': (ctx) => Home(),
        '/notification': (ctx) => NotificationsView(),
        '/search': (ctx) => SearchView(),
      },
      builder: EasyLoading.init(),
    );
  }
}
