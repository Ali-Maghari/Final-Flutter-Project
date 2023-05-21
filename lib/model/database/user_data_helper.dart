import 'package:my_teeth/model/user/user.dart';
import 'package:sqflite/sqflite.dart';

class UserDataHelper {
  final Database _db;

  UserDataHelper(this._db) {
    _userDataHelper = this;
  }

  static late UserDataHelper _userDataHelper;

  static UserDataHelper getUserDataHelper() {
    return _userDataHelper;
  }

  onCreate() {
    _db.execute(User.createTable);
  }

  Future<int> insertUser(User user) async {
    try {
      return await _db.insert(User.tableName, user.toMap());
    } catch (e) {
      return -1;
    }
  }

  Future<User?> getUser(int? id) async {
    List<Map> results =
        await _db.query(User.tableName, where: '${User.colId}=$id');
    if (results.isEmpty) {
      return null;
    }
    return User.fromMap(results.first);
  }

  Future<bool> updateUser(User user) async {
    try {
      await _db.update(User.tableName, user.toMap(),
          where: '${User.colId}=${user.id}');
      return true;
    } catch (e) {
      return false;
    }
  }

}
