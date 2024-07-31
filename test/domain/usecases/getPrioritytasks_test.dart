import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/domain/usecases/getPriorityTasksUsecase.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late Getprioritytasksusecase getPriorityTasksUsecase;
  late MockTaskmanagementrepository mockTaskmanagementrepository;

  setUp(() {
    mockTaskmanagementrepository = MockTaskmanagementrepository();
    getPriorityTasksUsecase = Getprioritytasksusecase(mockTaskmanagementrepository);
  });

  final Map<String, Minitask> miniTasks = {
    '0': Minitask(name: "Run", id: '0'),
    '1': Minitask(name: "Walk", id: '1'),
  };

  final List<Prioritytask> testPriorityTasks = [
    Prioritytask(
      id: '0',
      icon: const Icon(Icons.ac_unit),
      miniTasksList: miniTasks,
      title: "run",
      description: "I want the test to fail",
      startDate: DateTime.utc(2024, 7, 26, 23, 12, 28),
      endDate: DateTime.utc(2024, 7, 27, 23, 12, 43),
      status: false,
      color: Colors.red,
    ),
  ];

  test("Should get the list of priorityTasks", () async {
    // arrange
    when(mockTaskmanagementrepository.getPriorityTasks())
        .thenAnswer((_) async => Right(testPriorityTasks));
    // act
    final result = await getPriorityTasksUsecase();
    // assert
    expect(result, Right(testPriorityTasks));
  });
}
