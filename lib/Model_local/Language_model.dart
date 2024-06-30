import 'package:hive/hive.dart';

part 'Language_model.g.dart';

@HiveType(typeId: 56)
class Language_model extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String engkey;
  @HiveField(2)
  String engvalue;
  @HiveField(3)
  String key;
  @HiveField(4)
  String Value;

  Language_model({
    required this.id,
    required this.engkey,
    required this.engvalue,
    required this.key,
    required this.Value,
  });

  Language_model.fromJson(
    Map<String, dynamic> json,
    String Key,
  )   : id = "$Key-${json['ID']}",
        engkey = 'English',
        engvalue = json['English'].toString(),
        key = '$Key'.toString(),
        Value = json['$Key'].toString();

  Map<String, dynamic> toJson(Language_model h) {
    return {
      'id': h.id,
      'engkey': h.engkey,
      'engvalue': h.engvalue,
      'key': h.key,
      'Value': h.Value,
    };
  }
}
