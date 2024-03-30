import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nike_shoe_shop/common/constants/define_collection.dart';
import 'package:nike_shoe_shop/entities/models/requests/payment_model.dart';
import 'package:nike_shoe_shop/services/local/share_pref.dart';
import 'package:nike_shoe_shop/services/sevice_status.dart';

class PaymentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<SendOrderStatus> sendPayment(PaymentModel paymentModel) async {
    try {
      final paymentsCollection =
          _firestore.collection(AppDefineCollection.APP_PAYMENT);
      final data = paymentModel.toJson();

      await paymentsCollection.add(data);
      return SendOrderStatus.success;
    } catch (e) {
      return SendOrderStatus.failure;
    }
  }

  Future<List<PaymentModel>> getPaymentByUid() async {
    try {
      final paymentsCollection = await _firestore
          .collection(AppDefineCollection.APP_PAYMENT)
          .where('uId', isEqualTo: SharedPrefs.token)
          .get();
      final data = paymentsCollection.docs
          .map((doc) => PaymentModel.fromJson(doc))
          .toList();
      return data;
    } catch (e) {
      throw Exception('Error fetching payments: $e');
    }
  }
}
