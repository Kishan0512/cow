import 'package:hive/hive.dart';

part 'Visit_Registration.g.dart';

@HiveType(typeId: 44)
class Visit_Registration extends HiveObject {
  @HiveField(0)
  var visitID;
  @HiveField(1)
  var dCSCode;
  @HiveField(2)
  var dCSSAPCode;
  @HiveField(3)
  var dCSName;
  @HiveField(4)
  var farmerCode;
  @HiveField(5)
  var farmerName;
  @HiveField(6)
  var farmerMobile;
  @HiveField(7)
  var address;
  @HiveField(8)
  var registerBy;
  @HiveField(9)
  var registerNo;
  @HiveField(10)
  var arrivaltime;
  @HiveField(11)
  var complaint;
  @HiveField(12)
  var animalID;
  @HiveField(13)
  var visitCost;
  @HiveField(14)
  var species;
  @HiveField(15)
  var lotID;
  @HiveField(16)
  var requestType;
  @HiveField(17)
  var lotname;
  @HiveField(18)
  var herd;
  @HiveField(19)
  var herdName;
  @HiveField(20)
  var masterStaff;
  @HiveField(21)
  var extensionOfficerStaff;
  @HiveField(22)
  var farmerid;
  @HiveField(23)
  var compliaintid;
  @HiveField(24)
  var status;
  @HiveField(25)
  var date;
  @HiveField(26)
  var vO;
  @HiveField(27)
  String syncStaus;

  Visit_Registration(
      {required this.visitID,
      required this.dCSCode,
      required this.dCSSAPCode,
      required this.dCSName,
      required this.farmerCode,
      required this.farmerName,
      required this.farmerMobile,
      required this.address,
      required this.registerBy,
      required this.registerNo,
      required this.arrivaltime,
      required this.complaint,
      required this.animalID,
      required this.visitCost,
      required this.species,
      required this.lotID,
      required this.requestType,
      required this.lotname,
      required this.herd,
      required this.herdName,
      required this.masterStaff,
      required this.extensionOfficerStaff,
      required this.farmerid,
      required this.compliaintid,
      required this.status,
      required this.date,
      required this.vO,
      required this.syncStaus});

  Visit_Registration.fromJson(Map<String, dynamic> json)
      : visitID = json['VisitID'],
        dCSCode = json['DCSCode'],
        dCSSAPCode = json['DCSSAPCode'],
        dCSName = json['DCSName'],
        farmerCode = json['FarmerCode'],
        farmerName = json['FarmerName'],
        farmerMobile = json['FarmerMobile'],
        address = json['address'],
        registerBy = json['RegisterBy'],
        registerNo = json['RegisterNo'],
        arrivaltime = json['Arrivaltime'],
        complaint = json['Complaint'],
        animalID = json['AnimalID'],
        visitCost = json['VisitCost'],
        species = json['Species'],
        lotID = json['lotID'],
        requestType = json['RequestType'],
        lotname = json['lotname'],
        herd = json['herd'],
        herdName = json['herd_name'],
        masterStaff = json['masterStaff'],
        extensionOfficerStaff = json['extensionOfficerStaff'],
        farmerid = json['farmerid'],
        compliaintid = json['compliaintid'],
        status = json['Status'],
        date = json['Date'],
        vO = json['VO'],
        syncStaus = json['syncStaus'] ?? "1";

  static Map<String, dynamic> toJson(Visit_Registration h) {
    return {
      'VisitID': h.visitID,
      'DCSCode': h.dCSCode,
      'DCSSAPCode': h.dCSSAPCode,
      'DCSName': h.dCSName,
      'FarmerCode': h.farmerCode,
      'FarmerName': h.farmerName,
      'FarmerMobile': h.farmerMobile,
      'address': h.address,
      'RegisterBy': h.registerBy,
      'RegisterNo': h.registerNo,
      'Arrivaltime': h.arrivaltime,
      'Complaint': h.complaint,
      'AnimalID': h.animalID,
      'VisitCost': h.visitCost,
      'Species': h.species,
      'lotID': h.lotID,
      'RequestType': h.requestType,
      'lotname': h.lotname,
      'herd': h.herd,
      'herd_name': h.herdName,
      'masterStaff': h.masterStaff,
      'extensionOfficerStaff': h.extensionOfficerStaff,
      'farmerid': h.farmerid,
      'compliaintid': h.compliaintid,
      'Status': h.status,
      'Date': h.date,
      'VO': h.vO
    };
  }
}
