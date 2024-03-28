import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';
import 'package:nike_shoe_shop/entities/models/requests/user_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';
import 'package:nike_shoe_shop/features/user/home/domain/repository/home_repository_interface.dart';
import 'package:nike_shoe_shop/services/local/cart_service.dart';
import 'package:nike_shoe_shop/services/local/share_pref.dart';
import 'package:nike_shoe_shop/services/remote/home_service.dart';
import 'package:nike_shoe_shop/services/remote/profile_service.dart';

class HomeRepositoryImpl implements IHomeRepository {
  final HomeService homeService = HomeService();
  final CartService cartService = CartService();
  final ProfileService profileService = ProfileService();

  @override
  Future<List<CategoryModel>> allCategories() async {
    return homeService.fetchCategories();
  }

  @override
  Future<List<ProductModel>> bestSalerProductByCategoryId(int cateId) async {
    final List<ProductModel> products =
        await homeService.fetchBestSalerProducts();
    return products.where((element) => element.categoryId == cateId).toList();
  }

  @override
  Future<ProductModel> newProductByCategoryId(int cateId) async {
    final List<ProductModel> products = await homeService.fetchNewProducts();

    return products.firstWhere((element) => element.categoryId == cateId);
  }

  @override
  Future<List<ProductModel>> searchProducts(String texSearch) {
    return homeService.searchProducts(texSearch);
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
    return await profileService.fetchUserByUid();
  }
}
