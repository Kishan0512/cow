import 'package:hive/hive.dart';

part 'Animal_details.g.dart';

@HiveType(typeId: 30)
class Animal_details extends HiveObject {
  @HiveField(0)
  String tagId;
  @HiveField(1)
  var code;
  @HiveField(2)
  String name;
  @HiveField(3)
  String dOB;
  @HiveField(4)
  var age;
  @HiveField(5)
  var birthWeight;
  @HiveField(6)
  var salvageFlag;
  @HiveField(7)
  var groupFlag;
  @HiveField(8)
  var catCalfFlag;
  @HiveField(9)
  var sensorNo;
  @HiveField(10)
  var photo;
  @HiveField(11)
  var parity;
  @HiveField(12)
  var selectCancel;
  @HiveField(13)
  var insuranceNo;
  @HiveField(14)
  var aITagNo;
  @HiveField(15)
  var currentParity;
  @HiveField(16)
  String registrationDate;
  @HiveField(17)
  var marketValue;
  @HiveField(18)
  var nORings;
  @HiveField(19)
  var rearingPurpose;
  @HiveField(20)
  var color;
  @HiveField(21)
  var hornDistance;
  @HiveField(22)
  var policyPeriod;
  @HiveField(23)
  var transactionDate;
  @HiveField(24)
  var hypothecation;
  @HiveField(25)
  var hypothecationNo;
  @HiveField(26)
  var doctor;
  @HiveField(27)
  var sendCMS;
  @HiveField(28)
  var insuranceFlag;
  @HiveField(29)
  String breedingStatus;
  @HiveField(30)
  String heatDate;
  @HiveField(31)
  var heatSeq;
  @HiveField(32)
  var abortionSeq;
  @HiveField(33)
  String pDDate;
  @HiveField(34)
  String calvingDate;
  @HiveField(35)
  String dryDate;
  @HiveField(36)
  String milkDate;
  @HiveField(37)
  var lastMilk;
  @HiveField(38)
  var totalMilk;
  @HiveField(39)
  var selectFlag;
  @HiveField(40)
  var selectRemarks;
  @HiveField(41)
  var selectColor;
  @HiveField(42)
  var disposalRemarks;
  @HiveField(43)
  var isSuspended;
  @HiveField(44)
  var syncStatus;
  @HiveField(45)
  var lat;
  @HiveField(46)
  var long;
  @HiveField(47)
  var species;
  @HiveField(48)
  var breed;
  @HiveField(49)
  var herd;
  @HiveField(50)
  var lot;
  @HiveField(51)
  var farmer;
  @HiveField(52)
  var status;
  @HiveField(53)
  var lastSire;
  @HiveField(54)
  var sire;
  @HiveField(55)
  var dam;
  @HiveField(56)
  var paternalSire;
  @HiveField(57)
  var paternalDam;
  @HiveField(58)
  var pd1;
  @HiveField(59)
  var pd2;
  @HiveField(60)
  var sexFlg;
  @HiveField(61)
  var managerStaff;
  @HiveField(62)
  var extensionOfficerStaff;
  @HiveField(63)
  var zone;
  @HiveField(64)
  var disposalFlag;
  @HiveField(65)
  var pBFlag;
  @HiveField(66)
  var virtualLot;
  @HiveField(67)
  int id;
  @HiveField(68)
  String createdAt;
  @HiveField(69)
  String updatedAt;
  @HiveField(70)
  var lastUpdatedByUser;
  @HiveField(71)
  var createdByUser;
  @HiveField(72)
  var staff;
  @HiveField(73)
  var serverID;
  @HiveField(74)
  var clientID;

  Animal_details(
      {required this.tagId,
      required this.code,
      required this.name,
      required this.dOB,
      required this.age,
      required this.birthWeight,
      required this.salvageFlag,
      required this.groupFlag,
      required this.catCalfFlag,
      required this.sensorNo,
      required this.photo,
      required this.parity,
      required this.selectCancel,
      required this.insuranceNo,
      required this.aITagNo,
      required this.currentParity,
      required this.registrationDate,
      required this.marketValue,
      required this.nORings,
      required this.rearingPurpose,
      required this.color,
      required this.hornDistance,
      required this.policyPeriod,
      required this.transactionDate,
      required this.hypothecation,
      required this.hypothecationNo,
      required this.doctor,
      required this.sendCMS,
      required this.insuranceFlag,
      required this.breedingStatus,
      required this.heatDate,
      required this.heatSeq,
      required this.abortionSeq,
      required this.pDDate,
      required this.calvingDate,
      required this.dryDate,
      required this.milkDate,
      required this.lastMilk,
      required this.totalMilk,
      required this.selectFlag,
      required this.selectRemarks,
      required this.selectColor,
      required this.disposalRemarks,
      required this.isSuspended,
      required this.syncStatus,
      required this.lat,
      required this.long,
      required this.species,
      required this.breed,
      required this.herd,
      required this.lot,
      required this.farmer,
      required this.status,
      required this.lastSire,
      required this.sire,
      required this.dam,
      required this.paternalSire,
      required this.paternalDam,
      required this.pd1,
      required this.pd2,
      required this.sexFlg,
      required this.managerStaff,
      required this.extensionOfficerStaff,
      required this.zone,
      required this.disposalFlag,
      required this.pBFlag,
      required this.virtualLot,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser,
      required this.staff,
      required this.serverID,
      required this.clientID});

  Animal_details.fromJson(Map<String, dynamic> json)
      : tagId = json['TagId'] ?? "",
        code = json['code'],
        name = json['Name'] ?? "",
        dOB = json['DOB'] ?? "",
        age = json['Age'] ?? 0,
        birthWeight = json['BirthWeight'],
        salvageFlag = json['SalvageFlag'],
        groupFlag = json['GroupFlag'],
        catCalfFlag = json['CatCalfFlag'],
        sensorNo = json['SensorNo'],
        photo = json['Photo'],
        parity = json['Parity'] ?? 0,
        selectCancel = json['SelectCancel'],
        insuranceNo = json['InsuranceNo'],
        aITagNo = json['AITagNo'],
        currentParity = json['CurrentParity'] ?? 0,
        registrationDate = json['RegistrationDate'] ?? "",
        marketValue = json['MarketValue'],
        nORings = json['NORings'],
        rearingPurpose = json['RearingPurpose'],
        color = json['Color'],
        hornDistance = json['HornDistance'],
        policyPeriod = json['PolicyPeriod'],
        transactionDate = json['TransactionDate'],
        hypothecation = json['Hypothecation'],
        hypothecationNo = json['HypothecationNo'],
        doctor = json['Doctor'] ?? 0,
        sendCMS = json['SendCMS'],
        insuranceFlag = json['InsuranceFlag'],
        breedingStatus = json['BreedingStatus'] ?? "",
        heatDate = json['HeatDate'] ?? "",
        heatSeq = json['HeatSeq'] ?? 0,
        abortionSeq = json['AbortionSeq'],
        pDDate = json['PDDate'] ?? "",
        calvingDate = json['CalvingDate'] ?? "",
        dryDate = json['DryDate'] ?? "",
        milkDate = json['MilkDate'] ?? "",
        lastMilk = json['LastMilk'],
        totalMilk = json['TotalMilk'] ?? 0.0,
        selectFlag = json['SelectFlag'],
        selectRemarks = json['SelectRemarks'],
        selectColor = json['SelectColor'],
        disposalRemarks = json['DisposalRemarks'],
        isSuspended = json['IsSuspended'],
        syncStatus = json['SyncStatus'],
        lat = json['Lat'],
        long = json['Long'],
        species = json['species'] ?? 0,
        breed = json['breed'] ?? 0,
        herd = json['herd'] ?? 0,
        lot = json['lot'] ?? 0,
        farmer = json['farmer'] ?? 0,
        status = json['status'] ?? 0,
        lastSire = json['lastSire'] ?? 0,
        sire = json['sire'],
        dam = json['dam'],
        paternalSire = json['paternalSire'],
        paternalDam = json['paternalDam'],
        pd1 = json['pd1'] ?? 0,
        pd2 = json['pd2'] ?? 0,
        sexFlg = json['SexFlg'] ?? 0,
        managerStaff = json['managerStaff'],
        extensionOfficerStaff = json['extensionOfficerStaff'],
        zone = json['zone'] ?? 0,
        disposalFlag = json['DisposalFlag'],
        pBFlag = json['PBFlag'],
        virtualLot = json['virtualLot'],
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0,
        staff = json['Staff'] ?? 0,
        serverID = json['serverID'] ?? 0,
        clientID = json['clientID'] ?? 0;
  Map<String, dynamic> toJson(Animal_details h) {
    return {
      'TagId': h.tagId,
      'code': h.code,
      'Name': h.name,
      'DOB': h.dOB,
      'Age': h.age,
      'BirthWeight': h.birthWeight,
      'SalvageFlag': h.salvageFlag,
      'GroupFlag': h.groupFlag,
      'CatCalfFlag': h.catCalfFlag,
      'SensorNo': h.sensorNo,
      'Photo': h.photo,
      'Parity': h.parity,
      'SelectCancel': h.selectCancel,
      'InsuranceNo': h.insuranceNo,
      'AITagNo': h.aITagNo,
      'CurrentParity': h.currentParity,
      'RegistrationDate': h.registrationDate,
      'MarketValue': h.marketValue,
      'NORings': h.nORings,
      'RearingPurpose': h.rearingPurpose,
      'Color': h.color,
      'HornDistance': h.hornDistance,
      'PolicyPeriod': h.policyPeriod,
      'TransactionDate': h.transactionDate,
      'Hypothecation': h.hypothecation,
      'HypothecationNo': h.hypothecationNo,
      'Doctor': h.doctor,
      'SendCMS': h.sendCMS,
      'InsuranceFlag': h.insuranceFlag,
      'BreedingStatus': h.breedingStatus,
      'HeatDate': h.heatDate,
      'HeatSeq': h.heatSeq,
      'AbortionSeq': h.abortionSeq,
      'PDDate': h.pDDate,
      'CalvingDate': h.calvingDate,
      'DryDate': h.dryDate,
      'MilkDate': h.milkDate,
      'LastMilk': h.lastMilk,
      'TotalMilk': h.totalMilk,
      'SelectFlag': h.selectFlag,
      'SelectRemarks': h.selectRemarks,
      'SelectColor': h.selectColor,
      'DisposalRemarks': h.disposalRemarks,
      'IsSuspended': h.isSuspended,
      'SyncStatus': h.syncStatus,
      'Lat': h.lat,
      'Long': h.long,
      'species': h.species,
      'breed': h.breed,
      'herd': h.herd,
      'lot': h.lot,
      'farmer': h.farmer,
      'status': h.status,
      'lastSire': h.lastSire,
      'sire': h.sire,
      'dam': h.dam,
      'paternalSire': h.paternalSire,
      'paternalDam': h.paternalDam,
      'pd1': h.pd1,
      'pd2': h.pd2,
      'SexFlg': h.sexFlg,
      'managerStaff': h.managerStaff,
      'extensionOfficerStaff': h.extensionOfficerStaff,
      'zone': h.zone,
      'DisposalFlag': h.disposalFlag,
      'PBFlag': h.pBFlag,
      'virtualLot': h.virtualLot,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
      'Staff': h.staff,
      'serverID': h.serverID,
      'clientID': h.clientID
    };
  }
}
