import 'package:my_teeth/model/reminder/reminder.dart';
import 'package:sqflite/sqflite.dart';

import 'db.dart';

class ReminderDataHelper {
  final Database _db;

  ReminderDataHelper(this._db) {
    _userDataHelper = this;
  }

  static late ReminderDataHelper _userDataHelper;

  static ReminderDataHelper getReminderDataHelper() {
    return _userDataHelper;
  }

  onCreate() {
    _db.execute(Reminder.createTable);
  }

  Future<int> insertReminder(Reminder reminder) async {
    try {
      return await _db.insert(Reminder.tableName, reminder.toMap());
    } catch (e) {
      return -1;
    }
  }

  Future<Reminder?> getReminder(int? id) async {
    List<Map> results =
        await _db.query(Reminder.tableName, where: '${Reminder.colId}=$id');
    if (results.isEmpty) {
      return null;
    }
    return Reminder.fromMap(results.first);
  }

  Future<List<Reminder>> getRemindersByUserId(int? userId) async {
    List<Map> results = await _db.query(Reminder.tableName,
        where: '${Reminder.colUserId}=$userId', orderBy: '${Reminder.colTime} ASC');
    List<Reminder> reminders = [];
    for (Map map in results) {
      Map resultMap = {
        Reminder.colIsCompleted: await Db.getDatabaseHelper().getDayReminderDataHelper().getDayReminderByReminderId(map[Reminder.colId]) == null ? 0 : 1,
      };
      resultMap.addAll(map);
      print(resultMap);
      reminders.add(Reminder.fromMap(resultMap));
    }
    return reminders;
  }

  Future<bool> updateReminder(Reminder reminder) async {
    try {
      await _db.update(Reminder.tableName, reminder.toMap(),
          where: '${Reminder.colId}=${reminder.id}');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteReminder(int? id) async {
    try {
      await _db.delete(Reminder.tableName, where: '${Reminder.colId}=$id');
      return true;
    } catch (e) {
      return false;
    }
  }

}
