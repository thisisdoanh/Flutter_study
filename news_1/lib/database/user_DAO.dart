// ignore_for_file: file_names

import 'package:floor/floor.dart';
import 'user.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM User')
  Future<List<User>> findAllUser();

  @insert
  Future<void> insertPerson(User user);
  
  @Query('SELECT * FROM User WHERE email = :a')
  Future<User?> findUserByEmail(String a);

  @Query('DELETE FROM User')
  Future<void> deleteAllUser();

  @update
  Future<void> updateUser(User user);
}
