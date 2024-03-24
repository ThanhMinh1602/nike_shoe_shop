// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';

class HomeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final querySnapshot =
          await _firestore.collection('categories').orderBy('id').get();
      return querySnapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  Future<List<ProductModel>> fetchBestSalerProducts() async {
    try {
      final querySnapshot = await _firestore
          .collection('products')
          .orderBy('orderCount', descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching best seller products: $e');
      return [];
    }
  }

  Future<List<ProductModel>> fetchNewProducts() async {
    try {
      final querySnapshot = await _firestore
          .collection('products')
          .orderBy('id', descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching new products: $e');
      return [];
    }
  }

  Future<List<ProductModel>> searchProducts(String searchText) async {
    String searchTermLower = searchText.toLowerCase();

    List<ProductModel> matchedProducts = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('products').get();
      for (var doc in querySnapshot.docs) {
        String nameLower = doc['name'].toLowerCase();
        if (nameLower.contains(searchTermLower)) {
          matchedProducts
              .add(ProductModel.fromJson(doc.data() as Map<String, dynamic>));
        }
      }
      return matchedProducts;
    } catch (e) {
      print('Error searching products: $e');
      return [];
    }
  }
}
