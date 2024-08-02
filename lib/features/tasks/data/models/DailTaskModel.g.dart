// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DailTaskModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailtaskmodelAdapter extends TypeAdapter<Dailtaskmodel> {
  @override
  final int typeId = 1;

  @override
  Dailtaskmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dailtaskmodel(
      title: fields[0] as String,
      description: fields[1] as String,
      startDate: fields[2] as DateTime,
      endDate: fields[3] as DateTime,
      id: fields[4] as String,
      status: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Dailtaskmodel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailtaskmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
