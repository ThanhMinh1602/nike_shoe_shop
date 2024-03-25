import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';
import 'package:nike_shoe_shop/features/cart/domain/repository/cart_repository_interface.dart';
import 'package:nike_shoe_shop/services/local/cart_service.dart';

class CartRepositoryImpl implements ICartRepository {
  final CartService cartService = CartService();

  @override
  Future<List<CartModel>> getCartProducts() async {
    List<CartModel> cartProducts = await cartService.getCartItems();
    return cartProducts;
  }

  @override
  Future<void> removeProductFromCart(int productId) async {
    await cartService.removeProductItem(productId);
  }
}
