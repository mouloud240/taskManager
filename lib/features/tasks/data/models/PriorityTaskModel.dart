import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_manager/features/tasks/data/models/MiniTaskModel.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:intl/intl.dart';
part 'PriorityTaskModel.g.dart';

DateFormat dateFormat = DateFormat("MMMM d, y 'at' h:mm:ss a");

@HiveType(typeId: 3)
class Prioritytaskmodel extends Prioritytask
    with HiveObjectMixin, EquatableMixin {
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
  @HiveField(6)
  int id;
  Prioritytaskmodel(
      {required this.icon,
      required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.miniTasks,
      required this.id})
      : super(
            icon: icon,
            miniTasksList: miniTasks,
            title: title,
            description: description,
            startDate: startDate,
            endDate: endDate,
            id: id);
  factory Prioritytaskmodel.fromJson(Map<String, dynamic> json) {
    return Prioritytaskmodel(
        title: json['title'],
        description: json['description'],
        startDate: dateFormat.parse(json['startDate'].replaceAll(" UTC+1", "")),
        endDate: dateFormat.parse(json["endDate"].replaceAll(" UTC+1", "")),
        miniTasks: [
          for (var elemnt in json['miniTasksList'])
            Minitaskmodel.fromJson(elemnt)
        ],
        icon: Icon(Icons.ac_unit),
        id: json['id']);
  }
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "startDate": "${dateFormat.format(startDate)} UTC+1",
      "endDate": "${dateFormat.format(endDate)} UTC+1",
      "miniTasksList": [for (var elemnt in miniTasks) elemnt.toJson()],
      "icon": "",
      "id": id,
    };
  }

  @override
  List<Object?> get props =>
      [title, description, startDate, endDate, miniTasks, id];
}
