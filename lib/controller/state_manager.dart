import 'package:flutter/material.dart';
import 'package:my_teeth/model/database/db.dart';
import 'package:my_teeth/model/shared_preferences/shared_utils.dart';
import '../constants/constants.dart';
import '../constants/strings.dart';
import '../model/reminder/reminder.dart';
import '../model/user/user.dart';
import '../model/user/user_manager.dart';
import '../utils/utils.dart';

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
  String appTheme = SharedUtils.getSharedUtils().getString(SharedPreferencesKeys.appTheme) ?? AppTheme.dynamicAppTheme;
  String appThemeMode = SharedUtils.getSharedUtils().getString(SharedPreferencesKeys.appThemeMode) ?? AppThemeMode.followSystem;
  String appThemeInThemesScreen = SharedUtils.getSharedUtils().getString(SharedPreferencesKeys.appTheme) ?? AppTheme.dynamicAppTheme;
  String appThemeModeInThemesScreen = SharedUtils.getSharedUtils().getString(SharedPreferencesKeys.appThemeMode) ?? AppThemeMode.followSystem;

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

  void addReminder(BuildContext context, Reminder reminder) async {
    User? currentUser = await userManager.getCurrentUser();
    reminder.userId = currentUser!.id;
    reminder.id = await Db.getDatabaseHelper().getReminderDataHelper().insertReminder(reminder);
    if (reminder.id == -1) {
      if (context.mounted) {
        Utils.getUtils().showSnackBar(
            context: context,
            message: Strings.reminderAlreadyExists,
            animation: Animations.sadThree);
        Navigator.of(context).pop();
      }
      return;
    }
    _arrReminders.add(reminder);
    if (context.mounted) {
      Navigator.of(context).pop();
      Utils.getUtils().showSnackBar(
          context: context,
          message: Strings.reminderAddedSuccessfully,
          duration: 1400);
    }
    notifyListeners();
  }

  void updateReminder(BuildContext context, Reminder editedReminder, Reminder reminder) async {
    User? currentUser = await userManager.getCurrentUser();
    reminder.userId = currentUser!.id;
    reminder.id = editedReminder.id;
    bool isUpdated = await Db.getDatabaseHelper().getReminderDataHelper().updateReminder(reminder);
    if (!isUpdated) {
      if (context.mounted) {
        Utils.getUtils().showSnackBar(
            context: context,
            message: Strings.reminderAlreadyExists,
            duration: 1400);
        Navigator.of(context).pop();
      }
      return;
    }
    _arrReminders[_arrReminders.indexWhere((element) => element.id == reminder.id)] = reminder;
    if (context.mounted) {
      Navigator.of(context).pop();
      Utils.getUtils().showSnackBar(
          context: context,
          message: Strings.reminderUpdatedSuccessfully,
          duration: 1400);
    }
    notifyListeners();
  }

  Future<void> deleteReminder(BuildContext context, Reminder reminder) async {
    bool isDeleted = await Db.getDatabaseHelper().getReminderDataHelper().deleteReminder(reminder.id);
    if (!isDeleted) {
      if (context.mounted) {
        Navigator.pop(context);
        Utils.getUtils().showSnackBar(
            context: context,
            message: Strings.anErrorOccurredWhileDeletingTheReminder,
            duration: 1400);
      }
      return;
    }
    if (context.mounted) {
      _arrReminders.removeWhere((element) => element.id == reminder.id);
      Navigator.pop(context);
      Utils.getUtils().showSnackBar(
          context: context,
          message: Strings.reminderDeletedSuccessfully,
          duration: 1400);
    }
    notifyListeners();
  }

  void setAppTheme(String theme) {
    appThemeInThemesScreen = theme;
    notifyListeners();
  }

  void setAppThemeMode(String themeMode) {
    appThemeModeInThemesScreen = themeMode;
    notifyListeners();
  }

  void resetAppTheme() {
    appThemeInThemesScreen = appTheme;
    appThemeModeInThemesScreen = appThemeMode;
    notifyListeners();
  }

  void applyTheme() {
    appTheme = appThemeInThemesScreen;
    appThemeMode = appThemeModeInThemesScreen;
    SharedUtils.getSharedUtils().setString(SharedPreferencesKeys.appTheme, appTheme);
    SharedUtils.getSharedUtils().setString(SharedPreferencesKeys.appThemeMode, appThemeMode);
    notifyListeners();
  }

}
