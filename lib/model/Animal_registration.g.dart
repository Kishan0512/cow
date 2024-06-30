// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Animal_registration.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalRegistrationAdapter extends TypeAdapter<Animal_Registration> {
  @override
  final int typeId = 60;

  @override
  Animal_Registration read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Animal_Registration(
      tagId: fields[0] as dynamic,
      code: fields[1] as dynamic,
      name: fields[2] as dynamic,
      inputDate: fields[3] as dynamic,
      birthWeight: fields[4] as dynamic,
      sensorNo: fields[5] as dynamic,
      photo: fields[6] as dynamic,
      parity: fields[7] as dynamic,
      registrationDate: fields[8] as dynamic,
      marketValue: fields[9] as dynamic,
      staff: fields[10] as dynamic,
      lat: fields[11] as dynamic,
      long: fields[12] as dynamic,
      species: fields[13] as dynamic,
      breed: fields[14] as dynamic,
      herd: fields[15] as dynamic,
      lot: fields[16] as dynamic,
      farmer: fields[17] as dynamic,
      lastSire: fields[18] as dynamic,
      sire: fields[19] as dynamic,
      dam: fields[20] as dynamic,
      paternalSire: fields[21] as dynamic,
      paternalDam: fields[22] as dynamic,
      sexFlg: fields[23] as dynamic,
      SyncStatus: fields[27] as dynamic,
      zone: fields[24] as dynamic,
      createdAt: fields[25] as dynamic,
      updatedAt: fields[26] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Animal_Registration obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj.tagId)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.inputDate)
      ..writeByte(4)
      ..write(obj.birthWeight)
      ..writeByte(5)
      ..write(obj.sensorNo)
      ..writeByte(6)
      ..write(obj.photo)
      ..writeByte(7)
      ..write(obj.parity)
      ..writeByte(8)
      ..write(obj.registrationDate)
      ..writeByte(9)
      ..write(obj.marketValue)
      ..writeByte(10)
      ..write(obj.staff)
      ..writeByte(11)
      ..write(obj.lat)
      ..writeByte(12)
      ..write(obj.long)
      ..writeByte(13)
      ..write(obj.species)
      ..writeByte(14)
      ..write(obj.breed)
      ..writeByte(15)
      ..write(obj.herd)
      ..writeByte(16)
      ..write(obj.lot)
      ..writeByte(17)
      ..write(obj.farmer)
      ..writeByte(18)
      ..write(obj.lastSire)
      ..writeByte(19)
      ..write(obj.sire)
      ..writeByte(20)
      ..write(obj.dam)
      ..writeByte(21)
      ..write(obj.paternalSire)
      ..writeByte(22)
      ..write(obj.paternalDam)
      ..writeByte(23)
      ..write(obj.sexFlg)
      ..writeByte(24)
      ..write(obj.zone)
      ..writeByte(25)
      ..write(obj.createdAt)
      ..writeByte(26)
      ..write(obj.updatedAt)
      ..writeByte(27)
      ..write(obj.SyncStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalRegistrationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
