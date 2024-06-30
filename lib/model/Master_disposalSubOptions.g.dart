// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_disposalSubOptions.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterdisposalSubOptionsAdapter
    extends TypeAdapter<Master_disposalSubOptions> {
  @override
  final int typeId = 11;

  @override
  Master_disposalSubOptions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_disposalSubOptions(
      name: fields[0] as String,
      disposal: fields[1] as int,
      id: fields[2] as int,
      createdAt: fields[3] as String,
      updatedAt: fields[4] as String,
      createdByUser: fields[5] as int,
      lastUpdatedByUser: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Master_disposalSubOptions obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.disposal)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.createdByUser)
      ..writeByte(6)
      ..write(obj.lastUpdatedByUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasterdisposalSubOptionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
