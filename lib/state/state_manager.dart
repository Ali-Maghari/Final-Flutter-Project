import 'package:flutter/material.dart';
import 'package:my_teeth/constants/strings.dart';

class StateManager with ChangeNotifier {
  bool passwordInLoginObscureTextState = false;
  int currentIntroPage = 0;
  String title = Strings.home;
  int currentMainPage = 0;
  bool isFloatingActionButtonExtended = true;
  bool isFloatingActionButtonVisible = true;

  void setPasswordInLoginObscureTextState(bool isObscureText) {
    passwordInLoginObscureTextState = isObscureText;
    notifyListeners();
  }

  void setCurrentIntroPage(int page) {
    currentIntroPage = page;
    notifyListeners();
  }

  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  void setCurrentMainPage(int page) {
    currentMainPage = page;
    notifyListeners();
  }

  void setIsFloatingActionButtonExtended(bool isExtended) {
    isFloatingActionButtonExtended = isExtended;
    notifyListeners();
  }

  void setIsFloatingActionButtonVisible(bool isVisible) {
    isFloatingActionButtonVisible = isVisible;
    notifyListeners();
  }

}
