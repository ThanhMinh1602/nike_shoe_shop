import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nike_shoe_shop/entities/models/requests/payment_model.dart';
import 'package:nike_shoe_shop/services/local/share_pref.dart';
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
      return SendOrderStatus.failure;
    }
  }

  Future<List<PaymentModel>> getOderByUid() async {
    final paymentsCollection = await _firestore
        .collection('payments')
        .where('uId', isEqualTo: SharedPrefs.token)
        .get();
    final data = paymentsCollection.docs
        .map((doc) => PaymentModel.fromJson(doc))
        .toList();
    return data;
  }
}
