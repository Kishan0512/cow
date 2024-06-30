// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_smsSetting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MastersmsSettingAdapter extends TypeAdapter<Master_smsSetting> {
  @override
  final int typeId = 19;

  @override
  Master_smsSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_smsSetting(
      task: fields[0] as String,
      fromDays: fields[1] as int,
      toDays: fields[2] as int,
      orderNo: fields[3] as int,
      doctor: fields[4] as int,
      farmer: fields[5] as int,
      id: fields[6] as int,
      createdAt: fields[7] as String,
      updatedAt: fields[8] as String,
      lastUpdatedByUser: fields[9] as int,
      createdByUser: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Master_smsSetting obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.task)
      ..writeByte(1)
      ..write(obj.fromDays)
      ..writeByte(2)
      ..write(obj.toDays)
      ..writeByte(3)
      ..write(obj.orderNo)
      ..writeByte(4)
      ..write(obj.doctor)
      ..writeByte(5)
      ..write(obj.farmer)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(10)
      ..write(obj.createdByUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MastersmsSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
