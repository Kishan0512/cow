import 'package:hive/hive.dart';

part 'Animal_Treatment.g.dart';

@HiveType(typeId: 38)
class Animal_Treatment extends HiveObject {
  @HiveField(0)
  var tagId;
  @HiveField(1)
  var fromDate;
  @HiveField(2)
  var toDate;
  @HiveField(3)
  var treatmentSequence;
  @HiveField(4)
  var noTreatment;
  @HiveField(5)
  var dateOfTreatment;
  @HiveField(6)
  var pulse;
  @HiveField(7)
  var respiration;
  @HiveField(8)
  var observation;
  @HiveField(9)
  var labTest;
  @HiveField(10)
  var cost;
  @HiveField(11)
  var followUpDate;
  @HiveField(12)
  var lat;
  @HiveField(13)
  var long;
  @HiveField(14)
  var treatmentComplaint;
  @HiveField(15)
  var systemAffected;
  @HiveField(16)
  var diagnosis;
  @HiveField(17)
  var temperature;
  @HiveField(18)
  var doctor;
  @HiveField(19)
  var details;
  @HiveField(20)
  var managerStaff;
  @HiveField(21)
  var extensionOfficerStaff;
  @HiveField(22)
  var zone;
  @HiveField(23)
  var id;
  @HiveField(24)
  var createdAt;
  @HiveField(25)
  var updatedAt;
  @HiveField(26)
  var lastUpdatedByUser;
  @HiveField(27)
  var createdByUser;
  @HiveField(28)
  var visitID;
  @HiveField(29)
  var receiptNo;
  @HiveField(30)
  var herd;
  @HiveField(31)
  var lot;
  @HiveField(32)
  var farmer;
  @HiveField(33)
  var serverID;
  @HiveField(34)
  var clientID;
  @HiveField(35)
  var SyncStatus;

  Animal_Treatment(
      {required this.tagId,
      required this.fromDate,
      required this.toDate,
      required this.treatmentSequence,
      required this.noTreatment,
      required this.dateOfTreatment,
      required this.temperature,
      required this.pulse,
      required this.respiration,
      required this.observation,
      required this.labTest,
      required this.cost,
      required this.followUpDate,
      required this.lat,
      required this.long,
      required this.treatmentComplaint,
      required this.systemAffected,
      required this.diagnosis,
      required this.doctor,
      required this.details,
      required this.managerStaff,
      required this.extensionOfficerStaff,
      required this.zone,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser,
      required this.visitID,
      required this.receiptNo,
      required this.herd,
      required this.lot,
      required this.farmer,
      required this.serverID,
      required this.clientID,
      required this.SyncStatus});

 static Map<String, dynamic> toJson1(Animal_Treatment h) {
    return {
      'TagId': h.tagId,
      'SyncStatus': h.SyncStatus,
      'FromDate': h.fromDate,
      'ToDate': h.toDate,
      'TreatmentSequence': h.treatmentSequence,
      'NoTreatment': h.noTreatment,
      'DateOfTreatment': h.dateOfTreatment,
      'Temperature': h.temperature,
      'Pulse': h.pulse,
      'Respiration': h.respiration,
      'Observation': h.observation,
      'LabTest': h.labTest,
      'Cost': h.cost,
      'FollowUpDate': h.followUpDate,
      'Lat': h.lat,
      'Long': h.long,
      'treatmentComplaint': h.treatmentComplaint,
      'systemAffected': h.systemAffected,
      'diagnosis': h.diagnosis,
      'doctor': h.doctor,
      'details': h.details,
      'managerStaff': h.managerStaff,
      'extensionOfficerStaff': h.extensionOfficerStaff,
      'zone': h.zone,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
      'VisitID': h.visitID,
      'ReceiptNo': h.receiptNo,
      'herd': h.herd,
      'lot': h.lot,
      'farmer': h.farmer,
      'serverID': h.serverID,
      'clientID': h.clientID
    };
  }
  Map<String, dynamic> toJson(Animal_Treatment h) {
    return {
      'TagId': h.tagId,
      'SyncStatus': h.SyncStatus,
      'FromDate': h.fromDate,
      'ToDate': h.toDate,
      'TreatmentSequence': h.treatmentSequence,
      'NoTreatment': h.noTreatment,
      'DateOfTreatment': h.dateOfTreatment,
      'Temperature': h.temperature,
      'Pulse': h.pulse,
      'Respiration': h.respiration,
      'Observation': h.observation,
      'LabTest': h.labTest,
      'Cost': h.cost,
      'FollowUpDate': h.followUpDate,
      'Lat': h.lat,
      'Long': h.long,
      'treatmentComplaint': h.treatmentComplaint,
      'systemAffected': h.systemAffected,
      'diagnosis': h.diagnosis,
      'doctor': h.doctor,
      'details': h.details,
      'managerStaff': h.managerStaff,
      'extensionOfficerStaff': h.extensionOfficerStaff,
      'zone': h.zone,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
      'VisitID': h.visitID,
      'ReceiptNo': h.receiptNo,
      'herd': h.herd,
      'lot': h.lot,
      'farmer': h.farmer,
      'serverID': h.serverID,
      'clientID': h.clientID
    };
  }

  Animal_Treatment.fromJson(Map<String, dynamic> json)
      : tagId = json['TagId'] ?? 0,
        fromDate = json['FromDate'] ?? "",
        toDate = json['ToDate'] ?? "",
        treatmentSequence = json['TreatmentSequence'] ?? 0,
        noTreatment = json['NoTreatment'] ?? 0,
        dateOfTreatment = json['DateOfTreatment'],
        temperature = json['Temperature'] ?? 0,
        pulse = json['Pulse'] ?? 0,
        respiration = json['Respiration'] ?? 0,
        observation = json['Observation'] ?? "",
        labTest = json['LabTest'] ?? "",
        cost = json['Cost'] ?? "",
        followUpDate = json['FollowUpDate'] ?? "",
        lat = json['Lat'] ?? 0,
        long = json['Long'] ?? 0,
        treatmentComplaint = json['treatmentComplaint'] ?? 0,
        systemAffected = json['systemAffected'] ?? 0,
        diagnosis = json['diagnosis'] ?? 0,
        doctor = json['doctor'] ?? 0,
        details = json['details'] ?? 0,
        managerStaff = json['managerStaff'] ?? 0,
        extensionOfficerStaff = json['extensionOfficerStaff'] ?? 0,
        zone = json['zone'] ?? 0,
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0,
        visitID = json['VisitID'] ?? 0,
        receiptNo = json['ReceiptNo'] ?? "",
        herd = json['herd'] ?? 0,
        lot = json['lot'] ?? 0,
        farmer = json['farmer'] ?? 0,
        serverID = json['serverID'] ?? 0,
        SyncStatus = json['SyncStatus'] ?? "1",
        clientID = json['clientID'];
}
