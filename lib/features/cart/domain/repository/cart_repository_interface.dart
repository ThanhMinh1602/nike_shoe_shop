import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';

abstract class ICartRepository {
  Future<void> addProductToCart(CartModel cartModel);
  Future<void> removeProductFromCart(int index);
  Future<List<ProductModel>> getCartProducts();
}
