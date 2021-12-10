import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestore/tokens/forestore_colors.dart';

class LoadingPage extends StatelessWidget {
  final Color background;
  const LoadingPage({Key key, this.background}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          'Editar perfil',
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
      backgroundColor: background,
      body: const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}
