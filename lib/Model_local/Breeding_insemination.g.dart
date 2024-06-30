// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Breeding_insemination.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BreedinginseminationAdapter extends TypeAdapter<Breeding_insemination> {
  @override
  final int typeId = 47;

  @override
  Breeding_insemination read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Breeding_insemination(
      id: fields[0] as int,
      TagId: fields[1] as String,
      HeatDate: fields[2] as String,
      InseminationTicketNumber: fields[4] as int,
      AIT: fields[8] as String,
      sire: fields[9] as int,
      service: fields[10] as String,
      createdAt: fields[11] as String,
      StrawImage: fields[17] as String,
      BatchNo: fields[18] as String,
      createdByUser: fields[12] as int,
      herd: fields[13] as int,
      lot: fields[14] as int,
      farmer: fields[16] as int,
      SortedSemon: fields[15] as int,
      AICost: fields[19] as int,
      TotalAIDose: fields[5] as int,
      Long: fields[6] as String,
      ENTRY: fields[3] as int,
      SyncStatus: fields[21] as dynamic,
      Lat: fields[7] as String,
      ServerId: fields[20] as String,
      Visit: fields[22] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Breeding_insemination obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.TagId)
      ..writeByte(2)
      ..write(obj.HeatDate)
      ..writeByte(3)
      ..write(obj.ENTRY)
      ..writeByte(4)
      ..write(obj.InseminationTicketNumber)
      ..writeByte(5)
      ..write(obj.TotalAIDose)
      ..writeByte(6)
      ..write(obj.Long)
      ..writeByte(7)
      ..write(obj.Lat)
      ..writeByte(8)
      ..write(obj.AIT)
      ..writeByte(9)
      ..write(obj.sire)
      ..writeByte(10)
      ..write(obj.service)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.createdByUser)
      ..writeByte(13)
      ..write(obj.herd)
      ..writeByte(14)
      ..write(obj.lot)
      ..writeByte(15)
      ..write(obj.SortedSemon)
      ..writeByte(16)
      ..write(obj.farmer)
      ..writeByte(17)
      ..write(obj.StrawImage)
      ..writeByte(18)
      ..write(obj.BatchNo)
      ..writeByte(19)
      ..write(obj.AICost)
      ..writeByte(20)
      ..write(obj.ServerId)
      ..writeByte(21)
      ..write(obj.SyncStatus)
      ..writeByte(22)
      ..write(obj.Visit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BreedinginseminationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
