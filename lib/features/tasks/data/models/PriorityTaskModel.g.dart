// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PriorityTaskModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrioritytaskmodelAdapter extends TypeAdapter<Prioritytaskmodel> {
  @override
  final int typeId = 3;

  @override
  Prioritytaskmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Prioritytaskmodel(
      icon: fields[5] as Icon,
      title: fields[0] as String,
      description: fields[1] as String,
      startDate: fields[2] as DateTime,
      endDate: fields[3] as DateTime,
      miniTasks: (fields[4] as Map).cast<String, Minitaskmodel>(),
      id: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Prioritytaskmodel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.miniTasks)
      ..writeByte(5)
      ..write(obj.icon)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrioritytaskmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
