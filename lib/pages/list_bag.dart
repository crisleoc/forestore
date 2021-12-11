import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestore/data/db.dart';
import 'package:forestore/model/bag_products.dart';
import 'dart:math' as math;

class ListBagProducts extends StatefulWidget {
  ListBagProducts({Key key}) : super(key: key);

  @override
  _ListBagProductsState createState() => _ListBagProductsState();
}

class _ListBagProductsState extends State<ListBagProducts> {
  List<BagProducts> bProducts = [];

  void initState() {
    cargaProductos();
    super.initState();
  }

  cargaProductos() async {
    List<BagProducts> auxProduct = await DB.bProducts();
    setState(() {
      bProducts = auxProduct;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bProducts.length,
      itemBuilder: (context, i) => Dismissible(
        key: Key(i.toString()),
        direction: DismissDirection.startToEnd,
        background: Container(
          color: Colors.red,
          padding: const EdgeInsets.only(left: 5),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
        onDismissed: (direction) {
          DB.delete(bProducts[i].pNum);
        },
        child: Container(
          height: 70,
          width: double.infinity,
          padding: const EdgeInsets.only(right: 30, left: 30, bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    bProducts[i].name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${bProducts[i].price}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Transform.rotate(
                angle: 180 * math.pi / 180,
                child: const Icon(
                  CupertinoIcons.back,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
