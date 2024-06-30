// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Language_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LanguagemodelAdapter extends TypeAdapter<Language_model> {
  @override
  final int typeId = 56;

  @override
  Language_model read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Language_model(
      id: fields[0] as String,
      engkey: fields[1] as String,
      engvalue: fields[2] as String,
      key: fields[3] as String,
      Value: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Language_model obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.engkey)
      ..writeByte(2)
      ..write(obj.engvalue)
      ..writeByte(3)
      ..write(obj.key)
      ..writeByte(4)
      ..write(obj.Value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguagemodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
