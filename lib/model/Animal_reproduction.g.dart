// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Animal_reproduction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalreproductionAdapter extends TypeAdapter<Animal_reproduction> {
  @override
  final int typeId = 34;

  @override
  Animal_reproduction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Animal_reproduction(
      tagId: fields[0] as dynamic,
      parity: fields[1] as dynamic,
      heatSeq: fields[2] as dynamic,
      heatDate: fields[3] as dynamic,
      remPD1: fields[4] as dynamic,
      remPD2: fields[5] as dynamic,
      pDDate: fields[6] as dynamic,
      dateOfCalving: fields[7] as dynamic,
      dateOfDry: fields[8] as dynamic,
      dryTreatment: fields[9] as dynamic,
      flag: fields[10] as dynamic,
      retantionOfPlecenta: fields[11] as dynamic,
      comments: fields[12] as dynamic,
      reproductionProblemNote: fields[13] as dynamic,
      mobileOrDesktopEntryFlg: fields[14] as dynamic,
      totalAIDose: fields[15] as dynamic,
      abortionSeq: fields[16] as dynamic,
      vaccine: fields[17] as dynamic,
      colostrum: fields[18] as dynamic,
      inseminationTicketNumber: fields[19] as dynamic,
      pDTicketNumber: fields[20] as dynamic,
      calvingTicketNumber: fields[21] as dynamic,
      orderNumber: fields[22] as dynamic,
      oTP: fields[23] as dynamic,
      eNTRY: fields[24] as dynamic,
      lat: fields[25] as dynamic,
      long: fields[26] as dynamic,
      details: fields[27] as dynamic,
      inseminatorStaff: fields[28] as dynamic,
      sire: fields[29] as dynamic,
      pdBy: fields[30] as dynamic,
      service: fields[31] as dynamic,
      pd1: fields[32] as dynamic,
      pd2: fields[33] as dynamic,
      sex: fields[34] as dynamic,
      calfSex: fields[35] as dynamic,
      calvingType: fields[36] as dynamic,
      calvingTypeOption: fields[37] as dynamic,
      dryReason: fields[38] as dynamic,
      managerStaff: fields[39] as dynamic,
      extensionOfficerStaff: fields[40] as dynamic,
      zone: fields[41] as dynamic,
      id: fields[42] as dynamic,
      createdAt: fields[43] as dynamic,
      updatedAt: fields[44] as dynamic,
      lastUpdatedByUser: fields[45] as dynamic,
      createdByUser: fields[46] as dynamic,
      herd: fields[47] as dynamic,
      lot: fields[48] as dynamic,
      farmer: fields[49] as dynamic,
      sortedSemon: fields[50] as dynamic,
      strawImage: fields[51] as dynamic,
      batchNo: fields[52] as dynamic,
      aICost: fields[53] as dynamic,
      calfID: fields[54] as dynamic,
      calf2Sex: fields[55] as dynamic,
      calf2ID: fields[56] as dynamic,
      image1: fields[57] as dynamic,
      image2: fields[58] as dynamic,
      entryflag: fields[59] as dynamic,
      pDdays: fields[60] as dynamic,
      elegibleAI: fields[61] as dynamic,
      pregdays: fields[62] as dynamic,
      unknownSire: fields[63] as dynamic,
      eligibleAISEq: fields[64] as dynamic,
      serverID: fields[65] as dynamic,
      clientID: fields[66] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Animal_reproduction obj) {
    writer
      ..writeByte(67)
      ..writeByte(0)
      ..write(obj.tagId)
      ..writeByte(1)
      ..write(obj.parity)
      ..writeByte(2)
      ..write(obj.heatSeq)
      ..writeByte(3)
      ..write(obj.heatDate)
      ..writeByte(4)
      ..write(obj.remPD1)
      ..writeByte(5)
      ..write(obj.remPD2)
      ..writeByte(6)
      ..write(obj.pDDate)
      ..writeByte(7)
      ..write(obj.dateOfCalving)
      ..writeByte(8)
      ..write(obj.dateOfDry)
      ..writeByte(9)
      ..write(obj.dryTreatment)
      ..writeByte(10)
      ..write(obj.flag)
      ..writeByte(11)
      ..write(obj.retantionOfPlecenta)
      ..writeByte(12)
      ..write(obj.comments)
      ..writeByte(13)
      ..write(obj.reproductionProblemNote)
      ..writeByte(14)
      ..write(obj.mobileOrDesktopEntryFlg)
      ..writeByte(15)
      ..write(obj.totalAIDose)
      ..writeByte(16)
      ..write(obj.abortionSeq)
      ..writeByte(17)
      ..write(obj.vaccine)
      ..writeByte(18)
      ..write(obj.colostrum)
      ..writeByte(19)
      ..write(obj.inseminationTicketNumber)
      ..writeByte(20)
      ..write(obj.pDTicketNumber)
      ..writeByte(21)
      ..write(obj.calvingTicketNumber)
      ..writeByte(22)
      ..write(obj.orderNumber)
      ..writeByte(23)
      ..write(obj.oTP)
      ..writeByte(24)
      ..write(obj.eNTRY)
      ..writeByte(25)
      ..write(obj.lat)
      ..writeByte(26)
      ..write(obj.long)
      ..writeByte(27)
      ..write(obj.details)
      ..writeByte(28)
      ..write(obj.inseminatorStaff)
      ..writeByte(29)
      ..write(obj.sire)
      ..writeByte(30)
      ..write(obj.pdBy)
      ..writeByte(31)
      ..write(obj.service)
      ..writeByte(32)
      ..write(obj.pd1)
      ..writeByte(33)
      ..write(obj.pd2)
      ..writeByte(34)
      ..write(obj.sex)
      ..writeByte(35)
      ..write(obj.calfSex)
      ..writeByte(36)
      ..write(obj.calvingType)
      ..writeByte(37)
      ..write(obj.calvingTypeOption)
      ..writeByte(38)
      ..write(obj.dryReason)
      ..writeByte(39)
      ..write(obj.managerStaff)
      ..writeByte(40)
      ..write(obj.extensionOfficerStaff)
      ..writeByte(41)
      ..write(obj.zone)
      ..writeByte(42)
      ..write(obj.id)
      ..writeByte(43)
      ..write(obj.createdAt)
      ..writeByte(44)
      ..write(obj.updatedAt)
      ..writeByte(45)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(46)
      ..write(obj.createdByUser)
      ..writeByte(47)
      ..write(obj.herd)
      ..writeByte(48)
      ..write(obj.lot)
      ..writeByte(49)
      ..write(obj.farmer)
      ..writeByte(50)
      ..write(obj.sortedSemon)
      ..writeByte(51)
      ..write(obj.strawImage)
      ..writeByte(52)
      ..write(obj.batchNo)
      ..writeByte(53)
      ..write(obj.aICost)
      ..writeByte(54)
      ..write(obj.calfID)
      ..writeByte(55)
      ..write(obj.calf2Sex)
      ..writeByte(56)
      ..write(obj.calf2ID)
      ..writeByte(57)
      ..write(obj.image1)
      ..writeByte(58)
      ..write(obj.image2)
      ..writeByte(59)
      ..write(obj.entryflag)
      ..writeByte(60)
      ..write(obj.pDdays)
      ..writeByte(61)
      ..write(obj.elegibleAI)
      ..writeByte(62)
      ..write(obj.pregdays)
      ..writeByte(63)
      ..write(obj.unknownSire)
      ..writeByte(64)
      ..write(obj.eligibleAISEq)
      ..writeByte(65)
      ..write(obj.serverID)
      ..writeByte(66)
      ..write(obj.clientID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalreproductionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
