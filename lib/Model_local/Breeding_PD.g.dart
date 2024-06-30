// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Breeding_PD.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BreedingPDAdapter extends TypeAdapter<Breeding_PD> {
  @override
  final int typeId = 52;

  @override
  Breeding_PD read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Breeding_PD(
      result: fields[21] as dynamic,
      ServerId: fields[20] as dynamic,
      id: fields[0] as dynamic,
      SyncStatus: fields[19] as dynamic,
      AIT: fields[5] as dynamic,
      lastUpdatedByUser: fields[6] as dynamic,
      createdByUser: fields[7] as dynamic,
      herd: fields[8] as dynamic,
      lot: fields[9] as dynamic,
      farmer: fields[10] as dynamic,
      TagId: fields[11] as dynamic,
      PDDate: fields[12] as dynamic,
      ENTRY: fields[13] as dynamic,
      Lat: fields[14] as dynamic,
      Long: fields[15] as dynamic,
      createdAt: fields[16] as dynamic,
      visit: fields[22] as dynamic,
      updatedAt: fields[18] as dynamic,
    )
      ..PDTicketNumber = fields[1] as dynamic
      ..details = fields[2] as dynamic
      ..Reproduction = fields[3] as dynamic
      ..OTP = fields[4] as dynamic
      ..OrderNumber = fields[17] as dynamic;
  }

  @override
  void write(BinaryWriter writer, Breeding_PD obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.PDTicketNumber)
      ..writeByte(2)
      ..write(obj.details)
      ..writeByte(3)
      ..write(obj.Reproduction)
      ..writeByte(4)
      ..write(obj.OTP)
      ..writeByte(5)
      ..write(obj.AIT)
      ..writeByte(6)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(7)
      ..write(obj.createdByUser)
      ..writeByte(8)
      ..write(obj.herd)
      ..writeByte(9)
      ..write(obj.lot)
      ..writeByte(10)
      ..write(obj.farmer)
      ..writeByte(11)
      ..write(obj.TagId)
      ..writeByte(12)
      ..write(obj.PDDate)
      ..writeByte(13)
      ..write(obj.ENTRY)
      ..writeByte(14)
      ..write(obj.Lat)
      ..writeByte(15)
      ..write(obj.Long)
      ..writeByte(16)
      ..write(obj.createdAt)
      ..writeByte(17)
      ..write(obj.OrderNumber)
      ..writeByte(18)
      ..write(obj.updatedAt)
      ..writeByte(19)
      ..write(obj.SyncStatus)
      ..writeByte(20)
      ..write(obj.ServerId)
      ..writeByte(21)
      ..write(obj.result)
      ..writeByte(22)
      ..write(obj.visit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BreedingPDAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
