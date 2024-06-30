// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Animal_timeline.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimaltimelineAdapter extends TypeAdapter<Animal_timeline> {
  @override
  final int typeId = 36;

  @override
  Animal_timeline read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Animal_timeline(
      count: fields[0] as dynamic,
      headingText: fields[1] as dynamic,
      centerText: fields[2] as dynamic,
      dateText: fields[3] as dynamic,
      statusText: fields[4] as dynamic,
      tagno: fields[5] as dynamic,
      actualDate: fields[6] as dynamic,
      id: fields[7] as dynamic,
      createdAt: fields[8] as dynamic,
      updatedAt: fields[9] as dynamic,
      lastUpdatedByUser: fields[10] as dynamic,
      createdByUser: fields[11] as dynamic,
      clientID: fields[12] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Animal_timeline obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.headingText)
      ..writeByte(2)
      ..write(obj.centerText)
      ..writeByte(3)
      ..write(obj.dateText)
      ..writeByte(4)
      ..write(obj.statusText)
      ..writeByte(5)
      ..write(obj.tagno)
      ..writeByte(6)
      ..write(obj.actualDate)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(11)
      ..write(obj.createdByUser)
      ..writeByte(12)
      ..write(obj.clientID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimaltimelineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
