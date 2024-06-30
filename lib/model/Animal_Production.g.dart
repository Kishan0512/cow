// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Animal_Production.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalProductionAdapter extends TypeAdapter<Animal_Production> {
  @override
  final int typeId = 35;

  @override
  Animal_Production read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Animal_Production(
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
      solidsc: fields[18] as dynamic,
      solids: fields[19] as dynamic,
      eFAT: fields[20] as dynamic,
      eSNF: fields[21] as dynamic,
      nFAT: fields[22] as dynamic,
      nSNF: fields[23] as dynamic,
      mFAT: fields[24] as dynamic,
      mSNF: fields[25] as dynamic,
      cLR: fields[26] as dynamic,
      cFU: fields[27] as dynamic,
      acidity: fields[28] as dynamic,
      officialMilk: fields[29] as dynamic,
      lat: fields[30] as dynamic,
      long: fields[31] as dynamic,
      dayMilkTotal: fields[32] as dynamic,
      details: fields[33] as dynamic,
      managerStaff: fields[34] as dynamic,
      extensionOfficerStaff: fields[35] as dynamic,
      zone: fields[36] as dynamic,
      id: fields[37] as dynamic,
      createdAt: fields[38] as dynamic,
      updatedAt: fields[39] as dynamic,
      lastUpdatedByUser: fields[40] as dynamic,
      createdByUser: fields[41] as dynamic,
      herd: fields[42] as dynamic,
      lot: fields[43] as dynamic,
      farmer: fields[44] as dynamic,
      boxno: fields[45] as dynamic,
      bottleno: fields[46] as dynamic,
      staff: fields[47] as dynamic,
      serverID: fields[48] as dynamic,
      clientID: fields[49] as dynamic,
      SyncStatus: fields[50] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Animal_Production obj) {
    writer
      ..writeByte(51)
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
      ..write(obj.solidsc)
      ..writeByte(19)
      ..write(obj.solids)
      ..writeByte(20)
      ..write(obj.eFAT)
      ..writeByte(21)
      ..write(obj.eSNF)
      ..writeByte(22)
      ..write(obj.nFAT)
      ..writeByte(23)
      ..write(obj.nSNF)
      ..writeByte(24)
      ..write(obj.mFAT)
      ..writeByte(25)
      ..write(obj.mSNF)
      ..writeByte(26)
      ..write(obj.cLR)
      ..writeByte(27)
      ..write(obj.cFU)
      ..writeByte(28)
      ..write(obj.acidity)
      ..writeByte(29)
      ..write(obj.officialMilk)
      ..writeByte(30)
      ..write(obj.lat)
      ..writeByte(31)
      ..write(obj.long)
      ..writeByte(32)
      ..write(obj.dayMilkTotal)
      ..writeByte(33)
      ..write(obj.details)
      ..writeByte(34)
      ..write(obj.managerStaff)
      ..writeByte(35)
      ..write(obj.extensionOfficerStaff)
      ..writeByte(36)
      ..write(obj.zone)
      ..writeByte(37)
      ..write(obj.id)
      ..writeByte(38)
      ..write(obj.createdAt)
      ..writeByte(39)
      ..write(obj.updatedAt)
      ..writeByte(40)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(41)
      ..write(obj.createdByUser)
      ..writeByte(42)
      ..write(obj.herd)
      ..writeByte(43)
      ..write(obj.lot)
      ..writeByte(44)
      ..write(obj.farmer)
      ..writeByte(45)
      ..write(obj.boxno)
      ..writeByte(46)
      ..write(obj.bottleno)
      ..writeByte(47)
      ..write(obj.staff)
      ..writeByte(48)
      ..write(obj.serverID)
      ..writeByte(49)
      ..write(obj.clientID)
      ..writeByte(50)
      ..write(obj.SyncStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalProductionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
