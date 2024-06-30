import 'package:hive/hive.dart';

part 'Master_medicineType.g.dart';

@HiveType(typeId: 24)
class Master_medicineType extends HiveObject {
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

  Master_medicineType(
      {required this.name,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser});

  Master_medicineType.fromJson(Map<String, dynamic> json)
      : name = json['Name'] ?? "",
        id = json['ID'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0;

  Map<String, dynamic> toJson(Master_medicineType h) {
    return {
      'Name': h.name,
      'ID': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser
    };
  }
}
