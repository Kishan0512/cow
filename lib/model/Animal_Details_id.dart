import 'package:hive/hive.dart';

part 'Animal_Details_id.g.dart';

@HiveType(typeId: 42)
class Animal_Details_id extends HiveObject {
  @HiveField(0)
  var tagId;
  @HiveField(1)
  var code;
  @HiveField(2)
  var name;
  @HiveField(3)
  var dOB;
  @HiveField(4)
  var age;
  @HiveField(5)
  var birthWeight;
  @HiveField(6)
  var salvageFlag;
  @HiveField(7)
  var parity;
  @HiveField(8)
  var aITagNo;
  @HiveField(9)
  var currentParity;
  @HiveField(10)
  var registrationDate;
  @HiveField(11)
  var transactionDate;
  @HiveField(12)
  var breedingStatus;
  @HiveField(13)
  var heatDate;
  @HiveField(14)
  var heatSeq;
  @HiveField(15)
  var abortionSeq;
  @HiveField(16)
  var pDDate;
  @HiveField(17)
  var calvingDate;
  @HiveField(18)
  var dryDate;
  @HiveField(19)
  var milkDate;
  @HiveField(20)
  var lastMilk;
  @HiveField(21)
  var totalMilk;
  @HiveField(22)
  var selectFlag;
  @HiveField(23)
  var selectRemarks;
  @HiveField(24)
  var selectColor;
  @HiveField(25)
  var disposalRemarks;
  @HiveField(26)
  var isSuspended;
  @HiveField(27)
  var syncStatus;
  @HiveField(28)
  var lat;
  @HiveField(29)
  var long;
  @HiveField(30)
  var species;
  @HiveField(31)
  var breed;
  @HiveField(32)
  var herd;
  @HiveField(33)
  var lot;
  @HiveField(34)
  var farmer;
  @HiveField(35)
  var status;
  @HiveField(36)
  var pd1;
  @HiveField(37)
  var pd2;
  @HiveField(38)
  var sexFlg;
  @HiveField(39)
  var zone;
  @HiveField(40)
  var disposalFlag;
  @HiveField(41)
  var pBFlag;
  @HiveField(42)
  var virtualLot;
  @HiveField(43)
  var id;
  @HiveField(44)
  var farmername;
  @HiveField(45)
  var lotname;
  @HiveField(46)
  var herdname;
  @HiveField(47)
  var speciesname;
  @HiveField(48)
  var statusname;
  @HiveField(49)
  var breedname;
  @HiveField(50)
  var Syncstatus;
  @HiveField(51)
  var farmerCode;
  @HiveField(52)
  var lotcode;

  Animal_Details_id(
      {required this.tagId,
      required this.Syncstatus,
      required this.code,
      required this.name,
      required this.dOB,
      required this.age,
      required this.birthWeight,
      required this.salvageFlag,
      required this.parity,
      required this.aITagNo,
      required this.currentParity,
      required this.registrationDate,
      required this.transactionDate,
      required this.breedingStatus,
      required this.heatDate,
      required this.heatSeq,
      required this.abortionSeq,
      required this.pDDate,
      required this.calvingDate,
      required this.dryDate,
      required this.milkDate,
      required this.lastMilk,
      required this.totalMilk,
      required this.selectFlag,
      required this.selectRemarks,
      required this.selectColor,
      required this.disposalRemarks,
      required this.isSuspended,
      required this.syncStatus,
      required this.lat,
      required this.long,
      required this.species,
      required this.breed,
      required this.herd,
      required this.lot,
      required this.farmer,
      required this.status,
      required this.pd1,
      required this.pd2,
      required this.sexFlg,
      required this.zone,
      required this.disposalFlag,
      required this.pBFlag,
      required this.virtualLot,
      required this.farmername,
      required this.id,
      required this.lotname,
      required this.herdname,
      required this.speciesname,
      required this.statusname,
      required this.breedname,
      required this.farmerCode,
      required this.lotcode});

  Animal_Details_id.fromJson(Map<String, dynamic> json)
      : tagId = json['TagId'],
        code = json['code'],
        name = json['Name'],
        dOB = json['DOB'],
        Syncstatus = json['SyncStatus'],
        age = json['Age'],
        birthWeight = json['BirthWeight'],
        salvageFlag = json['SalvageFlag'],
        parity = json['Parity'],
        aITagNo = json['AITagNo'],
        currentParity = json['CurrentParity'],
        registrationDate = json['RegistrationDate'],
        transactionDate = json['TransactionDate'],
        breedingStatus = json['BreedingStatus'],
        heatDate = json['HeatDate'] ?? "",
        heatSeq = json['HeatSeq'],
        abortionSeq = json['AbortionSeq'],
        pDDate = json['PDDate'],
        calvingDate = json['CalvingDate'],
        dryDate = json['DryDate'],
        milkDate = json['MilkDate'],
        lastMilk = json['LastMilk'],
        totalMilk = json['TotalMilk'],
        selectFlag = json['SelectFlag'],
        selectRemarks = json['SelectRemarks'],
        selectColor = json['SelectColor'],
        disposalRemarks = json['DisposalRemarks'],
        isSuspended = json['IsSuspended'],
        syncStatus = json['SyncStatus'],
        lat = json['Lat'],
        long = json['Long'],
        species = json['species'],
        breed = json['breed'],
        herd = json['herd'],
        lot = json['lot'],
        farmer = json['farmer'],
        status = json['status'],
        pd1 = json['pd1'],
        pd2 = json['pd2'],
        sexFlg = json['SexFlg'],
        zone = json['zone'],
        disposalFlag = json['DisposalFlag'],
        pBFlag = json['PBFlag'],
        virtualLot = json['virtualLot'],
        id = json['id'],
        farmername = json['farmername'],
        lotname = json['lotname'],
        herdname = json['herdname'],
        speciesname = json['speciesname'],
        statusname = json['statusname'],
        breedname = json['breedname'],
        farmerCode = json['farmerCode'],
        lotcode = json['lotcode'];

  Map<String, dynamic> toJson(Animal_Details_id h) {
    return {
      'SyncStatus': h.Syncstatus,
      'TagId': h.tagId,
      'code': h.code,
      'Name': h.name,
      'DOB': h.dOB,
      'Age': h.age,
      'BirthWeight': h.birthWeight,
      'SalvageFlag': h.salvageFlag,
      'Parity': h.parity,
      'AITagNo': h.aITagNo,
      'CurrentParity': h.currentParity,
      'RegistrationDate': h.registrationDate,
      'TransactionDate': h.transactionDate,
      'BreedingStatus': h.breedingStatus,
      'HeatDate': h.heatDate,
      'HeatSeq': h.heatSeq,
      'AbortionSeq': h.abortionSeq,
      'PDDate': h.pDDate,
      'CalvingDate': h.calvingDate,
      'DryDate': h.dryDate,
      'MilkDate': h.milkDate,
      'LastMilk': h.lastMilk,
      'TotalMilk': h.totalMilk,
      'SelectFlag': h.selectFlag,
      'SelectRemarks': h.selectRemarks,
      'SelectColor': h.selectColor,
      'DisposalRemarks': h.disposalRemarks,
      'IsSuspended': h.isSuspended,
      'SyncStatus': h.syncStatus,
      'Lat': h.lat,
      'Long': h.long,
      'species': h.species,
      'breed': h.breed,
      'herd': h.herd,
      'lot': h.lot,
      'farmer': h.farmer,
      'status': h.status,
      'pd1': h.pd1,
      'pd2': h.pd2,
      'SexFlg': h.sexFlg,
      'zone': h.zone,
      'DisposalFlag': h.disposalFlag,
      'PBFlag': h.pBFlag,
      'virtualLot': h.virtualLot,
      'farmername': h.farmername,
      'id': h.id,
      'lotname': h.lotname,
      'herdname': h.herdname,
      'speciesname': h.speciesname,
      'statusname': h.statusname,
      'breedname': h.breedname,
      'farmerCode': h.farmerCode,
      'lotcode': h.lotcode
    };
  }

  static Map<String, dynamic> tomap(Animal_Details_id h) {
    return {
      'SyncStatus': h.Syncstatus,
      'TagId': h.tagId,
      'code': h.code,
      'Name': h.name,
      'DOB': h.dOB,
      'Age': h.age,
      'BirthWeight': h.birthWeight,
      'SalvageFlag': h.salvageFlag,
      'Parity': h.parity,
      'AITagNo': h.aITagNo,
      'CurrentParity': h.currentParity,
      'RegistrationDate': h.registrationDate,
      'TransactionDate': h.transactionDate,
      'BreedingStatus': h.breedingStatus,
      'HeatDate': h.heatDate,
      'HeatSeq': h.heatSeq,
      'AbortionSeq': h.abortionSeq,
      'PDDate': h.pDDate,
      'CalvingDate': h.calvingDate,
      'DryDate': h.dryDate,
      'MilkDate': h.milkDate,
      'LastMilk': h.lastMilk,
      'TotalMilk': h.totalMilk,
      'SelectFlag': h.selectFlag,
      'SelectRemarks': h.selectRemarks,
      'SelectColor': h.selectColor,
      'DisposalRemarks': h.disposalRemarks,
      'IsSuspended': h.isSuspended,
      'SyncStatus': h.syncStatus,
      'Lat': h.lat,
      'Long': h.long,
      'species': h.species,
      'breed': h.breed,
      'herd': h.herd,
      'lot': h.lot,
      'farmer': h.farmer,
      'status': h.status,
      'pd1': h.pd1,
      'pd2': h.pd2,
      'SexFlg': h.sexFlg,
      'zone': h.zone,
      'DisposalFlag': h.disposalFlag,
      'PBFlag': h.pBFlag,
      'virtualLot': h.virtualLot,
      'farmername': h.farmername,
      'id': h.id,
      'lotname': h.lotname,
      'herdname': h.herdname,
      'speciesname': h.speciesname,
      'statusname': h.statusname,
      'breedname': h.breedname,
      'farmerCode': h.farmerCode,
      'lotcode': h.lotcode
    };
  }
}
