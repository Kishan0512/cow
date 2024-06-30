// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Breeding_Dry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BreedingDryAdapter extends TypeAdapter<Breeding_Dry> {
  @override
  final int typeId = 51;

  @override
  Breeding_Dry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Breeding_Dry(
      id: fields[0] as dynamic,
      TagId: fields[1] as dynamic,
      DryDate: fields[2] as dynamic,
      DryReason: fields[3] as dynamic,
      DryTreatment: fields[4] as dynamic,
      OrderNumber: fields[5] as dynamic,
      OTP: fields[6] as dynamic,
      ENTRY: fields[7] as dynamic,
      Lat: fields[8] as dynamic,
      Long: fields[9] as dynamic,
      details: fields[10] as dynamic,
      Staff: fields[11] as dynamic,
      createdAt: fields[12] as dynamic,
      updatedAt: fields[13] as dynamic,
      lastUpdatedByUser: fields[14] as dynamic,
      createdByUser: fields[15] as dynamic,
      herd: fields[16] as dynamic,
      lot: fields[17] as dynamic,
      farmer: fields[18] as dynamic,
      SyncStatus: fields[19] as dynamic,
      ServerId: fields[20] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Breeding_Dry obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.TagId)
      ..writeByte(2)
      ..write(obj.DryDate)
      ..writeByte(3)
      ..write(obj.DryReason)
      ..writeByte(4)
      ..write(obj.DryTreatment)
      ..writeByte(5)
      ..write(obj.OrderNumber)
      ..writeByte(6)
      ..write(obj.OTP)
      ..writeByte(7)
      ..write(obj.ENTRY)
      ..writeByte(8)
      ..write(obj.Lat)
      ..writeByte(9)
      ..write(obj.Long)
      ..writeByte(10)
      ..write(obj.details)
      ..writeByte(11)
      ..write(obj.Staff)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt)
      ..writeByte(14)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(15)
      ..write(obj.createdByUser)
      ..writeByte(16)
      ..write(obj.herd)
      ..writeByte(17)
      ..write(obj.lot)
      ..writeByte(18)
      ..write(obj.farmer)
      ..writeByte(19)
      ..write(obj.SyncStatus)
      ..writeByte(20)
      ..write(obj.ServerId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BreedingDryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
