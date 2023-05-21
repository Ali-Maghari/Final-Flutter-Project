import 'package:shared_preferences/shared_preferences.dart';

class SharedUtils {
  SharedUtils._();

  static late SharedPreferences _sharedPreferences;

  static init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences getSharedUtils() {
    return _sharedPreferences;
  }
}
