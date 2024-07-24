import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';
import 'package:task_manager/features/auth/domain/repositories/user_auth_repository.dart';

class Login {
  final UserAuthRepository repository;

  Login(this.repository);

  Future<Either<Failure, void>> call(User user) async {
    return await repository.login(user);
  }
}
