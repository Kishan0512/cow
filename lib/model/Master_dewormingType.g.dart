// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_dewormingType.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterdewormingTypeAdapter extends TypeAdapter<Master_dewormingType> {
  @override
  final int typeId = 20;

  @override
  Master_dewormingType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_dewormingType(
      name: fields[0] as String,
      periodInDays: fields[1] as int,
      id: fields[2] as int,
      createdAt: fields[3] as String,
      updatedAt: fields[4] as String,
      lastUpdatedByUser: fields[5] as int,
      createdByUser: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Master_dewormingType obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.periodInDays)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(6)
      ..write(obj.createdByUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasterdewormingTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}