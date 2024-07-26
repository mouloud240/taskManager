import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/domain/repositories/taskManagementRepository.dart';

class Getdailytasksusecase {
  Taskmanagementrepository taskmanagementrepository;
  Getdailytasksusecase(this.taskmanagementrepository);
  Future<Either<Failure, List<Dailytask>>> call() {
    return taskmanagementrepository.getDailyTasks();
  }
}
