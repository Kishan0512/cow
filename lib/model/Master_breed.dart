import 'package:hive/hive.dart';

part 'Master_breed.g.dart';

@HiveType(typeId: 3)
class Master_breed extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String breedType;
  @HiveField(2)
  int species;
  @HiveField(3)
  int id;
  @HiveField(4)
  String createdAt;
  @HiveField(5)
  String updatedAt;
  @HiveField(6)
  int lastUpdatedByUser;
  @HiveField(7)
  int createdByUser;

  Master_breed(
      {required this.name,
      required this.breedType,
      required this.species,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser});

  Master_breed.fromJson(Map<String, dynamic> json)
      : name = json['Name'] ?? "",
        breedType = json['BreedType'] ?? "",
        species = json['species'] ?? 0,
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0;

  static Map<String, dynamic> toJson(Master_breed h) {
    return {
      'Name': h.name,
      'BreedType': h.breedType,
      'species': h.species,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser
    };
  }
}
