import 'package:hive/hive.dart';

part 'Animal_Vaccination.g.dart';

@HiveType(typeId: 40)
class Animal_Vaccination extends HiveObject {
  @HiveField(0)
  String TagId;
  @HiveField(1)
  String DateOfVaccination;
  @HiveField(2)
  String BatchNo;
  @HiveField(3)
  String Dose;
  @HiveField(4)
  String Cost;
  @HiveField(5)
  int vaccine;
  @HiveField(6)
  int vaccinationType;
  @HiveField(7)
  int medicineRoute;
  @HiveField(8)
  int doneBy;
  @HiveField(9)
  int details;
  @HiveField(10)
  int id;
  @HiveField(11)
  String createdAt;
  @HiveField(12)
  String updatedAt;
  @HiveField(13)
  int lastUpdatedByUser;
  @HiveField(14)
  String SyncStatus;
  @HiveField(15)
  int createdByUser;
  @HiveField(16)
  String Lat;
  @HiveField(17)
  String Long;
  @HiveField(18)
  String managerStaff;
  @HiveField(19)
  String extensionOfficerStaff;
  @HiveField(20)
  String zone;
  @HiveField(21)
  String serverID;

  Animal_Vaccination(
      {required this.TagId,
      required this.DateOfVaccination,
      required this.BatchNo,
      required this.Dose,
      required this.Cost,
      required this.vaccine,
      required this.vaccinationType,
      required this.medicineRoute,
      required this.doneBy,
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
      required this.serverID,
      required this.zone});

  Animal_Vaccination.fromJson(Map<String, dynamic> json)
      : TagId = json['TagId'] ?? "",
        DateOfVaccination = json['DateOfVaccination'] ?? "",
        BatchNo = json['BatchNo'] ?? "",
        Dose = json['Dose'].toString(),
        Cost = json['Cost'].toString(),
        vaccine = json['vaccine'] ?? 0,
        vaccinationType = json['vaccinationType'] ?? 0,
        medicineRoute = json['medicineRoute'] ?? 0,
        doneBy = json['doneBy'] ?? 0,
        details = json['details'] ?? 0,
        SyncStatus = json['SyncStatus'] ?? "",
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0,
        Lat = json['Lat'].toString(),
        Long = json['Long'].toString(),
        managerStaff = json['managerStaff'] ?? "",
        extensionOfficerStaff = json['extensionOfficerStaff'] ?? "",
        serverID = json['serverID'] ?? "",
        zone = json['zone'] ?? "";

  Map<String, dynamic> toJson(Animal_Vaccination h) {
    return {
      "TagId": h.TagId,
      "DateOfVaccination": h.DateOfVaccination,
      "BatchNo": h.BatchNo,
      "Dose": h.Dose,
      "Cost": h.Cost,
      "vaccine": h.vaccine,
      "vaccinationType": h.vaccinationType,
      "medicineRoute": h.medicineRoute,
      "doneBy": h.doneBy,
      "details": h.details,
      'SyncStatus': h.SyncStatus,
      "id": h.id,
      "createdAt": h.createdAt,
      "updatedAt": h.updatedAt,
      "lastUpdatedByUser": h.lastUpdatedByUser,
      "createdByUser": h.createdByUser,
      'Lat': h.Lat,
      'Long': h.Long,
      'managerStaff': h.managerStaff,
      'extensionOfficerStaff': h.extensionOfficerStaff,
      'serverID': h.serverID,
      'zone': h.zone
    };
  }
}
