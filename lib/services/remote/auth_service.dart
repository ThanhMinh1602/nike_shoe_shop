import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nike_shoe_shop/entities/models/requests/login_request.dart';
import 'package:nike_shoe_shop/entities/models/requests/user_model.dart';
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
      final usermodel = UserModel(
          email: signupRequest.email,
          password: signupRequest.password,
          avatar: 'https://avatar-management.services.atlassian.com/default/16',
          name: signupRequest.name,
          createdAt: DateTime.now());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(usermodel.toJson());
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

  Future<void> updatePassword(String newPassword) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'Không tìm thấy người dùng. Vui lòng đăng nhập lại.',
        );
      }
      await currentUser.updatePassword(newPassword);
      print("Thay đổi mật khẩu thành công!");
    } on FirebaseAuthException catch (e) {
      print("Lỗi khi thay đổi mật khẩu: ${e.message}");
      rethrow;
    } catch (e) {
      print("Lỗi không xác định: $e");
      rethrow;
    }
  }
}
