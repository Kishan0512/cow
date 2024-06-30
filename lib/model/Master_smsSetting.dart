import 'package:hive/hive.dart';

part 'Master_smsSetting.g.dart';

@HiveType(typeId: 19)
class Master_smsSetting extends HiveObject {
  @HiveField(0)
  String task;
  @HiveField(1)
  int fromDays;
  @HiveField(2)
  int toDays;
  @HiveField(3)
  int orderNo;
  @HiveField(4)
  int doctor;
  @HiveField(5)
  int farmer;
  @HiveField(6)
  int id;
  @HiveField(7)
  String createdAt;
  @HiveField(8)
  String updatedAt;
  @HiveField(9)
  int lastUpdatedByUser;
  @HiveField(10)
  int createdByUser;

  Master_smsSetting(
      {required this.task,
      required this.fromDays,
      required this.toDays,
      required this.orderNo,
      required this.doctor,
      required this.farmer,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser});

  Master_smsSetting.fromJson(Map<String, dynamic> json)
      : task = json['Task'] ?? "",
        fromDays = json['FromDays'] ?? 0,
        toDays = json['ToDays'] ?? 0,
        orderNo = json['OrderNo'] ?? 0,
        doctor = json['doctor'] ?? 0,
        farmer = json['farmer'] ?? 0,
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0;

  static Map<String, dynamic> toJson(Master_smsSetting h) {
    return {
      'Task': h.task,
      'FromDays': h.fromDays,
      'ToDays': h.toDays,
      'OrderNo': h.orderNo,
      'doctor': h.doctor,
      'farmer': h.farmer,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser
    };
  }
}
