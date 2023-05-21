import 'package:my_teeth/constants/constants.dart';
import 'package:my_teeth/model/database/db.dart';
import 'package:my_teeth/model/shared_preferences/shared_utils.dart';
import 'user.dart';

class UserManager {
  UserManager._();

  User? _user;

  static UserManager? _instance;

  static UserManager getUserManager() {
    _instance ??= UserManager._();
    return _instance!;
  }

  Future<User?> getCurrentUser() async {
    _user ??= await Db.getDatabaseHelper().getUserDataHelper().getUser(
        SharedUtils.getSharedUtils()
            .getInt(SharedPreferencesKeys.loggedUserId));
    return _user;
  }

  void setCurrentUser(User user) {
    _user = user;
    Db.getDatabaseHelper().getUserDataHelper().updateUser(user);
  }

  void removeCurrentUser() {
    _user = null;
    SharedUtils.getSharedUtils().remove(SharedPreferencesKeys.loggedUserId);
  }

  void login() {
    if (_user == null) {
      return;
    }
    SharedUtils.getSharedUtils()
        .setInt(SharedPreferencesKeys.loggedUserId, _user!.id!);
    SharedUtils.getSharedUtils()
        .setBool(SharedPreferencesKeys.isUserLoggedIn, true);
  }

  void logout() {
    if (_user == null) {
      return;
    }
    SharedUtils.getSharedUtils().setInt(SharedPreferencesKeys.loggedUserId, -1);
    SharedUtils.getSharedUtils()
        .setBool(SharedPreferencesKeys.isUserLoggedIn, false);
  }
}
