import 'package:hive/hive.dart';

part 'Master_disposal.g.dart';

@HiveType(typeId: 10)
class Master_disposal extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int id;
  @HiveField(2)
  String createdAt;
  @HiveField(3)
  String updatedAt;
  @HiveField(4)
  int createdByUser;
  @HiveField(5)
  int lastUpdatedByUser;

  Master_disposal(
      {required this.name,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.createdByUser,
      required this.lastUpdatedByUser});

  Master_disposal.fromJson(Map<String, dynamic> json)
      : name = json['Name'] ?? "",
        id = json['ID'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        createdByUser = json['createdByUser'] ?? 0,
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0;

  static Map<String, dynamic> toJson(Master_disposal h) {
    return {
      'Name': h.name,
      'ID': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'createdByUser': h.createdByUser,
      'lastUpdatedByUser': h.lastUpdatedByUser
    };
  }
}
