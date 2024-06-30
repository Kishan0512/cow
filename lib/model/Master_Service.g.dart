// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_Service.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterserviceAdapter extends TypeAdapter<Master_service> {
  @override
  final int typeId = 4;

  @override
  Master_service read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_service(
      name: fields[0] as String,
      id: fields[1] as int,
      createdAt: fields[2] as String,
      updatedAt: fields[3] as String,
      lastUpdatedByUser: fields[4] as int,
      createdByUser: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Master_service obj) {
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
      ..write(obj.lastUpdatedByUser)
      ..writeByte(5)
      ..write(obj.createdByUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasterserviceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
