// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_Farmer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterFarmerAdapter extends TypeAdapter<Master_Farmer> {
  @override
  final int typeId = 57;

  @override
  Master_Farmer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_Farmer(
      dCSCode: fields[0] as String,
      code: fields[1] as String,
      name: fields[2] as String,
      middleName: fields[3] as String,
      lastName: fields[4] as String,
      mobile: fields[5] as String,
      cFlag: fields[6] as String,
      bFlag: fields[7] as String,
      producerCode: fields[8] as String,
      sAPcode: fields[9] as String,
      countryCode: fields[10] as dynamic,
      country: fields[11] as dynamic,
      state: fields[12] as dynamic,
      district: fields[13] as dynamic,
      taluka: fields[14] as dynamic,
      village: fields[15] as dynamic,
      address: fields[16] as dynamic,
      isSendSMS: fields[17] as dynamic,
      isSuspended: fields[18] as bool,
      photo: fields[19] as dynamic,
      education: fields[20] as dynamic,
      adultMale: fields[21] as dynamic,
      adultFemale: fields[22] as dynamic,
      youngMale: fields[23] as dynamic,
      youngFemale: fields[24] as dynamic,
      childrenMale: fields[25] as dynamic,
      childrenFemale: fields[26] as dynamic,
      landArea: fields[27] as dynamic,
      landHolding: fields[28] as dynamic,
      cropGrown: fields[29] as dynamic,
      irrigation: fields[30] as dynamic,
      irrigatedArea: fields[31] as dynamic,
      rainFedArea: fields[32] as dynamic,
      fodderCropsGrown: fields[33] as dynamic,
      cOFS29: fields[34] as dynamic,
      cO4: fields[35] as dynamic,
      lot: fields[36] as int,
      smsLanguage: fields[37] as dynamic,
      managerStaff: fields[38] as dynamic,
      aiStaff: fields[39] as dynamic,
      id: fields[40] as int,
      createdAt: fields[41] as dynamic,
      updatedAt: fields[42] as dynamic,
      lastUpdatedByUser: fields[43] as dynamic,
      createdByUser: fields[44] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Master_Farmer obj) {
    writer
      ..writeByte(45)
      ..writeByte(0)
      ..write(obj.dCSCode)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.middleName)
      ..writeByte(4)
      ..write(obj.lastName)
      ..writeByte(5)
      ..write(obj.mobile)
      ..writeByte(6)
      ..write(obj.cFlag)
      ..writeByte(7)
      ..write(obj.bFlag)
      ..writeByte(8)
      ..write(obj.producerCode)
      ..writeByte(9)
      ..write(obj.sAPcode)
      ..writeByte(10)
      ..write(obj.countryCode)
      ..writeByte(11)
      ..write(obj.country)
      ..writeByte(12)
      ..write(obj.state)
      ..writeByte(13)
      ..write(obj.district)
      ..writeByte(14)
      ..write(obj.taluka)
      ..writeByte(15)
      ..write(obj.village)
      ..writeByte(16)
      ..write(obj.address)
      ..writeByte(17)
      ..write(obj.isSendSMS)
      ..writeByte(18)
      ..write(obj.isSuspended)
      ..writeByte(19)
      ..write(obj.photo)
      ..writeByte(20)
      ..write(obj.education)
      ..writeByte(21)
      ..write(obj.adultMale)
      ..writeByte(22)
      ..write(obj.adultFemale)
      ..writeByte(23)
      ..write(obj.youngMale)
      ..writeByte(24)
      ..write(obj.youngFemale)
      ..writeByte(25)
      ..write(obj.childrenMale)
      ..writeByte(26)
      ..write(obj.childrenFemale)
      ..writeByte(27)
      ..write(obj.landArea)
      ..writeByte(28)
      ..write(obj.landHolding)
      ..writeByte(29)
      ..write(obj.cropGrown)
      ..writeByte(30)
      ..write(obj.irrigation)
      ..writeByte(31)
      ..write(obj.irrigatedArea)
      ..writeByte(32)
      ..write(obj.rainFedArea)
      ..writeByte(33)
      ..write(obj.fodderCropsGrown)
      ..writeByte(34)
      ..write(obj.cOFS29)
      ..writeByte(35)
      ..write(obj.cO4)
      ..writeByte(36)
      ..write(obj.lot)
      ..writeByte(37)
      ..write(obj.smsLanguage)
      ..writeByte(38)
      ..write(obj.managerStaff)
      ..writeByte(39)
      ..write(obj.aiStaff)
      ..writeByte(40)
      ..write(obj.id)
      ..writeByte(41)
      ..write(obj.createdAt)
      ..writeByte(42)
      ..write(obj.updatedAt)
      ..writeByte(43)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(44)
      ..write(obj.createdByUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasterFarmerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
