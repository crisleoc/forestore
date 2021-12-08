import 'package:flutter/material.dart';
import 'package:forestore/tokens/forestore_colors.dart';

class BagView extends StatelessWidget {
  const BagView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text(
          "Bag",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
