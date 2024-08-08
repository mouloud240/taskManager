import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/tasks/data/models/DailTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/MiniTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/PriorityTaskModel.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';

class LocalDataSource {
  final Box prioBox = Hive.box<Prioritytask>("NewPriorityTasks");
  final Box dailyBox = Hive.box<Dailytask>("MyDailyTasks");
  //create
  Future<Either<Failure, void>> createNewDailyTask(
      Dailtaskmodel dailytask) async {
    try {
      await dailyBox.put(dailytask.id, dailytask);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> createNewPriorityTask(
      Prioritytaskmodel task) async {
    try {
      await prioBox.put(task.id, task);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> addtaskInPriorityTask(
      Prioritytaskmodel priorityTask, Minitaskmodel newTask) async {
    try {
      priorityTask.miniTasks[newTask.id] = newTask;
      prioBox.put(priorityTask.id, priorityTask);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  //update
  Future<Either<Failure, void>> updatePriorityTask(
      Prioritytaskmodel priorityTask) async {
    try {
      await prioBox.put(priorityTask.id, priorityTask);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> updateDailyTask(Dailtaskmodel dailyTask) async {
    try {
      await dailyBox.put(dailyTask.id, dailyTask);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> editMiniTaskInPriorityTask(
      Prioritytaskmodel priorityTask, Minitaskmodel editedTask) async {
    try {
      priorityTask.miniTasks[editedTask.id] = editedTask;
      prioBox.put(priorityTask.id, priorityTask);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

//delete
  Future<Either<Failure, void>> deleteMiniTask(
      Prioritytaskmodel priorityTask, Minitaskmodel miniTask) async {
    try {
      priorityTask.miniTasks.remove(miniTask.id);
      prioBox.put(priorityTask.id, priorityTask);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteDailyTask(String id) async {
    try {
      await dailyBox.delete(id);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> deletePriorityTask(String id) async {
    try {
      await prioBox.delete(id);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

//read
  Future<Either<Failure, List<Dailytask>>> getDailyTasks() async {
    try {
      return Right(dailyBox.values.toList() as List<Dailytask>);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, List<Prioritytask>>> getPriorityTasks() async {
    try {
      return Right(prioBox.values.toList() as List<Prioritytask>);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
