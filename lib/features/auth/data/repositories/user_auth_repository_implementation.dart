import 'dart:ffi';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/data/models/usermodel.dart';
import 'package:task_manager/features/auth/data/source/local/local_user.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';
import 'package:task_manager/features/auth/domain/repositories/user_auth_repository.dart';

class UserAuthRepositoryImplementation implements UserAuthRepository {
  RemoteAuth remoteAuth;
 
  UserAuthRepositoryImplementation(this.remoteAuth);
  @override
  Future<Either<Failure, void>> changePassword(String password) async {
    try {
      return right(remoteAuth.changePassword(password));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> login(User user) async {
    try {
      return right(remoteAuth.login(user as UserModel));
      
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      return right(remoteAuth.logout());
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signup(User user) async {
    try {
      return right(remoteAuth.signup(user as UserModel));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateImage(File newImage) async {
    try {
      // return right( remoteAuth.updateImage(newImage));
      // ignore: void_checks
      return right(Void);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
