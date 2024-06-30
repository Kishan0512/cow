// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Animal_Vaccination.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalVaccinationAdapter extends TypeAdapter<Animal_Vaccination> {
  @override
  final int typeId = 40;

  @override
  Animal_Vaccination read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Animal_Vaccination(
      TagId: fields[0] as String,
      DateOfVaccination: fields[1] as String,
      BatchNo: fields[2] as String,
      Dose: fields[3] as String,
      Cost: fields[4] as String,
      vaccine: fields[5] as int,
      vaccinationType: fields[6] as int,
      medicineRoute: fields[7] as int,
      doneBy: fields[8] as int,
      details: fields[9] as int,
      SyncStatus: fields[14] as String,
      id: fields[10] as int,
      createdAt: fields[11] as String,
      updatedAt: fields[12] as String,
      lastUpdatedByUser: fields[13] as int,
      createdByUser: fields[15] as int,
      Lat: fields[16] as String,
      Long: fields[17] as String,
      managerStaff: fields[18] as String,
      extensionOfficerStaff: fields[19] as String,
      serverID: fields[21] as String,
      zone: fields[20] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Animal_Vaccination obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.TagId)
      ..writeByte(1)
      ..write(obj.DateOfVaccination)
      ..writeByte(2)
      ..write(obj.BatchNo)
      ..writeByte(3)
      ..write(obj.Dose)
      ..writeByte(4)
      ..write(obj.Cost)
      ..writeByte(5)
      ..write(obj.vaccine)
      ..writeByte(6)
      ..write(obj.vaccinationType)
      ..writeByte(7)
      ..write(obj.medicineRoute)
      ..writeByte(8)
      ..write(obj.doneBy)
      ..writeByte(9)
      ..write(obj.details)
      ..writeByte(10)
      ..write(obj.id)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(13)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(14)
      ..write(obj.SyncStatus)
      ..writeByte(15)
      ..write(obj.createdByUser)
      ..writeByte(16)
      ..write(obj.Lat)
      ..writeByte(17)
      ..write(obj.Long)
      ..writeByte(18)
      ..write(obj.managerStaff)
      ..writeByte(19)
      ..write(obj.extensionOfficerStaff)
      ..writeByte(20)
      ..write(obj.zone)
      ..writeByte(21)
      ..write(obj.serverID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalVaccinationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
