import 'package:hive/hive.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';

part 'DailTaskModel.g.dart';
@HiveType(typeId: 1)

class Dailtaskmodel extends Dailytask with HiveObjectMixin {
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
      required this.endDate}) : super(title:title, description:description, startDate: startDate, endDate: endDate);

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
        startDate: json['startDate'],
        endDate: json['endDate']);
  }
  Dailytask toEntity() {
    return Dailytask(
        title: title,
        description: description,
        startDate: startDate,
        endDate: endDate);
  }
}
