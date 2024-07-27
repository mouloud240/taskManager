import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/domain/repositories/taskManagementRepository.dart';

class UpdateDailyUsecase {
  Taskmanagementrepository taskmanagementrepository;
  UpdateDailyUsecase(this.taskmanagementrepository);
  Future<Either<Failure, void>> call(List<Dailytask> dailys) {
    return taskmanagementrepository.updateDailyTasks(dailys);
  }
}

class UpdatePriorityUsecase {
  Taskmanagementrepository taskmanagementrepository;
  UpdatePriorityUsecase(this.taskmanagementrepository);
  Future<Either<Failure, void>> call(List<Prioritytask> priors) {
    return taskmanagementrepository.updatePriorityTasks(priors);
  }
}

class EditTaskInpriorityUsecase {
  Taskmanagementrepository taskmanagementrepository;
  EditTaskInpriorityUsecase(this.taskmanagementrepository);
  Future<Either<Failure, void>> call(
      Prioritytask priorityTask, Minitask editedTask) {
    return taskmanagementrepository.editTaskInPriorityTask(
        priorityTask, editedTask);
  }
}
