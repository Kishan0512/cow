// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Animal_Deworming.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalDewormingAdapter extends TypeAdapter<Animal_Deworming> {
  @override
  final int typeId = 33;

  @override
  Animal_Deworming read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Animal_Deworming(
      tagId: fields[0] as dynamic,
      date: fields[1] as String,
      batchNo: fields[2] as dynamic,
      dose: fields[3] as dynamic,
      redewormingDate: fields[4] as String,
      cost: fields[5] as dynamic,
      lat: fields[6] as dynamic,
      long: fields[7] as dynamic,
      details: fields[8] as dynamic,
      dewormingType: fields[9] as dynamic,
      dewormerMedicine: fields[10] as dynamic,
      medicineRoute: fields[11] as dynamic,
      doneBy: fields[12] as dynamic,
      managerStaff: fields[13] as dynamic,
      extensionOfficerStaff: fields[14] as dynamic,
      zone: fields[15] as dynamic,
      id: fields[16] as dynamic,
      createdAt: fields[17] as String,
      updatedAt: fields[18] as String,
      lastUpdatedByUser: fields[19] as dynamic,
      createdByUser: fields[20] as dynamic,
      herd: fields[21] as dynamic,
      lot: fields[22] as dynamic,
      farmer: fields[23] as dynamic,
      serverID: fields[24] as dynamic,
      clientID: fields[25] as dynamic,
      SyncStatus: fields[26] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Animal_Deworming obj) {
    writer
      ..writeByte(27)
      ..writeByte(0)
      ..write(obj.tagId)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.batchNo)
      ..writeByte(3)
      ..write(obj.dose)
      ..writeByte(4)
      ..write(obj.redewormingDate)
      ..writeByte(5)
      ..write(obj.cost)
      ..writeByte(6)
      ..write(obj.lat)
      ..writeByte(7)
      ..write(obj.long)
      ..writeByte(8)
      ..write(obj.details)
      ..writeByte(9)
      ..write(obj.dewormingType)
      ..writeByte(10)
      ..write(obj.dewormerMedicine)
      ..writeByte(11)
      ..write(obj.medicineRoute)
      ..writeByte(12)
      ..write(obj.doneBy)
      ..writeByte(13)
      ..write(obj.managerStaff)
      ..writeByte(14)
      ..write(obj.extensionOfficerStaff)
      ..writeByte(15)
      ..write(obj.zone)
      ..writeByte(16)
      ..write(obj.id)
      ..writeByte(17)
      ..write(obj.createdAt)
      ..writeByte(18)
      ..write(obj.updatedAt)
      ..writeByte(19)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(20)
      ..write(obj.createdByUser)
      ..writeByte(21)
      ..write(obj.herd)
      ..writeByte(22)
      ..write(obj.lot)
      ..writeByte(23)
      ..write(obj.farmer)
      ..writeByte(24)
      ..write(obj.serverID)
      ..writeByte(25)
      ..write(obj.clientID)
      ..writeByte(26)
      ..write(obj.SyncStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalDewormingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
