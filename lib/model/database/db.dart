import 'package:my_teeth/model/database/reminder_data_helper.dart';
import 'package:my_teeth/model/database/user_data_helper.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  Db._();

  static Db? _instance;
  // static late Database _database;

  static init(String dbName) async {
    String appPath = await getDatabasesPath();
    String dbPath = '$appPath/$dbName.db';
    // _database =
    await openDatabase(dbPath, version: 1, onCreate: (db, v) {
      UserDataHelper(db).onCreate();
      ReminderDataHelper(db).onCreate();
    }, onOpen: (db) {
      UserDataHelper(db);
      ReminderDataHelper(db);
    });
  }

  static Db getDatabaseHelper() {
    _instance ??= Db._();
    return _instance!;
  }

  UserDataHelper getUserDataHelper() {
    return UserDataHelper.getUserDataHelper();
  }

  ReminderDataHelper getReminderDataHelper() {
    return ReminderDataHelper.getReminderDataHelper();
  }

}
