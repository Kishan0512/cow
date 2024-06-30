// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_UserLots.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterUserlotsAdapter extends TypeAdapter<Master_Userlots> {
  @override
  final int typeId = 1;

  @override
  Master_Userlots read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_Userlots(
      name: fields[0] as dynamic,
      code: fields[1] as dynamic,
      lotcode: fields[2] as dynamic,
      note: fields[3] as dynamic,
      isSuspended: fields[4] as bool,
      lat: fields[5] as dynamic,
      lng: fields[6] as dynamic,
      weekDay: fields[7] as dynamic,
      fromTime: fields[8] as dynamic,
      toTime: fields[9] as dynamic,
      herd: fields[10] as dynamic,
      id: fields[11] as dynamic,
      createdAt: fields[12] as dynamic,
      updatedAt: fields[13] as dynamic,
      lastUpdatedByUser: fields[14] as dynamic,
      createdByUser: fields[15] as dynamic,
      village: fields[16] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Master_Userlots obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.lotcode)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.isSuspended)
      ..writeByte(5)
      ..write(obj.lat)
      ..writeByte(6)
      ..write(obj.lng)
      ..writeByte(7)
      ..write(obj.weekDay)
      ..writeByte(8)
      ..write(obj.fromTime)
      ..writeByte(9)
      ..write(obj.toTime)
      ..writeByte(10)
      ..write(obj.herd)
      ..writeByte(11)
      ..write(obj.id)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt)
      ..writeByte(14)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(15)
      ..write(obj.createdByUser)
      ..writeByte(16)
      ..write(obj.village);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasterUserlotsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
