import 'package:hive/hive.dart';

part 'Master_paramter.g.dart';

@HiveType(typeId: 14)
class Master_paramter extends HiveObject {
  @HiveField(0)
  int heatInterval;
  @HiveField(1)
  int heatIntervalVar;
  @HiveField(2)
  int pD1;
  @HiveField(3)
  int pD1Var;
  @HiveField(4)
  int pD2;
  @HiveField(5)
  int pD2Var;
  @HiveField(6)
  int dried;
  @HiveField(7)
  int driedVar;
  @HiveField(8)
  int insuranceVar;
  @HiveField(9)
  int milkInterval;
  @HiveField(10)
  int heiferMaleAge;
  @HiveField(11)
  int heiferFemaleAge;
  @HiveField(12)
  int repeatBreeding;
  @HiveField(13)
  int conCalv;
  @HiveField(14)
  int calvingInterval;
  @HiveField(15)
  int lactationLength;
  @HiveField(16)
  int expectedFirstService;
  @HiveField(17)
  int peakDays;
  @HiveField(18)
  int openPeriod;
  @HiveField(19)
  int dryPeriod;
  @HiveField(20)
  int tFDays;
  @HiveField(21)
  int calvingDays;
  @HiveField(22)
  int milkProduction;
  @HiveField(23)
  int age;
  @HiveField(24)
  int noAI;
  @HiveField(25)
  int lactation;
  @HiveField(26)
  int firstHeatAfterCalving;
  @HiveField(27)
  int hundredDaysYield;
  @HiveField(28)
  int minStrawStock;
  @HiveField(29)
  int sirePregnancyRate;
  @HiveField(30)
  int snf;
  @HiveField(31)
  int fat;
  @HiveField(32)
  int protein;
  @HiveField(33)
  int lactose;
  @HiveField(34)
  int averageYield;
  @HiveField(35)
  int peakYield;
  @HiveField(36)
  int tFDMilk;
  @HiveField(37)
  int syncID;
  @HiveField(38)
  int breed;
  @HiveField(39)
  int id;
  @HiveField(40)
  String createdAt;
  @HiveField(41)
  String updatedAt;
  @HiveField(42)
  int lastUpdatedByUser;
  @HiveField(43)
  int createdByUser;

  Master_paramter(
      {required this.heatInterval,
      required this.heatIntervalVar,
      required this.pD1,
      required this.pD1Var,
      required this.pD2,
      required this.pD2Var,
      required this.dried,
      required this.driedVar,
      required this.insuranceVar,
      required this.milkInterval,
      required this.heiferMaleAge,
      required this.heiferFemaleAge,
      required this.repeatBreeding,
      required this.conCalv,
      required this.calvingInterval,
      required this.lactationLength,
      required this.expectedFirstService,
      required this.peakDays,
      required this.openPeriod,
      required this.dryPeriod,
      required this.tFDays,
      required this.calvingDays,
      required this.milkProduction,
      required this.age,
      required this.noAI,
      required this.lactation,
      required this.firstHeatAfterCalving,
      required this.hundredDaysYield,
      required this.minStrawStock,
      required this.sirePregnancyRate,
      required this.snf,
      required this.fat,
      required this.protein,
      required this.lactose,
      required this.averageYield,
      required this.peakYield,
      required this.tFDMilk,
      required this.syncID,
      required this.breed,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.lastUpdatedByUser,
      required this.createdByUser});

  Master_paramter.fromJson(Map<String, dynamic> json)
      : heatInterval = json['HeatInterval'] ?? 0,
        heatIntervalVar = json['HeatIntervalVar'] ?? 0,
        pD1 = json['PD1'] ?? 0,
        pD1Var = json['PD1Var'] ?? 0,
        pD2 = json['PD2'] ?? 0,
        pD2Var = json['PD2Var'] ?? 0,
        dried = json['Dried'] ?? 0,
        driedVar = json['DriedVar'] ?? 0,
        insuranceVar = json['InsuranceVar'] ?? 0,
        milkInterval = json['MilkInterval'] ?? 0,
        heiferMaleAge = json['HeiferMaleAge'] ?? 0,
        heiferFemaleAge = json['HeiferFemaleAge'] ?? 0,
        repeatBreeding = json['RepeatBreeding'] ?? 0,
        conCalv = json['ConCalv'] ?? 0,
        calvingInterval = json['CalvingInterval'] ?? 0,
        lactationLength = json['LactationLength'] ?? 0,
        expectedFirstService = json['ExpectedFirstService'] ?? 0,
        peakDays = json['PeakDays'] ?? 0,
        openPeriod = json['OpenPeriod'] ?? 0,
        dryPeriod = json['DryPeriod'] ?? 0,
        tFDays = json['TFDays'] ?? 0,
        calvingDays = json['CalvingDays'] ?? 0,
        milkProduction = json['MilkProduction'] ?? 0,
        age = json['Age'] ?? 0,
        noAI = json['NoAI'] ?? 0,
        lactation = json['Lactation'] ?? 0,
        firstHeatAfterCalving = json['FirstHeatAfterCalving'] ?? 0,
        hundredDaysYield = json['HundredDaysYield'] ?? 0,
        minStrawStock = json['MinStrawStock'] ?? 0,
        sirePregnancyRate = json['SirePregnancyRate'] ?? 0,
        snf = json['Snf'] ?? 0,
        fat = json['Fat'] ?? 0,
        protein = json['Protein'] ?? 0,
        lactose = json['Lactose'] ?? 0,
        averageYield = json['AverageYield'] ?? 0,
        peakYield = json['PeakYield'] ?? 0,
        tFDMilk = json['TFDMilk'] ?? 0,
        syncID = json['SyncID'] ?? 0,
        breed = json['breed'] ?? 0,
        id = json['id'] ?? 0,
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? 0,
        createdByUser = json['createdByUser'] ?? 0;

  Map<String, dynamic> toJson(Master_paramter h) {
    return {
      'HeatInterval': h.heatInterval,
      'HeatIntervalVar': h.heatIntervalVar,
      'PD1': h.pD1,
      'PD1Var': h.pD1Var,
      'PD2': h.pD2,
      'PD2Var': h.pD2Var,
      'Dried': h.dried,
      'DriedVar': h.driedVar,
      'InsuranceVar': h.insuranceVar,
      'MilkInterval': h.milkInterval,
      'HeiferMaleAge': h.heiferMaleAge,
      'HeiferFemaleAge': h.heiferFemaleAge,
      'RepeatBreeding': h.repeatBreeding,
      'ConCalv': h.conCalv,
      'CalvingInterval': h.calvingInterval,
      'LactationLength': h.lactationLength,
      'ExpectedFirstService': h.expectedFirstService,
      'PeakDays': h.peakDays,
      'OpenPeriod': h.openPeriod,
      'DryPeriod': h.dryPeriod,
      'TFDays': h.tFDays,
      'CalvingDays': h.calvingDays,
      'MilkProduction': h.milkProduction,
      'Age': h.age,
      'NoAI': h.noAI,
      'Lactation': h.lactation,
      'FirstHeatAfterCalving': h.firstHeatAfterCalving,
      'HundredDaysYield': h.hundredDaysYield,
      'MinStrawStock': h.minStrawStock,
      'SirePregnancyRate': h.sirePregnancyRate,
      'Snf': h.snf,
      'Fat': h.fat,
      'Protein': h.protein,
      'Lactose': h.lactose,
      'AverageYield': h.averageYield,
      'PeakYield': h.peakYield,
      'TFDMilk': h.tFDMilk,
      'SyncID': h.syncID,
      'breed': h.breed,
      'id': h.id,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
    };
  }
}
