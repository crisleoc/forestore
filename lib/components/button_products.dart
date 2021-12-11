import 'package:flutter/material.dart';
import 'package:forestore/model/bag_products.dart';
import 'package:forestore/tokens/forestore_colors.dart';
import 'package:ionicons/ionicons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forestore/data/db.dart';

class ButtonProducts extends StatefulWidget {
  final Map<String, dynamic>? productAdd;

  ButtonProducts({Key? key, this.productAdd}) : super(key: key);

  @override
  _ButtonProductsState createState() => _ButtonProductsState(this.productAdd);
}

class _ButtonProductsState extends State<ButtonProducts> {
  final Map<String, dynamic>? productAdd;
  bool btnIcon = true;
  bool btnColor = true;
  bool productAdded = false;

  _ButtonProductsState(this.productAdd);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        setState(() {
          btnColor = !btnColor;
          btnIcon = !btnIcon;
          productAdded = !productAdded;
        });

        if (productAdded) {
          DB.insert(BagProducts(
            pNum: productAdd!["id"],
            name: productAdd!["productName"],
            price: double.parse(productAdd!["price"]),
            imgUrl: productAdd!["productImg"],
          ));
          print('Producto agregado');
        } else {
          DB.delete(productAdd!["id"]);
          print('Producto Eliminado');
        }

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
