import 'package:my_teeth/model/reminder/reminder.dart';

class DayReminder {
  int? id;
  int? reminderId;
  int? time;


  DayReminder({
    this.id,
    this.reminderId,
    this.time,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DayReminder.colTime: time,
      DayReminder.colReminderId: reminderId,
    };
    if (id != null) {
      map[DayReminder.colId] = id;
    }
    return map;
  }

  DayReminder.fromMap(Map map) {
    id = map[DayReminder.colId];
    reminderId = map[DayReminder.colReminderId];
    time = map[DayReminder.colTime];
  }

  static String tableName = "day_reminders";
  static String colId = "id";
  static String colReminderId = "reminder_id";
  static String colTime = "time";
  static String createTable =
      "CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colReminderId INTEGER NOT NULL REFERENCES ${Reminder.tableName}(${Reminder.colId}) ON DELETE CASCADE, $colTime INTEGER NOT NULL)";
}
