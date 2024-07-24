import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/domain/repositories/user_auth_repository.dart';

class Changepassword {
  UserAuthRepository repository;

  Changepassword(this.repository);
  Future<Future<Either<Failure, void>>> call(String password) async {
    return repository.changePassword(password);
  }
}
