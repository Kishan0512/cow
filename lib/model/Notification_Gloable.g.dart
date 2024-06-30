// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Notification_Gloable.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationGloableAdapter extends TypeAdapter<Notification_Gloable> {
  @override
  final int typeId = 61;

  @override
  Notification_Gloable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Notification_Gloable(
      TagId: fields[0] as dynamic,
      Date: fields[1] as dynamic,
      Type: fields[2] as dynamic,
      ID: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Notification_Gloable obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.TagId)
      ..writeByte(1)
      ..write(obj.Date)
      ..writeByte(2)
      ..write(obj.Type)
      ..writeByte(3)
      ..write(obj.ID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationGloableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
