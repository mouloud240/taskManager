import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/domain/repositories/user_auth_repository.dart';

class Updateinfousecase {
  UserAuthRepository userAuthRepository;
  Updateinfousecase({required this.userAuthRepository});
  Future<Either<Failure, void>> call(String proffesion, String name) {
    return userAuthRepository.updateInfo(proffesion, name);
  }
}
