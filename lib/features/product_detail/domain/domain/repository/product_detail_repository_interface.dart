import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';

abstract class IProductDetailRepository {
  Future<void> addProductToCart(CartModel cartModel);
}
