import 'package:nike_shoe_shop/entities/models/requests/payment_model.dart';
import 'package:nike_shoe_shop/features/user/order/domain/repository/order_repository_interface.dart';
import 'package:nike_shoe_shop/services/remote/checkout_service.dart';

class OrderRepositoryImpl implements IOrderRepository {
  final CheckoutService checkoutService = CheckoutService();
  @override
  Future<List<PaymentModel>> getOrder() async {
    return await checkoutService.getOderByUid();
  }
}
