// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Milk_production_id.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MilkproductionidAdapter extends TypeAdapter<Milk_production_id> {
  @override
  final int typeId = 43;

  @override
  Milk_production_id read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Milk_production_id(
      tagId: fields[0] as dynamic,
      date: fields[1] as dynamic,
      parity: fields[2] as dynamic,
      morningYield: fields[3] as dynamic,
      eveningYield: fields[4] as dynamic,
      nightYield: fields[5] as dynamic,
      midnightYield: fields[6] as dynamic,
      fat: fields[7] as dynamic,
      snf: fields[8] as dynamic,
      lactose: fields[9] as dynamic,
      protein: fields[10] as dynamic,
      fatC: fields[11] as dynamic,
      snfC: fields[12] as dynamic,
      lactoseC: fields[13] as dynamic,
      proteinC: fields[14] as dynamic,
      cumulativeMilkTotal: fields[15] as dynamic,
      lactationMilkTotal: fields[16] as dynamic,
      daysCount: fields[17] as dynamic,
      officialMilk: fields[18] as dynamic,
      lat: fields[19] as dynamic,
      long: fields[20] as dynamic,
      dayMilkTotal: fields[21] as dynamic,
      details: fields[22] as dynamic,
      id: fields[23] as dynamic,
      herd: fields[24] as dynamic,
      lot: fields[25] as dynamic,
      farmer: fields[26] as dynamic,
      boxno: fields[27] as dynamic,
      bottleno: fields[28] as dynamic,
      staff: fields[29] as dynamic,
      SyncStatus: fields[32] as dynamic,
      clientID: fields[31] as dynamic,
      serverID: fields[30] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Milk_production_id obj) {
    writer
      ..writeByte(33)
      ..writeByte(0)
      ..write(obj.tagId)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.parity)
      ..writeByte(3)
      ..write(obj.morningYield)
      ..writeByte(4)
      ..write(obj.eveningYield)
      ..writeByte(5)
      ..write(obj.nightYield)
      ..writeByte(6)
      ..write(obj.midnightYield)
      ..writeByte(7)
      ..write(obj.fat)
      ..writeByte(8)
      ..write(obj.snf)
      ..writeByte(9)
      ..write(obj.lactose)
      ..writeByte(10)
      ..write(obj.protein)
      ..writeByte(11)
      ..write(obj.fatC)
      ..writeByte(12)
      ..write(obj.snfC)
      ..writeByte(13)
      ..write(obj.lactoseC)
      ..writeByte(14)
      ..write(obj.proteinC)
      ..writeByte(15)
      ..write(obj.cumulativeMilkTotal)
      ..writeByte(16)
      ..write(obj.lactationMilkTotal)
      ..writeByte(17)
      ..write(obj.daysCount)
      ..writeByte(18)
      ..write(obj.officialMilk)
      ..writeByte(19)
      ..write(obj.lat)
      ..writeByte(20)
      ..write(obj.long)
      ..writeByte(21)
      ..write(obj.dayMilkTotal)
      ..writeByte(22)
      ..write(obj.details)
      ..writeByte(23)
      ..write(obj.id)
      ..writeByte(24)
      ..write(obj.herd)
      ..writeByte(25)
      ..write(obj.lot)
      ..writeByte(26)
      ..write(obj.farmer)
      ..writeByte(27)
      ..write(obj.boxno)
      ..writeByte(28)
      ..write(obj.bottleno)
      ..writeByte(29)
      ..write(obj.staff)
      ..writeByte(30)
      ..write(obj.serverID)
      ..writeByte(31)
      ..write(obj.clientID)
      ..writeByte(32)
      ..write(obj.SyncStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MilkproductionidAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
