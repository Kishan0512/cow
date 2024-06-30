// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Breeding_Abortion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BreedingAbortionAdapter extends TypeAdapter<Breeding_Abortion> {
  @override
  final int typeId = 49;

  @override
  Breeding_Abortion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Breeding_Abortion(
      id: fields[0] as dynamic,
      TagId: fields[1] as dynamic,
      AbortionDate: fields[2] as dynamic,
      AbortionSeq: fields[3] as dynamic,
      OrderNumber: fields[4] as dynamic,
      OTP: fields[5] as dynamic,
      ENTRY: fields[6] as dynamic,
      Lat: fields[7] as dynamic,
      Long: fields[8] as dynamic,
      details: fields[9] as dynamic,
      createdAt: fields[10] as dynamic,
      updatedAt: fields[11] as dynamic,
      lastUpdatedByUser: fields[12] as dynamic,
      createdByUser: fields[13] as dynamic,
      herd: fields[14] as dynamic,
      lot: fields[15] as dynamic,
      SyncStatus: fields[17] as dynamic,
      visit: fields[19] as dynamic,
      ServerId: fields[18] as dynamic,
      farmer: fields[16] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Breeding_Abortion obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.TagId)
      ..writeByte(2)
      ..write(obj.AbortionDate)
      ..writeByte(3)
      ..write(obj.AbortionSeq)
      ..writeByte(4)
      ..write(obj.OrderNumber)
      ..writeByte(5)
      ..write(obj.OTP)
      ..writeByte(6)
      ..write(obj.ENTRY)
      ..writeByte(7)
      ..write(obj.Lat)
      ..writeByte(8)
      ..write(obj.Long)
      ..writeByte(9)
      ..write(obj.details)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt)
      ..writeByte(12)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(13)
      ..write(obj.createdByUser)
      ..writeByte(14)
      ..write(obj.herd)
      ..writeByte(15)
      ..write(obj.lot)
      ..writeByte(16)
      ..write(obj.farmer)
      ..writeByte(17)
      ..write(obj.SyncStatus)
      ..writeByte(18)
      ..write(obj.ServerId)
      ..writeByte(19)
      ..write(obj.visit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BreedingAbortionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
