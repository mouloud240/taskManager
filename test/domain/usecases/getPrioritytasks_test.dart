
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/domain/usecases/getPriorityTasksUsecase.dart';


import '../../helpers/test_helpers.mocks.dart';

void main() {
  late Getprioritytasksusecase getprioritytasksusecase;
  late MockTaskmanagementrepository mymockTaskmanagementrepository;
  setUp(() {
    mymockTaskmanagementrepository = MockTaskmanagementrepository();
    getprioritytasksusecase =
        Getprioritytasksusecase(mymockTaskmanagementrepository);
  });
  List<Prioritytask> testPriortask = [
    Prioritytask(
        id: 0,
        icon: Icon(Icons.ac_unit),
        miniTasksList: [Minitask(name: "Run"), Minitask(name: "Walk")],
        title: "run",
        description: "I want the test to fail",
        startDate: DateTime.utc(2024, 7, 26, 23, 12, 28),
        endDate: DateTime.utc(2024, 7, 27, 23, 12, 43))
  ];
 
  test("Should Get the list of priorityTasks", () async {
    //arrange
    when(mymockTaskmanagementrepository.getPriorityTasks())
        .thenAnswer((_) async => Right(testPriortask));
    //act
    final result = await getprioritytasksusecase.call();
    //assert
    expect(result, Right(testPriortask));
  });
}
