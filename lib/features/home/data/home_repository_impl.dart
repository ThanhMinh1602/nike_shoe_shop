import 'package:nike_shoe_shop/entities/models/cart_model.dart';
import 'package:nike_shoe_shop/entities/models/user_model.dart';
import 'package:nike_shoe_shop/entities/models/category_model.dart';
import 'package:nike_shoe_shop/entities/models/product_model.dart';
import 'package:nike_shoe_shop/features/home/domain/repository/home_repository_interface.dart';
import 'package:nike_shoe_shop/services/local/cart_service.dart';
import 'package:nike_shoe_shop/services/local/share_pref.dart';
import 'package:nike_shoe_shop/services/remote/auth_service.dart';
import 'package:nike_shoe_shop/services/remote/category_service.dart';
import 'package:nike_shoe_shop/services/remote/product_service.dart';

class HomeRepositoryImpl implements IHomeRepository {
  final CartService cartService = CartService();
  final CategoryService categoryService = CategoryService();
  final ProductService productService = ProductService();
  final AuthService authService = AuthService();

  @override
  Future<List<CategoryModel>> allCategories() async {
    return categoryService.fetchCategories();
  }

  @override
  Future<List<ProductModel>> bestSalerProductByCategoryId(String cateId) async {
    final products = await productService.fetchBestSalerProducts();
    return products.where((element) => element.categoryId == cateId).toList();
  }

  @override
  Future<ProductModel> newProductByCategoryId(String cateId) async {
    final products = await productService.fetchNewProducts();

    return products.firstWhere((element) => element.categoryId == cateId);
  }

  @override
  Future<List<ProductModel>> searchProducts(String texSearch) {
    return productService.searchProducts(texSearch);
  }

  @override
  Future<void> logOut() async {
    await SharedPrefs.removeSeason();
  }

  @override
  Future<int> addProductToCart(CartModel cartModel) async {
    return await cartService.addItem(cartModel);
  }

  @override
  Future<UserModel> userData() async {
    return await authService.fetchUserByUid();
  }
}
