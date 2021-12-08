import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestore/tokens/forestore_colors.dart';

final List<Map<String, dynamic>> slideTokens = [
  {
    "ImgURL": "assets/slide_img1.png",
    "color": MyColors.green300,
    "title": "Bienvenido a Forestore",
    "subtitle": "El lugar donde puedes comprar y vender al mismo tiempo 24 / 7",
  },
  {
    "ImgURL": "assets/slide_img2.png",
    "color": MyColors.yellow300,
    "title": "Con envíos gratis en menos de 24 horas",
    "subtitle": "",
  },
  {
    "ImgURL": "assets/slide_img3.png",
    "color": MyColors.red300,
    "title": "Encuentra miles de productos",
    "subtitle": "",
  },
  {
    "ImgURL": "assets/slide_img4.png",
    "color": MyColors.pink300,
    "title": "¿Empezamos?",
    "subtitle": "",
  },
];

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SliderNewUser();
  }
}

class SliderNewUser extends State<CarouselWithIndicatorDemo> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Builder(
              builder: (context) {
                final double height = MediaQuery.of(context).size.height;
                return CarouselSlider(
                  options: CarouselOptions(
                      height: height,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }
                      // autoPlay: false,
                      ),
                  items: slideTokens
                      .map((item) => Container(
                            color: item["color"],
                            width: double.maxFinite,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 30),
                                  child: Image.asset(
                                    item["ImgURL"],
                                    // fit: BoxFit.cover,
                                    height: height / 2.5,
                                    // width: 200,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(20),
                                      child: Text(
                                        item["title"],
                                        textDirection: TextDirection.ltr,
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ),
                                    if (item["subtitle"] != "")
                                      Text(
                                        item["subtitle"],
                                        textDirection: TextDirection.ltr,
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(.9),
                                          fontFamily: 'Montserrat',
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                  ],
                                ),
                                if (item == slideTokens[slideTokens.length - 1])
                                  CupertinoButton(
                                    pressedOpacity: 0.5,
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.black,
                                    child: const Icon(
                                      CupertinoIcons.arrow_right,
                                      color: Colors.white,
                                      size: 35,
                                      semanticLabel: "Get started",
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, ('/signin'));
                                    },
                                  )
                              ],
                            ),
                          ))
                      .toList(),
                );
              },
            ),
            Positioned(
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: slideTokens.map((url) {
                  int index = slideTokens.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Color.fromRGBO(255, 255, 255, 1)
                          : Color.fromRGBO(255, 255, 255, 0.5),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
