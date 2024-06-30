import 'package:hive/hive.dart';

part 'Master_Farmer.g.dart';

@HiveType(typeId: 57)
class Master_Farmer extends HiveObject {
  @HiveField(0)
  String dCSCode;
  @HiveField(1)
  String code;
  @HiveField(2)
  String name;
  @HiveField(3)
  String middleName;
  @HiveField(4)
  String lastName;
  @HiveField(5)
  String mobile;
  @HiveField(6)
  String cFlag;
  @HiveField(7)
  String bFlag;
  @HiveField(8)
  String producerCode;
  @HiveField(9)
  String sAPcode;
  @HiveField(10)
  var countryCode;
  @HiveField(11)
  var country;
  @HiveField(12)
  var state;
  @HiveField(13)
  var district;
  @HiveField(14)
  var taluka;
  @HiveField(15)
  var village;
  @HiveField(16)
  var address;
  @HiveField(17)
  var isSendSMS;
  @HiveField(18)
  bool isSuspended;
  @HiveField(19)
  var photo;
  @HiveField(20)
  var education;
  @HiveField(21)
  var adultMale;
  @HiveField(22)
  var adultFemale;
  @HiveField(23)
  var youngMale;
  @HiveField(24)
  var youngFemale;
  @HiveField(25)
  var childrenMale;
  @HiveField(26)
  var childrenFemale;
  @HiveField(27)
  var landArea;
  @HiveField(28)
  var landHolding;
  @HiveField(29)
  var cropGrown;
  @HiveField(30)
  var irrigation;
  @HiveField(31)
  var irrigatedArea;
  @HiveField(32)
  var rainFedArea;
  @HiveField(33)
  var fodderCropsGrown;
  @HiveField(34)
  var cOFS29;
  @HiveField(35)
  var cO4;
  @HiveField(36)
  int lot;
  @HiveField(37)
  var smsLanguage;
  @HiveField(38)
  var managerStaff;
  @HiveField(39)
  var aiStaff;
  @HiveField(40)
  int id;
  @HiveField(41)
  var createdAt;
  @HiveField(42)
  var updatedAt;
  @HiveField(43)
  var lastUpdatedByUser;
  @HiveField(44)
  var createdByUser;

  Master_Farmer(
      {required this.dCSCode,
      required this.code,
      required this.name,
      required this.middleName,
      required this.lastName,
      required this.mobile,
      required this.cFlag,
      required this.bFlag,
      required this.producerCode,
      required this.sAPcode,
      required this.countryCode,
      required this.country,
      required this.state,
      required this.district,
      required this.taluka,
      required this.village,
      required this.address,
      required this.isSendSMS,
      required this.isSuspended,
      required this.photo,
      required this.education,
      required this.adultMale,
      required this.adultFemale,
      required this.youngMale,
      required this.youngFemale,
      required this.childrenMale,
      required this.childrenFemale,
      required this.landArea,
      required this.landHolding,
      required this.cropGrown,
      required this.irrigation,
      required this.irrigatedArea,
      required this.rainFedArea,
      required this.fodderCropsGrown,
      required this.cOFS29,
      required this.cO4,
      required this.lot,
      required this.smsLanguage,
      required this.managerStaff,
      required this.aiStaff,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser});

  Master_Farmer.fromJson(Map<String, dynamic> json)
      : dCSCode = json['DCSCode'] ?? "",
        code = json['code'] ?? "",
        name = json['Name'] ?? "",
        middleName = json['MiddleName'] ?? "",
        lastName = json['LastName'] ?? "",
        mobile = json['Mobile'] ?? "",
        cFlag = json['CFlag'] ?? "",
        bFlag = json['BFlag'] ?? "",
        producerCode = json['ProducerCode'] ?? "",
        sAPcode = json['SAPcode'] ?? "",
        countryCode = json['CountryCode'],
        country = json['Country'],
        state = json['State'],
        district = json['District'],
        taluka = json['Taluka'],
        village = json['Village'],
        address = json['Address'],
        isSendSMS = json['IsSendSMS'],
        isSuspended = json['IsSuspended'] ?? false,
        photo = json['Photo'],
        education = json['Education'],
        adultMale = json['AdultMale'],
        adultFemale = json['AdultFemale'],
        youngMale = json['YoungMale'],
        youngFemale = json['YoungFemale'],
        childrenMale = json['ChildrenMale'],
        childrenFemale = json['ChildrenFemale'],
        landArea = json['LandArea'],
        landHolding = json['LandHolding'],
        cropGrown = json['CropGrown'],
        irrigation = json['Irrigation'],
        irrigatedArea = json['IrrigatedArea'],
        rainFedArea = json['RainFedArea'],
        fodderCropsGrown = json['FodderCropsGrown'],
        cOFS29 = json['COFS29'],
        cO4 = json['CO4'],
        lot = json['lot'] ?? 0,
        smsLanguage = json['smsLanguage'],
        managerStaff = json['managerStaff'],
        aiStaff = json['aiStaff'],
        id = json['id'] ?? 0,
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        lastUpdatedByUser = json['lastUpdatedByUser'],
        createdByUser = json['createdByUser'];

  static Map<String, dynamic> toJson(Master_Farmer h) {
    return {
      'DCSCode': h.dCSCode,
      'code': h.code,
      'Name': h.name,
      'MiddleName': h.middleName,
      'LastName': h.lastName,
      'Mobile': h.mobile,
      'CFlag': h.cFlag,
      'BFlag': h.bFlag,
      'ProducerCode': h.producerCode,
      'SAPcode': h.sAPcode,
      'CountryCode': h.countryCode,
      'Country': h.country,
      'State': h.state,
      'District': h.district,
      'Taluka': h.taluka,
      'Village': h.village,
      'Address': h.address,
      'IsSendSMS': h.isSendSMS,
      'IsSuspended': h.isSuspended,
      'Photo': h.photo,
      'Education': h.education,
      'AdultMale': h.adultMale,
      'AdultFemale': h.adultFemale,
      'YoungMale': h.youngMale,
      'YoungFemale': h.youngFemale,
      'ChildrenMale': h.childrenMale,
      'ChildrenFemale': h.childrenFemale,
      'LandArea': h.landArea,
      'LandHolding': h.landHolding,
      'CropGrown': h.cropGrown,
      'Irrigation': h.irrigation,
      'IrrigatedArea': h.irrigatedArea,
      'RainFedArea': h.rainFedArea,
      'FodderCropsGrown': h.fodderCropsGrown,
      'COFS29': h.cOFS29,
      'CO4': h.cO4,
      'lot': h.lot,
      'smsLanguage': h.smsLanguage,
      'managerStaff': h.managerStaff,
      'aiStaff': h.aiStaff,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser
    };
  }
}
