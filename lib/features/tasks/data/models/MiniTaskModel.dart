import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:task_manager/features/tasks/domain/entities/miniTask.dart';
part 'MiniTaskModel.g.dart';

@HiveType(typeId: 2)
class Minitaskmodel extends Minitask with HiveObjectMixin, EquatableMixin {
  @HiveField(0)
  String name;
  @HiveField(1)
  bool status;
  @HiveField(2)
  int id;
  Minitaskmodel({required this.name, this.status = false, required this.id})
      : super(name: name, status: status, id: id);
  factory Minitaskmodel.fromEntity(Minitask minitask) {
    return Minitaskmodel(
        name: minitask.name, status: minitask.status, id: minitask.id);
  }
  factory Minitaskmodel.fromJson(Map<String, dynamic> json) {
    return Minitaskmodel(
        name: json['name'], status: json['status'], id: json["id"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "status": status,
      "id": id,
    };
  }

  Minitask toEntity() {
    return Minitask(name: name, status: status, id: id);
  }

  @override
  List<Object?> get props => [name, status];
}
