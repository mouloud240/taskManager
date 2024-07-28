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
      final currUser = ref.watch(userStateProvider);
      return await currUser.when(
        data: (data) async {
          final DocumentSnapshot doc =
              await db.collection("users").doc(data!.uid).get();

          final Map<String, dynamic> tasks =
              doc.get("priorityTasks") as Map<String, dynamic>;
          return Right(tasks);
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

  Future<Either<Failure, Map<String, dynamic>>> getDailyTasks_remote() async {
    try {
      final currUser = ref.watch(userStateProvider);
      return await currUser.when(
        data: (data) async {
          final DocumentSnapshot doc =
              await db.collection("users").doc(data!.uid).get();
          final Map<String, dynamic> tasks =
              doc.get("dailyTasks") as Map<String, dynamic>;

          return Right(tasks);
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
          await db
              .collection("users")
              .doc(data!.uid)
              .update({"dailyTasks.${dailyTask.id}": dailyTask.toJson()});
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
          await db.collection('users').doc(data!.uid).update(
              {"priorityTasks.${priorityTask.id}": priorityTask.toJson()});

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
      Either<Failure, Map<String, dynamic>> priorityTasks =
          await getPriorityTasks_remote();
      return currUser.when(data: (data) async {
        return priorityTasks.fold((failure) {
          return left(failure);
        }, (tasks) {
          tasks[priorityTask.id]['minitasks'][newTask.id] = newTask.toJson();
          db
              .collection('users')
              .doc(data!.uid)
              .update({"priorityTasks": tasks});

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
        Either<Failure, Map<String, dynamic>> priorityTasks =
            await getPriorityTasks_remote();
        return priorityTasks.fold((failure) {
          return left(failure);
        }, (tasks) {
          tasks[priorityTask.id]['minitasks'][editedTask.id] =
              editedTask.toJson();

          db
              .collection("users")
              .doc(data!.uid)
              .update({"priorityTasks": tasks});

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

  Future<Either<Failure, void>> deleteDailyTask(String id) async {
    try {
      final currUser = ref.watch(userStateProvider);
      return await currUser.when(
          data: (user) async {
            // ignore: no_leading_underscores_for_local_identifiers
            Either<Failure, Map<String, dynamic>> _dailyTasks =
                await getDailyTasks_remote();
            _dailyTasks.fold((failure) => Left(failure), (dailyTasks) {
              dailyTasks.remove(id);
              db
                  .collection("users")
                  .doc(user!.uid)
                  .update({"dailyTasks": dailyTasks});
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

  Future<Either<Failure, void>> deletePriorityTask(String id) async {
    try {
      final currUser = ref.watch(userStateProvider);
      return currUser.when(
          data: (user) async {
            Either<Failure, Map<String, dynamic>> priorityTasks =
                await getPriorityTasks_remote();
            priorityTasks.fold((failure) => Left(failure), (priorityTasks) {
              priorityTasks.remove(id);
              db
                  .collection("users")
                  .doc(user!.uid)
                  .update({"priorityTasks": priorityTasks});
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
      Prioritytaskmodel priorityTask, String id) async {
    try {
      final currUser = ref.watch(userStateProvider);
      return currUser.when(
          data: (user) async {
            Either<Failure, Map<String, dynamic>> priorityTasks =
                await getPriorityTasks_remote();
            priorityTasks.fold((failure) => Left(failure), (priorityTasks) {
              priorityTasks[priorityTask.id]['minitasks'].remove(id);
              db
                  .collection("users")
                  .doc(user!.uid)
                  .update({"priorityTasks": priorityTasks});
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
