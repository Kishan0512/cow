import 'package:hive/hive.dart';

part 'Master_feature.g.dart';

@HiveType(typeId: 27)
class Master_feature extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String grouping;
  @HiveField(2)
  int id;
  @HiveField(3)
  String createdAt;
  @HiveField(4)
  String updatedAt;

  Master_feature(
      {required this.name,
      required this.grouping,
      required this.id,
      required this.createdAt,
      required this.updatedAt});

  Master_feature.fromJson(Map<String, dynamic> json)
      : name = json['Name'] ?? "",
        grouping = json['Grouping'] ?? "",
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "";

  Map<String, dynamic> toJson(Master_feature h) {
    return {
      'Name': h.name,
      'Grouping': h.grouping,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt
    };
  }
}
