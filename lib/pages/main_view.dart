import 'package:flutter/material.dart';
import 'package:forestore/tokens/forestore_colors.dart';

class MainView extends StatelessWidget {
  const MainView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text(
          "Main",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
