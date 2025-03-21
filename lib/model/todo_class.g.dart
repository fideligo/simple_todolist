// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoClassAdapter extends TypeAdapter<ToDoClass> {
  @override
  final int typeId = 0;

  @override
  ToDoClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDoClass(
      id: fields[0] as String,
      todoText: fields[1] as String,
      todoType: fields[2] as String,
      isDone: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ToDoClass obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.todoText)
      ..writeByte(2)
      ..write(obj.todoType)
      ..writeByte(3)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
