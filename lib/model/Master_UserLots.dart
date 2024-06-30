import 'package:hive/hive.dart';

part 'Master_UserLots.g.dart';

@HiveType(typeId: 1)
class Master_Userlots extends HiveObject {
  @HiveField(0)
  var name;
  @HiveField(1)
  var code;
  @HiveField(2)
  var lotcode;
  @HiveField(3)
  var note;
  @HiveField(4)
  bool isSuspended;
  @HiveField(5)
  var lat;
  @HiveField(6)
  var lng;
  @HiveField(7)
  var weekDay;
  @HiveField(8)
  var fromTime;
  @HiveField(9)
  var toTime;
  @HiveField(10)
  var herd;
  @HiveField(11)
  var id;
  @HiveField(12)
  var createdAt;
  @HiveField(13)
  var updatedAt;
  @HiveField(14)
  var lastUpdatedByUser;
  @HiveField(15)
  var createdByUser;
  @HiveField(16)
  var village;

  Master_Userlots(
      {required this.name,
      required this.code,
      required this.lotcode,
      required this.note,
      required this.isSuspended,
      required this.lat,
      required this.lng,
      required this.weekDay,
      required this.fromTime,
      required this.toTime,
      required this.herd,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser,
      required this.village});

  Master_Userlots.fromJson(Map<String, dynamic> json)
      : name = json['Name'] ?? "",
        code = json['code'] ?? "",
        lotcode = json['Lotcode'] ?? 0,
        note = json['Note'] ?? "",
        isSuspended = json['IsSuspended'] ?? false,
        lat = json['Lat'] ?? 0,
        lng = json['Lng'] ?? 0,
        weekDay = json['WeekDay'] ?? "",
        fromTime = json['FromTime'] ?? "",
        toTime = json['ToTime'] ?? "",
        herd = json['herd'] ?? 0,
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0,
        village = json['Village'] ?? 0;

  static Map<String, dynamic> toJson(Master_Userlots h) {
    return {
      'Name': h.name,
      'code': h.code,
      'Lotcode': h.lotcode,
      'Note': h.note,
      'IsSuspended': h.isSuspended,
      'Lat': h.lat,
      'Lng': h.lng,
      'WeekDay': h.weekDay,
      'FromTime': h.fromTime,
      'ToTime': h.toTime,
      'herd': h.herd,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
      'Village': h.village
    };
  }
}
