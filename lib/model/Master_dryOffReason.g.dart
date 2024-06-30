// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_dryOffReason.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterdryOffReasonAdapter extends TypeAdapter<Master_dryOffReason> {
  @override
  final int typeId = 13;

  @override
  Master_dryOffReason read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_dryOffReason(
      name: fields[0] as String,
      id: fields[1] as int,
      createdAt: fields[2] as String,
      updatedAt: fields[3] as String,
      createdByUser: fields[4] as int,
      lastUpdatedByUser: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Master_dryOffReason obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.updatedAt)
      ..writeByte(4)
      ..write(obj.createdByUser)
      ..writeByte(5)
      ..write(obj.lastUpdatedByUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasterdryOffReasonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
