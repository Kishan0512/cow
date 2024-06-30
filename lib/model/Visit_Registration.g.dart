// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Visit_Registration.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VisitRegistrationAdapter extends TypeAdapter<Visit_Registration> {
  @override
  final int typeId = 44;

  @override
  Visit_Registration read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Visit_Registration(
      visitID: fields[0] as dynamic,
      dCSCode: fields[1] as dynamic,
      dCSSAPCode: fields[2] as dynamic,
      dCSName: fields[3] as dynamic,
      farmerCode: fields[4] as dynamic,
      farmerName: fields[5] as dynamic,
      farmerMobile: fields[6] as dynamic,
      address: fields[7] as dynamic,
      registerBy: fields[8] as dynamic,
      registerNo: fields[9] as dynamic,
      arrivaltime: fields[10] as dynamic,
      complaint: fields[11] as dynamic,
      animalID: fields[12] as dynamic,
      visitCost: fields[13] as dynamic,
      species: fields[14] as dynamic,
      lotID: fields[15] as dynamic,
      requestType: fields[16] as dynamic,
      lotname: fields[17] as dynamic,
      herd: fields[18] as dynamic,
      herdName: fields[19] as dynamic,
      masterStaff: fields[20] as dynamic,
      extensionOfficerStaff: fields[21] as dynamic,
      farmerid: fields[22] as dynamic,
      compliaintid: fields[23] as dynamic,
      status: fields[24] as dynamic,
      date: fields[25] as dynamic,
      vO: fields[26] as dynamic,
      syncStaus: fields[27] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Visit_Registration obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj.visitID)
      ..writeByte(1)
      ..write(obj.dCSCode)
      ..writeByte(2)
      ..write(obj.dCSSAPCode)
      ..writeByte(3)
      ..write(obj.dCSName)
      ..writeByte(4)
      ..write(obj.farmerCode)
      ..writeByte(5)
      ..write(obj.farmerName)
      ..writeByte(6)
      ..write(obj.farmerMobile)
      ..writeByte(7)
      ..write(obj.address)
      ..writeByte(8)
      ..write(obj.registerBy)
      ..writeByte(9)
      ..write(obj.registerNo)
      ..writeByte(10)
      ..write(obj.arrivaltime)
      ..writeByte(11)
      ..write(obj.complaint)
      ..writeByte(12)
      ..write(obj.animalID)
      ..writeByte(13)
      ..write(obj.visitCost)
      ..writeByte(14)
      ..write(obj.species)
      ..writeByte(15)
      ..write(obj.lotID)
      ..writeByte(16)
      ..write(obj.requestType)
      ..writeByte(17)
      ..write(obj.lotname)
      ..writeByte(18)
      ..write(obj.herd)
      ..writeByte(19)
      ..write(obj.herdName)
      ..writeByte(20)
      ..write(obj.masterStaff)
      ..writeByte(21)
      ..write(obj.extensionOfficerStaff)
      ..writeByte(22)
      ..write(obj.farmerid)
      ..writeByte(23)
      ..write(obj.compliaintid)
      ..writeByte(24)
      ..write(obj.status)
      ..writeByte(25)
      ..write(obj.date)
      ..writeByte(26)
      ..write(obj.vO)
      ..writeByte(27)
      ..write(obj.syncStaus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisitRegistrationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
