// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Bredding_Calving.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BreedingCalvingAdapter extends TypeAdapter<Breeding_Calving> {
  @override
  final int typeId = 53;

  @override
  Breeding_Calving read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Breeding_Calving(
      id: fields[0] as dynamic,
      TagId: fields[1] as dynamic,
      CalvingDate: fields[2] as dynamic,
      Comments: fields[3] as dynamic,
      ReproductionProblemNote: fields[4] as dynamic,
      CalvingTicketNumber: fields[5] as dynamic,
      OrderNumber: fields[6] as dynamic,
      OTP: fields[7] as dynamic,
      ENTRY: fields[8] as dynamic,
      Lat: fields[9] as dynamic,
      Long: fields[10] as dynamic,
      details: fields[11] as dynamic,
      Sex: fields[12] as dynamic,
      CalfSex: fields[13] as dynamic,
      CalvingType: fields[14] as dynamic,
      calvingTypeOption: fields[15] as dynamic,
      staff: fields[16] as dynamic,
      createdAt: fields[17] as dynamic,
      updatedAt: fields[18] as dynamic,
      lastUpdatedByUser: fields[19] as dynamic,
      createdByUser: fields[20] as dynamic,
      herd: fields[21] as dynamic,
      lot: fields[22] as dynamic,
      farmer: fields[23] as dynamic,
      CalfID: fields[24] as dynamic,
      Calf2Sex: fields[25] as dynamic,
      Calf2ID: fields[26] as dynamic,
      image1: fields[27] as dynamic,
      image2: fields[28] as dynamic,
      SyncStatus: fields[29] as dynamic,
      ServerId: fields[30] as dynamic,
      visit: fields[31] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Breeding_Calving obj) {
    writer
      ..writeByte(32)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.TagId)
      ..writeByte(2)
      ..write(obj.CalvingDate)
      ..writeByte(3)
      ..write(obj.Comments)
      ..writeByte(4)
      ..write(obj.ReproductionProblemNote)
      ..writeByte(5)
      ..write(obj.CalvingTicketNumber)
      ..writeByte(6)
      ..write(obj.OrderNumber)
      ..writeByte(7)
      ..write(obj.OTP)
      ..writeByte(8)
      ..write(obj.ENTRY)
      ..writeByte(9)
      ..write(obj.Lat)
      ..writeByte(10)
      ..write(obj.Long)
      ..writeByte(11)
      ..write(obj.details)
      ..writeByte(12)
      ..write(obj.Sex)
      ..writeByte(13)
      ..write(obj.CalfSex)
      ..writeByte(14)
      ..write(obj.CalvingType)
      ..writeByte(15)
      ..write(obj.calvingTypeOption)
      ..writeByte(16)
      ..write(obj.staff)
      ..writeByte(17)
      ..write(obj.createdAt)
      ..writeByte(18)
      ..write(obj.updatedAt)
      ..writeByte(19)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(20)
      ..write(obj.createdByUser)
      ..writeByte(21)
      ..write(obj.herd)
      ..writeByte(22)
      ..write(obj.lot)
      ..writeByte(23)
      ..write(obj.farmer)
      ..writeByte(24)
      ..write(obj.CalfID)
      ..writeByte(25)
      ..write(obj.Calf2Sex)
      ..writeByte(26)
      ..write(obj.Calf2ID)
      ..writeByte(27)
      ..write(obj.image1)
      ..writeByte(28)
      ..write(obj.image2)
      ..writeByte(29)
      ..write(obj.SyncStatus)
      ..writeByte(30)
      ..write(obj.ServerId)
      ..writeByte(31)
      ..write(obj.visit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BreedingCalvingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
