import 'package:hive/hive.dart';

part 'Animal_Deworming.g.dart';

@HiveType(typeId: 33)
class Animal_Deworming extends HiveObject {
  @HiveField(0)
  var tagId;
  @HiveField(1)
  String date;
  @HiveField(2)
  var batchNo;
  @HiveField(3)
  var dose;
  @HiveField(4)
  String redewormingDate;
  @HiveField(5)
  var cost;
  @HiveField(6)
  var lat;
  @HiveField(7)
  var long;
  @HiveField(8)
  var details;
  @HiveField(9)
  var dewormingType;
  @HiveField(10)
  var dewormerMedicine;
  @HiveField(11)
  var medicineRoute;
  @HiveField(12)
  var doneBy;
  @HiveField(13)
  var managerStaff;
  @HiveField(14)
  var extensionOfficerStaff;
  @HiveField(15)
  var zone;
  @HiveField(16)
  var id;
  @HiveField(17)
  String createdAt;
  @HiveField(18)
  String updatedAt;
  @HiveField(19)
  var lastUpdatedByUser;
  @HiveField(20)
  var createdByUser;
  @HiveField(21)
  var herd;
  @HiveField(22)
  var lot;
  @HiveField(23)
  var farmer;
  @HiveField(24)
  var serverID;
  @HiveField(25)
  var clientID;
  @HiveField(26)
  var SyncStatus;

  Animal_Deworming(
      {required this.tagId,
      required this.date,
      required this.batchNo,
      required this.dose,
      required this.redewormingDate,
      required this.cost,
      required this.lat,
      required this.long,
      required this.details,
      required this.dewormingType,
      required this.dewormerMedicine,
      required this.medicineRoute,
      required this.doneBy,
      required this.managerStaff,
      required this.extensionOfficerStaff,
      required this.zone,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser,
      required this.herd,
      required this.lot,
      required this.farmer,
      required this.serverID,
      required this.clientID,
      required this.SyncStatus});

  Animal_Deworming.fromJson(Map<String, dynamic> json)
      : tagId = json['TagId'] ?? 0,
        date = json['Date'] ?? "",
        batchNo = json['BatchNo'] ?? 0,
        dose = json['Dose'] ?? 0,
        redewormingDate = json['RedewormingDate'] ?? "",
        cost = json['Cost'] ?? 0,
        lat = json['Lat'] ?? 0,
        long = json['Long'] ?? 0,
        details = json['details'] ?? 0,
        dewormingType = json['dewormingType'] ?? 0,
        dewormerMedicine = json['dewormerMedicine'] ?? 0,
        medicineRoute = json['medicineRoute'] ?? 0,
        doneBy = json['doneBy'] ?? 0,
        managerStaff = json['managerStaff'] ?? 0,
        extensionOfficerStaff = json['extensionOfficerStaff'] ?? 0,
        zone = json['zone'] ?? 0,
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0,
        herd = json['herd'] ?? 0,
        lot = json['lot'] ?? 0,
        farmer = json['farmer'] ?? 0,
        serverID = json['serverID'] ?? 0,
        clientID = json['clientID'],
        SyncStatus = json['SyncStatus'] ?? "0";

  Map<String, dynamic> toJson(Animal_Deworming h) {
    return {
      'TagId': h.tagId,
      'Date': h.date,
      'BatchNo': h.batchNo,
      'Dose': h.dose,
      'RedewormingDate': h.redewormingDate,
      'Cost': h.cost,
      'Lat': h.lat,
      'Long': h.long,
      'details': h.details,
      'dewormingType': h.dewormingType,
      'dewormerMedicine': h.dewormerMedicine,
      'medicineRoute': h.medicineRoute,
      'doneBy': h.doneBy,
      'managerStaff': h.managerStaff,
      'extensionOfficerStaff': h.extensionOfficerStaff,
      'zone': h.zone,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
      'herd': h.herd,
      'lot': h.lot,
      'farmer': h.farmer,
      'serverID': h.serverID,
      'clientID': h.clientID,
      'SyncStatus': h.SyncStatus,
    };
  }
}
