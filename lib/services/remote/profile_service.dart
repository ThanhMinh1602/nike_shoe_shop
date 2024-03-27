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

  Future<void> updateUser(UserModel userModel) async {
    try {
      final queryData = _firestore.collection('users').doc(SharedPrefs.token);
      queryData.update(userModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadImageAndSaveToFirestore(File imageFile) async {
    try {
      final storage = FirebaseStorage.instance;
      String fileName = basename(imageFile.path);
      final Reference ref = storage.ref().child('user_avatar/').child(fileName);
      final UploadTask uploadTask = ref.putFile(imageFile);
      final TaskSnapshot downloadUrl = await uploadTask;
      final String url = await downloadUrl.ref.getDownloadURL();
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(SharedPrefs.token).set({
        'profile_image': url,
      });
    } catch (e) {
      print('Error uploading image and saving to Firestore: $e');
    }
  }
}
