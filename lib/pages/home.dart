import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestore/data/server_conection.dart';
import 'package:forestore/pages/bag.dart';
import 'package:forestore/pages/main_view.dart';
import 'package:forestore/pages/notifications.dart';
import 'package:forestore/pages/profile.dart';
import 'package:forestore/pages/search.dart';
import 'package:forestore/tokens/forestore_colors.dart';
import 'package:ionicons/ionicons.dart';

class Home extends StatefulWidget {
  final userName;
  final password;
  Home({
    Key? key,
    this.userName,
    this.password,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState(this.userName, this.password);
}

class _HomeState extends State<Home> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  final userName;
  final password;
  int index = 1;
  var navBarColor = MyColors.yellow100;
  var mainColor = MyColors.yellow300;
  var appBarColor = Colors.black;

  _HomeState(this.userName, this.password);

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(
        Ionicons.bag_handle_outline,
        size: 30,
      ),
      const Icon(
        Ionicons.home_outline,
        size: 30,
      ),
      const Icon(
        Ionicons.person_outline,
        size: 30,
      ),
    ];

    final screens = [
      BagView(),
      MainView(),
      ProfileView(
        userName: userName,
        password: password,
      ),
      NotificationsView(),
      SearchView(),
    ];

    if (index == 1) {
      navBarColor = MyColors.yellow100;
      mainColor = MyColors.yellow300;
      appBarColor = Colors.black;
    } else if (index == 0) {
      navBarColor = MyColors.green100;
      mainColor = MyColors.green300;
      appBarColor = Colors.black;
    } else if (index == 2) {
      navBarColor = MyColors.blue100;
      mainColor = MyColors.blue300;
      appBarColor = Colors.white;
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          foregroundColor: appBarColor,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 35,
                height: 35,
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  // border: Border.all(width: 1, color: Colors.black),
                ),
                child: Image.asset('assets/forest.png'),
              ),
              const Text(
                'Forestore',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          elevation: 0,
          // centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notification');
              },
              icon: Icon(Ionicons.notifications_outline),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
              icon: Icon(Ionicons.search_outline),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.back),
          ),
        ),
        // Text('$userName and $password')
        body: screens[index],
        bottomNavigationBar: CurvedNavigationBar(
          key: navigationKey,
          color: navBarColor,
          buttonBackgroundColor: navBarColor,
          backgroundColor: Colors.transparent,
          index: index,
          items: items,
          height: 60,
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}
