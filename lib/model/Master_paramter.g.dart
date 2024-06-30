// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_paramter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterparamterAdapter extends TypeAdapter<Master_paramter> {
  @override
  final int typeId = 14;

  @override
  Master_paramter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_paramter(
      heatInterval: fields[0] as int,
      heatIntervalVar: fields[1] as int,
      pD1: fields[2] as int,
      pD1Var: fields[3] as int,
      pD2: fields[4] as int,
      pD2Var: fields[5] as int,
      dried: fields[6] as int,
      driedVar: fields[7] as int,
      insuranceVar: fields[8] as int,
      milkInterval: fields[9] as int,
      heiferMaleAge: fields[10] as int,
      heiferFemaleAge: fields[11] as int,
      repeatBreeding: fields[12] as int,
      conCalv: fields[13] as int,
      calvingInterval: fields[14] as int,
      lactationLength: fields[15] as int,
      expectedFirstService: fields[16] as int,
      peakDays: fields[17] as int,
      openPeriod: fields[18] as int,
      dryPeriod: fields[19] as int,
      tFDays: fields[20] as int,
      calvingDays: fields[21] as int,
      milkProduction: fields[22] as int,
      age: fields[23] as int,
      noAI: fields[24] as int,
      lactation: fields[25] as int,
      firstHeatAfterCalving: fields[26] as int,
      hundredDaysYield: fields[27] as int,
      minStrawStock: fields[28] as int,
      sirePregnancyRate: fields[29] as int,
      snf: fields[30] as int,
      fat: fields[31] as int,
      protein: fields[32] as int,
      lactose: fields[33] as int,
      averageYield: fields[34] as int,
      peakYield: fields[35] as int,
      tFDMilk: fields[36] as int,
      syncID: fields[37] as int,
      breed: fields[38] as int,
      id: fields[39] as int,
      createdAt: fields[40] as String,
      updatedAt: fields[41] as String,
      lastUpdatedByUser: fields[42] as int,
      createdByUser: fields[43] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Master_paramter obj) {
    writer
      ..writeByte(44)
      ..writeByte(0)
      ..write(obj.heatInterval)
      ..writeByte(1)
      ..write(obj.heatIntervalVar)
      ..writeByte(2)
      ..write(obj.pD1)
      ..writeByte(3)
      ..write(obj.pD1Var)
      ..writeByte(4)
      ..write(obj.pD2)
      ..writeByte(5)
      ..write(obj.pD2Var)
      ..writeByte(6)
      ..write(obj.dried)
      ..writeByte(7)
      ..write(obj.driedVar)
      ..writeByte(8)
      ..write(obj.insuranceVar)
      ..writeByte(9)
      ..write(obj.milkInterval)
      ..writeByte(10)
      ..write(obj.heiferMaleAge)
      ..writeByte(11)
      ..write(obj.heiferFemaleAge)
      ..writeByte(12)
      ..write(obj.repeatBreeding)
      ..writeByte(13)
      ..write(obj.conCalv)
      ..writeByte(14)
      ..write(obj.calvingInterval)
      ..writeByte(15)
      ..write(obj.lactationLength)
      ..writeByte(16)
      ..write(obj.expectedFirstService)
      ..writeByte(17)
      ..write(obj.peakDays)
      ..writeByte(18)
      ..write(obj.openPeriod)
      ..writeByte(19)
      ..write(obj.dryPeriod)
      ..writeByte(20)
      ..write(obj.tFDays)
      ..writeByte(21)
      ..write(obj.calvingDays)
      ..writeByte(22)
      ..write(obj.milkProduction)
      ..writeByte(23)
      ..write(obj.age)
      ..writeByte(24)
      ..write(obj.noAI)
      ..writeByte(25)
      ..write(obj.lactation)
      ..writeByte(26)
      ..write(obj.firstHeatAfterCalving)
      ..writeByte(27)
      ..write(obj.hundredDaysYield)
      ..writeByte(28)
      ..write(obj.minStrawStock)
      ..writeByte(29)
      ..write(obj.sirePregnancyRate)
      ..writeByte(30)
      ..write(obj.snf)
      ..writeByte(31)
      ..write(obj.fat)
      ..writeByte(32)
      ..write(obj.protein)
      ..writeByte(33)
      ..write(obj.lactose)
      ..writeByte(34)
      ..write(obj.averageYield)
      ..writeByte(35)
      ..write(obj.peakYield)
      ..writeByte(36)
      ..write(obj.tFDMilk)
      ..writeByte(37)
      ..write(obj.syncID)
      ..writeByte(38)
      ..write(obj.breed)
      ..writeByte(39)
      ..write(obj.id)
      ..writeByte(40)
      ..write(obj.createdAt)
      ..writeByte(41)
      ..write(obj.updatedAt)
      ..writeByte(42)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(43)
      ..write(obj.createdByUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasterparamterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
