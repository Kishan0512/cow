// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Animal_weight_entry_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalweightentrymodelAdapter
    extends TypeAdapter<Animal_weight_entry_model> {
  @override
  final int typeId = 39;

  @override
  Animal_weight_entry_model read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Animal_weight_entry_model(
      TagId: fields[0] as String,
      Date: fields[1] as String,
      ChestGirth: fields[2] as String,
      Weight: fields[3] as String,
      Length: fields[4] as String,
      WeightGain: fields[5] as String,
      AutoNo: fields[6] as int,
      details: fields[7] as int,
      SyncStatus: fields[8] as String,
      id: fields[9] as int,
      createdAt: fields[10] as String,
      updatedAt: fields[11] as String,
      lastUpdatedByUser: fields[12] as int,
      createdByUser: fields[13] as int,
      Lat: fields[14] as String,
      Long: fields[15] as String,
      managerStaff: fields[16] as int,
      extensionOfficerStaff: fields[17] as int,
      zone: fields[18] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Animal_weight_entry_model obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.TagId)
      ..writeByte(1)
      ..write(obj.Date)
      ..writeByte(2)
      ..write(obj.ChestGirth)
      ..writeByte(3)
      ..write(obj.Weight)
      ..writeByte(4)
      ..write(obj.Length)
      ..writeByte(5)
      ..write(obj.WeightGain)
      ..writeByte(6)
      ..write(obj.AutoNo)
      ..writeByte(7)
      ..write(obj.details)
      ..writeByte(8)
      ..write(obj.SyncStatus)
      ..writeByte(9)
      ..write(obj.id)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt)
      ..writeByte(12)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(13)
      ..write(obj.createdByUser)
      ..writeByte(14)
      ..write(obj.Lat)
      ..writeByte(15)
      ..write(obj.Long)
      ..writeByte(16)
      ..write(obj.managerStaff)
      ..writeByte(17)
      ..write(obj.extensionOfficerStaff)
      ..writeByte(18)
      ..write(obj.zone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalweightentrymodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
