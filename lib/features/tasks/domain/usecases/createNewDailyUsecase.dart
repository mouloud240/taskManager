import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/domain/repositories/taskManagementRepository.dart';

class Createnewdailyusecase {
  final Taskmanagementrepository taskmanagementrepository;
  Createnewdailyusecase(this.taskmanagementrepository);
  Future<Either<Failure, void>> call(Dailytask dailyTask) {
    return taskmanagementrepository.createNewDailyTask(dailyTask);
  }
}
