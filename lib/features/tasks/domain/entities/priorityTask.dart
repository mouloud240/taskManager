import 'package:date_utils/date_utils.dart' as dt;
import 'package:flutter/material.dart';
import 'package:task_manager/features/tasks/domain/entities/Task.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';

class Prioritytask extends Task {
  Map<String, Minitask> miniTasksList;
  Widget? icon;
  Color? color;

  Prioritytask(
      {this.icon,
      required this.miniTasksList,
      required super.title,
      required super.description,
      required super.startDate,
      required super.endDate,
      required super.id,
      required super.status,
      this.color});

  int calculateprogress() {
    if (miniTasksList.isEmpty) {
      return 0;
    }
    int completed = 0;
    miniTasksList.forEach((key, value) {
      if (value.status) {
        completed++;
      }
    });

    return (completed / miniTasksList.length * 100).toInt();
  }

  getRemainingTime() {
    return endDate.difference(DateTime.now()).inDays;
  }
}
