import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/domain/repositories/taskManagementRepository.dart';

class Getprioritytasksusecase {
  Taskmanagementrepository taskmanagementrepository;
  Getprioritytasksusecase(this.taskmanagementrepository);
  Future<Either<Failure, List<Prioritytask>>> call() {
    return taskmanagementrepository.getPriorityTasks();
  }
}
