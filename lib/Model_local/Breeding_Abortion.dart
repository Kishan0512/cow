import 'package:hive/hive.dart';

part 'Breeding_Abortion.g.dart';

@HiveType(typeId: 49)
class Breeding_Abortion extends HiveObject {
  @HiveField(0)
  var id;
  @HiveField(1)
  var TagId;
  @HiveField(2)
  var AbortionDate;
  @HiveField(3)
  var AbortionSeq;
  @HiveField(4)
  var OrderNumber;
  @HiveField(5)
  var OTP;
  @HiveField(6)
  var ENTRY;
  @HiveField(7)
  var Lat;
  @HiveField(8)
  var Long;
  @HiveField(9)
  var details;
  @HiveField(10)
  var createdAt;
  @HiveField(11)
  var updatedAt;
  @HiveField(12)
  var lastUpdatedByUser;
  @HiveField(13)
  var createdByUser;
  @HiveField(14)
  var herd;
  @HiveField(15)
  var lot;
  @HiveField(16)
  var farmer;
  @HiveField(17)
  var SyncStatus;
  @HiveField(18)
  var ServerId;
  @HiveField(19)
  var visit;

  Breeding_Abortion(
      {required this.id,
      required this.TagId,
      required this.AbortionDate,
      required this.AbortionSeq,
      required this.OrderNumber,
      required this.OTP,
      required this.ENTRY,
      required this.Lat,
      required this.Long,
      required this.details,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser,
      required this.herd,
      required this.lot,
      required this.SyncStatus,
      required this.visit,
      required this.ServerId,
      required this.farmer});

  Breeding_Abortion.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? "",
        TagId = json['TagId'] ?? "",
        AbortionDate = json['AbortionDate'] ?? "",
        AbortionSeq = json['AbortionSeq'] ?? 0,
        OrderNumber = json['OrderNumber'],
        OTP = json['OTP'],
        ENTRY = json['ENTRY'],
        Lat = json['Lat'],
        Long = json['Long'],
        details = json['details'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        lastUpdatedByUser = json['lastUpdatedByUser'],
        createdByUser = json['createdbyuser'],
        herd = json['herd'],
        lot = json['lot'],
        visit = json['visit'],
        SyncStatus = json['SyncStatus'],
        farmer = json['farmer'];

  Map<String, dynamic> toJson(Breeding_Abortion h) {
    return {
      'id': h.id,
      'TagId': h.TagId,
      'AbortionDate': h.AbortionDate,
      'AbortionSeq': h.AbortionSeq,
      'OrderNumber': h.OrderNumber,
      'OTP': h.OTP,
      'ENTRY': h.ENTRY,
      'Lat': h.Lat,
      'Long': h.Long,
      'details': h.details,
      'createdAt': h.createdAt,
      'visit': h.visit,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdbyuser': h.createdByUser,
      'herd': h.herd,
      'SyncStatus': h.SyncStatus,
      'lot': h.lot,
      'farmer': h.farmer
    };
  }
}
