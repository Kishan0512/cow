import 'package:hive/hive.dart';

part 'Vehicle_purpose.g.dart';

@HiveType(typeId: 45)
class Vehicle_purpose extends HiveObject {
  @HiveField(0)
  var iD;
  @HiveField(1)
  var visitPurpose;
  @HiveField(2)
  var registrationDate;
  @HiveField(3)
  var createdAt;
  @HiveField(4)
  var updatedAt;
  @HiveField(5)
  var lastUpdatedByUser;
  @HiveField(6)
  var createdByUser;

  Vehicle_purpose(
      {required this.iD,
      required this.visitPurpose,
      required this.registrationDate,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser});

  Vehicle_purpose.fromJson(Map<String, dynamic> json)
      : iD = json['ID'],
        visitPurpose = json['VisitPurpose'],
        registrationDate = json['RegistrationDate'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        lastUpdatedByUser = json['lastUpdatedByUser'],
        createdByUser = json['createdByUser'];

  Map<String, dynamic> toJson(Vehicle_purpose h) {
    return {
      'ID': h.iD,
      'VisitPurpose': h.visitPurpose,
      'RegistrationDate': h.registrationDate,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
    };
  }
}
