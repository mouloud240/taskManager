import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/domain/repositories/taskManagementRepository.dart';

class Addnewtaskinpriorusecase {
  Taskmanagementrepository taskmanagementrepository;
  Addnewtaskinpriorusecase(this.taskmanagementrepository);
  Future<Either<Failure, void>> call(Prioritytask prior, Minitask task) {
    return taskmanagementrepository.addNewtaskInPriorityTask(prior, task);
  }
}
