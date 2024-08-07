import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_manager/features/tasks/data/models/MiniTaskModel.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:intl/intl.dart';
part 'PriorityTaskModel.g.dart';

int convertToInt(Color? color) {
  if (color != null) {
    return color.value;
  }
  return 0;
}

Color convertToColor(int intColor) {
  return Color(intColor);
}

DateFormat dateFormat = DateFormat("MMMM d, y 'at' h:mm:ss a");

@HiveType(typeId: 3)
class Prioritytaskmodel extends Prioritytask
    with HiveObjectMixin, EquatableMixin {
  @override
  @HiveField(0)
  String title;
  @override
  @HiveField(1)
  String description;
  @override
  @HiveField(2)
  DateTime startDate;
  @override
  @HiveField(3)
  DateTime endDate;
  @HiveField(4)
  Map<String, Minitaskmodel> miniTasks;
  @override
  @HiveField(5)
  Widget? icon;
  @override
  @HiveField(6)
  String id;
  @override
  @HiveField(7)
  bool status;
  @override
  @HiveField(8)
  Color? color;
  Prioritytaskmodel({
    this.icon,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.miniTasks,
    required this.id,
    this.color,
    this.status = false,
  }) : super(
          icon: icon,
          miniTasksList: miniTasks,
          title: title,
          description: description,
          startDate: startDate,
          endDate: endDate,
          id: id,
          status: status,
          color: color,
        );
  factory Prioritytaskmodel.fromJson(Map<String, dynamic> json) {
    return Prioritytaskmodel(
      title: json['title'],
      description: json['description'],
      startDate: dateFormat.parse(json['startDate'].replaceAll(" UTC+1", "")),
      endDate: dateFormat.parse(json["endDate"].replaceAll(" UTC+1", "")),
      miniTasks: (json['minitasks'] as Map<String, dynamic>).map((key, value) =>
          MapEntry(key, Minitaskmodel.fromJson(value as Map<String, dynamic>))),
      icon: json['icon'],
      id: json['id'],
      status: json['status'],
      color: convertToColor(json['color']),
    );
  }
  factory Prioritytaskmodel.fromEntity(Prioritytask task) {
    return Prioritytaskmodel(
        icon: task.icon,
        title: task.title,
        description: task.description,
        startDate: task.startDate,
        endDate: task.endDate,
        miniTasks: task.miniTasksList.map(
            (key, value) => MapEntry(key, Minitaskmodel.fromEntity(value))),
        id: task.id,
        status: task.status,
        color: task.color);
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "startDate": "${dateFormat.format(startDate)} UTC+1",
      "endDate": "${dateFormat.format(endDate)} UTC+1",
      "minitasks": miniTasks.map((key, value) => MapEntry(key, value.toJson())),
      "icon": icon,
      "id": id,
      "status": status,
      "color": convertToInt(color),
    };
  }

  Prioritytask toEntity() {
    return Prioritytask(
      icon: icon,
      miniTasksList: miniTasks.map((key, value) {
        return MapEntry(key, value.toEntity());
      }),
      title: title,
      description: description,
      startDate: startDate,
      endDate: endDate,
      id: id,
      status: status,
      color: color,
    );
  }

  @override
  List<Object?> get props =>
      [title, description, startDate, endDate, miniTasks, id, status];
}
