import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';

abstract class ICheckoutRepository {
  Future<List<CartModel>> getCartProducts();
}
