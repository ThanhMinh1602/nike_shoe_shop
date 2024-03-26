import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';
import 'package:nike_shoe_shop/features/checkout/domain/checkout_repository_interface.dart';
import 'package:nike_shoe_shop/services/local/cart_service.dart';

class CheckoutRepositoryImpl implements ICheckoutRepository {
  final CartService cartService = CartService();

  @override
  Future<List<CartModel>> getCartProducts() async {
    List<CartModel> cartProducts = await cartService.getCartItems();
    return cartProducts;
  }
}
