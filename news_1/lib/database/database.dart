import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'user.dart';
import 'user_DAO.dart';

part 'database.g.dart'; 
@Database(version: 5, entities: [User])
 abstract class AppDatabase extends FloorDatabase {
   UserDao get userDao;
 }