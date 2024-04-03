import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:nike_shoe_shop/common/constants/define_collection.dart';
import 'package:nike_shoe_shop/common/constants/paypal_payment.dart';
import 'package:nike_shoe_shop/entities/models/payment_model.dart';
import 'package:nike_shoe_shop/services/local/share_pref.dart';
import 'package:nike_shoe_shop/services/sevice_status.dart';

class PaymentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<SendOrderStatus> sendPayment(PaymentModel paymentModel) async {
    try {
      final docId =
          _firestore.collection(AppDefineCollection.APP_PAYMENT).doc().id;
      final paymentsCollection =
          _firestore.collection(AppDefineCollection.APP_PAYMENT);
      final data = paymentModel.toJson();
      await paymentsCollection.doc(docId).set({
        ...data,
        'paymentId': docId,
      });
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

  // Future<UsePaypal> paypalPayment(String totalPrice) async {
  //   return UsePaypal(
  //       sandboxMode: true,
  //       clientId: PaypalPayment.clientId,
  //       secretKey: PaypalPayment.secretKey,
  //       returnURL: "https://samplesite.com/return",
  //       cancelURL: "https://samplesite.com/cancel",
  //       transactions: [
  //         {
  //           "amount": {
  //             "total": totalPrice,
  //             "currency": "USD",
  //             "details": {
  //               "subtotal": totalPrice,
  //               "shipping": '0',
  //               "shipping_discount": 0
  //             }
  //           },
  //           "description": "The payment transaction description.",
  //         }
  //       ],
  //       note: "Contact us for any questions on your order.",
  //       onSuccess: (Map params) async {
  //         print("onSuccess: $params");
  //       },
  //       onError: (error) {
  //         print("onError: $error");
  //       },
  //       onCancel: (params) {
  //         print('cancelled: $params');
  //       });
  // }
}
