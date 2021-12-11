import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:forestore/components/button_products.dart';
import 'package:forestore/tokens/forestore_colors.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Map<String, dynamic>> items = [];
  ScrollController _scrollController = new ScrollController();

  Image getImg(int selector) {
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

  String? getTitle(int selector) {
    if (items[selector]["productName"] != null) {
      return items[selector]["productName"];
    } else {
      return "No data";
    }
  }

  String getSubTitle(int selector) {
    if (items[selector]["price"] != null) {
      return '\$ ${items[selector]["price"]}';
    } else {
      return 'No data';
    }
  }

  var _counter = 0;
  dynamic _searchName = null;
  var _searchType = 'products';

  Timer? _timer;

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

  Widget getButton(int selector) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: const Text(
                'Productos recomendados',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 210,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
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
                                getTitle(index)!,
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
    );
  }

  var url = 'https://sheetsu.com/apis/v1.0su/5a774ce7a249/sheets/';

  fetch(String object, {int? id, String? name}) async {
    _counter++;
    late var link;
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
    final response = await http.get(Uri.parse(link));
    EasyLoading.dismiss();

    try {
      if (response.statusCode == 200) {
        List? data = JSON.jsonDecode(response.body);
        setState(() {
          if (data!.length > 1) {
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

  fetchItems(String object, int id, {String? name}) {
    if (name != null) {
      fetch(object, name: name);
    } else {
      fetch(object, id: id);
    }
  }
}
