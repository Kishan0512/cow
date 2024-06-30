// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_feature.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterfeatureAdapter extends TypeAdapter<Master_feature> {
  @override
  final int typeId = 27;

  @override
  Master_feature read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_feature(
      name: fields[0] as String,
      grouping: fields[1] as String,
      id: fields[2] as int,
      createdAt: fields[3] as String,
      updatedAt: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Master_feature obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.grouping)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasterfeatureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
