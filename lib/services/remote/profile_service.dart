import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nike_shoe_shop/entities/models/requests/user_model.dart';
import 'package:nike_shoe_shop/services/local/share_pref.dart';
import 'package:path/path.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<UserModel> fetchUserByUid() async {
    try {
      final queryData =
          await _firestore.collection('users').doc(SharedPrefs.token).get();
      var userData = queryData.data();
      return UserModel.fromJson(userData!);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(File? imageFile, UserModel? userModel) async {
    if (imageFile == null || userModel == null) {
      print('image file or usermodel null');
      return;
    }
    try {
      final storage = FirebaseStorage.instance;
      String fileName = basename(imageFile.path);
      String imagePath = 'user_avatar/${SharedPrefs.token!}/user_avatar';
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
      print('uplaod error $e');
    }
  }

  Future<void> _updateUserWithAvatar(
      UserModel userModel, String imageUrl) async {
    try {
      final userDocRef = _firestore.collection('users').doc(SharedPrefs.token);
      await userDocRef.update({
        ...userModel.toJson(),
        'avatar': imageUrl,
      });
    } catch (e) {
      print('rrror update user with avatar: $e');
    }
  }

  Future<void> _updateUserWithoutAvatar(UserModel userModel) async {
    try {
      final userDocRef = _firestore.collection('users').doc(SharedPrefs.token);
      await userDocRef.update({
        ...userModel.toJson(),
      });
    } catch (e) {
      print('error updating user without avatar: $e');
    }
  }
}
