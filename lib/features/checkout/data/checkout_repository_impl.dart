import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:nike_shoe_shop/entities/models/cart_model.dart';
import 'package:nike_shoe_shop/entities/models/payment_model.dart';
import 'package:nike_shoe_shop/features/checkout/domain/checkout_repository_interface.dart';
import 'package:nike_shoe_shop/services/local/cart_service.dart';
import 'package:nike_shoe_shop/services/remote/payment_service.dart';
import 'package:nike_shoe_shop/services/sevice_status.dart';

class CheckoutRepositoryImpl implements ICheckoutRepository {
  final CartService cartService = CartService();
  final PaymentService paymentService = PaymentService();

  @override
  Future<List<CartModel>> getCartProducts() async {
    List<CartModel> cartProducts = await cartService.getCartItems();
    return cartProducts;
  }

  @override
  Future<SendOrderStatus> sendOrder(PaymentModel paymentModel) async {
    return await paymentService.sendPayment(paymentModel);
  }

  @override
  Future<void> clearCart() async {
    await cartService.clearAllCart();
  }

  // @override
  // Future<void> sendEmail(
  //     String recipientEmail, PaymentModel paymentModel) async {
  //   await paymentService.sendEmail(recipientEmail, paymentModel);
  // }
}
