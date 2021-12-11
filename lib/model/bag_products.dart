import 'dart:ffi';

class BagProducts {
  int id;
  String pNum;
  String name;
  double price;
  String imgUrl;

  BagProducts({
    this.id,
    this.pNum,
    this.name,
    this.price,
    this.imgUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pNum': pNum,
      'name': name,
      'price': price,
      'imgUrl': imgUrl
    };
  }
}
