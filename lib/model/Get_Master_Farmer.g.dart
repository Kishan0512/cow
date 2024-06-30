// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Get_Master_Farmer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetMasterFarmerAdapter extends TypeAdapter<Get_Master_Farmer> {
  @override
  final int typeId = 55;

  @override
  Get_Master_Farmer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Get_Master_Farmer(
      dCSCode: fields[0] as dynamic,
      code: fields[1] as dynamic,
      name: fields[2] as dynamic,
      middleName: fields[3] as dynamic,
      lastName: fields[4] as dynamic,
      mobile: fields[5] as dynamic,
      producerCode: fields[6] as dynamic,
      sAPcode: fields[7] as dynamic,
      lot: fields[8] as dynamic,
      id: fields[9] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Get_Master_Farmer obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.dCSCode)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.middleName)
      ..writeByte(4)
      ..write(obj.lastName)
      ..writeByte(5)
      ..write(obj.mobile)
      ..writeByte(6)
      ..write(obj.producerCode)
      ..writeByte(7)
      ..write(obj.sAPcode)
      ..writeByte(8)
      ..write(obj.lot)
      ..writeByte(9)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetMasterFarmerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
