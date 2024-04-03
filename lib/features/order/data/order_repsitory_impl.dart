import 'package:nike_shoe_shop/entities/models/payment_model.dart';
import 'package:nike_shoe_shop/features/order/domain/repository/order_repository_interface.dart';
import 'package:nike_shoe_shop/services/remote/payment_service.dart';

class OrderRepositoryImpl implements IOrderRepository {
  final PaymentService paymentService = PaymentService();
  @override
  Future<List<PaymentModel>> getOrder() async {
    return await paymentService.getPaymentByUid();
  }
}
