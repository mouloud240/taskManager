import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';

part 'usermodel.g.dart';

@HiveType(typeId: 0)
class UserModel extends User with HiveObjectMixin {
  @override
  @HiveField(0)
  final String? uid;
  @override
  @HiveField(1)
  final String password;

  @override
  @HiveField(2)
  final String? username;
  @override
  @HiveField(3)
  final String email;

  @HiveField(4)
  final String? image;
  UserModel({
    this.uid,
    required this.email,
    required this.password,
    this.username,
    this.image,
  }) : super(uid: uid, password: password, username: username, email: email);
  factory UserModel.fromEntity(User user) {
    return UserModel(
        email: user.email,
        password: user.password,
        image: user.userPfp,
        uid: user.uid,
        username: user.username);
  }
  User toEntity() {
    return User(password: password, email: email, uid: uid, username: username);
  }
}
