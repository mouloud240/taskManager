import 'package:flutter/material.dart';
import 'package:task_manager/features/tasks/domain/entities/Task.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';

class Prioritytask extends Task {
  List<Minitask> miniTasksList;
  Icon icon;
 
  Prioritytask(
      {required this.icon,
      required this.miniTasksList,
      required super.title,
      required super.description,
      required super.startDate,
      required super.endDate,
      required super.id
      
      });

  toJson() {}
}
