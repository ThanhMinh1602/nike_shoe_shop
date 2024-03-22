import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nike_shoe_shop/entities/models/appmodels/category_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';

class HomeService {
  final firestore = FirebaseFirestore.instance;
  Future<List<CategoryModel>> fetchCategories() async {
    final querySnapshot = await firestore.collection('categories').get();
    List<CategoryModel> categories = querySnapshot.docs
        .map((doc) => CategoryModel.fromJson(doc.data()))
        .toList();
    return categories;
  }

  Future<List<ProductModel>> fetchProducts() async {
    final querySnapshot = await firestore.collection('products').get();
    List<ProductModel> productByCateId = querySnapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data()))
        .toList();
    return productByCateId;
  }
}
