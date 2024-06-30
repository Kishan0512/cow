import 'package:hive/hive.dart';

part 'Milk_PD.g.dart';

@HiveType(typeId: 58)
class Milk_PDTest extends HiveObject {
  @HiveField(0)
  var HeatDate;
  @HiveField(1)
  var testDate;
  @HiveField(2)
  var TagId;
  @HiveField(3)
  var AIT;
  @HiveField(4)
  var QRCodeResult;
  @HiveField(5)
  var Note;
  @HiveField(6)
  var createdByUser;
  @HiveField(7)
  var SyncStatus;
  @HiveField(8)
  var id;
  Milk_PDTest(
      {required this.HeatDate,
      required this.testDate,
      required this.TagId,
      required this.AIT,
      required this.QRCodeResult,
      required this.Note,
      required this.createdByUser,
      required this.id,
      required this.SyncStatus});

  Milk_PDTest.fromJson(Map<String, dynamic> json)
      : HeatDate = json['HeatDate'],
        testDate = json['testDate'],
        id = json['id'],
        TagId = json['TagId'],
        AIT = json['AIT'],
        QRCodeResult = json['QRCodeResult'],
        Note = json['Note'],
        SyncStatus = json['SyncStatus'],
        createdByUser = json['createdByUser'];

  Map<String, dynamic> toJson(Milk_PDTest h) {
    return {
      'HeatDate': h.HeatDate,
      'testDate': h.testDate,
      'TagId': h.TagId,
      'AIT': h.AIT,
      'id': h.id,
      'QRCodeResult': h.QRCodeResult,
      'Note': h.Note,
      'SyncStatus': h.SyncStatus,
      'createdByUser': h.createdByUser
    };}
    static Map<String, dynamic> toJson1(Milk_PDTest h) {
      return {
        'HeatDate': h.HeatDate,
        'testDate': h.testDate,
        'TagId': h.TagId,
        'AIT': h.AIT,
        'id': h.id,
        'QRCodeResult': h.QRCodeResult,
        'Note': h.Note,
        'SyncStatus': h.SyncStatus,
        'createdByUser': h.createdByUser
      };}

  }

