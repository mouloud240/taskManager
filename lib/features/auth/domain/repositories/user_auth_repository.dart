import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/data/models/usermodel.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';

abstract class UserAuthRepository {
  Future<Either<Failure, bool>> login(String email, String password);
  Future<Either<Failure, auth.UserCredential>> signup(UserModel user);
  Future<Either<Failure, void>> changePassword(String newpass);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, String>> updateImage(File newImage, String id);
  Future<Either<Failure, void>> resetPassword(String email);
  Future<Either<Failure, void>> updateInfo(String proffesion, String name);
}
