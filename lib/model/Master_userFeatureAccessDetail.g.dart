// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_userFeatureAccessDetail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasteruserFeatureAccessDetailAdapter
    extends TypeAdapter<Master_userFeatureAccessDetail> {
  @override
  final int typeId = 28;

  @override
  Master_userFeatureAccessDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_userFeatureAccessDetail(
      user: fields[0] as int,
      feature: fields[1] as int,
      canCreate: fields[2] as bool,
      canView: fields[3] as bool,
      canEdit: fields[4] as bool,
      canDelete: fields[5] as bool,
      combinedPermissionValue: fields[6] as int,
      id: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Master_userFeatureAccessDetail obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.feature)
      ..writeByte(2)
      ..write(obj.canCreate)
      ..writeByte(3)
      ..write(obj.canView)
      ..writeByte(4)
      ..write(obj.canEdit)
      ..writeByte(5)
      ..write(obj.canDelete)
      ..writeByte(6)
      ..write(obj.combinedPermissionValue)
      ..writeByte(7)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasteruserFeatureAccessDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
