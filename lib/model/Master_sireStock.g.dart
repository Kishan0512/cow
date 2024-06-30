// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_sireStock.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MastersireStockAdapter extends TypeAdapter<Master_sireStock> {
  @override
  final int typeId = 29;

  @override
  Master_sireStock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_sireStock(
      name: fields[0] as String,
      code: fields[1] as String,
      dob: fields[2] as String,
      birthWeight: fields[3] as int,
      naturalOrAIBirth: fields[4] as int,
      allowAllUser: fields[5] as bool,
      isSuspended: fields[6] as bool,
      sID: fields[7] as String,
      sireIndex: fields[8] as String,
      mID: fields[9] as String,
      motherMilkYield: fields[10] as int,
      minStrawStock: fields[11] as int,
      breed: fields[12] as int,
      source: fields[13] as String,
      iD: fields[14] as int,
      createdAt: fields[15] as String,
      updatedAt: fields[16] as String,
      lastUpdatedByUser: fields[17] as int,
      createdByUser: fields[18] as int,
      Syncstatus: fields[19] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Master_sireStock obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.dob)
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
      ..write(obj.iD)
      ..writeByte(15)
      ..write(obj.createdAt)
      ..writeByte(16)
      ..write(obj.updatedAt)
      ..writeByte(17)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(18)
      ..write(obj.createdByUser)
      ..writeByte(19)
      ..write(obj.Syncstatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MastersireStockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
