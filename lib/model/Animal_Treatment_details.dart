import 'package:hive/hive.dart';

part 'Animal_Treatment_details.g.dart';

@HiveType(typeId: 37)
class Animal_Treatment_details extends HiveObject {
  @HiveField(0)
  var tagId;
  @HiveField(1)
  var date;
  @HiveField(2)
  var treatmentSequence;
  @HiveField(3)
  var tradeName;
  @HiveField(4)
  var doseRate;
  @HiveField(5)
  var totalDose;
  @HiveField(6)
  var batchNo;
  @HiveField(7)
  var medicineCode;
  @HiveField(8)
  var medicineLedger;
  @HiveField(9)
  var medicineRoute;
  @HiveField(10)
  var details;
  @HiveField(11)
  var id;
  @HiveField(12)
  var createdAt;
  @HiveField(13)
  var updatedAt;
  @HiveField(14)
  var lastUpdatedByUser;
  @HiveField(15)
  var createdByUser;
  @HiveField(16)
  var herd;
  @HiveField(17)
  var lot;
  @HiveField(18)
  var farmer;
  @HiveField(19)
  var serverID;
  @HiveField(20)
  var clientID;
  @HiveField(21)
  var syncstatus;

  Animal_Treatment_details(
      {required this.tagId,
      required this.date,
      required this.treatmentSequence,
      required this.tradeName,
      required this.doseRate,
      required this.totalDose,
      required this.batchNo,
      required this.medicineCode,
      required this.medicineLedger,
      required this.medicineRoute,
      required this.details,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser,
      required this.herd,
      required this.lot,
      required this.farmer,
      required this.serverID,
      required this.syncstatus,
      required this.clientID});

  Animal_Treatment_details.fromJson(Map<String, dynamic> json)
      : tagId = json['TagId'] ?? 0,
        date = json['Date'] ?? "",
        treatmentSequence = json['TreatmentSequence'] ?? 0,
        tradeName = json['TradeName'] ?? "",
        doseRate = json['DoseRate'] ?? 0,
        totalDose = json['TotalDose'] ?? 0,
        batchNo = json['BatchNo'] ?? "",
        medicineCode = json['MedicineCode'] ?? 0,
        medicineLedger = json['medicineLedger'] ?? 0,
        medicineRoute = json['medicineRoute'] ?? 0,
        details = json['details'] ?? 0,
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
        syncstatus = json['syncstatus'] ?? "1";

  Map<String, dynamic> toJson(Animal_Treatment_details h) {
    return {
      'TagId': h.tagId,
      'Date': h.date,
      'TreatmentSequence': h.treatmentSequence,
      'TradeName': h.tradeName,
      'DoseRate': h.doseRate,
      'TotalDose': h.totalDose,
      'BatchNo': h.batchNo,
      'MedicineCode': h.medicineCode,
      'medicineLedger': h.medicineLedger,
      'medicineRoute': h.medicineRoute,
      'details': h.details,
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
      'syncstatus': h.syncstatus
    };
  }
}
