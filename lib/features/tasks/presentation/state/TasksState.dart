import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager/core/failure/failure.dart';
import 'package:task_manager/features/tasks/data/repositories/taskManagement_repository_implementation.dart';
import 'package:task_manager/features/tasks/data/source/local/local_data_source.dart';
import 'package:task_manager/features/tasks/data/source/remote/remote_data_source.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/domain/usecases/getDailyTasksUsecase.dart';
import 'package:task_manager/features/tasks/domain/usecases/getPriorityTasksUsecase.dart';

part 'TasksState.g.dart';

final local = LocalDataSource();

@riverpod
class priorityTasksState extends _$priorityTasksState {
  @override
  Future<Either<Failure, List<Prioritytask>>> build(WidgetRef remoteref) async {
    final remote = RemoteDataSource(remoteref);
    final taskRepoImplentation = TaskmanagementRepositoryImplementation(
        localDataSource: local, remoteDataSource: remote);
    return Getprioritytasksusecase(taskRepoImplentation).call();
  }
}

@riverpod
class dailyTasksState extends _$dailyTasksState {
  @override
  Future<Either<Failure, List<Dailytask>>> build(WidgetRef remoteRef) async {
    final remote = RemoteDataSource(remoteRef);
    final taskRepoImplentation = TaskmanagementRepositoryImplementation(
        localDataSource: local, remoteDataSource: remote);
    final tasks = await Getdailytasksusecase(taskRepoImplentation).call();
    return tasks;
  }
}
