import 'package:flutter/material.dart';
import 'package:my_teeth/model/database/db.dart';
import '../model/reminder/reminder.dart';
import '../model/user/user.dart';
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
  GlobalKey<FormState> addOrEditReminderFormKey = GlobalKey<FormState>();
  bool passwordInLoginObscureTextState = true;
  bool passwordInRegisterObscureTextState = true;
  int currentIntroPage = 0;
  int currentMainPage = 0;
  bool isFloatingActionButtonExtended = true;
  bool isFloatingActionButtonVisible = true;
  TextEditingController timeControllerInAddOrEditReminderBottomSheet = TextEditingController();
  TextEditingController titleControllerInAddOrEditReminderBottomSheet = TextEditingController();
  TextEditingController descriptionControllerInAddOrEditReminderBottomSheet = TextEditingController();
  List<Reminder> _arrReminders = [];

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

  Future<List<Reminder>> getUserReminders() async {
    User? currentUser = await userManager.getCurrentUser();
    _arrReminders = await Db.getDatabaseHelper()
        .getReminderDataHelper()
        .getRemindersByUserId(currentUser!.id);
    return _arrReminders;
  }

  void addReminder(Reminder reminder) async {
    await Db.getDatabaseHelper().getReminderDataHelper().insertReminder(reminder);
    _arrReminders.add(reminder);
    notifyListeners();
  }

}
