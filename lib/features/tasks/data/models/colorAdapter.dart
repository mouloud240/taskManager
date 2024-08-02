import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class MyColorAdapter extends TypeAdapter<Color> {
  @override
  final typeId = 11; // Assign a unique type ID

  @override
  Color read(BinaryReader reader) {
    int value = reader.readInt();
    return Color(value);
  }

  @override
  void write(BinaryWriter writer, Color color) {
    writer.writeInt(color.value);
  }
}
