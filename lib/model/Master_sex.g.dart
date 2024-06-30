// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_sex.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MastersexAdapter extends TypeAdapter<Master_sex> {
  @override
  final int typeId = 7;

  @override
  Master_sex read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_sex(
      name: fields[0] as String,
      id: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Master_sex obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MastersexAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
