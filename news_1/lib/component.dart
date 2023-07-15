import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_1/database/database.dart';

import 'database/user.dart';

class Component with ChangeNotifier, DiagnosticableTreeMixin {
  int type = 1;
  List<User> listUser = [];
  User? userFindByEmail;

  late dynamic database;
  late dynamic userDao;

  Future<void> initDatabase() async {
    database = await $FloorAppDatabase.databaseBuilder('InfoUser.db').build();
    userDao = database.userDao;
    notifyListeners();
  }

  bool watchPass = true;
  IconData iconWatchPass = Icons.remove_red_eye;

  void setType(int n) {
    type = n;
    notifyListeners();
  }

  void setWatchPassTrue() {
    watchPass = true;
    notifyListeners();
  }

  void setWatchPass() {
    watchPass = !watchPass;
    notifyListeners();
  }

  void changeIconWatchPass() {
    iconWatchPass = (iconWatchPass =
        (watchPass == true) ? Icons.visibility_off : Icons.remove_red_eye);
    notifyListeners();
  }

  Future<void> addToSql(
      String username, String email, String phoneNum, String password) async {
    User user = User(
        username: username,
        email: email,
        phoneNumber: phoneNum,
        password: password,
        type: type);
    await userDao.insertPerson(user);
    listUser = await userDao.findAllUser();
    notifyListeners();
  }

  Future<void> getUser() async {
    listUser = await userDao.findAllUser();
    notifyListeners();
  }

  Future<void> findUserByEmail(String email) async {
    userFindByEmail = null;
    userFindByEmail = await userDao.findUserByEmail(email);
    notifyListeners();
  }

  Future<void> deleteAllUser() async {
    await userDao.deleteAllUser();
    notifyListeners();
  }

  Future<void> updateUser(String email, String password) async {
    User userOld = await userDao.findUserByEmail(email);
    // ignore: unnecessary_null_comparison
    if (userOld != null) {
      User userUpdate = User(
        id: userOld.id,
        username: userOld.username,
        email: userOld.email,
        phoneNumber: userOld.phoneNumber,
        password: password,
        type: userOld.type,
      );
      await userDao.updateUser(userUpdate);
    }
    notifyListeners();
  }
}
