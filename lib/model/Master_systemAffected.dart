import 'package:hive/hive.dart';

part 'Master_systemAffected.g.dart';

@HiveType(typeId: 22)
class Master_systemAffected extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int id;
  @HiveField(2)
  String createdAt;
  @HiveField(3)
  String updatedAt;
  @HiveField(4)
  int lastUpdatedByUser;
  @HiveField(5)
  int createdByUser;

  Master_systemAffected(
      {required this.name,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser});

  Master_systemAffected.fromJson(Map<String, dynamic> json)
      : name = json['Name'] ?? "",
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0;

  Map<String, dynamic> toJson(Master_systemAffected h) {
    return {
      'Name': h.name,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser
    };
  }
}
