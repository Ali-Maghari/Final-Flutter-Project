class User {
  int? id;
  String? name;
  String? email;
  String? password;
  int? birthdate; // time in milliseconds
  int? image;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.birthdate,
    this.image,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      User.colName: name,
      User.colEmail: email,
      User.colPassword: password,
      User.colBirthdate: birthdate,
      User.colImage: image,
    };
    if (id != null) {
      map[User.colId] = id;
    }
    return map;
  }

  User.fromMap(Map map) {
    id = map[User.colId];
    name = map[User.colName];
    email = map[User.colEmail];
    password = map[User.colPassword];
    birthdate = map[User.colBirthdate];
    image = map[User.colImage];
  }

  static String tableName = "users";
  static String colId = "id";
  static String colName = "name";
  static String colEmail = "email";
  static String colPassword = "password";
  static String colBirthdate = "birthdate";
  static String colImage = "image";
  static String createTable =
      "CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colEmail TEXT, $colPassword TEXT, $colBirthdate INTEGER, $colImage BLOB)";
}
