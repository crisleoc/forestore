import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestore/pages/home.dart';
import 'package:forestore/pages/log_in.dart';
import 'package:forestore/pages/notifications.dart';
import 'package:forestore/pages/search.dart';
import 'package:forestore/pages/sign_in.dart';
import 'package:forestore/pages/slider_new_user.dart';

void main() => runApp(MyApp());

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
    );
  }
}
