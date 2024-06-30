import 'package:hive/hive.dart';

part 'Master_sireStock.g.dart';

@HiveType(typeId: 29)
class Master_sireStock extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String code;
  @HiveField(2)
  String dob;
  @HiveField(3)
  int birthWeight;
  @HiveField(4)
  int naturalOrAIBirth;
  @HiveField(5)
  bool allowAllUser;
  @HiveField(6)
  bool isSuspended;
  @HiveField(7)
  String sID;
  @HiveField(8)
  String sireIndex;
  @HiveField(9)
  String mID;
  @HiveField(10)
  int motherMilkYield;
  @HiveField(11)
  int minStrawStock;
  @HiveField(12)
  int breed;
  @HiveField(13)
  String source;
  @HiveField(14)
  int iD;
  @HiveField(15)
  String createdAt;
  @HiveField(16)
  String updatedAt;
  @HiveField(17)
  int lastUpdatedByUser;
  @HiveField(18)
  int createdByUser;
  @HiveField(19)
  String Syncstatus;

  Master_sireStock(
      {required this.name,
      required this.code,
      required this.dob,
      required this.birthWeight,
      required this.naturalOrAIBirth,
      required this.allowAllUser,
      required this.isSuspended,
      required this.sID,
      required this.sireIndex,
      required this.mID,
      required this.motherMilkYield,
      required this.minStrawStock,
      required this.breed,
      required this.source,
      required this.iD,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser,
      required this.Syncstatus});

  Master_sireStock.fromJson(Map<String, dynamic> json)
      : name = json['Name'] ?? "",
        code = json['code'] ?? "",
        dob = json['dob'] ?? "",
        birthWeight = json['BirthWeight'] ?? 0,
        naturalOrAIBirth = json['NaturalOrAIBirth'] ?? 0,
        allowAllUser = json['AllowAllUser'] ?? false,
        isSuspended = json['IsSuspended'] ?? false,
        sID = json['SID'] ?? "",
        sireIndex = json['SireIndex'] ?? "",
        mID = json['MID'] ?? "",
        motherMilkYield = json['MotherMilkYield'] ?? 0,
        minStrawStock = json['MinStrawStock'] ?? 0,
        breed = json['Breed'] ?? 0,
        source = json['source'] ?? "",
        iD = json['ID'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0,
        Syncstatus = json['Syncstatus'] ?? "1";

  Map<String, dynamic> toJson(Master_sireStock h) {
    return {
      'Name': h.name,
      'code': h.code,
      'dob': h.dob,
      'BirthWeight': h.birthWeight,
      'NaturalOrAIBirth': h.naturalOrAIBirth,
      'AllowAllUser': h.allowAllUser,
      'IsSuspended': h.isSuspended,
      'SID': h.sID,
      'SireIndex': h.sireIndex,
      'MID': h.mID,
      'MotherMilkYield': h.motherMilkYield,
      'MinStrawStock': h.minStrawStock,
      'Breed': h.breed,
      'source': h.source,
      'ID': h.iD,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
      'Syncstatus': h.Syncstatus
    };
  }
}
