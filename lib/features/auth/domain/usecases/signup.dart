import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/data/models/usermodel.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';
import 'package:task_manager/features/auth/domain/repositories/user_auth_repository.dart';

class Signup {
  UserAuthRepository repository;
  Signup(this.repository);
  Future<Either<Failure, auth.UserCredential>> call(UserModel user) async {
    return repository.signup(user);
  }
}
