import 'package:hive/hive.dart';

part 'Animal_Disposal.g.dart';

@HiveType(typeId: 32)
class Animal_Disposal extends HiveObject {
  @HiveField(0)
  var oldTagId;
  @HiveField(1)
  var tagId;
  @HiveField(2)
  var date;
  @HiveField(3)
  var soldTo;
  @HiveField(4)
  var soldPrice;
  @HiveField(5)
  var herd;
  @HiveField(6)
  var lot;
  @HiveField(7)
  var farmer;
  @HiveField(8)
  var oldDetails;
  @HiveField(9)
  var details;
  @HiveField(10)
  var disposalReason;
  @HiveField(11)
  var diedReason;
  @HiveField(12)
  var id;
  @HiveField(13)
  var createdAt;
  @HiveField(14)
  var updatedAt;
  @HiveField(15)
  var lastUpdatedByUser;
  @HiveField(16)
  var createdByUser;
  @HiveField(17)
  var staff;
  @HiveField(18)
  var disposaltype;
  @HiveField(19)
  var SyncStatus;
  @HiveField(20)
  var ServerId;

  Animal_Disposal(
      {required this.SyncStatus,
      required this.oldTagId,
      required this.tagId,
      required this.date,
      required this.soldTo,
      required this.soldPrice,
      required this.herd,
      required this.lot,
      required this.farmer,
      required this.oldDetails,
      required this.details,
      required this.disposalReason,
      required this.diedReason,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser,
      required this.staff,
      required this.disposaltype,
      required this.ServerId});

  Animal_Disposal.fromJson(Map<String, dynamic> json)
      : oldTagId = json['OldTagId'] ?? 0,
        tagId = json['TagId'] ?? 0,
        date = json['Date'] ?? "",
        soldTo = json['SoldTo'] ?? "",
        soldPrice = json['SoldPrice'] ?? 0,
        herd = json['herd'] ?? 0,
        lot = json['lot'] ?? 0,
        farmer = json['farmer'] ?? 0,
        oldDetails = json['oldDetails'] ?? 0,
        details = json['details'] ?? 0,
        disposalReason = json['disposalReason'] ?? 0,
        diedReason = json['diedReason'] ?? 0,
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        SyncStatus = json['SyncStatus'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0,
        staff = json['Staff'],
        disposaltype = json['Disposaltype'],
        ServerId = json['ServerId'] ?? "";

  Map<String, dynamic> toJson(Animal_Disposal h) {
    return {
      'OldTagId': h.oldTagId,
      'TagId': h.tagId,
      'Date': h.date,
      'SoldTo': h.soldTo,
      'SoldPrice': h.soldPrice,
      'herd': h.herd,
      'lot': h.lot,
      'farmer': h.farmer,
      'oldDetails': h.oldDetails,
      'details': h.details,
      'disposalReason': h.disposalReason,
      'diedReason': h.diedReason,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
      'Staff': h.staff,
      'Disposaltype': h.disposaltype,
      'SyncStatus': h.SyncStatus,
      'ServerId': h.ServerId,
    };
  }
}
