import 'package:dartz/dartz.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';

abstract class Taskmanagementrepository {
//Notification
  Future<Either<Failure, void>> pushNotification();
//Sync
  Future<Either<Failure, void>> syncData();

  //create
  Future<Either<Failure, void>> createNewDailyTask(Dailytask dailyTask);
  Future<Either<Failure, void>> createNewPriorityTask(Prioritytask priorityTask);
  //read
  Future<Either<Failure, List<Prioritytask>>> getPriorityTasks();
  Future<Either<Failure, List<Dailytask>>> getDailyTasks();
  //update
  Future<Either<Failure, void>> addNewtaskInPriorityTask(Prioritytask priortityTask, Minitask newTask);
  Future<Either<Failure, void>> editTaskInPriorityTask(Prioritytask priorityTask, Minitask editedTask);
  Future<Either<Failure, void>> updateDailyTasks(List<Dailytask> dailyTasks);
  Future<Either<Failure, void>> updatePriorityTasks(List<Prioritytask> priorityTasks);
  //delete
  Future<Either<Failure, void>> deleteDailyTask(Dailytask dailyTask);
  Future<Either<Failure, void>> deletePriorityTask(Prioritytask priorityTask);
  Future<Either<Failure, void>> deleteTaskfromPriorityTask(
      Prioritytask priorityTask, Minitask miniTask);
}
