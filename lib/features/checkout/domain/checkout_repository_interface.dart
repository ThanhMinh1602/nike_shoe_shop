import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';
import 'package:nike_shoe_shop/entities/models/requests/payment_model.dart';
import 'package:nike_shoe_shop/services/sevice_status.dart';

abstract class ICheckoutRepository {
  Future<List<CartModel>> getCartProducts();
  Future<SendOrderStatus> sendOrder(PaymentModel paymentModel);
  Future<void> clearCart();
}
