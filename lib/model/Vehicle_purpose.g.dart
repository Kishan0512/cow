// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Vehicle_purpose.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehiclepurposeAdapter extends TypeAdapter<Vehicle_purpose> {
  @override
  final int typeId = 45;

  @override
  Vehicle_purpose read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vehicle_purpose(
      iD: fields[0] as dynamic,
      visitPurpose: fields[1] as dynamic,
      registrationDate: fields[2] as dynamic,
      createdAt: fields[3] as dynamic,
      updatedAt: fields[4] as dynamic,
      lastUpdatedByUser: fields[5] as dynamic,
      createdByUser: fields[6] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Vehicle_purpose obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.iD)
      ..writeByte(1)
      ..write(obj.visitPurpose)
      ..writeByte(2)
      ..write(obj.registrationDate)
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
      other is VehiclepurposeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
