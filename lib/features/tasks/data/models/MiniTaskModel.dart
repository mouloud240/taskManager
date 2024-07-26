import 'package:hive/hive.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';
part 'MiniTaskModel.g.dart';
@HiveType(typeId: 2)
class Minitaskmodel extends Minitask with HiveObjectMixin{
  @HiveField(0)
  String name;
  @HiveField(1)
  bool status;
  Minitaskmodel({required this.name, required this.status}) : super(name: name, status: status);
  factory Minitaskmodel.fromEntity(Minitask minitask) {
    return Minitaskmodel(
        name: minitask.name,
        status: minitask.status);
  }
  factory Minitaskmodel.fromJson(Map<String, dynamic> json) {
    return Minitaskmodel(
        name: json['name'],
        status: json['status']);
  }
  Minitask toEntity() {
    return Minitask(
        name: name,
        status: status);
  }
}