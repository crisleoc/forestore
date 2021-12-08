import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    fetchFive();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchFive();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 60,
                      child: CupertinoTextField(
                        textAlignVertical: TextAlignVertical.center,
                        placeholderStyle: label_input,
                        placeholder: 'Buscar',
                        cursorColor: Colors.blue,
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
                          border:
                              Border.all(width: 1.5, color: MyColors.black300),
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
                                print('hola');
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
                                border: Border.all(
                                  width: 1.5,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              height: 80,
                              width: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.network(
                                  items[index]["storeImg"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[index]["storeName"],
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  items[index]["type"],
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
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StoreView(store: items[index]),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        MyColors.yellow300),
                                  ),
                                  child: const Text(
                                    'Ir',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  )),
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

  var url =
      'https://sheetsu.com/apis/v1.0su/71ace603b465/sheets/stores/search?id=';

  fetch(int id) async {
    final link = '${url}$id';
    final response = await http.get(link);
    if (response.statusCode == 200) {
      setState(() {
        items.add(JSON.jsonDecode(response.body)[0]);
      });
    } else {
      throw Exception('Failed to load images');
    }
  }

  fetchFive() {
    for (int i = 0; i < 5; i++) {
      fetch(i);
    }
  }
}
