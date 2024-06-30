import 'package:hive/hive.dart';

part 'Master_sex.g.dart';

@HiveType(typeId: 7)
class Master_sex extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int id;

  Master_sex({required this.name, required this.id});

  Master_sex.fromJson(Map<String, dynamic> json)
      : name = json['Name'] ?? "",
        id = json['ID'] ?? 0;

  static Map<String, dynamic> toJson(Master_sex h) {
    return {'Name': h.name, 'ID': h.id};
  }
}
