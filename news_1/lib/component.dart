import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Component with ChangeNotifier, DiagnosticableTreeMixin {
  int gioiTinh = 0;

  void setGioiTinh(int n) {
    gioiTinh = n;
    notifyListeners();
  }

  void addToSql(String username, String email, String phoneNum, String password,
      int gender) async {

    await User.database?.transaction(
      (txn) async {
        int id1 = await txn.rawInsert(
          'INSERT INTO user(username, email, phone_number, password, gender) VALUES ($username, $email,$phoneNum, $password, $gender)',
        );

      },
    );
    print(User.database);
    notifyListeners();
  }
}

class User {
  static Database? database;
  static Future<Database> getInstance() async {
    database ??= await openDatabase(
      join(await getDatabasesPath(), 'user.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE user(id INTEGER PRIMARY KEY, username TEXT, email TEXT, phone_number TEXT, password TEXT, gender INTEGER)",
        );
      },
      version: 1,
      singleInstance: true,
    );
    return database!;
  }
}
