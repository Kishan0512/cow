import 'package:hive/hive.dart';

part 'Animal_weight_entry_model.g.dart';

@HiveType(typeId: 39)
class Animal_weight_entry_model extends HiveObject {
  @HiveField(0)
  String TagId;
  @HiveField(1)
  String Date;
  @HiveField(2)
  String ChestGirth;
  @HiveField(3)
  String Weight;
  @HiveField(4)
  String Length;
  @HiveField(5)
  String WeightGain;
  @HiveField(6)
  int AutoNo;
  @HiveField(7)
  int details;
  @HiveField(8)
  String SyncStatus;
  @HiveField(9)
  int id;
  @HiveField(10)
  String createdAt;
  @HiveField(11)
  String updatedAt;
  @HiveField(12)
  int lastUpdatedByUser;
  @HiveField(13)
  int createdByUser;
  @HiveField(14)
  String Lat;
  @HiveField(15)
  String Long;
  @HiveField(16)
  int managerStaff;
  @HiveField(17)
  int extensionOfficerStaff;
  @HiveField(18)
  int zone;

  Animal_weight_entry_model(
      {required this.TagId,
      required this.Date,
      required this.ChestGirth,
      required this.Weight,
      required this.Length,
      required this.WeightGain,
      required this.AutoNo,
      required this.details,
      required this.SyncStatus,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser,
      required this.Lat,
      required this.Long,
      required this.managerStaff,
      required this.extensionOfficerStaff,
      required this.zone});

  Animal_weight_entry_model.fromJson(Map<String, dynamic> json)
      : TagId = json['TagId'] ?? "",
        Date = json['Date'] ?? "",
        ChestGirth = json['ChestGirth'].toString(),
        Weight = json['Weight'].toString(),
        Length = json['Length'].toString(),
        WeightGain = json['WeightGain'] ?? "",
        AutoNo = json['AutoNo'] ?? 0,
        details = json['details'] ?? 0,
        SyncStatus = json['SyncStatus'] ?? "",
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0,
        Lat = json['Lat'].toString(),
        Long = json['Long'].toString(),
        managerStaff = json['managerStaff'] ?? 0,
        extensionOfficerStaff = json['extensionOfficerStaff'] ?? 0,
        zone = json['zone'] ?? 0;

  Map<String, dynamic> toJson(Animal_weight_entry_model h) {
    return {
      'TagId': h.TagId,
      'Date': h.Date,
      'ChestGirth': h.ChestGirth,
      'Weight': h.Weight,
      'Length': h.Length,
      'WeightGain': h.WeightGain,
      'AutoNo': h.AutoNo,
      'details': h.details,
      'SyncStatus': h.SyncStatus,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
      'Lat': h.Lat,
      'Long': h.Long,
      'managerStaff': h.managerStaff,
      'extensionOfficerStaff': h.extensionOfficerStaff,
      'zone': h.zone
    };
  }

}
