import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_manager/features/tasks/data/models/MiniTaskModel.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
part 'PriorityTaskModel.g.dart';
@HiveType(typeId: 3)
class Prioritytaskmodel extends Prioritytask with HiveObjectMixin {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime startDate;
  @HiveField(3)
  DateTime endDate;
  @HiveField(4)
  List<Minitaskmodel> miniTasks;
  @HiveField(5)
  Icon icon;
  Prioritytaskmodel(
      {required this.icon,
        required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.miniTasks}):super(icon:icon , miniTasksList: miniTasks, title: title, description:description, startDate: startDate, endDate: endDate);
  factory Prioritytaskmodel.fromJson(Map<String, dynamic> json) {
    return Prioritytaskmodel(
        title: json['title'],
        description: json['description'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        miniTasks: json['miniTasksList'],
        icon: json['icon']
        );
  }
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "startDate": startDate,
      "endDate": endDate,
      "MiniTasksList": miniTasks,
      "icon": icon
    };
  }
  //todo fix the mini TasksList
}
