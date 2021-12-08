import 'package:flutter/material.dart';

class StoreView extends StatelessWidget {
  final Map<String, dynamic> store;
  const StoreView({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store"),
      ),
      body: Center(
        child: Text(store["storeName"]),
      ),
    );
  }
}
