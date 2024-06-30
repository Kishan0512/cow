// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_sire.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MastersireAdapter extends TypeAdapter<Master_sire> {
  @override
  final int typeId = 16;

  @override
  Master_sire read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_sire(
      name: fields[0] as dynamic,
      code: fields[1] as dynamic,
      dOB: fields[2] as dynamic,
      birthWeight: fields[3] as dynamic,
      naturalOrAIBirth: fields[4] as dynamic,
      allowAllUser: fields[5] as dynamic,
      isSuspended: fields[6] as dynamic,
      sID: fields[7] as dynamic,
      sireIndex: fields[8] as dynamic,
      mID: fields[9] as dynamic,
      motherMilkYield: fields[10] as dynamic,
      minStrawStock: fields[11] as dynamic,
      breed: fields[12] as dynamic,
      source: fields[13] as dynamic,
      id: fields[14] as dynamic,
      createdAt: fields[15] as dynamic,
      updatedAt: fields[16] as dynamic,
      lastUpdatedByUser: fields[17] as dynamic,
      createdByUser: fields[18] as dynamic,
      normalCost: fields[19] as dynamic,
      deductionCode: fields[20] as dynamic,
      Syncstatus: fields[22] as dynamic,
      Selected: fields[23] as dynamic,
      unknownsire: fields[21] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Master_sire obj) {
    writer
      ..writeByte(24)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.dOB)
      ..writeByte(3)
      ..write(obj.birthWeight)
      ..writeByte(4)
      ..write(obj.naturalOrAIBirth)
      ..writeByte(5)
      ..write(obj.allowAllUser)
      ..writeByte(6)
      ..write(obj.isSuspended)
      ..writeByte(7)
      ..write(obj.sID)
      ..writeByte(8)
      ..write(obj.sireIndex)
      ..writeByte(9)
      ..write(obj.mID)
      ..writeByte(10)
      ..write(obj.motherMilkYield)
      ..writeByte(11)
      ..write(obj.minStrawStock)
      ..writeByte(12)
      ..write(obj.breed)
      ..writeByte(13)
      ..write(obj.source)
      ..writeByte(14)
      ..write(obj.id)
      ..writeByte(15)
      ..write(obj.createdAt)
      ..writeByte(16)
      ..write(obj.updatedAt)
      ..writeByte(17)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(18)
      ..write(obj.createdByUser)
      ..writeByte(19)
      ..write(obj.normalCost)
      ..writeByte(20)
      ..write(obj.deductionCode)
      ..writeByte(21)
      ..write(obj.unknownsire)
      ..writeByte(22)
      ..write(obj.Syncstatus)
      ..writeByte(23)
      ..write(obj.Selected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MastersireAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
