// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_vaccinationType.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MastervaccinationTypeAdapter extends TypeAdapter<Master_vaccinationType> {
  @override
  final int typeId = 17;

  @override
  Master_vaccinationType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_vaccinationType(
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
  void write(BinaryWriter writer, Master_vaccinationType obj) {
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
      other is MastervaccinationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
