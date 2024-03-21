import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String accessTokenKey = 'accessToken';

  static late SharedPreferences _prefs;

  static Future<void> initialise() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? get token {
    return _prefs.getString(accessTokenKey);
  }

  static set token(String? token) =>
      _prefs.setString(accessTokenKey, token ?? '');
  static removeSeason() {
    _prefs.remove(accessTokenKey);
  }
}
