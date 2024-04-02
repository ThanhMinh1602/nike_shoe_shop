import 'dart:async';
import 'package:nike_shoe_shop/services/local/share_pref.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:nike_shoe_shop/entities/models/cart_model.dart';

class CartService {
  static const _databaseName = 'nike_shoe_shop.db';
  static const _tableName = 'cart_items';
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return await openDatabase(
      path,
      version: 6,
      onCreate: _createTable,
    );
  }

  Future _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uID TEXT NOT NULL,
        productId TEXT NOT NULL,
        productName TEXT NOT NULL,
        productImage TEXT NOT NULL,
        productPrice REAL NOT NULL,
        quantity INTEGER NOT NULL,
        size INTEGER NOT NULL
      )
    ''');
  }

  Future<List<CartModel>> getCartItems() async {
    String uID = SharedPrefs.token!;
    final db = await database;
    final result = await db!.query(
      _tableName,
      where: 'uID = ?',
      whereArgs: [uID],
      orderBy: 'id DESC',
    );
    return result.map((e) => CartModel.fromJson(e)).toList();
  }

  Future<int> addItem(CartModel item) async {
    String uID = SharedPrefs.token!;
    final db = await database;
    final existingProduct = await db!.query(
      _tableName,
      where: 'productId = ? AND uID = ?',
      whereArgs: [item.productId, uID],
    );
    if (existingProduct.isNotEmpty) {
      final currentQuantity = existingProduct[0]['quantity'] as int;
      return await db.update(
        _tableName,
        {'quantity': currentQuantity + 1},
        where: 'productId = ? AND uID = ?',
        whereArgs: [item.productId, uID],
      );
    } else {
      return await db.insert(_tableName, {...item.toJson(), 'uID': uID});
    }
  }

  Future<int> updateItemQuantity(String productId, int quantity) async {
    String uID = SharedPrefs.token!;
    final db = await database;
    return await db!.update(
      _tableName,
      {'quantity': quantity},
      where: 'productId = ? AND uID = ?',
      whereArgs: [productId, uID],
    );
  }

  Future<int> removeProductItem(String productId) async {
    String uID = SharedPrefs.token!;
    final db = await database;
    return await db!.delete(
      _tableName,
      where: 'productId = ? AND uID = ?', 
      whereArgs: [productId, uID],
    );
  }

  Future<int> clearAllCart() async {
    String uID = SharedPrefs.token!;
    final db = await database;
    return await db!.delete(
      _tableName,
      where: 'uID = ?',
      whereArgs: [uID],
    );
  }
}
