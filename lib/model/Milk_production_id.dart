import 'package:hive/hive.dart';

part 'Milk_production_id.g.dart';

@HiveType(typeId: 43)
class Milk_production_id extends HiveObject {
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
  var officialMilk;
  @HiveField(19)
  var lat;
  @HiveField(20)
  var long;
  @HiveField(21)
  var dayMilkTotal;
  @HiveField(22)
  var details;
  @HiveField(23)
  var id;
  @HiveField(24)
  var herd;
  @HiveField(25)
  var lot;
  @HiveField(26)
  var farmer;
  @HiveField(27)
  var boxno;
  @HiveField(28)
  var bottleno;
  @HiveField(29)
  var staff;
  @HiveField(30)
  var serverID;
  @HiveField(31)
  var clientID;
  @HiveField(32)
  var SyncStatus;

  Milk_production_id({
    required this.tagId,
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
    required this.officialMilk,
    required this.lat,
    required this.long,
    required this.dayMilkTotal,
    required this.details,
    required this.id,
    required this.herd,
    required this.lot,
    required this.farmer,
    required this.boxno,
    required this.bottleno,
    required this.staff,
    required this.SyncStatus,
    required this.clientID,
    required this.serverID,
  });

  Milk_production_id.fromJson(Map<String, dynamic> json)
      : tagId = json['TagId'],
        date = json['Date'],
        parity = json['Parity'],
        morningYield = json['MorningYield'],
        eveningYield = json['EveningYield'],
        nightYield = json['NightYield'],
        midnightYield = json['MidnightYield'],
        fat = json['Fat'],
        snf = json['Snf'],
        lactose = json['Lactose'],
        protein = json['Protein'],
        fatC = json['FatC'],
        snfC = json['SnfC'],
        lactoseC = json['LactoseC'],
        proteinC = json['ProteinC'],
        cumulativeMilkTotal = json['CumulativeMilkTotal'],
        lactationMilkTotal = json['LactationMilkTotal'],
        daysCount = json['DaysCount'],
        officialMilk = json['OfficialMilk'],
        lat = json['Lat'],
        long = json['Long'],
        dayMilkTotal = json['DayMilkTotal'],
        details = json['details'],
        id = json['id'],
        herd = json['herd'],
        lot = json['lot'],
        farmer = json['farmer'],
        boxno = json['boxno'],
        bottleno = json['bottleno'],
        serverID = json['serverID'] ?? 0,
        SyncStatus = json['SyncStatus'] ?? "1",
        clientID = json['clientID'],
        staff = json['Staff'];

  Map<String, dynamic> toJson(Milk_production_id h) {
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
      'OfficialMilk': h.officialMilk,
      'Lat': h.lat,
      'Long': h.long,
      'DayMilkTotal': h.dayMilkTotal,
      'details': h.details,
      'id': h.id,
      'herd': h.herd,
      'lot': h.lot,
      'farmer': h.farmer,
      'boxno': h.boxno,
      'bottleno': h.bottleno,
      'Staff': h.staff,
      'serverID': h.serverID,
      'clientID': h.clientID,
      'SyncStatus': h.SyncStatus,
    };
  }
 static Map<String, dynamic> toJson1(Milk_production_id h) {
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
      'OfficialMilk': h.officialMilk,
      'Lat': h.lat,
      'Long': h.long,
      'DayMilkTotal': h.dayMilkTotal,
      'details': h.details,
      'id': h.id,
      'herd': h.herd,
      'lot': h.lot,
      'farmer': h.farmer,
      'boxno': h.boxno,
      'bottleno': h.bottleno,
      'Staff': h.staff,
      'serverID': h.serverID,
      'clientID': h.clientID,
      'SyncStatus': h.SyncStatus,
    };
  }
}
