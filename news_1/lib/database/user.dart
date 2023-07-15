import 'package:floor/floor.dart';

@entity
class User {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'username')
  final String username;
  @ColumnInfo(name: 'email')
  final String email;
  @ColumnInfo(name: 'phoneNumber')
  final String phoneNumber;
  @ColumnInfo(name: 'password')
  final String password;
  @ColumnInfo(name: 'type')
  final int type;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.type,
  });
}
