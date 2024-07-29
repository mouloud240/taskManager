import 'package:task_manager/features/tasks/domain/entities/Task.dart';

class Dailytask extends Task{
  Dailytask({required super.title, required super.description, required super.startDate, required super.endDate ,required super.id,required super.status});
  @override
  String getType() {
    return "Dailytask";
  }

}
