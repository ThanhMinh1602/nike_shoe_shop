import 'package:firebase_auth/firebase_auth.dart';
import 'package:nike_shoe_shop/services/local/share_pref.dart';

class SetTokenUseCase {
  Future<void> call() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? idToken = user.uid;
        SharedPrefs.token = idToken;
      } else {
        throw Exception('No user is currently signed in.');
      }
    } catch (e) {
      throw Exception('Failed to get Firebase token: $e');
    }
  }
}
