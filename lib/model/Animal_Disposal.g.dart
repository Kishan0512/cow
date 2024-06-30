// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Animal_Disposal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalDisposalAdapter extends TypeAdapter<Animal_Disposal> {
  @override
  final int typeId = 32;

  @override
  Animal_Disposal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Animal_Disposal(
      SyncStatus: fields[19] as dynamic,
      oldTagId: fields[0] as dynamic,
      tagId: fields[1] as dynamic,
      date: fields[2] as dynamic,
      soldTo: fields[3] as dynamic,
      soldPrice: fields[4] as dynamic,
      herd: fields[5] as dynamic,
      lot: fields[6] as dynamic,
      farmer: fields[7] as dynamic,
      oldDetails: fields[8] as dynamic,
      details: fields[9] as dynamic,
      disposalReason: fields[10] as dynamic,
      diedReason: fields[11] as dynamic,
      id: fields[12] as dynamic,
      createdAt: fields[13] as dynamic,
      updatedAt: fields[14] as dynamic,
      lastUpdatedByUser: fields[15] as dynamic,
      createdByUser: fields[16] as dynamic,
      staff: fields[17] as dynamic,
      disposaltype: fields[18] as dynamic,
      ServerId: fields[20] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Animal_Disposal obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.oldTagId)
      ..writeByte(1)
      ..write(obj.tagId)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.soldTo)
      ..writeByte(4)
      ..write(obj.soldPrice)
      ..writeByte(5)
      ..write(obj.herd)
      ..writeByte(6)
      ..write(obj.lot)
      ..writeByte(7)
      ..write(obj.farmer)
      ..writeByte(8)
      ..write(obj.oldDetails)
      ..writeByte(9)
      ..write(obj.details)
      ..writeByte(10)
      ..write(obj.disposalReason)
      ..writeByte(11)
      ..write(obj.diedReason)
      ..writeByte(12)
      ..write(obj.id)
      ..writeByte(13)
      ..write(obj.createdAt)
      ..writeByte(14)
      ..write(obj.updatedAt)
      ..writeByte(15)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(16)
      ..write(obj.createdByUser)
      ..writeByte(17)
      ..write(obj.staff)
      ..writeByte(18)
      ..write(obj.disposaltype)
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
      other is AnimalDisposalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
