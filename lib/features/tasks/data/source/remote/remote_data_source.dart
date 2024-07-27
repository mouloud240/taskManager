import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/auth/presentation/state/userState.dart';
import 'package:task_manager/features/tasks/data/models/DailTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/PriorityTaskModel.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';

class RemoteDataSource {
  WidgetRef ref;
  RemoteDataSource(this.ref);
  final db = FirebaseFirestore.instance;

  Future<Either<Failure, List<Prioritytaskmodel>>> getPriorityTasks() async {
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

  Future<Either<Failure, List<Dailtaskmodel>>> getDailyTasks() async {
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

  Future<Either<Failure, void>> createNewDailyTask(
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

  Future<Either<Failure, void>> createNewPriorityTask(
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

  // Future<Either<Failure, void>> addNewtaskInPriorityTask(
  //     Prioritytask priortityTask, Minitask newTask) async {
  //   try {
  //     final currUser = ref.watch(userStateProvider);
  //     currUser.when(
  //         data: (data)async {
  //           Either<Failure,List<Prioritytaskmodel>> priorityTasks = await getPriorityTasks();
  //           return await db.collection("users").doc(data!.uid).update({

  //           });
  //         },
  //         error: (err, stk) {
  //           return Left(Failure(errMessage: err.toString()));
  //         },
  //         loading: () {return Failure(errMessage: "Loading")});
  //   } catch (e) {
  //     return Left(Failure(errMessage: e.toString()));
  //   }
  // }
}
