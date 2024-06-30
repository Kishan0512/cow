import 'package:hive/hive.dart';

part 'Bredding_Calving.g.dart';

@HiveType(typeId: 53)
class Breeding_Calving extends HiveObject {
  @HiveField(0)
  var id;
  @HiveField(1)
  var TagId;
  @HiveField(2)
  var CalvingDate;
  @HiveField(3)
  var Comments;
  @HiveField(4)
  var ReproductionProblemNote;
  @HiveField(5)
  var CalvingTicketNumber;
  @HiveField(6)
  var OrderNumber;
  @HiveField(7)
  var OTP;
  @HiveField(8)
  var ENTRY;
  @HiveField(9)
  var Lat;
  @HiveField(10)
  var Long;
  @HiveField(11)
  var details;
  @HiveField(12)
  var Sex;
  @HiveField(13)
  var CalfSex;
  @HiveField(14)
  var CalvingType;
  @HiveField(15)
  var calvingTypeOption;
  @HiveField(16)
  var staff;
  @HiveField(17)
  var createdAt;
  @HiveField(18)
  var updatedAt;
  @HiveField(19)
  var lastUpdatedByUser;
  @HiveField(20)
  var createdByUser;
  @HiveField(21)
  var herd;
  @HiveField(22)
  var lot;
  @HiveField(23)
  var farmer;
  @HiveField(24)
  var CalfID;
  @HiveField(25)
  var Calf2Sex;
  @HiveField(26)
  var Calf2ID;
  @HiveField(27)
  var image1;
  @HiveField(28)
  var image2;
  @HiveField(29)
  var SyncStatus;
  @HiveField(30)
  var ServerId;
  @HiveField(31)
  var visit;

  Breeding_Calving({
    required this.id,
    required this.TagId,
    required this.CalvingDate,
    required this.Comments,
    required this.ReproductionProblemNote,
    required this.CalvingTicketNumber,
    required this.OrderNumber,
    required this.OTP,
    required this.ENTRY,
    required this.Lat,
    required this.Long,
    required this.details,
    required this.Sex,
    required this.CalfSex,
    required this.CalvingType,
    required this.calvingTypeOption,
    required this.staff,
    required this.createdAt,
    required this.updatedAt,
    required this.lastUpdatedByUser,
    required this.createdByUser,
    required this.herd,
    required this.lot,
    required this.farmer,
    required this.CalfID,
    required this.Calf2Sex,
    required this.Calf2ID,
    required this.image1,
    required this.image2,
    required this.SyncStatus,
    required this.ServerId,
    required this.visit,
  });

  Breeding_Calving.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        TagId = json['TagId'],
        CalvingDate = json['CalvingDate'],
        Comments = json['Comments'],
        ReproductionProblemNote = json['ReproductionProblemNote'],
        CalvingTicketNumber = json['CalvingTicketNumber'],
        OrderNumber = json['OrderNumber'],
        OTP = json['OTP'],
        ENTRY = json['ENTRY'],
        Lat = json['Lat'],
        Long = json['Long'],
        details = json['details'],
        Sex = json['Sex'],
        CalfSex = json['CalfSex'],
        CalvingType = json['CalvingType'],
        calvingTypeOption = json['calvingTypeOption'],
        staff = json['staff'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        lastUpdatedByUser = json['lastUpdatedByUser'],
        createdByUser = json['createdByUser'],
        herd = json['herd'],
        lot = json['lot'],
        farmer = json['farmer'],
        CalfID = json['CalfID'],
        Calf2Sex = json['Calf2Sex'],
        Calf2ID = json['Calf2ID'],
        image1 = json['image1'],
        image2 = json['image2'],
        visit = json['visit'],
        SyncStatus = json['SyncStatus'];
  Map<String, dynamic> toJson(Breeding_Calving h) {
    return {
      'id': h.id,
      'TagId': h.TagId,
      'CalvingDate': h.CalvingDate,
      'Comments': h.Comments,
      'ReproductionProblemNote': h.ReproductionProblemNote,
      'CalvingTicketNumber': h.CalvingTicketNumber,
      'OrderNumber': h.OrderNumber,
      'OTP': h.OTP,
      'ENTRY': h.ENTRY,
      'Lat': h.Lat,
      'Long': h.Long,
      'details': h.details,
      'Sex': h.Sex,
      'CalfSex': h.CalfSex,
      'CalvingType': h.CalvingType,
      'calvingTypeOption': h.calvingTypeOption,
      'staff': h.staff,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
      'herd': h.herd,
      'lot': h.lot,
      'farmer': h.farmer,
      'CalfID': h.CalfID,
      'visit': h.visit,
      'Calf2Sex': h.Calf2Sex,
      'Calf2ID': h.Calf2ID,
      'image1': h.image1,
      'image2': h.image2,
      'SyncStatus': h.SyncStatus
    };
  }
}
