import 'dart:ui';
import 'package:hive_flutter/hive_flutter.dart';

class ColorAdapter extends TypeAdapter<Color> {
  @override
  int get typeId => 3;
  @override
  read(BinaryReader reader) => Color(reader.readUint32());
  @override
  void write(BinaryWriter writer, Color obj) => writer.writeUint32(obj.value);
}
