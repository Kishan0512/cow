import 'package:hive/hive.dart';

part 'Master_disposalSubOptions.g.dart';

@HiveType(typeId: 11)
class Master_disposalSubOptions extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int disposal;
  @HiveField(2)
  int id;
  @HiveField(3)
  String createdAt;
  @HiveField(4)
  String updatedAt;
  @HiveField(5)
  int createdByUser;
  @HiveField(6)
  int lastUpdatedByUser;

  Master_disposalSubOptions(
      {required this.name,
      required this.disposal,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.createdByUser,
      required this.lastUpdatedByUser});

  Master_disposalSubOptions.fromJson(Map<String, dynamic> json)
      : name = json['Name'] ?? "",
        disposal = json['disposal'] ?? 0,
        id = json['ID'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        createdByUser = json['createdByUser'] ?? 0,
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0;

  static Map<String, dynamic> toJson(Master_disposalSubOptions h) {
    return {
      'Name': h.name,
      'disposal': h.disposal,
      'ID': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'createdByUser': h.createdByUser,
      'lastUpdatedByUser': h.lastUpdatedByUser
    };
  }
}
