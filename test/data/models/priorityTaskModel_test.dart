import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/features/tasks/data/models/MiniTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/PriorityTaskModel.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';

import '../../helpers/json_reader.dart';

DateFormat dateFormat = DateFormat("MMMM d, y 'at' h:mm:ss a");

void main() {
  final testPrioTask = Prioritytaskmodel(
    id: "0",
    icon: Icon(Icons.ac_unit),
    miniTasks: {
      "0": Minitaskmodel(name: "making first Test", status: true, id: "0"),
      "1": Minitaskmodel(name: "making second Test", status: false, id: "1"),
    },
    title: "Testing function",
    description: "Trying to test the model",
    startDate: dateFormat.parse("July 27, 2024 at 1:06:24 AM"),
    endDate: dateFormat.parse("July 28, 2024 at 1:06:51 AM"),
    status: false,
    color: Colors.red,
  );

  test("Should be a subclass of Priority", () async {
    //assert
    expect(testPrioTask, isA<Prioritytask>());
  });

  test("Should return a PriorityTaskModel from Json", () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummydata/PriorityModel.json'),
    );

    //act
    final result = Prioritytaskmodel.fromJson(jsonMap);

    //assert
    expect(result, testPrioTask);
  });

  test("Should return json from a Prioritytaskmodel", () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummydata/PriorityModel.json'),
    );

    //act
    final result = testPrioTask.toJson();

    //assert
    expect(result, jsonMap);
  });
}
