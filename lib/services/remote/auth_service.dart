import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nike_shoe_shop/common/constants/define_collection.dart';
import 'package:nike_shoe_shop/entities/models/requests/login_request.dart';
import 'package:nike_shoe_shop/entities/models/requests/user_model.dart';
import 'package:nike_shoe_shop/services/local/share_pref.dart';
import 'package:nike_shoe_shop/services/sevice_status.dart';
import 'package:nike_shoe_shop/entities/models/requests/signup_request.dart';
import 'package:path/path.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<SignupResult> signUpWithEmail(SignupRequest signupRequest) async {
    try {
      final auth = await FirebaseAuth.instance
          // ignore: deprecated_member_use
          .fetchSignInMethodsForEmail(signupRequest.email);
      if (auth.isNotEmpty) {
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
          name: signupRequest.name);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(usermodel.toJson());
      return SignupResult.success;
    } catch (e) {
      return SignupResult.emailAlreadyExists;
    }
  }

  Future<bool> checkAdmin(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(AppDefineCollection.APP_ADMIN_ACCOUNT)
          .where('email', isEqualTo: email)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Error checking admin: $e');
    }
  }

  Future<SigninResult> signInWithEmail(LoginRequest loginRequest) async {
    try {
      final isAdmin = await checkAdmin(loginRequest.email);
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginRequest.email,
        password: loginRequest.password,
      );

      if (result.user != null) {
        if (isAdmin) {
          return SigninResult.successIsAdmin;
        } else {
          return SigninResult.successIsUser;
        }
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
      _firestore
          .collection(AppDefineCollection.APP_USER)
          .doc(currentUser.uid)
          .update({'password': newPassword});
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> fetchUserByUid() async {
    try {
      final queryData = await _firestore
          .collection(AppDefineCollection.APP_USER)
          .doc(SharedPrefs.token)
          .get();
      var userData = queryData.data();
      return UserModel.fromJson(userData!);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(File? imageFile, UserModel? userModel) async {
    if (imageFile == null || userModel == null) {
      return;
    }
    try {
      final storage = FirebaseStorage.instance;
      String fileName = basename(imageFile.path);
      String imagePath =
          '${AppDefineCollection.APP_USER_AVATAR}/${SharedPrefs.token!}/user_avatar';
      final Reference ref = storage.ref().child(imagePath);
      if (fileName.isNotEmpty) {
        final UploadTask uploadTask = ref.putFile(imageFile);
        final TaskSnapshot downloadUrl = await uploadTask;
        final String imageUrl = await downloadUrl.ref.getDownloadURL();
        await _updateUserWithAvatar(userModel, imageUrl);
      } else {
        await _updateUserWithoutAvatar(userModel);
      }
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }

  Future<void> _updateUserWithAvatar(
      UserModel userModel, String imageUrl) async {
    try {
      final userDocRef = _firestore
          .collection(AppDefineCollection.APP_USER)
          .doc(SharedPrefs.token);
      await userDocRef.update({
        ...userModel.toJson(),
        'avatar': imageUrl,
      });
    } catch (e) {
      throw Exception('Error updating user with avatar: $e');
    }
  }

  Future<void> _updateUserWithoutAvatar(UserModel userModel) async {
    try {
      final userDocRef = _firestore
          .collection(AppDefineCollection.APP_USER)
          .doc(SharedPrefs.token);
      await userDocRef.update(
        userModel.toJson(),
      );
    } catch (e) {
      throw Exception('Error updating user without avatar: $e');
    }
  }
}
