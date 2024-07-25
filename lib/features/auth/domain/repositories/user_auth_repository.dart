import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';

abstract class UserAuthRepository {
  Future<Either<Failure, bool>> login(String email,String password);
  Future<Either<Failure, void>> signup(User user);
  Future<Either<Failure, void>> changePassword(String newpass);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> updateImage(File newImage);
}
