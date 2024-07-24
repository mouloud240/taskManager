import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';

part 'usermodel.g.dart';

@HiveType(typeId: 0)
class UserModel extends User with HiveObjectMixin {
  @HiveField(0)
  int uid;
  @HiveField(1)
  String password;

  @HiveField(2)
  String username;
  @HiveField(3)
  String email;

  @HiveField(3)
  File? image;
  UserModel({
    required this.uid,
    required this.email,
    required this.password,
    required this.username,
     this.image,
  }) : super(uid: uid, password: password, username: username, email: email);
}