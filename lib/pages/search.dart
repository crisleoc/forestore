import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:forestore/components/button_products.dart';
import 'package:forestore/pages/store_view.dart';
import 'package:forestore/tokens/forestore_colors.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  // final _formKey = GlobalKey<FormState>();

  var _placeHolder = 'Buscar';
  TextEditingController _myPhoneField = TextEditingController();

  var label_input = TextStyle(
    fontFamily: 'Montserrat',
    color: MyColors.black300,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  var btnTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: MyColors.black300,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  var btnTiendas = MyColors.blue200;
  var btnProductos = Colors.transparent;

  List<Map<String, dynamic>> items = [];
  ScrollController _scrollController = new ScrollController();

  var _searchType = 'stores';
  var _searchName = null;
  var _counter = 0;

  Timer _timer;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    EasyLoading.show(status: 'Cargando...');
    for (int i = 0; i < 5; i++) {
      fetchItems(_searchType, _counter, name: _searchName);
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // fetchItems(_searchType, _counter, name: _searchName);
        for (int i = 0; i < 4; i++) {
          fetchItems(_searchType, _counter, name: _searchName);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Image getImg(int selector) {
    if (_searchType == 'stores') {
      if (items[selector]["storeImg"] == null) {
        return Image.asset(
          'assets/noImg.png',
          fit: BoxFit.cover,
        );
      } else {
        return Image.network(
          items[selector]["storeImg"],
          fit: BoxFit.cover,
        );
      }
    } else if (_searchType == 'products') {
      if (items[selector]["productImg"] == null) {
        return Image.asset(
          'assets/noImg.png',
          fit: BoxFit.cover,
        );
      } else {
        return Image.network(
          items[selector]["productImg"],
          fit: BoxFit.cover,
        );
      }
    }
  }

  String getTitle(int selector) {
    if (_searchType == 'stores') {
      if (items[selector]["storeName"] != null) {
        return items[selector]["storeName"];
      } else {
        return "No data";
      }
    } else if (_searchType == 'products') {
      if (items[selector]["productName"] != null) {
        return items[selector]["productName"];
      } else {
        return "No data";
      }
    }
  }

  String getSubTitle(int selector) {
    if (_searchType == 'stores') {
      if (items[selector]["type"] != null) {
        return items[selector]["type"];
      } else {
        return 'No data';
      }
    } else if (_searchType == 'products') {
      if (items[selector]["price"] != null) {
        return '\$ ${items[selector]["price"]}';
      } else {
        return 'No data';
      }
    }
  }

  Widget getButton(int selector) {
    if (_searchType == 'stores') {
      if (items[selector]["storeName"] != null) {
        return TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoreView(store: items[selector]),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MyColors.yellow300),
            ),
            child: const Text(
              'Ir',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ));
      } else {
        return TextButton(
          onPressed: null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MyColors.black100),
          ),
          child: const Text(
            'Ir',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );
      }
    } else if (_searchType == 'products') {
      if (items[selector]["productName"] != null) {
        return ButtonProducts(
          productAdd: items[selector],
        );
      } else {
        return TextButton(
          onPressed: null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MyColors.black100),
          ),
          child: const Icon(
            Ionicons.add_outline,
            color: Colors.black,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          title: const Text(
            'Buscar',
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
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 50,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(btnTiendas),
                            ),
                            onPressed: () {
                              setState(() {
                                btnTiendas = MyColors.blue200;
                                btnProductos = Colors.transparent;
                                _searchType = 'stores';
                                _searchName = null;
                                _counter = 0;
                                items = [];
                                for (int i = 0; i < 5; i++) {
                                  fetchItems(_searchType, _counter,
                                      name: _searchName);
                                }
                              });
                            },
                            child: Text(
                              'Tiendas',
                              style: btnTextStyle,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 50,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(btnProductos),
                            ),
                            onPressed: () {
                              setState(() {
                                btnProductos = MyColors.blue200;
                                btnTiendas = Colors.transparent;
                                _searchType = 'products';
                                _searchName = null;
                                _counter = 0;
                                items = [];
                                for (int i = 0; i < 5; i++) {
                                  fetchItems(_searchType, _counter,
                                      name: _searchName);
                                }
                              });
                            },
                            child: Text(
                              'Productos',
                              style: btnTextStyle,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Form(
                      // key: _formKey,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 60,
                        child: CupertinoTextField(
                          controller: _myPhoneField,
                          textAlignVertical: TextAlignVertical.center,
                          placeholderStyle: label_input,
                          placeholder: _placeHolder,
                          cursorColor: Colors.blue,
                          maxLines: 1,
                          textCapitalization: TextCapitalization.words,
                          cursorHeight: 20,
                          cursorWidth: 1.5,
                          style: label_input,
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            right: 70,
                            left: 20,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5, color: MyColors.black300),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            child: Icon(
                              Ionicons.search_outline,
                              color: MyColors.black300,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: TextButton(
                              onPressed: () {
                                if (_myPhoneField.text.isEmpty) {
                                  setState(() {
                                    _placeHolder = 'Ingrese su búsqueda';
                                  });
                                } else {
                                  setState(() {
                                    items = [];
                                    _counter = 0;
                                    _searchName = _myPhoneField.text;
                                    fetchItems(_searchType, _counter,
                                        name: _searchName);
                                  });
                                }
                              },
                              child: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 230,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1.5, color: Colors.black),
                        ),
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        constraints: const BoxConstraints.tightFor(height: 100),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              height: 80,
                              width: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: getImg(index),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    getTitle(index),
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Text(
                                  getSubTitle(index),
                                  style: TextStyle(
                                    color: MyColors.black200,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 50,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.5,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: getButton(index),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  var url = 'https://sheetsu.com/apis/v1.0su/5a774ce7a249/sheets/';

  fetch(String object, {int id, String name}) async {
    _counter++;
    var link;
    if (object == 'stores') {
      if (name != null) {
        link = '${url}stores/search?storeName=$name';
      } else {
        link = '${url}stores/search?id=$id';
      }
    } else if (object == 'products') {
      if (name != null) {
        link = '${url}products/search?productName=$name';
      } else {
        link = '${url}products/search?id=$id';
      }
    }
    EasyLoading.show(status: 'Cargando...');
    final response = await http.get(link);
    EasyLoading.dismiss();

    try {
      if (response.statusCode == 200) {
        List data = JSON.jsonDecode(response.body);
        setState(() {
          if (data.length > 1) {
            data.forEach((element) {
              items.add(element);
            });
          } else {
            items.add(data[0]);
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  fetchItems(String object, int id, {String name}) {
    if (name != null) {
      fetch(object, name: name);
    } else {
      fetch(object, id: id);
    }
  }
}
