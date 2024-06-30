// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Master_inseminator.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterinseminatorAdapter extends TypeAdapter<Master_inseminator> {
  @override
  final int typeId = 15;

  @override
  Master_inseminator read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Master_inseminator(
      name: fields[0] as dynamic,
      code: fields[1] as dynamic,
      countryCode: fields[2] as dynamic,
      mobile: fields[3] as dynamic,
      paymentType: fields[4] as dynamic,
      qualification: fields[5] as dynamic,
      address: fields[6] as dynamic,
      maxBalance: fields[7] as dynamic,
      basic: fields[8] as dynamic,
      isSendSMS: fields[9] as dynamic,
      vOFlag: fields[10] as dynamic,
      isSuspended: fields[11] as dynamic,
      allowUser: fields[12] as dynamic,
      email: fields[13] as dynamic,
      group: fields[14] as dynamic,
      smsLanguage: fields[15] as dynamic,
      id: fields[16] as dynamic,
      createdAt: fields[17] as dynamic,
      updatedAt: fields[18] as dynamic,
      lastUpdatedByUser: fields[19] as dynamic,
      createdByUser: fields[20] as dynamic,
      voCategory: fields[21] as dynamic,
      voPost: fields[22] as dynamic,
      employeeNo: fields[23] as dynamic,
      localName: fields[24] as dynamic,
      joiningDate: fields[25] as dynamic,
      zone: fields[26] as dynamic,
      route: fields[27] as dynamic,
      dCS: fields[28] as dynamic,
      gvcDetails: fields[29] as dynamic,
      dcsname: fields[30] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Master_inseminator obj) {
    writer
      ..writeByte(31)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.countryCode)
      ..writeByte(3)
      ..write(obj.mobile)
      ..writeByte(4)
      ..write(obj.paymentType)
      ..writeByte(5)
      ..write(obj.qualification)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.maxBalance)
      ..writeByte(8)
      ..write(obj.basic)
      ..writeByte(9)
      ..write(obj.isSendSMS)
      ..writeByte(10)
      ..write(obj.vOFlag)
      ..writeByte(11)
      ..write(obj.isSuspended)
      ..writeByte(12)
      ..write(obj.allowUser)
      ..writeByte(13)
      ..write(obj.email)
      ..writeByte(14)
      ..write(obj.group)
      ..writeByte(15)
      ..write(obj.smsLanguage)
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
      ..write(obj.voCategory)
      ..writeByte(22)
      ..write(obj.voPost)
      ..writeByte(23)
      ..write(obj.employeeNo)
      ..writeByte(24)
      ..write(obj.localName)
      ..writeByte(25)
      ..write(obj.joiningDate)
      ..writeByte(26)
      ..write(obj.zone)
      ..writeByte(27)
      ..write(obj.route)
      ..writeByte(28)
      ..write(obj.dCS)
      ..writeByte(29)
      ..write(obj.gvcDetails)
      ..writeByte(30)
      ..write(obj.dcsname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasterinseminatorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
