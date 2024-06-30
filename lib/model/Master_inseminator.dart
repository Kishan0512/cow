import 'package:hive/hive.dart';

part 'Master_inseminator.g.dart';

@HiveType(typeId: 15)
class Master_inseminator extends HiveObject {
  @HiveField(0)
  var name;
  @HiveField(1)
  var code;
  @HiveField(2)
  var countryCode;
  @HiveField(3)
  var mobile;
  @HiveField(4)
  var paymentType;
  @HiveField(5)
  var qualification;
  @HiveField(6)
  var address;
  @HiveField(7)
  var maxBalance;
  @HiveField(8)
  var basic;
  @HiveField(9)
  var isSendSMS;
  @HiveField(10)
  var vOFlag;
  @HiveField(11)
  var isSuspended;
  @HiveField(12)
  var allowUser;
  @HiveField(13)
  var email;
  @HiveField(14)
  var group;
  @HiveField(15)
  var smsLanguage;
  @HiveField(16)
  var id;
  @HiveField(17)
  var createdAt;
  @HiveField(18)
  var updatedAt;
  @HiveField(19)
  var lastUpdatedByUser;
  @HiveField(20)
  var createdByUser;
  @HiveField(21)
  var voCategory;
  @HiveField(22)
  var voPost;
  @HiveField(23)
  var employeeNo;
  @HiveField(24)
  var localName;
  @HiveField(25)
  var joiningDate;
  @HiveField(26)
  var zone;
  @HiveField(27)
  var route;
  @HiveField(28)
  var dCS;
  @HiveField(29)
  var gvcDetails;
  @HiveField(30)
  var dcsname;

  Master_inseminator(
      {required this.name,
      required this.code,
      required this.countryCode,
      required this.mobile,
      required this.paymentType,
      required this.qualification,
      required this.address,
      required this.maxBalance,
      required this.basic,
      required this.isSendSMS,
      required this.vOFlag,
      required this.isSuspended,
      required this.allowUser,
      required this.email,
      required this.group,
      required this.smsLanguage,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser,
      required this.voCategory,
      required this.voPost,
      required this.employeeNo,
      required this.localName,
      required this.joiningDate,
      required this.zone,
      required this.route,
      required this.dCS,
      required this.gvcDetails,
      required this.dcsname});

  Master_inseminator.fromJson(Map<String, dynamic> json)
      : name = json['Name'] ?? "",
        code = json['code'] ?? "",
        countryCode = json['CountryCode'] ?? "",
        mobile = json['Mobile'] ?? "",
        paymentType = json['PaymentType'] ?? "",
        qualification = json['Qualification'] ?? "",
        address = json['Address'] ?? "",
        maxBalance = json['MaxBalance'] ?? 0,
        basic = json['Basic'] ?? 0,
        isSendSMS = json['IsSendSMS'] ?? false,
        vOFlag = json['VOFlag'] ?? false,
        isSuspended = json['IsSuspended'] ?? false,
        allowUser = json['AllowUser'] ?? false,
        email = json['Email'] ?? "",
        group = json['group'] ?? 0,
        smsLanguage = json['smsLanguage'] ?? 0,
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0,
        voCategory = json['voCategory'] ?? 0,
        voPost = json['voPost'] ?? 0,
        employeeNo = json['employeeNo'] ?? 0,
        localName = json['localName'] ?? "",
        joiningDate = json['joiningDate'] ?? "",
        zone = json['zone'] ?? 0,
        route = json['Route'] ?? "",
        dCS = json['DCS'] ?? "",
        gvcDetails = json['gvcDetails'] ?? 0,
        dcsname = json['dcsname'] ?? "";

  static Map<String, dynamic> toJson(Master_inseminator h) {
    return {
      'Name': h.name,
      'code': h.code,
      'CountryCode': h.countryCode,
      'Mobile': h.mobile,
      'PaymentType': h.paymentType,
      'Qualification': h.qualification,
      'Address': h.address,
      'MaxBalance': h.maxBalance,
      'Basic': h.basic,
      'IsSendSMS': h.isSendSMS,
      'VOFlag': h.vOFlag,
      'IsSuspended': h.isSuspended,
      'AllowUser': h.allowUser,
      'Email': h.email,
      'group': h.group,
      'smsLanguage': h.smsLanguage,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
      'voCategory': h.voCategory,
      'voPost': h.voPost,
      'employeeNo': h.employeeNo,
      'localName': h.localName,
      'joiningDate': h.joiningDate,
      'zone': h.zone,
      'Route': h.route,
      'DCS': h.dCS,
      'gvcDetails': h.gvcDetails,
      'dcsname': h.dcsname
    };
  }
}
