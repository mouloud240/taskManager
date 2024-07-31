import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:task_manager/core/connection/network_info.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/tasks/data/models/DailTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/MiniTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/PriorityTaskModel.dart';
import 'package:task_manager/features/tasks/data/source/local/local_data_source.dart';
import 'package:task_manager/features/tasks/data/source/remote/remote_data_source.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/domain/repositories/taskManagementRepository.dart';

class TaskmanagementRepositoryImplementation
    implements Taskmanagementrepository {
  LocalDataSource localDataSource;
  RemoteDataSource remoteDataSource;
  final networkInfo = NetworkInfoImpl(DataConnectionChecker());
  TaskmanagementRepositoryImplementation(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> addNewtaskInPriorityTask(
      Prioritytask priorityTask, Minitask newTask) async {
    if (await networkInfo.isConnected) {
      localDataSource.addtaskInPriorityTask(
          Prioritytaskmodel.fromEntity(priorityTask),
          Minitaskmodel.fromEntity(newTask));
      return remoteDataSource.addNewtaskInPriorityTask_remote(
          Prioritytaskmodel.fromEntity(priorityTask),
          Minitaskmodel.fromEntity(newTask));
    } else {
      return localDataSource.addtaskInPriorityTask(
          Prioritytaskmodel.fromEntity(priorityTask),
          Minitaskmodel.fromEntity(newTask));
    }
  }

  @override
  Future<Either<Failure, void>> createNewDailyTask(Dailytask dailyTask) async {
    if (await networkInfo.isConnected) {
      localDataSource.createNewDailyTask(Dailtaskmodel.fromEntity(dailyTask));
      return remoteDataSource
          .createNewDailyTask_remote(Dailtaskmodel.fromEntity(dailyTask));
    } else {
      return localDataSource
          .createNewDailyTask(Dailtaskmodel.fromEntity(dailyTask));
    }
  }

  @override
  Future<Either<Failure, void>> createNewPriorityTask(
      Prioritytask priorityTask) async {
    if (await networkInfo.isConnected) {
      localDataSource
          .createNewPriorityTask(Prioritytaskmodel.fromEntity(priorityTask));
      return remoteDataSource.createNewPriorityTask_remote(
          Prioritytaskmodel.fromEntity(priorityTask));
    } else {
      return localDataSource
          .createNewPriorityTask(Prioritytaskmodel.fromEntity(priorityTask));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDailyTask(Dailytask dailyTask) async {
    if (await networkInfo.isConnected) {
      localDataSource.deleteDailyTask(dailyTask.id);
      return remoteDataSource.deleteDailyTask(dailyTask.id);
    }
    {
      return localDataSource.deleteDailyTask(dailyTask.id);
    }
  }

  @override
  Future<Either<Failure, void>> deletePriorityTask(
      Prioritytask priorityTask) async {
    if (await networkInfo.isConnected) {
      localDataSource.deletePriorityTask(priorityTask.id);
      return remoteDataSource.deletePriorityTask(priorityTask.id);
    } else {
      return localDataSource.deletePriorityTask(priorityTask.id);
    }
  }

  @override
  Future<Either<Failure, void>> deleteTaskfromPriorityTask(
      Prioritytask priorityTask, Minitask miniTask) async {
    if (await networkInfo.isConnected) {
      localDataSource.deleteMiniTask(Prioritytaskmodel.fromEntity(priorityTask),
          Minitaskmodel.fromEntity(miniTask));
      return remoteDataSource.deleteTaskfromPriorityTask(
          Prioritytaskmodel.fromEntity(priorityTask), miniTask.id);
    } else {
      return localDataSource.deleteMiniTask(
          Prioritytaskmodel.fromEntity(priorityTask),
          Minitaskmodel.fromEntity(miniTask));
    }
  }

  @override
  Future<Either<Failure, void>> editTaskInPriorityTask(
      Prioritytask priorityTask, Minitask editedTask) async {
    if (await networkInfo.isConnected) {
      localDataSource.editMiniTaskInPriorityTask(
          Prioritytaskmodel.fromEntity(priorityTask),
          Minitaskmodel.fromEntity(editedTask));
      return remoteDataSource.editTaskInPriorityTask_remote(
          Prioritytaskmodel.fromEntity(priorityTask),
          Minitaskmodel.fromEntity(editedTask));
    } else {
      return localDataSource.editMiniTaskInPriorityTask(
          Prioritytaskmodel.fromEntity(priorityTask),
          Minitaskmodel.fromEntity(editedTask));
    }
  }

  @override
  Future<Either<Failure, List<Dailytask>>> getDailyTasks() async {
    if (await networkInfo.isConnected) {
      Either<Failure, Map<String, dynamic>> res =
          await remoteDataSource.getDailyTasks_remote();
      final Either<Failure, List<Dailytask>> test = res.fold((fail) {
        return left(fail);
      }, (dailys) {
        List<Dailytask> tasks = [];
        dailys.forEach((key, value) {
          tasks.add(Dailtaskmodel.fromJson(value).toEntity());
        });
        return right(tasks);
      });
      return test;
    } else {
      return localDataSource.getDailyTasks();
    }
  }

  @override
  Future<Either<Failure, List<Prioritytask>>> getPriorityTasks() async {
    if (await networkInfo.isConnected) {
      List<Prioritytask> tasks = [];
      Either<Failure, Map<String, dynamic>> res =
          await remoteDataSource.getPriorityTasks_remote();
      final Either<Failure, List<Prioritytask>> out =
          res.fold((fail) => left(fail), (pTask) {
        pTask.forEach((key, value) {
          tasks.add(Prioritytaskmodel.fromJson(value).toEntity());
        });
        return Right(tasks);
      });
      return out;
    } else {
      return localDataSource.getPriorityTasks();
    }
  }

  @override
  Future<Either<Failure, void>> pushNotification() {
    // TODO: implement pushNotification
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> syncData() {
    // TODO: implement syncData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateDailyTasks(List<Dailytask> dailyTasks) {
    // TODO: implement updateDailyTasks
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updatePriorityTasks(
      List<Prioritytask> priorityTasks) {
    // TODO: implement updatePriorityTasks
    throw UnimplementedError();
  }
}
