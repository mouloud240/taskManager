import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/domain/repositories/taskManagementRepository.dart';

class Createnewpriorusecase {
  final Taskmanagementrepository taskmanagementrepository;
  Createnewpriorusecase(this.taskmanagementrepository);
  Future<Either<Failure, void>> call(Prioritytask task) {
    return taskmanagementrepository.createNewPriorityTask(task);
  }
}
