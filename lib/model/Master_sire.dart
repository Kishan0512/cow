import 'package:hive/hive.dart';

part 'Master_sire.g.dart';

@HiveType(typeId: 16)
class Master_sire extends HiveObject {
  @HiveField(0)
  var name;
  @HiveField(1)
  var code;
  @HiveField(2)
  var dOB;
  @HiveField(3)
  var birthWeight;
  @HiveField(4)
  var naturalOrAIBirth;
  @HiveField(5)
  var allowAllUser;
  @HiveField(6)
  var isSuspended;
  @HiveField(7)
  var sID;
  @HiveField(8)
  var sireIndex;
  @HiveField(9)
  var mID;
  @HiveField(10)
  var motherMilkYield;
  @HiveField(11)
  var minStrawStock;
  @HiveField(12)
  var breed;
  @HiveField(13)
  var source;
  @HiveField(14)
  var id;
  @HiveField(15)
  var createdAt;
  @HiveField(16)
  var updatedAt;
  @HiveField(17)
  var lastUpdatedByUser;
  @HiveField(18)
  var createdByUser;
  @HiveField(19)
  var normalCost;
  @HiveField(20)
  var deductionCode;
  @HiveField(21)
  var unknownsire;
  @HiveField(22)
  var Syncstatus;
  @HiveField(23)
  var Selected;

  Master_sire(
      {required this.name,
      required this.code,
      required this.dOB,
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
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser,
      required this.normalCost,
      required this.deductionCode,
      required this.Syncstatus,
      required this.Selected,
      required this.unknownsire});

  Master_sire.fromJson(Map<String, dynamic> json)
      : name = json['Name'] ?? "",
        code = json['code'] ?? "",
        dOB = json['DOB'] ?? "",
        birthWeight = json['BirthWeight'] ?? 0,
        naturalOrAIBirth = json['NaturalOrAIBirth'] ?? 0,
        allowAllUser = json['AllowAllUser'] ?? false,
        isSuspended = json['IsSuspended'] ?? false,
        sID = json['SID'] ?? "",
        sireIndex = json['SireIndex'] ?? "",
        mID = json['MID'] ?? "",
        motherMilkYield = json['MotherMilkYield'] ?? "",
        minStrawStock = json['MinStrawStock'] ?? 0,
        breed = json.containsKey('Breed') ? json['Breed'] : json['breed'],
        source = json['source'] ?? 0,
        id = json.containsKey('ID') ? json['ID'] : json['id'],
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0,
        normalCost = json['NormalCost'] ?? 0,
        deductionCode = json['DeductionCode'] ?? 0,
        Syncstatus = json['Syncstatus'] ?? "1",
        Selected = json['Selected'].toString(),
        unknownsire = json['Unknownsire'] ?? false;

  Map<String, dynamic> toJson(Master_sire h) {

    return {
      'Name': h.name,
      'code': h.code,
      'DOB': h.dOB,
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
      'ID': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
      'NormalCost': h.normalCost,
      'DeductionCode': h.deductionCode,
      'Unknownsire': h.unknownsire,
      'Selected': h.Selected,
      'Syncstatus': h.Syncstatus
    };
  }
}
