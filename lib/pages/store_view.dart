import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestore/tokens/forestore_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreView extends StatelessWidget {
  final Map<String, dynamic> store;
  const StoreView({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text(
          store["storeName"],
          style: const TextStyle(fontWeight: FontWeight.bold),
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
      backgroundColor: MyColors.green300,
      body: SafeArea(
        top: false,
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            height: double.infinity,
            // color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border:
                                  Border.all(width: 1.5, color: Colors.black),
                            ),
                            height: 80,
                            width: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.network(
                                store['storeImg'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                width: 1.5,
                                color: MyColors.green100,
                              )),
                            ),
                            child: InkWell(
                              child: Text(
                                "Sitio web",
                                style: TextStyle(
                                  color: MyColors.green100,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  // decoration: TextDecoration.underline,
                                ),
                              ),
                              onTap: () async {
                                var url = store["web"];
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'No se pudo ingresar a $url';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 150,
                            margin: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: Text(
                              store["phone"],
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 150,
                            margin: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: Text(
                              store["email"],
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 150,
                            margin: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: Text(
                              store["direction"],
                              softWrap: true,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(top: 20),
                  height: MediaQuery.of(context).size.height - 240,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
