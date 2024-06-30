// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_diagnosis.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterdiagnosisAdapter extends TypeAdapter<Master_diagnosis> {
  @override
  final int typeId = 26;

  @override
  Master_diagnosis read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_diagnosis(
      name: fields[0] as String,
      systemAffected: fields[1] as int,
      id: fields[2] as int,
      createdAt: fields[3] as String,
      updatedAt: fields[4] as String,
      lastUpdatedByUser: fields[5] as int,
      createdByUser: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Master_diagnosis obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.systemAffected)
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
      other is MasterdiagnosisAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
