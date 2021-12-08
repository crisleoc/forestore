import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestore/tokens/forestore_colors.dart';
import 'package:ionicons/ionicons.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          'Forestore',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      backgroundColor: MyColors.pink300,
      body: const Center(
        child: Text(
          "Notification",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
