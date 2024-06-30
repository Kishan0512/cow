// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Animal_Treatment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalTreatmentAdapter extends TypeAdapter<Animal_Treatment> {
  @override
  final int typeId = 38;

  @override
  Animal_Treatment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Animal_Treatment(
      tagId: fields[0] as dynamic,
      fromDate: fields[1] as dynamic,
      toDate: fields[2] as dynamic,
      treatmentSequence: fields[3] as dynamic,
      noTreatment: fields[4] as dynamic,
      dateOfTreatment: fields[5] as dynamic,
      temperature: fields[17] as dynamic,
      pulse: fields[6] as dynamic,
      respiration: fields[7] as dynamic,
      observation: fields[8] as dynamic,
      labTest: fields[9] as dynamic,
      cost: fields[10] as dynamic,
      followUpDate: fields[11] as dynamic,
      lat: fields[12] as dynamic,
      long: fields[13] as dynamic,
      treatmentComplaint: fields[14] as dynamic,
      systemAffected: fields[15] as dynamic,
      diagnosis: fields[16] as dynamic,
      doctor: fields[18] as dynamic,
      details: fields[19] as dynamic,
      managerStaff: fields[20] as dynamic,
      extensionOfficerStaff: fields[21] as dynamic,
      zone: fields[22] as dynamic,
      id: fields[23] as dynamic,
      createdAt: fields[24] as dynamic,
      updatedAt: fields[25] as dynamic,
      lastUpdatedByUser: fields[26] as dynamic,
      createdByUser: fields[27] as dynamic,
      visitID: fields[28] as dynamic,
      receiptNo: fields[29] as dynamic,
      herd: fields[30] as dynamic,
      lot: fields[31] as dynamic,
      farmer: fields[32] as dynamic,
      serverID: fields[33] as dynamic,
      clientID: fields[34] as dynamic,
      SyncStatus: fields[35] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Animal_Treatment obj) {
    writer
      ..writeByte(36)
      ..writeByte(0)
      ..write(obj.tagId)
      ..writeByte(1)
      ..write(obj.fromDate)
      ..writeByte(2)
      ..write(obj.toDate)
      ..writeByte(3)
      ..write(obj.treatmentSequence)
      ..writeByte(4)
      ..write(obj.noTreatment)
      ..writeByte(5)
      ..write(obj.dateOfTreatment)
      ..writeByte(6)
      ..write(obj.pulse)
      ..writeByte(7)
      ..write(obj.respiration)
      ..writeByte(8)
      ..write(obj.observation)
      ..writeByte(9)
      ..write(obj.labTest)
      ..writeByte(10)
      ..write(obj.cost)
      ..writeByte(11)
      ..write(obj.followUpDate)
      ..writeByte(12)
      ..write(obj.lat)
      ..writeByte(13)
      ..write(obj.long)
      ..writeByte(14)
      ..write(obj.treatmentComplaint)
      ..writeByte(15)
      ..write(obj.systemAffected)
      ..writeByte(16)
      ..write(obj.diagnosis)
      ..writeByte(17)
      ..write(obj.temperature)
      ..writeByte(18)
      ..write(obj.doctor)
      ..writeByte(19)
      ..write(obj.details)
      ..writeByte(20)
      ..write(obj.managerStaff)
      ..writeByte(21)
      ..write(obj.extensionOfficerStaff)
      ..writeByte(22)
      ..write(obj.zone)
      ..writeByte(23)
      ..write(obj.id)
      ..writeByte(24)
      ..write(obj.createdAt)
      ..writeByte(25)
      ..write(obj.updatedAt)
      ..writeByte(26)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(27)
      ..write(obj.createdByUser)
      ..writeByte(28)
      ..write(obj.visitID)
      ..writeByte(29)
      ..write(obj.receiptNo)
      ..writeByte(30)
      ..write(obj.herd)
      ..writeByte(31)
      ..write(obj.lot)
      ..writeByte(32)
      ..write(obj.farmer)
      ..writeByte(33)
      ..write(obj.serverID)
      ..writeByte(34)
      ..write(obj.clientID)
      ..writeByte(35)
      ..write(obj.SyncStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalTreatmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
