import 'dart:ffi';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/data/models/usermodel.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/repositories/user_auth_repository.dart';

class UserAuthRepositoryImplementation implements UserAuthRepository {
  RemoteAuth remoteAuth;

  UserAuthRepositoryImplementation(  this.remoteAuth);
  @override
  Future<Either<Failure, void>> changePassword(String password) async {
    // ignore: void_checks
    return right(remoteAuth.changePassword(password));
  }

  @override
  Future<Either<Failure, bool>> login(String email, String password) async {
    return await remoteAuth.login(email, password);
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return remoteAuth.logout();
  }

  @override
  Future<Either<Failure, auth.UserCredential>> signup(UserModel user) async {
    return await remoteAuth.signup(user);
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

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    return remoteAuth.resetPassword(email);
  }
}
