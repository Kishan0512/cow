import 'package:hive/hive.dart';

part 'Breeding_PD.g.dart';

@HiveType(typeId: 52)
class Breeding_PD extends HiveObject {
  @HiveField(0)
  var id;
  @HiveField(1)
  var PDTicketNumber;
  @HiveField(2)
  var details;
  @HiveField(3)
  var Reproduction;
  @HiveField(4)
  var OTP;
  @HiveField(5)
  var AIT;
  @HiveField(6)
  var lastUpdatedByUser;
  @HiveField(7)
  var createdByUser;
  @HiveField(8)
  var herd;
  @HiveField(9)
  var lot;
  @HiveField(10)
  var farmer;
  @HiveField(11)
  var TagId;
  @HiveField(12)
  var PDDate;
  @HiveField(13)
  var ENTRY;
  @HiveField(14)
  var Lat;
  @HiveField(15)
  var Long;
  @HiveField(16)
  var createdAt;
  @HiveField(17)
  var OrderNumber;
  @HiveField(18)
  var updatedAt;
  @HiveField(19)
  var SyncStatus;
  @HiveField(20)
  var ServerId;
  @HiveField(21)
  var result;
@HiveField(22)
  var visit;

  Breeding_PD(
      {required this.result,
      required this.ServerId,
      required this.id,
      required this.SyncStatus,
      required this.AIT,
      required this.lastUpdatedByUser,
      required this.createdByUser,
      required this.herd,
      required this.lot,
      required this.farmer,
      required this.TagId,
      required this.PDDate,
      required this.ENTRY,
      required this.Lat,
      required this.Long,
      required this.createdAt,
      required this.visit,
      required this.updatedAt});

  Breeding_PD.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? "",
        AIT = json['AIT'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? "",
        createdByUser = json['createdbyuser'] ?? "",
        herd = json['herd'] ?? "",
        lot = json['lot'] ?? "",
        farmer = json['farmer'] ?? "",
        TagId = json['TagId'] ?? "",
        PDDate = json['PDDate'] ?? "",
        ENTRY = json['ENTRY'] ?? "",
        Lat = json['Lat'] ?? "",
        Long = json['Long'] ?? "",
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        SyncStatus = json['SyncStatus'] ?? "",
        ServerId = json['ServerId'] ?? "",
        visit = json['visit'] ?? "0",
        result = json['Result'] ?? 0;

  Map<String, dynamic> toJson(Breeding_PD h) {
    return {
      'id': h.id,
      'AIT': h.AIT,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdbyuser': h.createdByUser,
      'herd': h.herd,
      'lot': h.lot,
      'farmer': h.farmer,
      'TagId': h.TagId,
      'PDDate': h.PDDate,
      'ENTRY': h.ENTRY,
      'Lat': h.Lat,
      'Long': h.Long,
      'createdAt': h.createdAt,
      'SyncStatus': h.SyncStatus,
      'updatedAt': h.updatedAt,
      'visit': h.visit,
      'ServerId': h.ServerId,
      'Result': h.result,
    };
  }

  static Map<String, dynamic> toJson1(Breeding_PD h) {
    return {
      'id': h.id,
      'AIT': h.AIT,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdbyuser': h.createdByUser,
      'herd': h.herd,
      'lot': h.lot,
      'farmer': h.farmer,
      'TagId': h.TagId,
      'PDDate': h.PDDate,
      'ENTRY': h.ENTRY,
      'Lat': h.Lat,
      'Long': h.Long,
      'createdAt': h.createdAt,
      'visit': h.visit,
      'SyncStatus': h.SyncStatus,
      'updatedAt': h.updatedAt,
      'ServerId': h.ServerId,
      'Result': h.result,
    };
  }
}
