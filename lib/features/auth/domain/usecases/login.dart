import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';
import 'package:task_manager/features/auth/domain/repositories/user_auth_repository.dart';

class LoginUsecase {
  final UserAuthRepository repository;

  LoginUsecase(this.repository);

  Future<Either<Failure, bool>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
