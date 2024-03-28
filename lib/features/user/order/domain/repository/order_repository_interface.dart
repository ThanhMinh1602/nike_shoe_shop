import 'package:nike_shoe_shop/entities/models/requests/payment_model.dart';

abstract class IOrderRepository {
  Future<List<PaymentModel>> getOrder();
}
