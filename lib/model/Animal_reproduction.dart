import 'package:hive/hive.dart';

part 'Animal_reproduction.g.dart';

@HiveType(typeId: 34)
class Animal_reproduction extends HiveObject {
  @HiveField(0)
  var tagId;
  @HiveField(1)
  var parity;
  @HiveField(2)
  var heatSeq;
  @HiveField(3)
  var heatDate;
  @HiveField(4)
  var remPD1;
  @HiveField(5)
  var remPD2;
  @HiveField(6)
  var pDDate;
  @HiveField(7)
  var dateOfCalving;
  @HiveField(8)
  var dateOfDry;
  @HiveField(9)
  var dryTreatment;
  @HiveField(10)
  var flag;
  @HiveField(11)
  var retantionOfPlecenta;
  @HiveField(12)
  var comments;
  @HiveField(13)
  var reproductionProblemNote;
  @HiveField(14)
  var mobileOrDesktopEntryFlg;
  @HiveField(15)
  var totalAIDose;
  @HiveField(16)
  var abortionSeq;
  @HiveField(17)
  var vaccine;
  @HiveField(18)
  var colostrum;
  @HiveField(19)
  var inseminationTicketNumber;
  @HiveField(20)
  var pDTicketNumber;
  @HiveField(21)
  var calvingTicketNumber;
  @HiveField(22)
  var orderNumber;
  @HiveField(23)
  var oTP;
  @HiveField(24)
  var eNTRY;
  @HiveField(25)
  var lat;
  @HiveField(26)
  var long;
  @HiveField(27)
  var details;
  @HiveField(28)
  var inseminatorStaff;
  @HiveField(29)
  var sire;
  @HiveField(30)
  var pdBy;
  @HiveField(31)
  var service;
  @HiveField(32)
  var pd1;
  @HiveField(33)
  var pd2;
  @HiveField(34)
  var sex;
  @HiveField(35)
  var calfSex;
  @HiveField(36)
  var calvingType;
  @HiveField(37)
  var calvingTypeOption;
  @HiveField(38)
  var dryReason;
  @HiveField(39)
  var managerStaff;
  @HiveField(40)
  var extensionOfficerStaff;
  @HiveField(41)
  var zone;
  @HiveField(42)
  var id;
  @HiveField(43)
  var createdAt;
  @HiveField(44)
  var updatedAt;
  @HiveField(45)
  var lastUpdatedByUser;
  @HiveField(46)
  var createdByUser;
  @HiveField(47)
  var herd;
  @HiveField(48)
  var lot;
  @HiveField(49)
  var farmer;
  @HiveField(50)
  var sortedSemon;
  @HiveField(51)
  var strawImage;
  @HiveField(52)
  var batchNo;
  @HiveField(53)
  var aICost;
  @HiveField(54)
  var calfID;
  @HiveField(55)
  var calf2Sex;
  @HiveField(56)
  var calf2ID;
  @HiveField(57)
  var image1;
  @HiveField(58)
  var image2;
  @HiveField(59)
  var entryflag;
  @HiveField(60)
  var pDdays;
  @HiveField(61)
  var elegibleAI;
  @HiveField(62)
  var pregdays;
  @HiveField(63)
  var unknownSire;
  @HiveField(64)
  var eligibleAISEq;
  @HiveField(65)
  var serverID;
  @HiveField(66)
  var clientID;

  Animal_reproduction(
      {required this.tagId,
      required this.parity,
      required this.heatSeq,
      required this.heatDate,
      required this.remPD1,
      required this.remPD2,
      required this.pDDate,
      required this.dateOfCalving,
      required this.dateOfDry,
      required this.dryTreatment,
      required this.flag,
      required this.retantionOfPlecenta,
      required this.comments,
      required this.reproductionProblemNote,
      required this.mobileOrDesktopEntryFlg,
      required this.totalAIDose,
      required this.abortionSeq,
      required this.vaccine,
      required this.colostrum,
      required this.inseminationTicketNumber,
      required this.pDTicketNumber,
      required this.calvingTicketNumber,
      required this.orderNumber,
      required this.oTP,
      required this.eNTRY,
      required this.lat,
      required this.long,
      required this.details,
      required this.inseminatorStaff,
      required this.sire,
      required this.pdBy,
      required this.service,
      required this.pd1,
      required this.pd2,
      required this.sex,
      required this.calfSex,
      required this.calvingType,
      required this.calvingTypeOption,
      required this.dryReason,
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
      required this.sortedSemon,
      required this.strawImage,
      required this.batchNo,
      required this.aICost,
      required this.calfID,
      required this.calf2Sex,
      required this.calf2ID,
      required this.image1,
      required this.image2,
      required this.entryflag,
      required this.pDdays,
      required this.elegibleAI,
      required this.pregdays,
      required this.unknownSire,
      required this.eligibleAISEq,
      required this.serverID,
      required this.clientID});

  Animal_reproduction.fromJson(Map<dynamic, dynamic> json)
      : tagId = json['TagId'] ?? 0,
        parity = json['Parity'] ?? 0,
        heatSeq = json['HeatSeq'] ?? 0,
        heatDate = json['HeatDate'] ?? "",
        remPD1 = json['RemPD1'] ?? "",
        remPD2 = json['RemPD2'] ?? "",
        pDDate = json['PDDate'] ?? "",
        dateOfCalving = json['DateOfCalving'] ?? "",
        dateOfDry = json['DateOfDry'] ?? "",
        dryTreatment = json['DryTreatment'] ?? "",
        flag = json['Flag'] ?? 0,
        retantionOfPlecenta = json['RetantionOfPlecenta'] ?? 0,
        comments = json['Comments'] ?? "",
        reproductionProblemNote = json['ReproductionProblemNote'] ?? "",
        mobileOrDesktopEntryFlg = json['MobileOrDesktopEntryFlg'] ?? "",
        totalAIDose = json['TotalAIDose'] ?? 0,
        abortionSeq = json['AbortionSeq'] ?? 0,
        vaccine = json['Vaccine'] ?? 0,
        colostrum = json['Colostrum'] ?? 0,
        inseminationTicketNumber = json['InseminationTicketNumber'] ?? "",
        pDTicketNumber = json['PDTicketNumber'] ?? "",
        calvingTicketNumber = json['CalvingTicketNumber'] ?? "",
        orderNumber = json['OrderNumber'] ?? "",
        oTP = json['OTP'] ?? 0,
        eNTRY = json['ENTRY'] ?? "",
        lat = json['Lat'] ?? 0,
        long = json['Long'] ?? 0,
        details = json['details'] ?? 0,
        inseminatorStaff = json['inseminatorStaff'],
        sire = json['sire'] ?? 0,
        pdBy = json['pdBy'],
        service = json['service'] ?? 0,
        pd1 = json['pd1'] ?? 0,
        pd2 = json['pd2'] ?? 0,
        sex = json['Sex'] ?? 0,
        calfSex = json['CalfSex'] ?? 0,
        calvingType = json['CalvingType'] ?? 0,
        calvingTypeOption = json['calvingTypeOption'] ?? 0,
        dryReason = json['DryReason'] ?? "",
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
        sortedSemon = json['SortedSemon'] ?? false,
        strawImage = json['StrawImage'] ?? "",
        batchNo = json['BatchNo'] ?? "",
        aICost = json['AICost'] ?? "",
        calfID = json['CalfID'] ?? "",
        calf2Sex = json['Calf2Sex'] ?? "",
        calf2ID = json['Calf2ID'] ?? "",
        image1 = json['image1'] ?? "",
        image2 = json['image2'] ?? "",
        entryflag = json['Entryflag'] ?? false,
        pDdays = json['PDdays'] ?? 0,
        elegibleAI = json['ElegibleAI'] ?? false,
        pregdays = json['Pregdays'] ?? 0,
        unknownSire = json['UnknownSire'] ?? false,
        eligibleAISEq = json['EligibleAISEq'] ?? 0,
        serverID = json['serverID'] ?? 0,
        clientID = json['clientID'] ?? 0;

  Map<dynamic, dynamic> toJson(Animal_reproduction h) {
    return {
      'TagId': h.tagId,
      'Parity': h.parity,
      'HeatSeq': h.heatSeq,
      'HeatDate': h.heatDate,
      'RemPD1': h.remPD1,
      'RemPD2': h.remPD2,
      'PDDate': h.pDDate,
      'DateOfCalving': h.dateOfCalving,
      'DateOfDry': h.dateOfDry,
      'DryTreatment': h.dryTreatment,
      'Flag': h.flag,
      'RetantionOfPlecenta': h.retantionOfPlecenta,
      'Comments': h.comments,
      'ReproductionProblemNote': h.reproductionProblemNote,
      'MobileOrDesktopEntryFlg': h.mobileOrDesktopEntryFlg,
      'TotalAIDose': h.totalAIDose,
      'AbortionSeq': h.abortionSeq,
      'Vaccine': h.vaccine,
      'Colostrum': h.colostrum,
      'InseminationTicketNumber': h.inseminationTicketNumber,
      'PDTicketNumber': h.pDTicketNumber,
      'CalvingTicketNumber': h.calvingTicketNumber,
      'OrderNumber': h.orderNumber,
      'OTP': h.oTP,
      'ENTRY': h.eNTRY,
      'Lat': h.lat,
      'Long': h.long,
      'details': h.details,
      'inseminatorStaff': h.inseminatorStaff,
      'sire': h.sire,
      'pdBy': h.pdBy,
      'service': h.service,
      'pd1': h.pd1,
      'pd2': h.pd2,
      'Sex': h.sex,
      'CalfSex': h.calfSex,
      'CalvingType': h.calvingType,
      'calvingTypeOption': h.calvingTypeOption,
      'DryReason': h.dryReason,
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
      'SortedSemon': h.sortedSemon,
      'StrawImage': h.strawImage,
      'BatchNo': h.batchNo,
      'AICost': h.aICost,
      'CalfID': h.calfID,
      'Calf2Sex': h.calf2Sex,
      'Calf2ID': h.calf2ID,
      'image1': h.image1,
      'image2': h.image2,
      'Entryflag': h.entryflag,
      'PDdays': h.pDdays,
      'ElegibleAI': h.elegibleAI,
      'Pregdays': h.pregdays,
      'UnknownSire': h.unknownSire,
      'EligibleAISEq': h.eligibleAISEq,
      'serverID': h.serverID,
      'clientID': h.clientID
    };
  }
}
