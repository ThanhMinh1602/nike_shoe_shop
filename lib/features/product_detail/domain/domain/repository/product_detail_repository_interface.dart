import 'package:nike_shoe_shop/entities/models/cart_model.dart';

abstract class IProductDetailRepository {
  Future<void> addProductToCart(CartModel cartModel);
}
