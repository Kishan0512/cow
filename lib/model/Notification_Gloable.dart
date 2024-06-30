import 'package:hive/hive.dart';

part 'Notification_Gloable.g.dart';

@HiveType(typeId: 61)
class Notification_Gloable extends HiveObject {
  @HiveField(0)
  var TagId;
  @HiveField(1)
  var Date;
  @HiveField(2)
  var Type;
  @HiveField(3)
  var ID;

  Notification_Gloable({
    required this.TagId,
    required this.Date,
    required this.Type,
    required this.ID,
  });

  Notification_Gloable.fromJson(Map<String, dynamic> json)
      : TagId = json['TagId'],
        Date = json['Date'],
        Type = json['Type'],
        ID = json['ID'];

  Map<String, dynamic> toJson(Notification_Gloable h) {
    return {
      'TagId': h.TagId,
      'Date': h.Date,
      'Type': h.Type,
      'ID': h.ID,
    };
  }

  static Map<String, dynamic> toJson1(Notification_Gloable h) {
    return {
      'TagId': h.TagId,
      'Date': h.Date,
      'Parity': h.Type,
      'ID': h.ID,
    };
  }
}
