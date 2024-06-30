// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Milk_PD.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MilkPDTestAdapter extends TypeAdapter<Milk_PDTest> {
  @override
  final int typeId = 58;

  @override
  Milk_PDTest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Milk_PDTest(
      HeatDate: fields[0] as dynamic,
      testDate: fields[1] as dynamic,
      TagId: fields[2] as dynamic,
      AIT: fields[3] as dynamic,
      QRCodeResult: fields[4] as dynamic,
      Note: fields[5] as dynamic,
      createdByUser: fields[6] as dynamic,
      id: fields[8] as dynamic,
      SyncStatus: fields[7] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Milk_PDTest obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.HeatDate)
      ..writeByte(1)
      ..write(obj.testDate)
      ..writeByte(2)
      ..write(obj.TagId)
      ..writeByte(3)
      ..write(obj.AIT)
      ..writeByte(4)
      ..write(obj.QRCodeResult)
      ..writeByte(5)
      ..write(obj.Note)
      ..writeByte(6)
      ..write(obj.createdByUser)
      ..writeByte(7)
      ..write(obj.SyncStatus)
      ..writeByte(8)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MilkPDTestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
