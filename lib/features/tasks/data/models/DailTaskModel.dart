import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';

part 'DailTaskModel.g.dart';

DateFormat dateFormat = DateFormat("MMMM d, y 'at' h:mm:ss a");

@HiveType(typeId: 1)
class Dailtaskmodel extends Dailytask with HiveObjectMixin, EquatableMixin {
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
  @override
  @HiveField(4)
  String id;
  @override
  @HiveField(5)
  bool status;

  Dailtaskmodel(
      {required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.id,
      this.status = false})
      : super(
          title: title,
          description: description,
          startDate: startDate,
          endDate: endDate,
          id: id,
          status: status,
        );

  factory Dailtaskmodel.fromEntity(Dailytask dailytask) {
    return Dailtaskmodel(
        title: dailytask.title,
        description: dailytask.description,
        startDate: dailytask.startDate,
        endDate: dailytask.endDate,
        id: dailytask.id);
  }
  factory Dailtaskmodel.fromJson(Map<String, dynamic> json) {
    return Dailtaskmodel(
        title: json['title'],
        description: json['description'],
        startDate: dateFormat.parse(json['startDate'].replaceAll(" UTC+1", "")),
        endDate: dateFormat.parse(json["endDate"].replaceAll(" UTC+1", "")),
        id: json["id"],
        status: json['status']);
  }
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "startDate": "${dateFormat.format(startDate)} UTC+1",
      "endDate": "${dateFormat.format(endDate)} UTC+1",
      "id": id,
      "status": status
    };
  }

  Dailytask toEntity() {
    return Dailytask(
        title: title,
        description: description,
        startDate: startDate,
        endDate: endDate,
        id: id,
        status: status);
  }

  @override
  List<Object?> get props =>
      [title, description, startDate, endDate, id, status];
}
