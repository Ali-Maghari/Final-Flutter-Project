import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../constants/constants.dart';
import '../constants/strings.dart';

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
    if (password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
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

  void showSnackBar(
      {required BuildContext context,
      required String message,
      String? animation,
      int duration = 2800,
      double widthPercentage = 0.96,
      double borderRadius = 10.0}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Expanded(child: Text(message)),
            animation != null
                ? Lottie.asset(
                    animation,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  )
                : const SizedBox(),
          ],
        ),
        duration: Duration(milliseconds: duration),
        width: MediaQuery.of(context).size.width * widthPercentage,
        padding: const EdgeInsets.all(
          14.0,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
