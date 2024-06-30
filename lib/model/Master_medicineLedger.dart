import 'package:hive/hive.dart';

part 'Master_medicineLedger.g.dart';

@HiveType(typeId: 23)
class Master_medicineLedger extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String code;
  @HiveField(2)
  String shortName;
  @HiveField(3)
  String companyName;
  @HiveField(4)
  dynamic dose;
  @HiveField(5)
  String dosageUnit;
  @HiveField(6)
  int minStock;
  @HiveField(7)
  int withdrawPeriod;
  @HiveField(8)
  int medicineCode;
  @HiveField(9)
  String groupCode;
  @HiveField(10)
  int medicineType;
  @HiveField(11)
  int medicineRoute;
  @HiveField(12)
  int id;
  @HiveField(13)
  String createdAt;
  @HiveField(14)
  String updatedAt;
  @HiveField(15)
  int lastUpdatedByUser;
  @HiveField(16)
  int createdByUser;

  Master_medicineLedger(
      {required this.name,
      required this.code,
      required this.shortName,
      required this.companyName,
      required this.dose,
      required this.dosageUnit,
      required this.minStock,
      required this.withdrawPeriod,
      required this.medicineCode,
      required this.groupCode,
      required this.medicineType,
      required this.medicineRoute,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser});

  Master_medicineLedger.fromJson(Map<String, dynamic> json)
      : name = json['Name'] ?? "",
        code = json['code'] ?? "",
        shortName = json['ShortName'] ?? "",
        companyName = json['CompanyName'] ?? "",
        dose = json['Dose'] ?? 0,
        dosageUnit = json['DosageUnit'] ?? "",
        minStock = json['MinStock'] ?? 0,
        withdrawPeriod = json['WithdrawPeriod'] ?? 0,
        medicineCode = json['MedicineCode'] ?? 0,
        groupCode = json['GroupCode'] ?? "",
        medicineType = json['medicineType'] ?? 0,
        medicineRoute = json['medicineRoute'] ?? 0,
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0;

  Map<String, dynamic> toJson(Master_medicineLedger h) {
    return {
      'Name': h.name,
      'code': h.code,
      'ShortName': h.shortName,
      'CompanyName': h.companyName,
      'Dose': h.dose,
      'DosageUnit': h.dosageUnit,
      'MinStock': h.minStock,
      'WithdrawPeriod': h.withdrawPeriod,
      'MedicineCode': h.medicineCode,
      'GroupCode': h.groupCode,
      'medicineType': h.medicineType,
      'medicineRoute': h.medicineRoute,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser
    };
  }
}
