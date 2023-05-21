import 'package:flutter/material.dart';
import 'package:my_teeth/constants/strings.dart';

import '../model/user/user_manager.dart';

class StateManager with ChangeNotifier {
  final UserManager userManager = UserManager.getUserManager();
  TextEditingController emailInLoginController = TextEditingController();
  TextEditingController passwordInLoginController = TextEditingController();
  TextEditingController emailInRegisterController = TextEditingController();
  TextEditingController passwordInRegisterController = TextEditingController();
  TextEditingController nameInRegisterController = TextEditingController();
  TextEditingController birthdateInRegisterController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  bool passwordInLoginObscureTextState = true;
  bool passwordInRegisterObscureTextState = true;
  int currentIntroPage = 0;
  String title = Strings.home;
  int currentMainPage = 0;
  bool isFloatingActionButtonExtended = true;
  bool isFloatingActionButtonVisible = true;
  TextEditingController timeControllerInAddOrEditReminderBottomSheet = TextEditingController();

  void setPasswordInLoginObscureTextState(bool isObscureText) {
    passwordInLoginObscureTextState = isObscureText;
    notifyListeners();
  }

  void setPasswordInRegisterObscureTextState(bool isObscureText) {
    passwordInRegisterObscureTextState = isObscureText;
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
