import 'package:hive/hive.dart';

part 'Master_reproductveProblem.g.dart';

@HiveType(typeId: 12)
class Master_reproductveProblem extends HiveObject {
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

  Master_reproductveProblem(
      {required this.name,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.createdByUser,
      required this.lastUpdatedByUser});

  Master_reproductveProblem.fromJson(Map<String, dynamic> json)
      : name = json['Name'] ?? "",
        id = json['ID'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        createdByUser = json['createdByUser'] ?? 0,
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0;

  static Map<String, dynamic> toJson(Master_reproductveProblem h) {
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
