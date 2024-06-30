// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_UserHerds.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterUserHerdsAdapter extends TypeAdapter<Master_UserHerds> {
  @override
  final int typeId = 0;

  @override
  Master_UserHerds read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_UserHerds(
      Name: fields[0] as String,
      code: fields[1] as String,
      IsSuspended: fields[2] as bool,
      Lat: fields[3] as dynamic,
      cc: fields[4] as int,
      Lng: fields[6] as dynamic,
      zone: fields[5] as int,
      managerStaff: fields[7] as int,
      extensionOfficerStaff: fields[10] as int,
      createdByUser: fields[8] as int,
      lastUpdatedByUser: fields[9] as int,
      company: fields[11] as int,
      id: fields[12] as int,
      createdAt: fields[13] as String,
      updatedAt: fields[14] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Master_UserHerds obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.Name)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.IsSuspended)
      ..writeByte(3)
      ..write(obj.Lat)
      ..writeByte(4)
      ..write(obj.cc)
      ..writeByte(5)
      ..write(obj.zone)
      ..writeByte(6)
      ..write(obj.Lng)
      ..writeByte(7)
      ..write(obj.managerStaff)
      ..writeByte(8)
      ..write(obj.createdByUser)
      ..writeByte(9)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(10)
      ..write(obj.extensionOfficerStaff)
      ..writeByte(11)
      ..write(obj.company)
      ..writeByte(12)
      ..write(obj.id)
      ..writeByte(13)
      ..write(obj.createdAt)
      ..writeByte(14)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasterUserHerdsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
