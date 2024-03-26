import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';
import 'package:nike_shoe_shop/entities/models/requests/payment_model.dart';
import 'package:nike_shoe_shop/features/checkout/domain/checkout_repository_interface.dart';
import 'package:nike_shoe_shop/services/local/cart_service.dart';
import 'package:nike_shoe_shop/services/remote/checkout_service.dart';
import 'package:nike_shoe_shop/services/sevice_status.dart';

class CheckoutRepositoryImpl implements ICheckoutRepository {
  final CartService cartService = CartService();
  final CheckoutService checkoutService = CheckoutService();

  @override
  Future<List<CartModel>> getCartProducts() async {
    List<CartModel> cartProducts = await cartService.getCartItems();
    return cartProducts;
  }

  @override
  Future<SendOrderStatus> sendOrder(PaymentModel paymentModel) async {
    return await checkoutService.sendOrder(paymentModel);
  }
}
