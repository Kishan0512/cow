import 'package:hive/hive.dart';

part 'Breeding_reproduction_id.g.dart';

@HiveType(typeId: 41)
class Breeding_reproduction_id extends HiveObject {
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
  var id;
  @HiveField(40)
  var SyncStatus;
  @HiveField(41)
  var CI;
  @HiveField(42)
  var Sirename;
  @HiveField(43)
  var insertflag;
  @HiveField(44)
  var AIDays;
  @HiveField(45)
  var CalvingPDDays;
  @HiveField(46)
  var AITname;
  @HiveField(47)
  var PDname;
  @HiveField(48)
  var PDResult;
  @HiveField(49)
  var PDdays;
  @HiveField(50)
  var Pregdays;
  @HiveField(51)
  var hI;
  @HiveField(52)
  var zone;
  @HiveField(53)
  var aICost;
  @HiveField(54)
  var createdAt;
  @HiveField(55)
  var updatedAt;
  @HiveField(56)
  var lastUpdatedByUser;
  @HiveField(57)
  var createdByUser;
  @HiveField(59)
  var TableNAme;
  @HiveField(58)
  var ServerId;

  Breeding_reproduction_id(
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
      required this.id,
      required this.SyncStatus,
      required this.CI,
      required this.Sirename,
      required this.insertflag,
      required this.AIDays,
      required this.CalvingPDDays,
      required this.AITname,
      required this.PDname,
      required this.PDResult,
      required this.PDdays,
      required this.Pregdays,
      required this.hI,
      required this.zone,
      required this.aICost,
      required this.createdAt,
      required this.createdByUser,
      required this.lastUpdatedByUser,
      required this.ServerId,
      required this.TableNAme,
      required this.updatedAt});

  Breeding_reproduction_id.fromJson(Map<String, dynamic> json)
      : tagId = json['TagId'] ?? "",
        parity = json['Parity'],
        heatSeq = json['HeatSeq'],
        heatDate = json['HeatDate'] ?? "",
        remPD1 = json['RemPD1'] ?? "",
        remPD2 = json['RemPD2'] ?? "",
        pDDate = json['PDDate'] ?? "",
        dateOfCalving = json['DateOfCalving'] ?? "",
        dateOfDry = json['DateOfDry'] ?? '',
        dryTreatment = json['DryTreatment'] ?? "",
        flag = json['Flag'],
        retantionOfPlecenta = json['RetantionOfPlecenta'] ?? 0,
        comments = json['Comments'] ?? "",
        reproductionProblemNote = json['ReproductionProblemNote'] ?? "",
        mobileOrDesktopEntryFlg = json['MobileOrDesktopEntryFlg'] ?? "",
        totalAIDose = json['TotalAIDose'],
        abortionSeq = json['AbortionSeq'],
        vaccine = json['Vaccine'],
        colostrum = json['Colostrum'],
        inseminationTicketNumber = json['InseminationTicketNumber'],
        pDTicketNumber = json['PDTicketNumber'],
        calvingTicketNumber = json['CalvingTicketNumber'],
        orderNumber = json['OrderNumber'],
        oTP = json['OTP'] ?? 0,
        eNTRY = json['ENTRY'] ?? "",
        lat = json['Lat'],
        long = json['Long'],
        details = json['details'] ?? "",
        inseminatorStaff = json['inseminatorStaff'] ?? 0,
        sire = json['sire'] ?? 0,
        pdBy = json['pdBy'] ?? 0,
        service = json['service'] ?? 0,
        pd1 = json['pd1'] ?? 0,
        pd2 = json['pd2'] ?? 0,
        sex = json['Sex'] ?? 0,
        calfSex = json['CalfSex'] ?? 0,
        calvingType = json['CalvingType'] ?? 0,
        calvingTypeOption = json['calvingTypeOption'] ?? 0,
        dryReason = json['DryReason'] ?? 0,
        id = json['id'] ?? "",
        CI = json['CI'] ?? "",
        Sirename = json['Sirename'] ?? "",
        insertflag = json['insertflag'] ?? "",
        AIDays = json['AIDays'] ?? "",
        CalvingPDDays = json['CalvingPDDays'] ?? "",
        AITname = json['AITname'] ?? "",
        PDname = json['PDname'] ?? "",
        PDResult = json['PDResult'] ?? "",
        PDdays = json['PDdays'] ?? 0,
        Pregdays = json['Pregdays'] ?? 0,
        SyncStatus = json['SyncStatus'] ?? "1",
        hI = json['HI'],
        zone = json['zone'],
        aICost = json['AICost'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        lastUpdatedByUser = json['lastUpdatedByUser'],
        createdByUser = json['createdByUser'],
        TableNAme = json['TableNAme'],
        ServerId = json['ServerId'] ?? '';

  static Map<String, dynamic> toMap(Breeding_reproduction_id h) {
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
      'id': h.id,
      'CI': h.CI,
      'Sirename': h.Sirename,
      'insertflag': h.insertflag,
      'AIDays': h.AIDays,
      'CalvingPDDays': h.CalvingPDDays,
      'AITname': h.AITname,
      'PDname': h.PDname,
      'PDResult': h.PDResult,
      'PDdays': h.PDdays,
      'Pregdays': h.Pregdays,
      'SyncStatus': h.SyncStatus,
      'HI': h.hI,
      'zone': h.zone,
      'AICost': h.aICost,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'ServerId': h.ServerId,
      'TableNAme': h.TableNAme,
      'createdByUser': h.createdByUser
    };
  }

  Map<String, dynamic> toJson(Breeding_reproduction_id h) {
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
      'id': h.id,
      'CI': h.CI,
      'Sirename': h.Sirename,
      'insertflag': h.insertflag,
      'AIDays': h.AIDays,
      'CalvingPDDays': h.CalvingPDDays,
      'AITname': h.AITname,
      'PDname': h.PDname,
      'PDResult': h.PDResult,
      'PDdays': h.PDdays,
      'Pregdays': h.Pregdays,
      'SyncStatus': h.SyncStatus,
      'HI': h.hI,
      'zone': h.zone,
      'AICost': h.aICost,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'ServerId': h.ServerId,
      'TableNAme': h.TableNAme,
      'createdByUser': h.createdByUser
    };
  }
}
