import 'package:hive/hive.dart';

part 'Animal_timeline.g.dart';

@HiveType(typeId: 36)
class Animal_timeline extends HiveObject {
  @HiveField(0)
  var count;
  @HiveField(1)
  var headingText;
  @HiveField(2)
  var centerText;
  @HiveField(3)
  var dateText;
  @HiveField(4)
  var statusText;
  @HiveField(5)
  var tagno;
  @HiveField(6)
  var actualDate;
  @HiveField(7)
  var id;
  @HiveField(8)
  var createdAt;
  @HiveField(9)
  var updatedAt;
  @HiveField(10)
  var lastUpdatedByUser;
  @HiveField(11)
  var createdByUser;
  @HiveField(12)
  var clientID;

  Animal_timeline({
    required this.count,
    required this.headingText,
    required this.centerText,
    required this.dateText,
    required this.statusText,
    required this.tagno,
    required this.actualDate,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.lastUpdatedByUser,
    required this.createdByUser,
    required this.clientID,
  });

  Animal_timeline.fromJson(Map<String, dynamic> json)
      : count = json['count'] ?? 0,
        headingText = json['heading_text'] ?? "",
        centerText = json['center_text'] ?? 0,
        dateText = json['date_text'] ?? "",
        statusText = json['status_text'] ?? "",
        tagno = json['tagno'] ?? "",
        actualDate = json['actual_date'] ?? "",
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0,
        clientID = json['clientID'];

  Map<String, dynamic> toJson(Animal_timeline h) {
    return {
      'count': h.count,
      'heading_text': h.headingText,
      'center_text': h.centerText,
      'date_text': h.dateText,
      'status_text': h.statusText,
      'tagno': h.tagno,
      'actual_date': h.actualDate,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
      'clientID': h.clientID
    };
  }
}
