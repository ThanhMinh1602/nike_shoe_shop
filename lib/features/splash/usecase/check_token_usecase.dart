import 'package:nike_shoe_shop/services/local/share_pref.dart';

class CheckTokenUseCase {
  Future<bool> call() async {
    final token = SharedPrefs.token;
    return token != null && token.isNotEmpty;
  }
}
