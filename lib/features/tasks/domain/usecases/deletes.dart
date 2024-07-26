import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/domain/repositories/taskManagementRepository.dart';

class DeleteDailyTaskUsecase {
  Taskmanagementrepository taskmanagementrepository;
  DeleteDailyTaskUsecase(this.taskmanagementrepository);
  Future<Either<Failure, void>> call(Dailytask dailyTask) {
    return taskmanagementrepository.deleteDailyTask(dailyTask);
  }
}

class DeletePriorityTaskUsecase {
  Taskmanagementrepository taskmanagementrepository;
  DeletePriorityTaskUsecase(this.taskmanagementrepository);
  Future<Either<Failure, void>> call(Prioritytask priorityTask) {
    return taskmanagementrepository.deletePriorityTask(priorityTask);
  }
}

class DeleteTaskFromPriorityTaskUsecase {
  Taskmanagementrepository taskmanagementrepository;
  DeleteTaskFromPriorityTaskUsecase(this.taskmanagementrepository);
  Future<Either<Failure, void>> call(
      Prioritytask priorityTask, Minitask miniTask) {
    return taskmanagementrepository.deleteTaskfromPriorityTask(
        priorityTask, miniTask);
  }
}
