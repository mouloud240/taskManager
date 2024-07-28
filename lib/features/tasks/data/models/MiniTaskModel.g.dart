// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MiniTaskModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MinitaskmodelAdapter extends TypeAdapter<Minitaskmodel> {
  @override
  final int typeId = 2;

  @override
  Minitaskmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Minitaskmodel(
      name: fields[0] as String,
      status: fields[1] as bool,
      id: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Minitaskmodel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MinitaskmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
