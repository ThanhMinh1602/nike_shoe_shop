import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nike_shoe_shop/entities/models/requests/payment_model.dart';
import 'package:nike_shoe_shop/services/sevice_status.dart';

class CheckoutService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<SendOrderStatus> sendOrder(PaymentModel paymentModel) async {
    final paymentsCollection = _firestore.collection('payments');
    try {
      final data = paymentModel.toJson();

      await paymentsCollection.add(data);
      return SendOrderStatus.success;
    } catch (e) {
      print(e);
      return SendOrderStatus.failure;
    }
  }
}
