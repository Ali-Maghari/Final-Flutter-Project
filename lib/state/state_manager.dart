import 'package:flutter/material.dart';

class StateManager with ChangeNotifier {
  bool passwordInLoginObscureTextState = false;

  void setPasswordInLoginObscureTextState(bool isObscureText) {
    passwordInLoginObscureTextState = isObscureText;
    notifyListeners();
  }
}
