import 'package:hive/hive.dart';

part 'Breeding_insemination.g.dart';

@HiveType(typeId: 47)
class Breeding_insemination extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String TagId;
  @HiveField(2)
  String HeatDate;
  @HiveField(3)
  int ENTRY;
  @HiveField(4)
  int InseminationTicketNumber;
  @HiveField(5)
  int TotalAIDose;
  @HiveField(6)
  String Long;
  @HiveField(7)
  String Lat;
  @HiveField(8)
  String AIT;
  @HiveField(9)
  int sire;
  @HiveField(10)
  String service;
  @HiveField(11)
  String createdAt;
  @HiveField(12)
  int createdByUser;
  @HiveField(13)
  int herd;
  @HiveField(14)
  int lot;
  @HiveField(15)
  int SortedSemon;
  @HiveField(16)
  int farmer;
  @HiveField(17)
  String StrawImage;
  @HiveField(18)
  String BatchNo;
  @HiveField(19)
  int AICost;
  @HiveField(20)
  String ServerId;
  @HiveField(21)
  var SyncStatus;
  @HiveField(22)
  var Visit;

  Breeding_insemination({
    required this.id,
    required this.TagId,
    required this.HeatDate,
    required this.InseminationTicketNumber,
    required this.AIT,
    required this.sire,
    required this.service,
    required this.createdAt,
    required this.StrawImage,
    required this.BatchNo,
    required this.createdByUser,
    required this.herd,
    required this.lot,
    required this.farmer,
    required this.SortedSemon,
    required this.AICost,
    required this.TotalAIDose,
    required this.Long,
    required this.ENTRY,
    required this.SyncStatus,
    required this.Lat,
    required this.ServerId,
    required this.Visit,
  });

  Breeding_insemination.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        TagId = json['TagId'] ?? "",
        HeatDate = json['HeatDate'] ?? "",
        InseminationTicketNumber = json['InseminationTicketNumber'] ?? 0,
        AIT = json['AIT'] ?? "",
        sire = json['sire'] ?? 0,
        service = json['service'] ?? "",
        createdAt = json['createdAt'] ?? "",
        StrawImage = json['StrawImage'] ?? "",
        BatchNo = json['BatchNo'] ?? "",
        createdByUser = json['createdByUser'] ?? 0,
        herd = json['herd'] ?? 0,
        lot = json['lot'] ?? 0,
        farmer = json['farmer'] ?? 00,
        ENTRY = json['ENTRY'] ?? 0,
        SortedSemon = json['SortedSemon'] ?? false,
        SyncStatus = json['SyncStatus'] ?? "",
        AICost = json['AICost'] ?? 0,
        TotalAIDose = json['TotalAIDose'] ?? 0,
        Long = json['Long'] ?? 0,
        ServerId = json['ServerId'] ?? "",
        Lat = json['Lat'] ?? 0,
        Visit = json['Visit'] ?? "0";

  Map<String, dynamic> toJson(Breeding_insemination h) {
    return {
      'id': h.id,
      'TagId': h.TagId,
      'HeatDate': h.HeatDate,
      'InseminationTicketNumber': h.InseminationTicketNumber,
      'AIT': h.AIT,
      'sire': h.sire,
      'service': h.service,
      'createdAt': h.createdAt,
      'StrawImage': h.StrawImage,
      'BatchNo': h.BatchNo,
      'createdByUser': h.createdByUser,
      'herd': h.herd,
      'lot': h.lot,
      'farmer': h.farmer,
      'ENTRY': h.ENTRY,
      'SortedSemon': h.SortedSemon,
      'AICost': h.AICost,
      'TotalAIDose': h.TotalAIDose,
      'SyncStatus': h.SyncStatus,
      'ServerId': h.ServerId,
      'Long': h.Long,
      'Lat': h.Lat,
      'Visit': h.Visit,
    };
  }

  static Map<String, dynamic> toJson1(Breeding_insemination h) {
    return {
      'id': h.id,
      'TagId': h.TagId,
      'HeatDate': h.HeatDate,
      'InseminationTicketNumber': h.InseminationTicketNumber,
      'AIT': h.AIT,
      'sire': h.sire,
      'service': h.service,
      'createdAt': h.createdAt,
      'StrawImage': h.StrawImage,
      'BatchNo': h.BatchNo,
      'createdByUser': h.createdByUser,
      'herd': h.herd,
      'lot': h.lot,
      'farmer': h.farmer,
      'ENTRY': h.ENTRY,
      'SortedSemon': h.SortedSemon,
      'AICost': h.AICost,
      'TotalAIDose': h.TotalAIDose,
      'SyncStatus': h.SyncStatus,
      'ServerId': h.ServerId,
      'Long': h.Long,
      'Lat': h.Lat,
      'Visit': h.Visit,
    };
  }
}
