import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';

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
      version: 1,
      onCreate: _createTable,
    );
  }

  Future _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER NOT NULL,
        productName TEXT NOT NULL,
        productImage TEXT NOT NULL,
        productPrice REAL NOT NULL,
        quantity INTEGER NOT NULL,
        size INTEGER NOT NULL
      )
    ''');
  }

  Future<List<CartModel>> getCartItems() async {
    final db = await database;
    final result = await db!.query(_tableName);
    return result.map((e) => CartModel.fromJson(e)).toList();
  }

  Future<int> addItem(CartModel item) async {
    final db = await database;
    final existingProduct = await db!.query(
      _tableName,
      where: 'productId = ?',
      whereArgs: [item.productId],
    );
    if (existingProduct.isNotEmpty) {
      // Sản phẩm đã tồn tại trong giỏ hàng, cập nhật quantity
      final currentQuantity = existingProduct[0]['quantity'] as int;
      return await db.update(
        _tableName,
        {'quantity': currentQuantity + 1},
        where: 'productId = ?',
        whereArgs: [item.productId],
      );
    } else {
      // Sản phẩm chưa tồn tại trong giỏ hàng, thêm mới
      return await db.insert(_tableName, item.toJson());
    }
  }

  Future<int> updateItemQuantity(int productId, int quantity) async {
    final db = await database;
    return await db!.update(
      _tableName,
      {'quantity': quantity},
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  Future<int> removeProductItem(int productId) async {
    final db = await database;
    return await db!.delete(
      _tableName,
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  Future<void> clearCart() async {
    final db = await database;
    await db!.delete(_tableName);
  }
}
