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
      required super.endDate});

  factory Prioritytask.fromJson(Map<String, dynamic> json) {
    return Prioritytask(
        icon: json['icon'],
        miniTasksList: json['miniTaskList'],
        title: json['title'],
        description: json['description'],
        startDate: json['startDate'],
        endDate: json['endDate']);
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      "minTaskList": miniTasksList,
      'title': title,
      "description": description,
      'startDate': startDate,
      'endDate': endDate
    };
  }
}
