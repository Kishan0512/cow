import 'package:hive/hive.dart';

part 'Master_vaccinationType.g.dart';

@HiveType(typeId: 17)
class Master_vaccinationType extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int periodInDays;
  @HiveField(2)
  int id;
  @HiveField(3)
  String createdAt;
  @HiveField(4)
  String updatedAt;
  @HiveField(5)
  int lastUpdatedByUser;
  @HiveField(6)
  int createdByUser;

  Master_vaccinationType(
      {required this.name,
      required this.periodInDays,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser});

  Master_vaccinationType.fromJson(Map<String, dynamic> json)
      : name = json['Name'] ?? "",
        periodInDays = json['PeriodInDays'] ?? 0,
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0;

  static Map<String, dynamic> toJson(Master_vaccinationType h) {
    return {
      'Name': h.name,
      'PeriodInDays': h.periodInDays,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser
    };
  }
}
