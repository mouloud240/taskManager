import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/domain/repositories/user_auth_repository.dart';

class UpdateImage{
  final UserAuthRepository repository;

  UpdateImage(this.repository);

  Future<Either<Failure, String>> call(File image,String id) async {
    return repository.updateImage(image,id);
  }
}