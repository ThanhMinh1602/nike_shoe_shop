import 'package:nike_shoe_shop/entities/models/cart_model.dart';
import 'package:nike_shoe_shop/entities/models/payment_model.dart';
import 'package:nike_shoe_shop/services/sevice_status.dart';

abstract class ICheckoutRepository {
  Future<List<CartModel>> getCartProducts();
  Future<SendOrderStatus> sendOrder(PaymentModel paymentModel);
  Future<void> clearCart();
}
