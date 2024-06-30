import 'package:hive/hive.dart';

part 'Master_calvingTypeOption.g.dart';

@HiveType(typeId: 9)
class Master_calvingTypeOption extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int calvingType;
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

  Master_calvingTypeOption(
      {required this.name,
      required this.calvingType,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.createdByUser,
      required this.lastUpdatedByUser});

  Master_calvingTypeOption.fromJson(Map<String, dynamic> json)
      : name = json['Name'] ?? "",
        calvingType = json['calvingType'] ?? 0,
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        createdByUser = json['createdByUser'] ?? 0,
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0;

  static Map<String, dynamic> toJson(Master_calvingTypeOption h) {
    return {
      'Name': h.name,
      'calvingType': h.calvingType,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'createdByUser': h.createdByUser,
      'lastUpdatedByUser': h.lastUpdatedByUser
    };
  }
}
