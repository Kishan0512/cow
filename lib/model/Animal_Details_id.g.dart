// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Animal_Details_id.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalDetailsidAdapter extends TypeAdapter<Animal_Details_id> {
  @override
  final int typeId = 42;

  @override
  Animal_Details_id read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Animal_Details_id(
      tagId: fields[0] as dynamic,
      Syncstatus: fields[50] as dynamic,
      code: fields[1] as dynamic,
      name: fields[2] as dynamic,
      dOB: fields[3] as dynamic,
      age: fields[4] as dynamic,
      birthWeight: fields[5] as dynamic,
      salvageFlag: fields[6] as dynamic,
      parity: fields[7] as dynamic,
      aITagNo: fields[8] as dynamic,
      currentParity: fields[9] as dynamic,
      registrationDate: fields[10] as dynamic,
      transactionDate: fields[11] as dynamic,
      breedingStatus: fields[12] as dynamic,
      heatDate: fields[13] as dynamic,
      heatSeq: fields[14] as dynamic,
      abortionSeq: fields[15] as dynamic,
      pDDate: fields[16] as dynamic,
      calvingDate: fields[17] as dynamic,
      dryDate: fields[18] as dynamic,
      milkDate: fields[19] as dynamic,
      lastMilk: fields[20] as dynamic,
      totalMilk: fields[21] as dynamic,
      selectFlag: fields[22] as dynamic,
      selectRemarks: fields[23] as dynamic,
      selectColor: fields[24] as dynamic,
      disposalRemarks: fields[25] as dynamic,
      isSuspended: fields[26] as dynamic,
      syncStatus: fields[27] as dynamic,
      lat: fields[28] as dynamic,
      long: fields[29] as dynamic,
      species: fields[30] as dynamic,
      breed: fields[31] as dynamic,
      herd: fields[32] as dynamic,
      lot: fields[33] as dynamic,
      farmer: fields[34] as dynamic,
      status: fields[35] as dynamic,
      pd1: fields[36] as dynamic,
      pd2: fields[37] as dynamic,
      sexFlg: fields[38] as dynamic,
      zone: fields[39] as dynamic,
      disposalFlag: fields[40] as dynamic,
      pBFlag: fields[41] as dynamic,
      virtualLot: fields[42] as dynamic,
      farmername: fields[44] as dynamic,
      id: fields[43] as dynamic,
      lotname: fields[45] as dynamic,
      herdname: fields[46] as dynamic,
      speciesname: fields[47] as dynamic,
      statusname: fields[48] as dynamic,
      breedname: fields[49] as dynamic,
      farmerCode: fields[51] as dynamic,
      lotcode: fields[52] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Animal_Details_id obj) {
    writer
      ..writeByte(53)
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
      ..write(obj.parity)
      ..writeByte(8)
      ..write(obj.aITagNo)
      ..writeByte(9)
      ..write(obj.currentParity)
      ..writeByte(10)
      ..write(obj.registrationDate)
      ..writeByte(11)
      ..write(obj.transactionDate)
      ..writeByte(12)
      ..write(obj.breedingStatus)
      ..writeByte(13)
      ..write(obj.heatDate)
      ..writeByte(14)
      ..write(obj.heatSeq)
      ..writeByte(15)
      ..write(obj.abortionSeq)
      ..writeByte(16)
      ..write(obj.pDDate)
      ..writeByte(17)
      ..write(obj.calvingDate)
      ..writeByte(18)
      ..write(obj.dryDate)
      ..writeByte(19)
      ..write(obj.milkDate)
      ..writeByte(20)
      ..write(obj.lastMilk)
      ..writeByte(21)
      ..write(obj.totalMilk)
      ..writeByte(22)
      ..write(obj.selectFlag)
      ..writeByte(23)
      ..write(obj.selectRemarks)
      ..writeByte(24)
      ..write(obj.selectColor)
      ..writeByte(25)
      ..write(obj.disposalRemarks)
      ..writeByte(26)
      ..write(obj.isSuspended)
      ..writeByte(27)
      ..write(obj.syncStatus)
      ..writeByte(28)
      ..write(obj.lat)
      ..writeByte(29)
      ..write(obj.long)
      ..writeByte(30)
      ..write(obj.species)
      ..writeByte(31)
      ..write(obj.breed)
      ..writeByte(32)
      ..write(obj.herd)
      ..writeByte(33)
      ..write(obj.lot)
      ..writeByte(34)
      ..write(obj.farmer)
      ..writeByte(35)
      ..write(obj.status)
      ..writeByte(36)
      ..write(obj.pd1)
      ..writeByte(37)
      ..write(obj.pd2)
      ..writeByte(38)
      ..write(obj.sexFlg)
      ..writeByte(39)
      ..write(obj.zone)
      ..writeByte(40)
      ..write(obj.disposalFlag)
      ..writeByte(41)
      ..write(obj.pBFlag)
      ..writeByte(42)
      ..write(obj.virtualLot)
      ..writeByte(43)
      ..write(obj.id)
      ..writeByte(44)
      ..write(obj.farmername)
      ..writeByte(45)
      ..write(obj.lotname)
      ..writeByte(46)
      ..write(obj.herdname)
      ..writeByte(47)
      ..write(obj.speciesname)
      ..writeByte(48)
      ..write(obj.statusname)
      ..writeByte(49)
      ..write(obj.breedname)
      ..writeByte(50)
      ..write(obj.Syncstatus)
      ..writeByte(51)
      ..write(obj.farmerCode)
      ..writeByte(52)
      ..write(obj.lotcode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalDetailsidAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
