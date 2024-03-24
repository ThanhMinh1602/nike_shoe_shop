import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nike_shoe_shop/entities/models/appmodels/category_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';

class HomeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> fetchCategories() async {
    final querySnapshot =
        await _firestore.collection('categories').orderBy('id').get();
    return querySnapshot.docs
        .map((doc) => CategoryModel.fromJson(doc.data()))
        .toList();
  }

  Future<List<ProductModel>> fetchBestSalerProducts() async {
    final querySnapshot = await _firestore
        .collection('products')
        .orderBy('orderCount', descending: true)
        .get();
    return querySnapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data()))
        .toList();
  }

  Future<List<ProductModel>> fetchNewProducts() async {
    final querySnapshot = await _firestore
        .collection('products')
        .orderBy('id', descending: true)
        .get();
    return querySnapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data()))
        .toList();
  }
}
