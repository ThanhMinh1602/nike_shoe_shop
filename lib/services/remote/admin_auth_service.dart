import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nike_shoe_shop/entities/models/requests/login_request.dart';
import 'package:nike_shoe_shop/services/sevice_status.dart';

class AdminAuthService {
  Future<bool> checkAdmin(String email) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('admin_accounts')
        .where('email', isEqualTo: email)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<SigninResult> adminSignInWithEmail(LoginRequest loginRequest) async {
    try {
      final isAdmin = await checkAdmin(loginRequest.email);

      if (isAdmin) {
        final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginRequest.email,
          password: loginRequest.password,
        );
        if (result.user != null) {
          return SigninResult.success;
        }
      }
      return SigninResult.failure;
    } catch (e) {
      print("Error occurred during admin sign in: $e");
      return SigninResult.failure;
    }
  }
}
