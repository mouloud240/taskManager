import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/tasks/domain/repositories/taskManagementRepository.dart';

class PushnotifUsecase {
  final Taskmanagementrepository taskmanagementrepository;
  PushnotifUsecase(this.taskmanagementrepository);
  Future<Either<Failure, void>> call() {
    return taskmanagementrepository.pushNotification();
  }
}
