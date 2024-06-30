import 'package:hive/hive.dart';

part 'Master_UserHerds.g.dart';

@HiveType(typeId: 0)
class Master_UserHerds extends HiveObject {
  @HiveField(0)
  String Name;
  @HiveField(1)
  String code;
  @HiveField(2)
  bool IsSuspended;
  @HiveField(3)
  var Lat;
  @HiveField(4)
  int cc;
  @HiveField(5)
  int zone;
  @HiveField(6)
  var Lng;
  @HiveField(7)
  int managerStaff;
  @HiveField(8)
  int createdByUser;
  @HiveField(9)
  int lastUpdatedByUser;
  @HiveField(10)
  int extensionOfficerStaff;
  @HiveField(11)
  int company;
  @HiveField(12)
  int id;
  @HiveField(13)
  String createdAt;
  @HiveField(14)
  String updatedAt;

  Master_UserHerds(
      {required this.Name,
      required this.code,
      required this.IsSuspended,
      required this.Lat,
      required this.cc,
      required this.Lng,
      required this.zone,
      required this.managerStaff,
      required this.extensionOfficerStaff,
      required this.createdByUser,
      required this.lastUpdatedByUser,
      required this.company,
      required this.id,
      required this.createdAt,
      required this.updatedAt});

  Master_UserHerds.fromJson(Map<String, dynamic> json)
      : Name = json['Name'] ?? "",
        code = json['code'] ?? "",
        IsSuspended = json['IsSuspended'] ?? false,
        Lat = json['Lat'] ?? 0,
        Lng = json['Lng'] ?? 0,
        managerStaff = json['managerStaff'] ?? 0,
        extensionOfficerStaff = json['extensionOfficerStaff'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0,
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        company = json['company'] ?? 0,
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        cc = json['cc'] ?? 0,
        zone = json['zone'] ?? 0;

  static Map<String, dynamic> toJson(Master_UserHerds h) {
    return {
      'Name': h.Name,
      'code': h.code,
      'IsSuspended': h.IsSuspended,
      'Lat': h.Lat,
      'Lng': h.Lng,
      'managerStaff': h.managerStaff,
      'extensionOfficerStaff': h.extensionOfficerStaff,
      'cc': h.cc,
      'zone': h.zone,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser
    };
  }
}
