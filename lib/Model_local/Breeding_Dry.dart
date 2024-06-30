import 'package:hive/hive.dart';

part 'Breeding_Dry.g.dart';

@HiveType(typeId: 51)
class Breeding_Dry extends HiveObject {
  @HiveField(0)
  var id;
  @HiveField(1)
  var TagId;
  @HiveField(2)
  var DryDate;
  @HiveField(3)
  var DryReason;
  @HiveField(4)
  var DryTreatment;
  @HiveField(5)
  var OrderNumber;
  @HiveField(6)
  var OTP;
  @HiveField(7)
  var ENTRY;
  @HiveField(8)
  var Lat;
  @HiveField(9)
  var Long;
  @HiveField(10)
  var details;
  @HiveField(11)
  var Staff;
  @HiveField(12)
  var createdAt;
  @HiveField(13)
  var updatedAt;
  @HiveField(14)
  var lastUpdatedByUser;
  @HiveField(15)
  var createdByUser;
  @HiveField(16)
  var herd;
  @HiveField(17)
  var lot;
  @HiveField(18)
  var farmer;
  @HiveField(19)
  var SyncStatus;
  @HiveField(20)
  var ServerId;

  Breeding_Dry({
    required this.id,
    required this.TagId,
    required this.DryDate,
    required this.DryReason,
    required this.DryTreatment,
    required this.OrderNumber,
    required this.OTP,
    required this.ENTRY,
    required this.Lat,
    required this.Long,
    required this.details,
    required this.Staff,
    required this.createdAt,
    required this.updatedAt,
    required this.lastUpdatedByUser,
    required this.createdByUser,
    required this.herd,
    required this.lot,
    required this.farmer,
    required this.SyncStatus,
    required this.ServerId,
  });

  Breeding_Dry.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        TagId = json['TagId'],
        DryDate = json['DryDate'],
        DryReason = json['DryReason'],
        DryTreatment = json['DryTreatment'],
        OrderNumber = json['OrderNumber'],
        OTP = json['OTP'],
        ENTRY = json['ENTRY'],
        Lat = json['Lat'],
        Long = json['Long'],
        details = json['details'],
        Staff = json['Staff'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        lastUpdatedByUser = json['lastUpdatedByUser'],
        createdByUser = json['createdByUser'],
        herd = json['herd'],
        lot = json['lot'],
        SyncStatus = json['SyncStatus'],
        farmer = json['farmer'];

  Map<String, dynamic> toJson(Breeding_Dry h) {
    return {
      'id': h.id,
      'TagId': h.TagId,
      'DryDate': h.DryDate,
      'DryReason': h.DryReason,
      'DryTreatment': h.DryTreatment,
      'OrderNumber': h.OrderNumber,
      'OTP': h.OTP,
      'ENTRY': h.ENTRY,
      'Lat': h.Lat,
      'Long': h.Long,
      'details': h.details,
      'Staff': h.Staff,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
      'herd': h.herd,
      'SyncStatus': h.SyncStatus,
      'lot': h.lot,
      'farmer': h.farmer
    };
  }
}
