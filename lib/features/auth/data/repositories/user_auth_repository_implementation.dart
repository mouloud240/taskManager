import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/data/models/usermodel.dart';
import 'package:task_manager/features/auth/data/source/local/local_user.dart';
import 'package:task_manager/features/auth/data/source/remote/remote_auth.dart';
import 'package:task_manager/features/auth/domain/repositories/user_auth_repository.dart';
import 'package:task_manager/features/tasks/presentation/state/TasksState.dart';

class UserAuthRepositoryImplementation implements UserAuthRepository {
  RemoteAuth remoteAuth;
  final storageRef = FirebaseStorage.instance.ref();
  final localUser = LocalUser();

  UserAuthRepositoryImplementation(this.remoteAuth);
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
  Future<Either<Failure, String>> updateImage(
      File newImage, String userid) async {
    try {
      final profileref = storageRef.child('profilePics/$userid.jpg');
      await profileref.putFile(newImage);
      remoteAuth.updateUserpfp(await profileref.getDownloadURL());
      return right(await profileref.getDownloadURL());
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    return remoteAuth.resetPassword(email);
  }

  @override
  Future<Either<Failure, void>> updateInfo(String proffesion, String name, DateTime dob) {
    return remoteAuth.updatecreds(proffesion, name,dob);
  }
}
