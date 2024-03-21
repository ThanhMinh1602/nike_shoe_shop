import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nike_shoe_shop/entities/models/requests/login_request.dart';
import 'package:nike_shoe_shop/services/sevice_status.dart';
import 'package:nike_shoe_shop/entities/models/requests/signup_request.dart';

class AuthService {
  Future<SignupResult> signUpWithEmail(SignupRequest signupRequest) async {
    try {
      final methods = await FirebaseAuth.instance
          // ignore: deprecated_member_use
          .fetchSignInMethodsForEmail(signupRequest.email);
      if (methods.isNotEmpty) {
        return SignupResult.emailAlreadyExists;
      }
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signupRequest.email,
        password: signupRequest.password,
      );
      String uid = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uID': uid,
        'email': signupRequest.email,
        'name': signupRequest.name,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return SignupResult.success;
    } catch (e) {
      return SignupResult.emailAlreadyExists;
    }
  }

  Future<SigninResult> signInWithEmail(LoginRequest loginRequest) async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginRequest.email,
        password: loginRequest.password,
      );
      if (result.user != null) {
        return SigninResult.success;
      } else {
        return SigninResult.failure;
      }
    } catch (e) {
      return SigninResult.failure;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
