import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';

abstract class IHomeRepository {
  Future<List<CategoryModel>> allCategories();
  Future<List<ProductModel>> bestSalerProductByCategoryId(int cateId);
  Future<ProductModel> newProductByCategoryId(int cateId);
  Future<List<ProductModel>> searchProducts(String texSearch);
  Future<void> logOut();
}
