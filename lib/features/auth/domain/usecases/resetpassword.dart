import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/domain/repositories/user_auth_repository.dart';

class ResetpasswordUsecase {
  final UserAuthRepository repository;

  ResetpasswordUsecase(this.repository);

  Future<Either<Failure, void>> call(String email) async {
    return await repository.resetPassword(email);
  }
}
