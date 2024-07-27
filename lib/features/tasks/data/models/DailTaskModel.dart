import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';

part 'DailTaskModel.g.dart';

@HiveType(typeId: 1)
DateFormat dateFormat = DateFormat("MMMM d, y 'at' h:mm:ss a");

class Dailtaskmodel extends Dailytask with HiveObjectMixin, EquatableMixin {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime startDate;
  @HiveField(3)
  DateTime endDate;

  Dailtaskmodel(
      {required this.title,
      required this.description,
      required this.startDate,
      required this.endDate})
      : super(
            title: title,
            description: description,
            startDate: startDate,
            endDate: endDate);

  factory Dailtaskmodel.fromEntity(Dailytask dailytask) {
    return Dailtaskmodel(
        title: dailytask.title,
        description: dailytask.description,
        startDate: dailytask.startDate,
        endDate: dailytask.endDate);
  }
  factory Dailtaskmodel.fromJson(Map<String, dynamic> json) {
    return Dailtaskmodel(
      title: json['title'],
      description: json['description'],
      startDate: dateFormat.parse(json['startDate'].replaceAll(" UTC+1", "")),
      endDate: dateFormat.parse(json["endDate"].replaceAll(" UTC+1", "")),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "startDate": "${dateFormat.format(startDate)} UTC+1",
      "endDate": "${dateFormat.format(endDate)} UTC+1",
    };
  }

  Dailytask toEntity() {
    return Dailytask(
        title: title,
        description: description,
        startDate: startDate,
        endDate: endDate);
  }

  @override
  List<Object?> get props => [title, description, startDate, endDate];
}
