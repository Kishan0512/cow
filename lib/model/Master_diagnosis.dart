import 'package:hive/hive.dart';

part 'Master_diagnosis.g.dart';

@HiveType(typeId: 26)
class Master_diagnosis extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int systemAffected;
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

  Master_diagnosis(
      {required this.name,
      required this.systemAffected,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser});

  Master_diagnosis.fromJson(Map<String, dynamic> json)
      : name = json['Name'] ?? "",
        systemAffected = json['systemAffected'] ?? 0,
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0;

  Map<String, dynamic> toJson(Master_diagnosis h) {
    return {
      'Name': h.name,
      'systemAffected': h.systemAffected,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser
    };
  }
}
