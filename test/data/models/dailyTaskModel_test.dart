import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/features/tasks/data/models/DailTaskModel.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import '../../helpers/json_reader.dart';

DateFormat dateFormat = DateFormat("MMMM d, y 'at' h:mm:ss a");
void main() {
  final Map<String, dynamic> jsonMap = {
    "title": "run",
    "description": "Go running",
    "startDate": "July 27, 2024 at 11:12:43 PM UTC+1",
    "endDate": "July 26, 2024 at 11:12:28 PM UTC+1",
    "id": 0
  };

  final testDailyTask = Dailtaskmodel(
      title: "run",
      description: "Go running",
      startDate: dateFormat.parse("July 27, 2024 at 11:12:43 PM"),
      endDate: dateFormat.parse("July 26, 2024 at 11:12:28 PM"),
      id: 0);
  test("Should be a subclass of DailyTask", () async {
    expect(testDailyTask, isA<Dailytask>());
  });
  test("Should return a DailyTaskModel from Json", () async {
    //araange
    //act
    final result = Dailtaskmodel.fromJson(jsonMap);
    //assert
    expect(result, testDailyTask);
  });
  test("should return a json from DailyTaskModel", () async {
    //arrange

    //act
    final result = testDailyTask.toJson();

    //assert
    expect(result, jsonMap);
  });
}
