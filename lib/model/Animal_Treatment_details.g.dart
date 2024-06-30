// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Animal_Treatment_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalTreatmentdetailsAdapter
    extends TypeAdapter<Animal_Treatment_details> {
  @override
  final int typeId = 37;

  @override
  Animal_Treatment_details read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Animal_Treatment_details(
      tagId: fields[0] as dynamic,
      date: fields[1] as dynamic,
      treatmentSequence: fields[2] as dynamic,
      tradeName: fields[3] as dynamic,
      doseRate: fields[4] as dynamic,
      totalDose: fields[5] as dynamic,
      batchNo: fields[6] as dynamic,
      medicineCode: fields[7] as dynamic,
      medicineLedger: fields[8] as dynamic,
      medicineRoute: fields[9] as dynamic,
      details: fields[10] as dynamic,
      id: fields[11] as dynamic,
      createdAt: fields[12] as dynamic,
      updatedAt: fields[13] as dynamic,
      lastUpdatedByUser: fields[14] as dynamic,
      createdByUser: fields[15] as dynamic,
      herd: fields[16] as dynamic,
      lot: fields[17] as dynamic,
      farmer: fields[18] as dynamic,
      serverID: fields[19] as dynamic,
      syncstatus: fields[21] as dynamic,
      clientID: fields[20] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Animal_Treatment_details obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.tagId)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.treatmentSequence)
      ..writeByte(3)
      ..write(obj.tradeName)
      ..writeByte(4)
      ..write(obj.doseRate)
      ..writeByte(5)
      ..write(obj.totalDose)
      ..writeByte(6)
      ..write(obj.batchNo)
      ..writeByte(7)
      ..write(obj.medicineCode)
      ..writeByte(8)
      ..write(obj.medicineLedger)
      ..writeByte(9)
      ..write(obj.medicineRoute)
      ..writeByte(10)
      ..write(obj.details)
      ..writeByte(11)
      ..write(obj.id)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt)
      ..writeByte(14)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(15)
      ..write(obj.createdByUser)
      ..writeByte(16)
      ..write(obj.herd)
      ..writeByte(17)
      ..write(obj.lot)
      ..writeByte(18)
      ..write(obj.farmer)
      ..writeByte(19)
      ..write(obj.serverID)
      ..writeByte(20)
      ..write(obj.clientID)
      ..writeByte(21)
      ..write(obj.syncstatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalTreatmentdetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
