import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Utils {
  static Utils? _instance;

  static Utils getUtils() {
    _instance ??= Utils();
    return _instance!;
  }

  void setStatusBarAndNavigationBarColor(BuildContext context,
      {Color? statusBarColorInLight,
      Color? navigationBarColorInLight,
      Color? statusBarColorInDark,
      Color? navigationBarColorInDark}) {
    if (!isSystemDarkModeEnabled(context)) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: statusBarColorInLight,
        systemNavigationBarColor: navigationBarColorInLight,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: statusBarColorInDark,
        systemNavigationBarColor: navigationBarColorInDark,
      ));
    }
  }

  bool isSystemDarkModeEnabled(BuildContext context) {
    return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
  }

  bool isValidPassword(String password) {
    if (password.length >= 8
    && password.contains(RegExp(r'[A-Z]'))
    && password.contains(RegExp(r'[a-z]'))
    && password.contains(RegExp(r'[0-9]'))
    && password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return true;
    }
    return false;
  }


  bool isValidEmail(String email) {
    return email.contains('@') &&
        email.endsWith('.com') &&
        (email.contains('@gmail') ||
            email.contains('@yahoo') ||
            email.contains('@hotmail') ||
            email.contains('@outlook') ||
            email.contains('@icloud'));
  }
}
