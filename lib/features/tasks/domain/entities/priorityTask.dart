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

  Map<String, dynamic> getdiffernce() {
    var daysdiff = endDate.difference(DateTime.now()).inDays;
    if (daysdiff < 0) {
      return {"days": 0, "hours": 0, "months": 0};
    }
    var hoursdiff = endDate.difference(DateTime.now()).inHours;
    var monthsDiff = daysdiff ~/ 30;
    daysdiff = daysdiff % 30;
    hoursdiff = hoursdiff % 24;
    return {"days": daysdiff, "hours": hoursdiff, "months": monthsDiff};
  }
}
