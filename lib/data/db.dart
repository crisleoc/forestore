import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:forestore/model/bag_products.dart';

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'products.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE bagProducts (id INTEGER PRIMARY KEY, pNum TEXT, name TEXT, price DOUBLE, imgUrl TEXT)",
      );
    }, version: 1);
  }

  static Future<void> insert(BagProducts bProduct) async {
    Database database = await _openDB();
    return database.insert("bagProducts", bProduct.toMap());
  }

  static Future<void> delete(String pNum) async {
    Database database = await _openDB();
    return database.delete("bagProducts", where: "pNum = ?", whereArgs: [pNum]);
  }

  static Future<void> update(BagProducts bProduct) async {
    Database database = await _openDB();
    return database.update(
      "bagProducts",
      bProduct.toMap(),
      where: "id = ?",
      whereArgs: [bProduct.id],
    );
  }

  static Future<List<BagProducts>> bProducts() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> productsMap =
        await database.query("bagProducts");
    return List.generate(
      productsMap.length,
      (i) => BagProducts(
        id: productsMap[i]['id'],
        pNum: productsMap[i]['pNum'],
        name: productsMap[i]['name'],
        price: productsMap[i]['price'],
        imgUrl: productsMap[i]['imgUrl'],
      ),
    );
  }
}
