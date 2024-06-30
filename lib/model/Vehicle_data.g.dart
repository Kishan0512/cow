// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Vehicle_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicledataAdapter extends TypeAdapter<Vehicle_data> {
  @override
  final int typeId = 46;

  @override
  Vehicle_data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vehicle_data(
      iD: fields[1] as dynamic,
      centerName: fields[2] as dynamic,
      vehicleNo: fields[3] as dynamic,
      contractorName: fields[4] as dynamic,
      vehicleType: fields[5] as dynamic,
      vehicleModel: fields[6] as dynamic,
      passingType: fields[7] as dynamic,
      aggrementFromDate: fields[8] as dynamic,
      aggrementToDate: fields[9] as dynamic,
      approvalRate: fields[10] as dynamic,
      currentRate: fields[11] as dynamic,
      insurance: fields[12] as dynamic,
      insuranceFromDate: fields[13] as dynamic,
      insuranceToDate: fields[14] as dynamic,
      registrationDate: fields[15] as dynamic,
      createdAt: fields[16] as dynamic,
      updatedAt: fields[17] as dynamic,
      lastUpdatedByUser: fields[18] as dynamic,
      createdByUser: fields[19] as dynamic,
      isactive: fields[20] as dynamic,
      isRegular: fields[0] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Vehicle_data obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.isRegular)
      ..writeByte(1)
      ..write(obj.iD)
      ..writeByte(2)
      ..write(obj.centerName)
      ..writeByte(3)
      ..write(obj.vehicleNo)
      ..writeByte(4)
      ..write(obj.contractorName)
      ..writeByte(5)
      ..write(obj.vehicleType)
      ..writeByte(6)
      ..write(obj.vehicleModel)
      ..writeByte(7)
      ..write(obj.passingType)
      ..writeByte(8)
      ..write(obj.aggrementFromDate)
      ..writeByte(9)
      ..write(obj.aggrementToDate)
      ..writeByte(10)
      ..write(obj.approvalRate)
      ..writeByte(11)
      ..write(obj.currentRate)
      ..writeByte(12)
      ..write(obj.insurance)
      ..writeByte(13)
      ..write(obj.insuranceFromDate)
      ..writeByte(14)
      ..write(obj.insuranceToDate)
      ..writeByte(15)
      ..write(obj.registrationDate)
      ..writeByte(16)
      ..write(obj.createdAt)
      ..writeByte(17)
      ..write(obj.updatedAt)
      ..writeByte(18)
      ..write(obj.lastUpdatedByUser)
      ..writeByte(19)
      ..write(obj.createdByUser)
      ..writeByte(20)
      ..write(obj.isactive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicledataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
