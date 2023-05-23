import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_teeth/model/database/db.dart';
import 'package:my_teeth/model/shared_preferences/shared_utils.dart';
import '../constants/constants.dart';
import '../constants/strings.dart';
import '../model/reminder/reminder.dart';
import '../model/user/user.dart';
import '../model/user/user_manager.dart';
import '../utils/utils.dart';
import '../view/screens/user/main_screen.dart';

class StateManager with ChangeNotifier {
  final UserManager userManager = UserManager.getUserManager();
  TextEditingController emailInLoginController = TextEditingController();
  TextEditingController passwordInLoginController = TextEditingController();
  TextEditingController emailInRegisterController = TextEditingController();
  TextEditingController passwordInRegisterController = TextEditingController();
  TextEditingController nameInRegisterController = TextEditingController();
  TextEditingController birthdateInRegisterController = TextEditingController();
  TextEditingController emailInProfileController = TextEditingController();
  TextEditingController passwordInProfileController = TextEditingController();
  TextEditingController nameInProfileController = TextEditingController();
  TextEditingController birthdateInProfileController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> addOrEditReminderFormKey = GlobalKey<FormState>();
  bool passwordInLoginObscureTextState = true;
  bool passwordInRegisterObscureTextState = true;
  bool passwordInProfileObscureTextState = true;
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

  void setPasswordInProfileObscureTextState(bool isObscureText) {
    passwordInProfileObscureTextState = isObscureText;
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

  Future<void> register(BuildContext context) async {
    User user = User(
      name: nameInRegisterController.text,
      email: emailInRegisterController.text,
      password:
      passwordInRegisterController.text,
      birthdate: DateTime.parse(birthdateInRegisterController.text)
          .millisecondsSinceEpoch,
    );
    user.id = await Db.getDatabaseHelper()
        .getUserDataHelper()
        .insertUser(user);
    if (user.id == -1) {
      if (context.mounted) {
        Utils.getUtils().showSnackBar(
            context: context,
            message: Strings.anAccountWithThisEmailAlreadyExists,
            animation: Animations.sadThree);
      }
      return;
    }
    userManager.setCurrentUser(user);
    userManager.login();
    // clear all previous stack and push home screen
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => MainScreen()),
              (route) => false);
    }
  }

  Future<void> login(BuildContext context) async {
    User? user = await Db.getDatabaseHelper()
        .getUserDataHelper()
        .getUserByEmailAndPassword(
      email: emailInLoginController.text,
      password: passwordInLoginController.text,
    );
    if (user == null) {
      if (context.mounted) {
        Utils.getUtils().showSnackBar(context: context,
            message: Strings.incorrectEmailOrPassword,
            animation: Animations.sadThree);
      }
      return;
    }
    userManager.setCurrentUser(user);
    userManager.login();
    if (context.mounted) {
      SharedUtils.getSharedUtils().setBool(
          SharedPreferencesKeys.isUserLoggedIn, true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => MainScreen()));
    }
  }

  Future<void> updateProfile(BuildContext context) async {
    User? currentUser = await userManager.getCurrentUser();
    User user = User(
      id: currentUser!.id,
      name: nameInProfileController.text,
      email: emailInProfileController.text,
      password: passwordInProfileController.text,
      birthdate: DateTime.parse(birthdateInProfileController.text)
          .millisecondsSinceEpoch,
      image: currentUser.image,
    );
    if (await Db.getDatabaseHelper().getUserDataHelper().updateUser(user) == false) {
      if (context.mounted) {
        Utils.getUtils().showSnackBar(
            context: context,
            message: Strings.anAccountWithThisEmailAlreadyExists,
            animation: Animations.sadThree);
      }
      return;
    }
    if (context.mounted) {
      userManager.setCurrentUser(user);
      Utils.getUtils().showSnackBar(
        context: context,
        message: Strings.profileUpdatedSuccessfully,
        duration: 1400);
      notifyListeners();
    }
  }

  Future<List<Reminder>> getUserReminders() async {
    User? currentUser = await userManager.getCurrentUser();
    _arrReminders = await Db.getDatabaseHelper()
        .getReminderDataHelper()
        .getRemindersByUserId(currentUser!.id);
    return _arrReminders;
  }

  Future<void> addReminder(BuildContext context) async {
    User? currentUser = await userManager.getCurrentUser();
    Reminder reminder = Reminder(
        title: titleControllerInAddOrEditReminderBottomSheet.text,
        time: DateFormat("hh:mm a").parse(timeControllerInAddOrEditReminderBottomSheet.text).millisecondsSinceEpoch,
        description: descriptionControllerInAddOrEditReminderBottomSheet.text,
        userId: currentUser!.id,
    );
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

  Future<void> updateReminder(BuildContext context, Reminder editedReminder) async {
    User? currentUser = await userManager.getCurrentUser();
    Reminder reminder = Reminder(
        id: editedReminder.id,
        title: titleControllerInAddOrEditReminderBottomSheet.text,
        time: DateFormat("hh:mm a").parse(timeControllerInAddOrEditReminderBottomSheet.text).millisecondsSinceEpoch,
        description: descriptionControllerInAddOrEditReminderBottomSheet.text,
        userId: currentUser!.id);
    bool isUpdated = await Db.getDatabaseHelper().getReminderDataHelper().updateReminder(reminder);
    if (!isUpdated) {
      if (context.mounted) {
        Utils.getUtils().showSnackBar(
            context: context,
            message: Strings.reminderAlreadyExists,
            animation: Animations.sadThree,
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
            animation: Animations.sadThree);
      }
      return;
    }
    _arrReminders.removeWhere((element) => element.id == reminder.id);
    if (context.mounted) {
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
