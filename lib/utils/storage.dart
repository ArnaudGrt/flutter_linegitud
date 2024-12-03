import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  // GETTERS
  static Future<bool?> getBool(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    try {
      return storage.getBool(key);
    } catch (e) {
      return null;
    }
  }

  // SETTERS
  static Future<bool> setBool(String key, bool value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    return storage.setBool(key, value);
  }
}
