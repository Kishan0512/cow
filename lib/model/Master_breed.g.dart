// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_breed.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterbreedAdapter extends TypeAdapter<Master_breed> {
  @override
  final int typeId = 3;

  @override
  Master_breed read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_breed(
      name: fields[0] as String,
      breedType: fields[1] as String,
      species: fields[2] as int,
      id: fields[3] as int,
      createdAt: fields[4] as String,
      updatedAt: fields[5] as String,
      lastUpdatedByUser: fields[6] as int,
      createdByUser: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Master_breed obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.breedType)
      ..writeByte(2)
      ..write(obj.species)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(7)
      ..write(obj.createdByUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasterbreedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
