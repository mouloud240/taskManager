import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';
import 'package:task_manager/features/tasks/data/models/DailTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/MiniTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/PriorityTaskModel.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';

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
          return Right(null);
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
          return Right(null);
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
      Prioritytask priorityTask, Minitask newTask) async {
    try {
      final currUser = ref.watch(userStateProvider);
      return currUser.when(data: (data) async {
        Either<Failure, List<Prioritytaskmodel>> priorityTasks =
            await getPriorityTasks_remote();
        return priorityTasks.fold((failure) {
          return left(failure);
        }, (data) {
          data[priorityTask.id]
              .miniTasks
              .add(Minitaskmodel.fromEntity(newTask));
          return Right(Null);
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
      Prioritytask priorityTask, Minitask editedTask) {
    try {
      final currUser = ref.watch(userStateProvider);
      return currUser.when(data: (data) async {
        Either<Failure, List<Prioritytaskmodel>> priorityTasks =
            await getPriorityTasks_remote();
        return priorityTasks.fold((failure) {
          return left(failure);
        }, (data) {
          data[priorityTask.id].miniTasks[editedTask.id] =
              Minitaskmodel.fromEntity(editedTask);

          return Right(Null);
        });
      }, error: (err, stk) {
        return Future<Either<Failure, void>>.value(
            Left(Failure(errMessage: err.toString())));
      }, loading: () {
        return Future<Either<Failure, void>>.value(
            Left(Failure(errMessage: "Loading")));
      });
    } catch (e) {
      return Future<Either<Failure, void>>.value(
          Left(Failure(errMessage: e.toString())));
    }
  }
}
