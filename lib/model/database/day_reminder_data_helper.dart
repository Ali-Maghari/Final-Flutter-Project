import 'package:sqflite/sqflite.dart';
import '../reminder/day_reminder.dart';

class DayReminderDataHelper {
  final Database _db;

  DayReminderDataHelper(this._db) {
    _userDataHelper = this;
  }

  static late DayReminderDataHelper _userDataHelper;

  static DayReminderDataHelper getDayReminderDataHelper() {
    return _userDataHelper;
  }

  onCreate() {
    _db.execute(DayReminder.createTable);
  }

  Future<int> insertDayReminder(DayReminder dayReminder) async {
    try {
      return await _db.insert(DayReminder.tableName, dayReminder.toMap());
    } catch (e) {
      return -1;
    }
  }

  Future<DayReminder?> getDayReminder(int? id) async {
    List<Map> results =
        await _db.query(DayReminder.tableName, where: '${DayReminder.colId}=$id');
    if (results.isEmpty) {
      return null;
    }
    return DayReminder.fromMap(results.first);
  }

  Future<DayReminder?> getDayReminderByReminderId(int? reminderId) async {
    List<Map> results = await _db.query(DayReminder.tableName,
        where: '${DayReminder.colReminderId}=$reminderId');
    if (results.isEmpty) {
      return null;
    }
    return DayReminder.fromMap(results.first);
  }

  Future<List<DayReminder>> getDayRemindersByDate(int date) async {
    List<Map> results = await _db.query(DayReminder.tableName,
        where: '${DayReminder.colTime}=$date');
    List<DayReminder> dayReminders = [];
    for (Map map in results) {
      dayReminders.add(DayReminder.fromMap(map));
    }
    return dayReminders;
  }

  Future<bool> deleteDayReminder(int? id) async {
    try {
      await _db.delete(DayReminder.tableName, where: '${DayReminder.colId}=$id');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertOrDeleteDayReminder(DayReminder dayReminder) async {
    DayReminder? existingDayReminder = await getDayReminderByReminderIdAndDate(dayReminder.reminderId, dayReminder.time ?? 0);
    if (existingDayReminder != null) {
      return await deleteDayReminder(existingDayReminder.id);
    } else {
      return await insertDayReminder(dayReminder) != -1;
    }
  }

  Future<DayReminder?> getDayReminderByReminderIdAndDate(
      int? reminderId, int date) async {
    List<Map> results = await _db.query(DayReminder.tableName,
        where:
        '${DayReminder.colReminderId}=$reminderId AND ${DayReminder.colTime}=$date');
    if (results.isEmpty) {
      return null;
    }
    return DayReminder.fromMap(results.first);
  }

}
