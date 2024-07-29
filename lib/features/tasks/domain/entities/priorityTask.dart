import 'package:flutter/material.dart';
import 'package:task_manager/features/tasks/domain/entities/Task.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';

class Prioritytask extends Task {
  Map<String,Minitask> miniTasksList;
  Widget? icon;
 
  Prioritytask(
      { this.icon,
      required this.miniTasksList,
      required super.title,
      required super.description,
      required super.startDate,
      required super.endDate,
      required super.id,
      required super.status
      
      });

  toJson() {}
}
