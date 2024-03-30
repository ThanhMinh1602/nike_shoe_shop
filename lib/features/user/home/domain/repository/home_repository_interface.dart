import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';
import 'package:nike_shoe_shop/entities/models/requests/user_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';

abstract class IHomeRepository {
  Future<List<CategoryModel>> allCategories();
  Future<List<ProductModel>> bestSalerProductByCategoryId(String cateId);
  Future<ProductModel> newProductByCategoryId(String cateId);
  Future<List<ProductModel>> searchProducts(String texSearch);
  Future<int> addProductToCart(CartModel cartModel);
  Future<UserModel> userData();
  Future<void> logOut();
}
