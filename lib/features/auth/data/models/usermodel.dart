import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';

part 'usermodel.g.dart';

@HiveType(typeId: 0)
class UserModel extends User with HiveObjectMixin {
  @HiveField(0)
  final String? uid;
  @HiveField(1)
  final String password;

  @HiveField(2)
  final String? username;
  @HiveField(3)
  final String email;

  @HiveField(4)
  final File? image;
  UserModel({
    this.uid,
    required this.email,
    required this.password,
    this.username,
    this.image,
  }) : super(uid: uid, password: password, username: username, email: email);
}
