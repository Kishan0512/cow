// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Animal_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimaldetailsAdapter extends TypeAdapter<Animal_details> {
  @override
  final int typeId = 30;

  @override
  Animal_details read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Animal_details(
      tagId: fields[0] as String,
      code: fields[1] as dynamic,
      name: fields[2] as String,
      dOB: fields[3] as String,
      age: fields[4] as dynamic,
      birthWeight: fields[5] as dynamic,
      salvageFlag: fields[6] as dynamic,
      groupFlag: fields[7] as dynamic,
      catCalfFlag: fields[8] as dynamic,
      sensorNo: fields[9] as dynamic,
      photo: fields[10] as dynamic,
      parity: fields[11] as dynamic,
      selectCancel: fields[12] as dynamic,
      insuranceNo: fields[13] as dynamic,
      aITagNo: fields[14] as dynamic,
      currentParity: fields[15] as dynamic,
      registrationDate: fields[16] as String,
      marketValue: fields[17] as dynamic,
      nORings: fields[18] as dynamic,
      rearingPurpose: fields[19] as dynamic,
      color: fields[20] as dynamic,
      hornDistance: fields[21] as dynamic,
      policyPeriod: fields[22] as dynamic,
      transactionDate: fields[23] as dynamic,
      hypothecation: fields[24] as dynamic,
      hypothecationNo: fields[25] as dynamic,
      doctor: fields[26] as dynamic,
      sendCMS: fields[27] as dynamic,
      insuranceFlag: fields[28] as dynamic,
      breedingStatus: fields[29] as String,
      heatDate: fields[30] as String,
      heatSeq: fields[31] as dynamic,
      abortionSeq: fields[32] as dynamic,
      pDDate: fields[33] as String,
      calvingDate: fields[34] as String,
      dryDate: fields[35] as String,
      milkDate: fields[36] as String,
      lastMilk: fields[37] as dynamic,
      totalMilk: fields[38] as dynamic,
      selectFlag: fields[39] as dynamic,
      selectRemarks: fields[40] as dynamic,
      selectColor: fields[41] as dynamic,
      disposalRemarks: fields[42] as dynamic,
      isSuspended: fields[43] as dynamic,
      syncStatus: fields[44] as dynamic,
      lat: fields[45] as dynamic,
      long: fields[46] as dynamic,
      species: fields[47] as dynamic,
      breed: fields[48] as dynamic,
      herd: fields[49] as dynamic,
      lot: fields[50] as dynamic,
      farmer: fields[51] as dynamic,
      status: fields[52] as dynamic,
      lastSire: fields[53] as dynamic,
      sire: fields[54] as dynamic,
      dam: fields[55] as dynamic,
      paternalSire: fields[56] as dynamic,
      paternalDam: fields[57] as dynamic,
      pd1: fields[58] as dynamic,
      pd2: fields[59] as dynamic,
      sexFlg: fields[60] as dynamic,
      managerStaff: fields[61] as dynamic,
      extensionOfficerStaff: fields[62] as dynamic,
      zone: fields[63] as dynamic,
      disposalFlag: fields[64] as dynamic,
      pBFlag: fields[65] as dynamic,
      virtualLot: fields[66] as dynamic,
      id: fields[67] as int,
      createdAt: fields[68] as String,
      updatedAt: fields[69] as String,
      lastUpdatedByUser: fields[70] as dynamic,
      createdByUser: fields[71] as dynamic,
      staff: fields[72] as dynamic,
      serverID: fields[73] as dynamic,
      clientID: fields[74] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Animal_details obj) {
    writer
      ..writeByte(75)
      ..writeByte(0)
      ..write(obj.tagId)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.dOB)
      ..writeByte(4)
      ..write(obj.age)
      ..writeByte(5)
      ..write(obj.birthWeight)
      ..writeByte(6)
      ..write(obj.salvageFlag)
      ..writeByte(7)
      ..write(obj.groupFlag)
      ..writeByte(8)
      ..write(obj.catCalfFlag)
      ..writeByte(9)
      ..write(obj.sensorNo)
      ..writeByte(10)
      ..write(obj.photo)
      ..writeByte(11)
      ..write(obj.parity)
      ..writeByte(12)
      ..write(obj.selectCancel)
      ..writeByte(13)
      ..write(obj.insuranceNo)
      ..writeByte(14)
      ..write(obj.aITagNo)
      ..writeByte(15)
      ..write(obj.currentParity)
      ..writeByte(16)
      ..write(obj.registrationDate)
      ..writeByte(17)
      ..write(obj.marketValue)
      ..writeByte(18)
      ..write(obj.nORings)
      ..writeByte(19)
      ..write(obj.rearingPurpose)
      ..writeByte(20)
      ..write(obj.color)
      ..writeByte(21)
      ..write(obj.hornDistance)
      ..writeByte(22)
      ..write(obj.policyPeriod)
      ..writeByte(23)
      ..write(obj.transactionDate)
      ..writeByte(24)
      ..write(obj.hypothecation)
      ..writeByte(25)
      ..write(obj.hypothecationNo)
      ..writeByte(26)
      ..write(obj.doctor)
      ..writeByte(27)
      ..write(obj.sendCMS)
      ..writeByte(28)
      ..write(obj.insuranceFlag)
      ..writeByte(29)
      ..write(obj.breedingStatus)
      ..writeByte(30)
      ..write(obj.heatDate)
      ..writeByte(31)
      ..write(obj.heatSeq)
      ..writeByte(32)
      ..write(obj.abortionSeq)
      ..writeByte(33)
      ..write(obj.pDDate)
      ..writeByte(34)
      ..write(obj.calvingDate)
      ..writeByte(35)
      ..write(obj.dryDate)
      ..writeByte(36)
      ..write(obj.milkDate)
      ..writeByte(37)
      ..write(obj.lastMilk)
      ..writeByte(38)
      ..write(obj.totalMilk)
      ..writeByte(39)
      ..write(obj.selectFlag)
      ..writeByte(40)
      ..write(obj.selectRemarks)
      ..writeByte(41)
      ..write(obj.selectColor)
      ..writeByte(42)
      ..write(obj.disposalRemarks)
      ..writeByte(43)
      ..write(obj.isSuspended)
      ..writeByte(44)
      ..write(obj.syncStatus)
      ..writeByte(45)
      ..write(obj.lat)
      ..writeByte(46)
      ..write(obj.long)
      ..writeByte(47)
      ..write(obj.species)
      ..writeByte(48)
      ..write(obj.breed)
      ..writeByte(49)
      ..write(obj.herd)
      ..writeByte(50)
      ..write(obj.lot)
      ..writeByte(51)
      ..write(obj.farmer)
      ..writeByte(52)
      ..write(obj.status)
      ..writeByte(53)
      ..write(obj.lastSire)
      ..writeByte(54)
      ..write(obj.sire)
      ..writeByte(55)
      ..write(obj.dam)
      ..writeByte(56)
      ..write(obj.paternalSire)
      ..writeByte(57)
      ..write(obj.paternalDam)
      ..writeByte(58)
      ..write(obj.pd1)
      ..writeByte(59)
      ..write(obj.pd2)
      ..writeByte(60)
      ..write(obj.sexFlg)
      ..writeByte(61)
      ..write(obj.managerStaff)
      ..writeByte(62)
      ..write(obj.extensionOfficerStaff)
      ..writeByte(63)
      ..write(obj.zone)
      ..writeByte(64)
      ..write(obj.disposalFlag)
      ..writeByte(65)
      ..write(obj.pBFlag)
      ..writeByte(66)
      ..write(obj.virtualLot)
      ..writeByte(67)
      ..write(obj.id)
      ..writeByte(68)
      ..write(obj.createdAt)
      ..writeByte(69)
      ..write(obj.updatedAt)
      ..writeByte(70)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(71)
      ..write(obj.createdByUser)
      ..writeByte(72)
      ..write(obj.staff)
      ..writeByte(73)
      ..write(obj.serverID)
      ..writeByte(74)
      ..write(obj.clientID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimaldetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
