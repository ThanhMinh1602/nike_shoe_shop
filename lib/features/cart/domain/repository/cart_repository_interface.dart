import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';

abstract class ICartRepository {
  Future<List<CartModel>> getCartProducts();
  Future<void> removeProductFromCart(String productId);
  Future<void> changeQuantity(String productId, int quantityChange);
}
