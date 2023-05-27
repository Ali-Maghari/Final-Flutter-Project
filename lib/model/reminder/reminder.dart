import '../user/user.dart';

class Reminder {
  int? id;
  int? userId;
  String? title;
  String? description;
  int? time; // time in milliseconds
  bool? isCompleted;

  Reminder({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.time,
    this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Reminder.colUserId: userId,
      Reminder.colTitle: title,
      Reminder.colDescription: description,
      Reminder.colTime: time,
    };
    if (id != null) {
      map[Reminder.colId] = id;
    }
    return map;
  }

  Reminder.fromMap(Map map) {
    id = map[Reminder.colId];
    userId = map[Reminder.colUserId];
    title = map[Reminder.colTitle];
    description = map[Reminder.colDescription];
    time = map[Reminder.colTime];
    isCompleted = map[Reminder.colIsCompleted] == 1 ? true : false;
  }

  static String tableName = "reminders";
  static String colId = "id";
  static String colUserId = "user_id";
  static String colTitle = "title";
  static String colDescription = "description";
  static String colTime = "date";
  static String colIsCompleted = "is_completed";
  static String createTable =
      "CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colUserId INTEGER NOT NULL REFERENCES ${User.tableName}(${User.colId}), $colTitle TEXT NOT NULL, $colDescription TEXT, $colTime INTEGER UNIQUE NOT NULL)";
}
