import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestore/model/user_info.dart';
import 'package:forestore/tokens/forestore_colors.dart';
import 'package:ionicons/ionicons.dart';

class EditStore extends StatelessWidget {
  final UserInfoRes usuario;
  const EditStore({Key key, this.usuario}) : super(key: key);

  String getName() {
    if (usuario != null) {
      if (usuario.name != "") {
        return usuario.name;
      }
    } else {
      return "No data";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          'Editar tienda',
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
      backgroundColor: MyColors.yellow300,
      body: Center(
        child: Text(
          getName(),
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
