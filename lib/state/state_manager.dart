import 'package:flutter/material.dart';

class StateManager with ChangeNotifier {
  bool passwordInLoginObscureTextState = false;
  int currentIntroPage = 0;

  void setPasswordInLoginObscureTextState(bool isObscureText) {
    passwordInLoginObscureTextState = isObscureText;
    notifyListeners();
  }

  void setCurrentIntroPage(int page) {
    currentIntroPage = page;
    notifyListeners();
  }

}
