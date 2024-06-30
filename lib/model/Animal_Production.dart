import 'package:hive/hive.dart';

part 'Animal_Production.g.dart';

@HiveType(typeId: 35)
class Animal_Production extends HiveObject {
  @HiveField(0)
  var tagId;
  @HiveField(1)
  var date;
  @HiveField(2)
  var parity;
  @HiveField(3)
  var morningYield;
  @HiveField(4)
  var eveningYield;
  @HiveField(5)
  var nightYield;
  @HiveField(6)
  var midnightYield;
  @HiveField(7)
  var fat;
  @HiveField(8)
  var snf;
  @HiveField(9)
  var lactose;
  @HiveField(10)
  var protein;
  @HiveField(11)
  var fatC;
  @HiveField(12)
  var snfC;
  @HiveField(13)
  var lactoseC;
  @HiveField(14)
  var proteinC;
  @HiveField(15)
  var cumulativeMilkTotal;
  @HiveField(16)
  var lactationMilkTotal;
  @HiveField(17)
  var daysCount;
  @HiveField(18)
  var solidsc;
  @HiveField(19)
  var solids;
  @HiveField(20)
  var eFAT;
  @HiveField(21)
  var eSNF;
  @HiveField(22)
  var nFAT;
  @HiveField(23)
  var nSNF;
  @HiveField(24)
  var mFAT;
  @HiveField(25)
  var mSNF;
  @HiveField(26)
  var cLR;
  @HiveField(27)
  var cFU;
  @HiveField(28)
  var acidity;
  @HiveField(29)
  var officialMilk;
  @HiveField(30)
  var lat;
  @HiveField(31)
  var long;
  @HiveField(32)
  var dayMilkTotal;
  @HiveField(33)
  var details;
  @HiveField(34)
  var managerStaff;
  @HiveField(35)
  var extensionOfficerStaff;
  @HiveField(36)
  var zone;
  @HiveField(37)
  var id;
  @HiveField(38)
  var createdAt;
  @HiveField(39)
  var updatedAt;
  @HiveField(40)
  var lastUpdatedByUser;
  @HiveField(41)
  var createdByUser;
  @HiveField(42)
  var herd;
  @HiveField(43)
  var lot;
  @HiveField(44)
  var farmer;
  @HiveField(45)
  var boxno;
  @HiveField(46)
  var bottleno;
  @HiveField(47)
  var staff;
  @HiveField(48)
  var serverID;
  @HiveField(49)
  var clientID;
  @HiveField(50)
  var SyncStatus;

  Animal_Production(
      {required this.tagId,
      required this.date,
      required this.parity,
      required this.morningYield,
      required this.eveningYield,
      required this.nightYield,
      required this.midnightYield,
      required this.fat,
      required this.snf,
      required this.lactose,
      required this.protein,
      required this.fatC,
      required this.snfC,
      required this.lactoseC,
      required this.proteinC,
      required this.cumulativeMilkTotal,
      required this.lactationMilkTotal,
      required this.daysCount,
      required this.solidsc,
      required this.solids,
      required this.eFAT,
      required this.eSNF,
      required this.nFAT,
      required this.nSNF,
      required this.mFAT,
      required this.mSNF,
      required this.cLR,
      required this.cFU,
      required this.acidity,
      required this.officialMilk,
      required this.lat,
      required this.long,
      required this.dayMilkTotal,
      required this.details,
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
      required this.boxno,
      required this.bottleno,
      required this.staff,
      required this.serverID,
      required this.clientID,
      required this.SyncStatus
      });

  Animal_Production.fromJson(Map<String, dynamic> json)
      : tagId = json['TagId'] ?? 0,
        date = json['Date'] ?? "",
        parity = json['Parity'] ?? 0,
        morningYield = json['MorningYield'] ?? 0,
        eveningYield = json['EveningYield'] ?? 0,
        nightYield = json['NightYield'] ?? 0,
        midnightYield = json['MidnightYield'] ?? 0,
        fat = json['Fat'] ?? "",
        snf = json['Snf'] ?? "",
        lactose = json['Lactose'] ?? "",
        protein = json['Protein'] ?? "",
        fatC = json['FatC'] ?? "",
        snfC = json['SnfC'] ?? "",
        lactoseC = json['LactoseC'] ?? "",
        proteinC = json['ProteinC'] ?? "",
        cumulativeMilkTotal = json['CumulativeMilkTotal'] ?? "",
        lactationMilkTotal = json['LactationMilkTotal'] ?? "",
        daysCount = json['DaysCount'] ?? 0,
        solidsc = json['Solidsc'] ?? "",
        solids = json['Solids'] ?? "",
        eFAT = json['EFAT'] ?? "",
        eSNF = json['ESNF'] ?? "",
        nFAT = json['NFAT'] ?? "",
        nSNF = json['NSNF'] ?? "",
        mFAT = json['MFAT'] ?? "",
        mSNF = json['MSNF'] ?? "",
        cLR = json['CLR'] ?? "",
        cFU = json['CFU'] ?? "",
        acidity = json['Acidity'] ?? "",
        officialMilk = json['OfficialMilk'] ?? "",
        lat = json['Lat'] ?? 0,
        long = json['Long'] ?? 0,
        dayMilkTotal = json['DayMilkTotal'] ?? 0,
        details = json['details'] ?? 0,
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
        boxno = json['boxno'] ?? 0,
        bottleno = json['bottleno'] ?? 0,
        staff = json['Staff'] ?? "",
        serverID = json['serverID'] ?? 0,
        SyncStatus=json['SyncStatus']?? "0",
        clientID = json['clientID'];

  Map<String, dynamic> toJson(Animal_Production h) {
    return {
      'TagId': h.tagId,
      'Date': h.date,
      'Parity': h.parity,
      'MorningYield': h.morningYield,
      'EveningYield': h.eveningYield,
      'NightYield': h.nightYield,
      'MidnightYield': h.midnightYield,
      'Fat': h.fat,
      'Snf': h.snf,
      'Lactose': h.lactose,
      'Protein': h.protein,
      'FatC': h.fatC,
      'SnfC': h.snfC,
      'LactoseC': h.lactoseC,
      'ProteinC': h.proteinC,
      'CumulativeMilkTotal': h.cumulativeMilkTotal,
      'LactationMilkTotal': h.lactationMilkTotal,
      'DaysCount': h.daysCount,
      'Solidsc': h.solidsc,
      'Solids': h.solids,
      'EFAT': h.eFAT,
      'ESNF': h.eSNF,
      'NFAT': h.nFAT,
      'NSNF': h.nSNF,
      'MFAT': h.mFAT,
      'MSNF': h.mSNF,
      'CLR': h.cLR,
      'CFU': h.cFU,
      'Acidity': h.acidity,
      'OfficialMilk': h.officialMilk,
      'Lat': h.lat,
      'Long': h.long,
      'SyncStatus' : h.SyncStatus,
      'DayMilkTotal': h.dayMilkTotal,
      'details': h.details,
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
      'boxno': h.boxno,
      'bottleno': h.bottleno,
      'Staff': h.staff,
      'serverID': h.serverID,
      'clientID': h.clientID
    };
  }
}
