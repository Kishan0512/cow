import 'package:hive/hive.dart';

part 'Vehicle_data.g.dart';

@HiveType(typeId: 46)
class Vehicle_data extends HiveObject {
  @HiveField(0)
  var isRegular;
  @HiveField(1)
  var iD;
  @HiveField(2)
  var centerName;
  @HiveField(3)
  var vehicleNo;
  @HiveField(4)
  var contractorName;
  @HiveField(5)
  var vehicleType;
  @HiveField(6)
  var vehicleModel;
  @HiveField(7)
  var passingType;
  @HiveField(8)
  var aggrementFromDate;
  @HiveField(9)
  var aggrementToDate;
  @HiveField(10)
  var approvalRate;
  @HiveField(11)
  var currentRate;
  @HiveField(12)
  var insurance;
  @HiveField(13)
  var insuranceFromDate;
  @HiveField(14)
  var insuranceToDate;
  @HiveField(15)
  var registrationDate;
  @HiveField(16)
  var createdAt;
  @HiveField(17)
  var updatedAt;
  @HiveField(18)
  var lastUpdatedByUser;
  @HiveField(19)
  var createdByUser;
  @HiveField(20)
  var isactive;

  Vehicle_data(
      {required this.iD,
      required this.centerName,
      required this.vehicleNo,
      required this.contractorName,
      required this.vehicleType,
      required this.vehicleModel,
      required this.passingType,
      required this.aggrementFromDate,
      required this.aggrementToDate,
      required this.approvalRate,
      required this.currentRate,
      required this.insurance,
      required this.insuranceFromDate,
      required this.insuranceToDate,
      required this.registrationDate,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser,
      required this.isactive,
      required this.isRegular});

  Vehicle_data.fromJson(Map<String, dynamic> json)
      : iD = json['ID'],
        centerName = json['CenterName'],
        vehicleNo = json['VehicleNo'],
        contractorName = json['ContractorName'],
        vehicleType = json['VehicleType'],
        vehicleModel = json['VehicleModel'],
        passingType = json['PassingType'],
        aggrementFromDate = json['AggrementFromDate'],
        aggrementToDate = json['AggrementToDate'],
        approvalRate = json['ApprovalRate'],
        currentRate = json['CurrentRate'],
        insurance = json['Insurance'],
        insuranceFromDate = json['InsuranceFromDate'],
        insuranceToDate = json['InsuranceToDate'],
        registrationDate = json['RegistrationDate'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        lastUpdatedByUser = json['lastUpdatedByUser'],
        createdByUser = json['createdByUser'],
        isactive = json['Isactive'],
        isRegular = json['isRegular'];

  Map<String, dynamic> toJson(Vehicle_data h) {
    return {
      'ID': h.iD,
      'CenterName': h.centerName,
      'VehicleNo': h.vehicleNo,
      'ContractorName': h.contractorName,
      'VehicleType': h.vehicleType,
      'VehicleModel': h.vehicleModel,
      'PassingType': h.passingType,
      'AggrementFromDate': h.aggrementFromDate,
      'AggrementToDate': h.aggrementToDate,
      'ApprovalRate': h.approvalRate,
      'CurrentRate': h.currentRate,
      'Insurance': h.insurance,
      'InsuranceFromDate': h.insuranceFromDate,
      'InsuranceToDate': h.insuranceToDate,
      'RegistrationDate': h.registrationDate,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
      'Isactive': h.isactive,
      'isRegular': h.isRegular,
    };
  }
}
