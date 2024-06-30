import 'package:hive/hive.dart';

part 'Get_Master_Farmer.g.dart';

@HiveType(typeId: 55)
class Get_Master_Farmer extends HiveObject {
  @HiveField(0)
  var dCSCode;
  @HiveField(1)
  var code;
  @HiveField(2)
  var name;
  @HiveField(3)
  var middleName;
  @HiveField(4)
  var lastName;
  @HiveField(5)
  var mobile;
  @HiveField(6)
  var producerCode;
  @HiveField(7)
  var sAPcode;
  @HiveField(8)
  var lot;
  @HiveField(9)
  var id;

  Get_Master_Farmer(
      {required this.dCSCode,
      required this.code,
      required this.name,
      required this.middleName,
      required this.lastName,
      required this.mobile,
      required this.producerCode,
      required this.sAPcode,
      required this.lot,
      required this.id});

  Get_Master_Farmer.fromJson(Map<String, dynamic> json)
      : dCSCode = json['DCSCode'],
        code = json['code'],
        name = json['Name'],
        middleName = json['MiddleName'],
        lastName = json['LastName'],
        mobile = json['Mobile'],
        producerCode = json['ProducerCode'],
        sAPcode = json['SAPcode'],
        lot = json['lot'],
        id = json['id'];

  static Map<String, dynamic> toJson(Get_Master_Farmer h) {
    return {
      'DCSCode': h.dCSCode,
      'code': h.code,
      'Name': h.name,
      'MiddleName': h.middleName,
      'LastName': h.lastName,
      'Mobile': h.mobile,
      'ProducerCode': h.producerCode,
      'SAPcode': h.sAPcode,
      'lot': h.lot,
      'id': h.id
    };
  }
}
