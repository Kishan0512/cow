// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_medicineLedger.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MastermedicineLedgerAdapter extends TypeAdapter<Master_medicineLedger> {
  @override
  final int typeId = 23;

  @override
  Master_medicineLedger read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_medicineLedger(
      name: fields[0] as String,
      code: fields[1] as String,
      shortName: fields[2] as String,
      companyName: fields[3] as String,
      dose: fields[4] as dynamic,
      dosageUnit: fields[5] as String,
      minStock: fields[6] as int,
      withdrawPeriod: fields[7] as int,
      medicineCode: fields[8] as int,
      groupCode: fields[9] as String,
      medicineType: fields[10] as int,
      medicineRoute: fields[11] as int,
      id: fields[12] as int,
      createdAt: fields[13] as String,
      updatedAt: fields[14] as String,
      lastUpdatedByUser: fields[15] as int,
      createdByUser: fields[16] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Master_medicineLedger obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.shortName)
      ..writeByte(3)
      ..write(obj.companyName)
      ..writeByte(4)
      ..write(obj.dose)
      ..writeByte(5)
      ..write(obj.dosageUnit)
      ..writeByte(6)
      ..write(obj.minStock)
      ..writeByte(7)
      ..write(obj.withdrawPeriod)
      ..writeByte(8)
      ..write(obj.medicineCode)
      ..writeByte(9)
      ..write(obj.groupCode)
      ..writeByte(10)
      ..write(obj.medicineType)
      ..writeByte(11)
      ..write(obj.medicineRoute)
      ..writeByte(12)
      ..write(obj.id)
      ..writeByte(13)
      ..write(obj.createdAt)
      ..writeByte(14)
      ..write(obj.updatedAt)
      ..writeByte(15)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(16)
      ..write(obj.createdByUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MastermedicineLedgerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
