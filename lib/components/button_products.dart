import 'package:flutter/material.dart';
import 'package:forestore/tokens/forestore_colors.dart';
import 'package:ionicons/ionicons.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ButtonProducts extends StatefulWidget {
  ButtonProducts({Key key}) : super(key: key);

  @override
  _ButtonProductsState createState() => _ButtonProductsState();
}

class _ButtonProductsState extends State<ButtonProducts> {
  bool btnIcon = true;
  bool btnColor = true;
  bool productAdded = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        setState(() {
          btnColor = !btnColor;
          btnIcon = !btnIcon;
          productAdded = !productAdded;
        });
        Fluttertoast.showToast(
            msg: productAdded ? "Producto agregado" : "Producto eliminado",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: MyColors.black200.withOpacity(0.8),
            textColor: Colors.white,
            fontSize: 16);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            btnColor ? Colors.greenAccent[700] : MyColors.red300),
      ),
      child: Icon(
        btnIcon ? Ionicons.add_outline : Ionicons.remove_outline,
        color: Colors.white,
      ),
    );
  }
}
