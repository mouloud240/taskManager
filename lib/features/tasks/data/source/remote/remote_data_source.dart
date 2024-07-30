// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';
import 'package:task_manager/features/tasks/data/models/DailTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/MiniTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/PriorityTaskModel.dart';

class RemoteDataSource {
  //todo fix the deletion of tasks
  WidgetRef ref;
  RemoteDataSource(this.ref);
  final db = FirebaseFirestore.instance;

  Future<Either<Failure, Map<String, dynamic>>>
      getPriorityTasks_remote() async {
    try {
      final currUser = await ref.read(userStateProvider.future);
      if (currUser == null) {
        return Left(Failure(errMessage: "User not found"));
      }
      final DocumentSnapshot doc =
          await db.collection("users").doc(currUser.uid).get();
      final Map<String, dynamic> tasks =
          doc.get("priorityTasks") as Map<String, dynamic>;
      return Right(tasks);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getDailyTasks_remote() async {
    final currUser = await ref.watch(userStateProvider.future);
    if (currUser == null) {
      return Left(Failure(errMessage: "User not found"));
    }
    try {
      final db = FirebaseFirestore.instance;
      final DocumentSnapshot doc =
          await db.collection("users").doc(currUser.uid).get();
      final Map<String, dynamic> tasks =
          doc.get("dailyTasks") as Map<String, dynamic>;

      return Right(tasks);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> createNewDailyTask_remote(
      Dailtaskmodel dailyTask) async {
    try {
      final currUser = await ref.read(userStateProvider.future);
      if (currUser == null) {
        return Left(Failure(errMessage: "User not found"));
      }
      await db
          .collection("users")
          .doc(currUser.uid)
          .update({"dailyTasks.${dailyTask.id}": dailyTask.toJson()});
      return const Right(Unit);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> createNewPriorityTask_remote(
      Prioritytaskmodel priorityTask) async {
    try {
      final currUser = await ref.read(userStateProvider.future);
      if (currUser == null) {
        return Left(Failure(errMessage: "User not found"));
      }
      await db
          .collection("users")
          .doc(currUser.uid)
          .update({"priorityTasks.${priorityTask.id}": priorityTask.toJson()});
      return const Right(Unit);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> addNewtaskInPriorityTask_remote(
      Prioritytaskmodel priorityTask, Minitaskmodel newTask) async {
    try {
      final currUser = await ref.read(userStateProvider.future);
      if (currUser == null) {
        return Left(Failure(errMessage: "User not found"));
      }
      Either<Failure, Map<String, dynamic>> priorityTasks =
          await getPriorityTasks_remote();
      return priorityTasks.fold((failure) {
        return Left(failure);
      }, (tasks) {
        tasks[priorityTask.id]['minitasks'][newTask.id] = newTask.toJson();
        db
            .collection('users')
            .doc(currUser.uid)
            .update({"priorityTasks": tasks});
        return const Right(Unit);
      });
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> editTaskInPriorityTask_remote(
      Prioritytaskmodel priorityTask, Minitaskmodel editedTask) async {
    try {
      final currUser = await ref.read(userStateProvider.future);
      if (currUser == null) {
        return Left(Failure(errMessage: "User not found"));
      }
      Either<Failure, Map<String, dynamic>> priorityTasks =
          await getPriorityTasks_remote();
      return priorityTasks.fold((failure) {
        return Left(failure);
      }, (tasks) {
        tasks[priorityTask.id]['minitasks'][editedTask.id] =
            editedTask.toJson();
        db
            .collection("users")
            .doc(currUser.uid)
            .update({"priorityTasks": tasks});
        return const Right(Unit);
      });
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteDailyTask(String id) async {
    try {
      final currUser = await ref.read(userStateProvider.future);
      if (currUser == null) {
        return Left(Failure(errMessage: "User not found"));
      }
      Either<Failure, Map<String, dynamic>> dailyTasks =
          await getDailyTasks_remote();
      return dailyTasks.fold((failure) => Left(failure), (tasks) {
        tasks.remove(id);
        db.collection("users").doc(currUser.uid).update({"dailyTasks": tasks});
        return const Right(Unit);
      });
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> deletePriorityTask(String id) async {
    try {
      final currUser = await ref.read(userStateProvider.future);
      if (currUser == null) {
        return Left(Failure(errMessage: "User not found"));
      }
      Either<Failure, Map<String, dynamic>> priorityTasks =
          await getPriorityTasks_remote();
      return priorityTasks.fold((failure) => Left(failure), (tasks) {
        tasks.remove(id);
        db
            .collection("users")
            .doc(currUser.uid)
            .update({"priorityTasks": tasks});
        return const Right(Unit);
      });
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteTaskfromPriorityTask(
      Prioritytaskmodel priorityTask, String id) async {
    try {
      final currUser = await ref.read(userStateProvider.future);
      if (currUser == null) {
        return Left(Failure(errMessage: "User not found"));
      }
      Either<Failure, Map<String, dynamic>> priorityTasks =
          await getPriorityTasks_remote();
      return priorityTasks.fold((failure) => Left(failure), (tasks) {
        tasks[priorityTask.id]['minitasks'].remove(id);
        db
            .collection("users")
            .doc(currUser.uid)
            .update({"priorityTasks": tasks});
        return const Right(Unit);
      });
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> updateDailyTasks(
      List<Dailtaskmodel> list) async {
    try {
      final currUser = await ref.read(userStateProvider.future);
      if (currUser == null) {
        return Left(Failure(errMessage: "User not found"));
      }
      Map<String, dynamic> tasks = {};
      for (var element in list) {
        tasks[element.id] = element.toJson();
      }
      db.collection("users").doc(currUser.uid).update({"dailyTasks": tasks});
      return const Right(Unit);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
