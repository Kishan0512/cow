import 'package:hive/hive.dart';

part 'Animal_registration.g.dart';

@HiveType(typeId: 60)
class Animal_Registration extends HiveObject {
  @HiveField(0)
  var tagId;
  @HiveField(1)
  var code;
  @HiveField(2)
  var name;
  @HiveField(3)
  var inputDate;
  @HiveField(4)
  var birthWeight;
  @HiveField(5)
  var sensorNo;
  @HiveField(6)
  var photo;
  @HiveField(7)
  var parity;
  @HiveField(8)
  var registrationDate;
  @HiveField(9)
  var marketValue;
  @HiveField(10)
  var staff;
  @HiveField(11)
  var lat;
  @HiveField(12)
  var long;
  @HiveField(13)
  var species;
  @HiveField(14)
  var breed;
  @HiveField(15)
  var herd;
  @HiveField(16)
  var lot;
  @HiveField(17)
  var farmer;
  @HiveField(18)
  var lastSire;
  @HiveField(19)
  var sire;
  @HiveField(20)
  var dam;
  @HiveField(21)
  var paternalSire;
  @HiveField(22)
  var paternalDam;
  @HiveField(23)
  var sexFlg;
  @HiveField(24)
  var zone;
  @HiveField(25)
  var createdAt;
  @HiveField(26)
  var updatedAt;
  @HiveField(27)
  var SyncStatus;

  Animal_Registration(
      {required this.tagId,
      required this.code,
      required this.name,
      required this.inputDate,
      required this.birthWeight,
      required this.sensorNo,
      required this.photo,
      required this.parity,
      required this.registrationDate,
      required this.marketValue,
      required this.staff,
      required this.lat,
      required this.long,
      required this.species,
      required this.breed,
      required this.herd,
      required this.lot,
      required this.farmer,
      required this.lastSire,
      required this.sire,
      required this.dam,
      required this.paternalSire,
      required this.paternalDam,
      required this.sexFlg,
      required this.SyncStatus,
      required this.zone,
      required this.createdAt,
      required this.updatedAt});

  Animal_Registration.fromJson(Map<String, dynamic> json)
      : tagId = json['tagId'],
        code = json['code'],
        name = json['name'],
        inputDate = json['inputDate'],
        birthWeight = json['birthWeight'],
        sensorNo = json['sensorNo'],
        photo = json['photo'],
        parity = json['parity'],
        registrationDate = json['registrationDate'],
        marketValue = json['marketValue'],
        staff = json['staff'],
        lat = json['lat'],
        long = json['long'],
        species = json['species'],
        breed = json['breed'],
        herd = json['herd'],
        lot = json['lot'],
        farmer = json['farmer'],
        lastSire = json['lastSire'],
        sire = json['sire'],
        dam = json['dam'],
        paternalSire = json['paternalSire'],
        paternalDam = json['paternalDam'],
        sexFlg = json['sexFlg'],
        zone = json['zone'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        SyncStatus = json['SyncStatus'];

   Map<String, dynamic> toJson(Animal_Registration h) {
    return {
      'tagId': h.tagId,
      'code': h.code,
      'name': h.name,
      'inputDate': h.inputDate,
      'birthWeight': h.birthWeight,
      'sensorNo': h.sensorNo,
      'photo': h.photo,
      'parity': h.parity,
      'registrationDate': h.registrationDate,
      'marketValue': h.marketValue,
      'staff': h.staff,
      'lat': h.lat,
      'long': h.long,
      'species': h.species,
      'breed': h.breed,
      'herd': h.herd,
      'lot': h.lot,
      'farmer': h.farmer,
      'lastSire': h.lastSire,
      'sire': h.sire,
      'dam': h.dam,
      'paternalSire': h.paternalSire,
      'paternalDam': h.paternalDam,
      'sexFlg': h.sexFlg,
      'zone': h.zone,
      'createdAt': h.createdAt,
      'SyncStatus': h.SyncStatus,
      'updatedAt': h.updatedAt
    };
  }
}
