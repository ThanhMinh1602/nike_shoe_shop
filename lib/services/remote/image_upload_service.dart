import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageUplaodService {
  Future<void> uploadImageAndSaveToFirestore(File imageFile) async {
    final storage = FirebaseStorage.instance;
    final Reference ref =
        storage.ref().child('images/').child('profile_image.jpg');
    final UploadTask uploadTask = ref.putFile(imageFile);
    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url = await downloadUrl.ref.getDownloadURL();
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc('user_id').set({
      'profile_image': url,
    });
  }
}
