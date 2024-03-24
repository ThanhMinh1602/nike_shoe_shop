import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';
import 'package:nike_shoe_shop/features/cart/domain/repository/cart_repository_interface.dart';
import 'package:nike_shoe_shop/services/local/cart_service.dart';
import 'package:nike_shoe_shop/services/remote/home_service.dart';

class CartRepositoryImpl implements ICartRepository {
  final HomeService homeService = HomeService();
  @override
  Future<void> addProductToCart(CartModel cartModel) async {
    CartService.cart.add(cartModel);
  }

  @override
  Future<List<ProductModel>> getCartProducts() async {
    throw UnimplementedError();
  }

  @override
  Future<void> removeProductFromCart(int index) {
    throw UnimplementedError();
  }
}
