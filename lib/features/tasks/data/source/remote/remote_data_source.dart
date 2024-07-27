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
  WidgetRef ref;
  RemoteDataSource(this.ref);
  final db = FirebaseFirestore.instance;

  Future<Either<Failure, List<Prioritytaskmodel>>>
      getPriorityTasks_remote() async {
    try {
      final currUser = ref.watch(userStateProvider);
      return await currUser.when(
        data: (data) async {
          final DocumentSnapshot doc =
              await db.collection("users").doc(data!.uid).get();
          final List<Prioritytaskmodel> priorityTasks = [];
          final List<dynamic> tasks = doc.get("priorityTasks");
          for (var element in tasks) {
            priorityTasks.add(Prioritytaskmodel.fromJson(element));
          }
          return Right(priorityTasks);
        },
        error: (error, stackTrace) {
          return Left(Failure(errMessage: error.toString()));
        },
        loading: () {
          return Left(Failure(errMessage: "Loading"));
        },
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, List<Dailtaskmodel>>> getDailyTasks_remote() async {
    try {
      final currUser = ref.watch(userStateProvider);
      return await currUser.when(
        data: (data) async {
          final DocumentSnapshot doc =
              await db.collection("users").doc(data!.uid).get();
          final List<Dailtaskmodel> dailyTasks = [];
          final List<dynamic> tasks = doc.get("dailyTasks");
          for (var element in tasks) {
            dailyTasks.add(Dailtaskmodel.fromJson(element));
          }
          return Right(dailyTasks);
        },
        error: (error, stackTrace) {
          return Left(Failure(errMessage: error.toString()));
        },
        loading: () {
          return Left(Failure(errMessage: "Loading"));
        },
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> createNewDailyTask_remote(
      Dailtaskmodel dailyTask) async {
    try {
      final currUser = ref.watch(userStateProvider);
      return await currUser.when(
        data: (data) async {
          await db.collection("users").doc(data!.uid).update({
            "dailyTasks": FieldValue.arrayUnion([dailyTask.toJson()])
          });
          // ignore: void_checks
          return const Right(Unit);
        },
        error: (error, stackTrace) {
          return Left(Failure(errMessage: error.toString()));
        },
        loading: () {
          return Left(Failure(errMessage: "Loading"));
        },
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> createNewPriorityTask_remote(
      Prioritytaskmodel priorityTask) async {
    try {
      final currUser = ref.watch(userStateProvider);
      return currUser.when(
        data: (data) async {
          await db.collection('users').doc(data!.uid).update({
            "priorityTasks": FieldValue.arrayUnion([priorityTask.toJson()])
          });
          // ignore: void_checks
          return const Right(unit);
        },
        error: (error, stackTrace) =>
            Left(Failure(errMessage: error.toString())),
        loading: () {
          return Left(Failure(errMessage: "Loading"));
        },
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> addNewtaskInPriorityTask_remote(
      Prioritytaskmodel priorityTask, Minitaskmodel newTask) async {
    try {
      final currUser = ref.watch(userStateProvider);
      return currUser.when(data: (data) async {
        Either<Failure, List<Prioritytaskmodel>> priorityTasks =
            await getPriorityTasks_remote();
        return priorityTasks.fold((failure) {
          return left(failure);
        }, (tasks) {
          tasks[priorityTask.id].miniTasks.add(newTask);
          db.collection("users").doc(data!.uid).update(
              {"priorityTasks": tasks.map((task) => task.toJson()).toList()});

          // ignore: void_checks
          return const Right(unit);
        });
      }, error: (err, stk) {
        return Future<Either<Failure, void>>.value(
            Left(Failure(errMessage: err.toString())));
      }, loading: () {
        return Left(Failure(errMessage: "Loading"));
      });
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> editTaskInPriorityTask_remote(
      Prioritytaskmodel priorityTask, Minitaskmodel editedTask) async {
    try {
      final currUser = ref.watch(userStateProvider);
      return currUser.when(data: (data) async {
        Either<Failure, List<Prioritytaskmodel>> priorityTasks =
            await getPriorityTasks_remote();
        return priorityTasks.fold((failure) {
          return left(failure);
        }, (tasks) {
          tasks[priorityTask.id].miniTasks[editedTask.id] =
              Minitaskmodel.fromEntity(editedTask);

          db.collection("users").doc(data!.uid).update(
              {"priorityTasks": tasks.map((task) => task.toJson()).toList()});

          // ignore: void_checks
          return const Right(unit);
        });
      }, error: (err, stk) {
        return Future<Either<Failure, void>>.value(
            Left(Failure(errMessage: err.toString())));
      }, loading: () {
        return Left(Failure(errMessage: "Loading"));
      });
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteDailyTask(Dailtaskmodel dailyTask) async {
    try {
      final currUser = ref.watch(userStateProvider);
      return await currUser.when(
          data: (user) async {
            // ignore: no_leading_underscores_for_local_identifiers
            Either<Failure, List<Dailtaskmodel>> _dailyTasks =
                await getDailyTasks_remote();
            _dailyTasks.fold((failure) => Left(failure), (dailyTasks) {
              dailyTasks.removeAt(dailyTask.id);
              db.collection("users").doc(user!.uid).update({
                "dailyTasks": dailyTasks.map((task) => task.toJson()).toList()
              });
            });
            // ignore: void_checks
            return const Right(unit);
          },
          error: (error, stackTrace) =>
              Left(Failure(errMessage: error.toString())),
          loading: () => Left(Failure(errMessage: "Loading")));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> deletePriorityTask(
      Prioritytaskmodel priorityTask) async {
    try {
      final currUser = ref.watch(userStateProvider);
      return currUser.when(
          data: (user) async {
            Either<Failure, List<Prioritytaskmodel>> priorityTasks =
                await getPriorityTasks_remote();
            priorityTasks.fold((failure) => Left(failure), (priorityTasks) {
              priorityTasks.removeAt(priorityTask.id);
              db.collection("users").doc(user!.uid).update({
                "priorityTasks":
                    priorityTasks.map((task) => task.toJson()).toList()
              });
            });
            // ignore: void_checks
            return const Right(unit);
          },
          error: (error, stackTrace) =>
              Left(Failure(errMessage: error.toString())),
          loading: () => Left(Failure(errMessage: "Loading")));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteTaskfromPriorityTask(
      Prioritytaskmodel priorityTask, Minitaskmodel miniTask) async {
    try {
      final currUser = ref.watch(userStateProvider);
      return currUser.when(
          data: (user) async {
            Either<Failure, List<Prioritytaskmodel>> priorityTasks =
                await getPriorityTasks_remote();
            priorityTasks.fold((failure) => Left(failure), (priorityTasks) {
              priorityTasks[priorityTask.id].miniTasks.removeAt(miniTask.id);
              db.collection("users").doc(user!.uid).update({
                "priorityTasks":
                    priorityTasks.map((task) => task.toJson()).toList()
              });
            });
            // ignore: void_checks
            return const Right(unit);
          },
          error: (error, stackTrace) =>
              Left(Failure(errMessage: error.toString())),
          loading: () => Left(Failure(errMessage: "Loading")));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
