import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:herdmannew/Model_local/Breeding_PD.dart';
import 'package:herdmannew/Model_local/Language_model.dart';
import 'package:herdmannew/Model_local/Milk_PD.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_ApiUrl.dart';
import 'package:herdmannew/model/Animal_Deworming.dart';
import 'package:herdmannew/model/Animal_Production.dart';
import 'package:herdmannew/model/Animal_Treatment.dart';
import 'package:herdmannew/model/Animal_Vaccination.dart';
import 'package:herdmannew/model/Animal_registration.dart';
import 'package:herdmannew/model/Animal_weight_entry_model.dart';
import 'package:herdmannew/model/Get_Master_Farmer.dart';
import 'package:herdmannew/model/Master_Service.dart';
import 'package:herdmannew/model/Master_UserLots.dart';
import 'package:herdmannew/model/Master_breed.dart';
import 'package:herdmannew/model/Master_calvingType.dart';
import 'package:herdmannew/model/Master_calvingTypeOption.dart';
import 'package:herdmannew/model/Master_dewormingType.dart';
import 'package:herdmannew/model/Master_diagnosis.dart';
import 'package:herdmannew/model/Master_disposal.dart';
import 'package:herdmannew/model/Master_disposalSubOptions.dart';
import 'package:herdmannew/model/Master_dryOffReason.dart';
import 'package:herdmannew/model/Master_feature.dart';
import 'package:herdmannew/model/Master_inseminator.dart';
import 'package:herdmannew/model/Master_medicineLedger.dart';
import 'package:herdmannew/model/Master_medicineRoute.dart';
import 'package:herdmannew/model/Master_medicineType.dart';
import 'package:herdmannew/model/Master_paramter.dart';
import 'package:herdmannew/model/Master_pd1.dart';
import 'package:herdmannew/model/Master_pd2.dart';
import 'package:herdmannew/model/Master_reproductveProblem.dart';
import 'package:herdmannew/model/Master_sex.dart';
import 'package:herdmannew/model/Master_sire.dart';
import 'package:herdmannew/model/Master_smsSetting.dart';
import 'package:herdmannew/model/Master_species.dart';
import 'package:herdmannew/model/Master_status.dart';
import 'package:herdmannew/model/Master_systemAffected.dart';
import 'package:herdmannew/model/Master_treatmentComplaint.dart';
import 'package:herdmannew/model/Master_userFeatureAccessDetail.dart';
import 'package:herdmannew/model/Master_vaccinationType.dart';
import 'package:herdmannew/model/Vehicle_purpose.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../../Model_local/Bredding_Calving.dart';
import '../../Model_local/Breeding_Abortion.dart';
import '../../Model_local/Breeding_Dry.dart';
import '../../Model_local/Breeding_insemination.dart';
import '../../model/Animal_Details_id.dart';
import '../../model/Animal_Disposal.dart';
import '../../model/Animal_Treatment_details.dart';
import '../../model/Animal_reproduction.dart';
import '../../model/Animal_timeline.dart';
import '../../model/Breeding_reproduction_id.dart';
import '../../model/Master_UserHerds.dart';
import '../../model/Milk_production_id.dart';
import '../../model/Vehicle_data.dart';
import '../../model/Visit_Registration.dart';
import '../A_SQL_Trigger/A_NetworkHelp.dart';
import '../Gobal_Widgets/Con_Usermast.dart';
import '../Gobal_Widgets/Constants.dart';
import 'Con_List.dart';
import 'SharedPref.dart';
import 'Sync_Api.dart';
import 'Sync_Json.dart';

class SyncDB {
  static List<String> TableName = const [];
  static ValueNotifier<bool> isFeatureAccess = ValueNotifier(false);

  static Future SyncTableAuto(bool _blnAuto) async {
    TableName.forEach((e) => SyncTable(e, _blnAuto));
  }

  static Future<int> insert_table(
    List note,
    String pStrTableName,
  ) async {
    try {
      switch (pStrTableName) {
        case "Account_medicineLedger":
          var box = await Hive.openBox<Master_medicineLedger>(
              "Master_medicineLedger");
          note
              .map((e) => box.put(
                  e['id'].toString(), Master_medicineLedger.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Milk_Pd_Test":
          var box = await Hive.openBox<Milk_PDTest>("Milk_Pd_Test");
          try {
            Constants.Last_milk_PD = int.parse(box.keys.last.toString());
          } catch (e) {
            print(e);
            Constants.Last_milk_PD = 0;
          }
          note
              .map((e) => box.put(e['id'].toString(), Milk_PDTest.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Breeding_pd":
          var box = await Hive.openBox<Breeding_PD>("Breeding_pd");
          try {
            Constants.Last_id_Breed_PD = int.parse(box.keys.last.toString());
          } catch (e) {
            print(e);
            Constants.Last_id_Breed_PD = 0;
          }
          note
              .map((e) => box.put(e['id'].toString(), Breeding_PD.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Breeding_Abortion":
          var box = await Hive.openBox<Breeding_Abortion>("Breeding_Abortion");
          try {
            Constants.Last_id_abor = int.parse(box.keys.last.toString());
          } catch (e) {
            print(e);
            Constants.Last_id_abor = 0;
          }
          note
              .map((e) =>
                  box.put(e['id'].toString(), Breeding_Abortion.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Breeding_insemination":
          var box = await Hive.openBox<Breeding_insemination>(
              "Breeding_insemination");
          try {
            Constants.Last_id_AI = int.parse(box.keys.last.toString());
          } catch (e) {
            print(e);
            Constants.Last_id_AI = 0;
          }
          note
              .map((e) => box.put(
                  e['id'].toString(), Breeding_insemination.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Dryoff_save":
          var box = await Hive.openBox<Breeding_Dry>("Dryoff_save");
          try {
            Constants.Last_id_dryoff = int.parse(box.keys.last.toString());
          } catch (e) {
            print(e);
            Constants.Last_id_dryoff = 0;
          }
          note
              .map((e) => box.put(e['id'].toString(), Breeding_Dry.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Breeding_Calving":
          var box = await Hive.openBox<Breeding_Calving>("Breeding_Calving");
          try {
            Constants.Last_id_dryoff = int.parse(box.keys.last.toString());
          } catch (e) {
            print(e);
            Constants.Last_id_dryoff = 0;
          }
          note
              .map((e) =>
                  box.put(e['id'].toString(), Breeding_Calving.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Health_deworming":
          var box = await Hive.openBox<Animal_Deworming>("Animal_Deworming");
          try {
            Constants.Last_id_Deworming = int.parse(box.keys.last.toString());
          } catch (e) {
            print(e);
            Constants.Last_id_Deworming = 0;
          }
          note
              .map((e) =>
                  box.put(e['id'].toString(), Animal_Deworming.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Account_medicineType":
          var box =
              await Hive.openBox<Master_medicineType>("Master_medicineType");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['ID'].toString(), Master_medicineType.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Animal_diedDetails":
          var box = await Hive.openBox<Animal_Disposal>("Animal_diedDetails");
          try {
            Constants.Last_id_Animal_diedDetails =
                int.parse(box.keys.last.toString());
          } catch (e) {
            print(e);
            Constants.Last_id_Animal_diedDetails = 0;
          }
          note
              .map((e) =>
                  box.put(e['id'].toString(), Animal_Disposal.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Breeding_reproduction":
          var box =
              await Hive.openBox<Animal_reproduction>("Breeding_reproduction");
          await box.clear();
          note
              .map((e) => box.put(
                  e['TagId'].toString(), Animal_reproduction.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Common_breed":
          var box = await Hive.openBox<Master_breed>("Master_breed");
          await box.clear();
          note
              .map((e) => box.put(e['id'].toString(), Master_breed.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Common_calvingType":
          var box =
              await Hive.openBox<Master_calvingType>("Master_calvingType");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['id'].toString(), Master_calvingType.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Common_calvingTypeOption":
          var box = await Hive.openBox<Master_calvingTypeOption>(
              "Master_calvingTypeOption");
          await box.clear();
          note
              .map((e) => box.put(
                  e['id'].toString(), Master_calvingTypeOption.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Common_disposal":
          var box = await Hive.openBox<Master_disposal>("Master_disposal");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['ID'].toString(), Master_disposal.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Common_disposalSubOptions":
          var box = await Hive.openBox<Master_disposalSubOptions>(
              "Master_disposalSubOptions");
          await box.clear();
          note
              .map((e) => box.put(
                  e['ID'].toString(), Master_disposalSubOptions.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Common_dryOffReason":
          var box =
              await Hive.openBox<Master_dryOffReason>("Master_dryOffReason");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['ID'].toString(), Master_dryOffReason.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Common_pd1":
          var box = await Hive.openBox<Master_pd1>("Master_pd1");
          await box.clear();
          note
              .map((e) => box.put(e['ID'].toString(), Master_pd1.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Common_pd2":
          var box = await Hive.openBox<Master_pd2>("Master_pd2");
          await box.clear();
          note
              .map((e) => box.put(e['ID'].toString(), Master_pd2.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Common_reproductiveProblem":
          var box = await Hive.openBox<Master_reproductveProblem>(
              "Master_reproductveProblem");
          await box.clear();
          note
              .map((e) => box.put(
                  e['ID'].toString(), Master_reproductveProblem.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Common_service":
          var box = await Hive.openBox<Master_service>("Master_service");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['ID'].toString(), Master_service.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Common_sex":
          var box = await Hive.openBox<Master_sex>("Master_sex");
          await box.clear();
          note
              .map((e) => box.put(e['ID'].toString(), Master_sex.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Common_smslanguage":
          break;
        case "Common_species":
          var box = await Hive.openBox<Master_species>("Master_species");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['id'].toString(), Master_species.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Common_status":
          var box = await Hive.openBox<Master_status>("Master_status");
          await box.clear();
          note
              .map(
                  (e) => box.put(e['ID'].toString(), Master_status.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Common_treatmentComplaint":
          var box = await Hive.openBox<Master_treatmentComplaint>(
              "Master_treatmentComplaint");
          await box.clear();
          note
              .map((e) => box.put(
                  e['ID'].toString(), Master_treatmentComplaint.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Common_vaccinationType":
          var box = await Hive.openBox<Master_vaccinationType>(
              "Master_vaccinationType");
          await box.clear();
          note
              .map((e) => box.put(
                  e['id'].toString(), Master_vaccinationType.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Health_CallCenterService":
          break;
        case "Health_FarmerComplaint":
          break;
        case "Health_diagnosis":
          var box = await Hive.openBox<Master_diagnosis>("Master_diagnosis");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['id'].toString(), Master_diagnosis.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Health_systemAffected":
          var box = await Hive.openBox<Master_systemAffected>(
              "Master_systemAffected");
          await box.clear();
          note
              .map((e) => box.put(
                  e['id'].toString(), Master_systemAffected.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Health_treatment":
          var box = await Hive.openBox<Animal_Treatment>("Animal_treatment");
          try {
            Constants.Last_id_Treatment = int.parse(box.keys.last.toString());
          } catch (e) {
            print(e);
            Constants.Last_id_Treatment = 0;
          }
          note
              .map((e) =>
                  box.put(e['id'].toString(), Animal_Treatment.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Health_treatmentDetails":
          var box = await Hive.openBox<Animal_Treatment_details>(
              "Health_treatmentDetails");
          try {
            Constants.Last_id_Treatment_detail =
                int.parse(box.keys.last.toString());
          } catch (e) {
            print(e);
            Constants.Last_id_Treatment_detail = 0;
          }
          note
              .map((e) => box.put(
                  e['id'].toString(), Animal_Treatment_details.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Health_vaccination":
          var box =
              await Hive.openBox<Animal_Vaccination>("Health_vaccination");
          await box.clear();
          note
              .map((e) => box.put(
                  e['TagId'].toString(), Animal_Vaccination.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Health_weightGainDiet":
          var box = await Hive.openBox<Animal_weight_entry_model>(
              "Health_weightGainDiet");
          await box.clear();
          note
              .map((e) => box.put(
                  e['TagId'].toString(), Animal_weight_entry_model.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Master_cc":
          break;
        case "Master_dewormingType":
          var box =
              await Hive.openBox<Master_dewormingType>("Master_dewormingType");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['id'].toString(), Master_dewormingType.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Master_farmer":
          if (note.isEmpty) break;
          var box = await Hive.openBox<Get_Master_Farmer>("Master_Farmer");
          note
              .map((e) =>
                  box.put(e['id'].toString(), Get_Master_Farmer.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Master_herd":
          var box = await Hive.openBox<Master_UserHerds>("Master_UserHerds");
          await box.clear();

          note
              .map((e) =>
                  box.put(e['id'].toString(), Master_UserHerds.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Master_lot":
          var box = await Hive.openBox<Master_Userlots>("Master_Userlots");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['id'].toString(), Master_Userlots.fromJson(e)))
              .toList();

          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Master_lotlatlong":
          break;
        case "Master_medicineRoute":
          var box =
              await Hive.openBox<Master_medicineRoute>("Master_medicineRoute");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['ID'].toString(), Master_medicineRoute.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Master_parameter":
          var box = await Hive.openBox<Master_paramter>("Master_paramter");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['id'].toString(), Master_paramter.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Master_sire":
          var box = await Hive.openBox<Master_sire>("Master_sire");
          await box.clear();
          try {
            note
                .map(
                    (e) => box.put(e.containsKey('id')?e['id'].toString():e['ID'].toString(), Master_sire.fromJson(e)))
                .toList();
            Sync_Json.Get_Master_Data(pStrTableName);
          } catch (e) {
            print("$e");
          }
          break;
        case "Master_smsSetting":
          var box = await Hive.openBox<Master_smsSetting>("Master_smsSetting");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['id'].toString(), Master_smsSetting.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Master_source":
          break;
        case "Master_staff":
          var box =
              await Hive.openBox<Master_inseminator>("Master_inseminator");
          await box.clear();
          // if (note
          //         .where((element) => element['Name'].toString() == "Unknown")
          //         .length ==
          //     0) {
          //   var temp = {
          //     "Name": "Unknown",
          //     "code": "",
          //     "CountryCode": "",
          //     "Mobile": "0",
          //     "PaymentType": "",
          //     "Qualification": "",
          //     "Address": null,
          //     "MaxBalance": null,
          //     "Basic": null,
          //     "IsSendSMS": false,
          //     "VOFlag": false,
          //     "IsSuspended": false,
          //     "AllowUser": false,
          //     "Email": "",
          //     "group": 9,
          //     "smsLanguage": 0,
          //     "id": 1,
          //     "createdAt": "2021-05-25T10:18:39.063Z",
          //     "updatedAt": "2021-05-25T10:18:39.063Z",
          //     "lastUpdatedByUser": null,
          //     "createdByUser": null,
          //     "voCategory": 0,
          //     "voPost": 0,
          //     "employeeNo": 0,
          //     "localName": "",
          //     "joiningDate": "",
          //     "zone": null,
          //     "Route": null,
          //     "DCS": null,
          //     "gvcDetails": null,
          //     "dcsname": ""
          //   };
          //   note.add(temp);
          // }

          note
              .map((e) =>
                  box.put(e['id'].toString(), Master_inseminator.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Milk_parameter":
          var box = await Hive.openBox<Master_paramter>("Master_Milk_paramter");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['id'].toString(), Master_paramter.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Milk_production":
          var box = await Hive.openBox<Animal_Production>("Milk_production");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['TagId'].toString(), Animal_Production.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "RoleAuthAndLogs_feature":
          var box = await Hive.openBox<Master_feature>("Master_feature");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['id'].toString(), Master_feature.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "Animal_Registration":

          var box = await Hive.openBox<Animal_Registration>("Animal_Registration");
          await box.clear();
          note
              .map((e) =>
              box.put(e[''].toString(), Animal_Registration.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "RoleAuthAndLogs_featureroleaccesscontrol":
          break;
        case "RoleAuthAndLogs_featureuseraccesscontrol":
          break;
        case "RoleAuthAndLogs_featureuseraccesstxn":
          var box = await Hive.openBox<Master_userFeatureAccessDetail>(
              "Master_userFeatureAccessDetail");
          // await box.clear();
          isFeatureAccess.value = true;
          note
              .map((e) => box.put(e['id'].toString(),
                  Master_userFeatureAccessDetail.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);

          break;
        case "RoleAuthAndLogs_module":
          break;
        case "RoleAuthAndLogs_role":
          break;
        case "Timeline":
          var box = await Hive.openBox<Animal_timeline>("Timeline");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['tagno'].toString(), Animal_timeline.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "VISITREGISTRATION":
          var box = await Hive.openBox<Visit_Registration>("VISITREGISTRATION");
          await box.clear();
          note
              .map((e) => box.put(
                  e['VisitID'].toString(), Visit_Registration.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Vehicle_purpose":
          var box = await Hive.openBox<Vehicle_purpose>("Vehicle_purpose");
          await box.clear();
          note
              .map((e) =>
                  box.put(e['ID'].toString(), Vehicle_purpose.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Vehicle_data":
          var box = await Hive.openBox<Vehicle_data>("Vehicle_data");
          await box.clear();
          note
              .map((e) => box.put(e['ID'].toString(), Vehicle_data.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
        case "Breeding_reproduction_id":
          try {
            var box = await Hive.openBox<Breeding_reproduction_id>(
                "Breeding_reproduction_id");
            note
                .map((e) =>
                    box.put("${e['id']}", Breeding_reproduction_id.fromJson(e)))
                .toList();
            Sync_Json.Get_Master_Data(pStrTableName);
          } catch (e) {
            print("$pStrTableName error = $e");
          }
          break;
        case "Animal_Details_id":
          try {
            var box =
                await Hive.openBox<Animal_Details_id>("Animal_Details_id");
            note
                .map((e) =>
                    box.put(e['id'].toString(), Animal_Details_id.fromJson(e)))
                .toList();
            Sync_Json.Get_Master_Data(pStrTableName);
          } catch (e) {
            print("$pStrTableName error = $e");
          }
          break;
        case "Milk_production_id":
          var box =
              await Hive.openBox<Milk_production_id>("Milk_production_id");
          try {
            Constants.Last_id_milk = int.parse(box.keys.last.toString());
          } catch (e) {
            print(e);
            Constants.Last_id_milk = 0;
          }
          note
              .map((e) =>
                  box.put(e['id'].toString(), Milk_production_id.fromJson(e)))
              .toList();
          Sync_Json.Get_Master_Data(pStrTableName);
          break;
      }
    } catch (e) {
      print("hive_insert_throw +++ $pStrTableName ++ $e");
    }
    return 1;
  }

  static Future<void> update_table(
      Map<String, Object?> note, String pStrTableName) async {}

  static Future<void> SyncTable(String pStrTableName, bool _blnauto,
      [List? map]) async {
    try {
      switch (pStrTableName) {
        case "OneTimeData":
          final res = await http.get(Uri.parse(AppUrl().ONETIMEDATA), headers: {
            'authorization': "Bearer " + Constants_Usermast.token,
            "Accept": "application/json"
          });
          if (res.statusCode == 200) {
            var resBody = json.decode(res.body);

            try {
              insert_table(
                  resBody["master_service"], Constants.Tbl_Common_service);
              insert_table(resBody["master_pd1"], Constants.Tbl_Common_pd1);
              insert_table(resBody["master_pd2"], Constants.Tbl_Common_pd2);
              insert_table(resBody["master_sex"], Constants.Tbl_Common_sex);
              insert_table(
                  resBody["master_disposal"], Constants.Tbl_Common_disposal);
              insert_table(resBody["master_disposalSubOptions"],
                  Constants.Tbl_Common_disposalSubOptions);
              insert_table(
                  resBody["master_status"], Constants.Tbl_Common_status);
              insert_table(resBody["master_reproductveProblem"],
                  Constants.Tbl_Common_reproductiveProblem);
              insert_table(resBody["master_medicineRoute"],
                  Constants.Tbl_Master_medicineRoute);
              insert_table(resBody["master_treatmentComplaint"],
                  Constants.Tbl_Common_treatmentComplaint);
              insert_table(resBody["master_medicineType"],
                  Constants.Tbl_Account_medicineType);
              insert_table(resBody["master_dryOffReason"],
                  Constants.Tbl_Common_dryOffReason);
            } catch (e) {
              print("ERROR FROM ONETIMEDATA   " + e.toString());
            }
          }
          break;
        case "MASTER_DATA":
          final res = await http.get(
              Uri.parse(AppUrl().MASTER_DATA + Constants_Usermast.user_id),
              headers: {
                'authorization': "Bearer " + Constants_Usermast.token,
                "Accept": "application/json"
              });

          if (res.statusCode == 200) {
            var resBody = json.decode(res.body);
            try {

              insert_table(resBody["user"]["herds"], Constants.Tbl_Master_herd);
              //insert_table(resBody["user"]["lots"], Constants.Tbl_Master_lot);
              if (!isFeatureAccess.value) {
                insert_table(resBody["userFeatureAccessDetail"],
                    Constants.Tbl_RoleAuthAndLogs_featureuseraccesstxn);
              }

              insert_table(resBody["species"], Constants.Tbl_Common_species);

              insert_table(resBody["breed"], Constants.Tbl_Common_breed);

              insert_table(resBody["inseminator"], Constants.Tbl_Master_staff);

              insert_table(
                  resBody["feature"], Constants.Tbl_RoleAuthAndLogs_feature);

              insert_table(resBody["paramter"], Constants.Tbl_Milk_parameter);

              insert_table(resBody["paramter"], Constants.Tbl_Master_parameter);

              insert_table(resBody["systemAffected"],
                  Constants.Tbl_Health_systemAffected);

              insert_table(resBody["medicineLedger"],
                  Constants.Tbl_Account_medicineLedger);

              insert_table(resBody["vaccinationType"],
                  Constants.Tbl_Common_vaccinationType);

              insert_table(
                  resBody["dewormingType"], Constants.Tbl_Master_dewormingType);

              insert_table(
                  resBody["diagnosis"], Constants.Tbl_Health_diagnosis);

              insert_table(
                  resBody["calfSchedule"], Constants.Tbl_Master_calfSchedule);

              insert_table(
                  resBody["calvingType"], Constants.Tbl_Common_calvingType);

              insert_table(resBody["calvingTypeOption"],
                  Constants.Tbl_Common_calvingTypeOption);

            } catch (e) {
              print("master error + $e");
            }
          }

          break;
        case "All_Animal_Download":
          List tagIds =
              map!.map((e) => {"TagId": e['TagId'], "id": e['id']}).toList();
          var testing = {'tagIdArray': jsonEncode(tagIds)};
          await ApiCalling.createPost(AppUrl().CATTLE_SYNC_BACK_URL,
                  "Bearer " + Constants_Usermast.token.toString(), testing)
              .then((response) async {
            if (response.statusCode == 200) {
              var jsonData = json.decode(response.body);
              insert_table(jsonData['details'], Constants.Tbl_Animal_details);
              insert_table(jsonData['reproduction'],
                  Constants.Tbl_Breeding_reproduction);
              insert_table(jsonData['timeline'], Constants.Tbl_Timeline);
              insert_table(
                  jsonData['production'], Constants.Tbl_Milk_production);
              insert_table(
                  jsonData['weight'], Constants.Tbl_Health_weightGainDiet);
              insert_table(
                  jsonData['deworming'], Constants.Tbl_Health_deworming);
              insert_table(
                  jsonData['vaccination'], Constants.Tbl_Health_vaccination);
              insert_table(
                  jsonData['treatment'], Constants.Tbl_Health_treatment);
              insert_table(jsonData['treatmentDetails'],
                  Constants.Tbl_Health_treatmentDetails);
              insert_table(
                  jsonData['diedDetails'], Constants.Tbl_Animal_diedDetails);
            } else {}
          });
          break;

        case "Master_Farmer":
          var box = await Hive.openBox<Get_Master_Farmer>("Master_Farmer");
          String key;
          try {
            key = box.keys.last;
          } catch (e) {
            key = "0";
          }
          final rese = await ApiCalling.createPost(AppUrl().Masterdata,
              "Bearer " + Constants_Usermast.token.toString(), {
            "Userid": "${Constants_Usermast.user_id}",
            "TBLSTR": "Master_farmer:$key"
          });

          if (rese.statusCode == 200 || rese.body.toString() != "[]") {
            var resBody = jsonDecode(rese.body);
            List<dynamic> data = resBody[0];
            try {
              insert_table(data, Constants.Tbl_Master_farmer);
            } catch (e) {
              print("GetFarmererror - $e");
            }
          }
          break;
        case "Master_lot":
          var box = await Hive.openBox<Master_Userlots>("Master_Userlots");
          String key;
          try {
            key = box.keys.last;
          } catch (e) {
            key = "0";
          }
          final rese = await ApiCalling.createPost(AppUrl().Masterdata,
              "Bearer " + Constants_Usermast.token.toString(), {
            "Userid": "${Constants_Usermast.user_id}",
            "TBLSTR": "Master_lot:$key"
          });

          if (rese.statusCode == 200 || rese.body.toString() != "[]") {
            var resBody = jsonDecode(rese.body);
            List<dynamic> data = resBody[0];
            try {
              insert_table(data, Constants.Tbl_Master_lot);
            } catch (e) {
              print("GetFarmererror - $e");
            }
          }
          break;
        case "Milk_production_id":
          var box =
              await Hive.openBox<Milk_production_id>("Milk_production_id");
          String key;
          try {
            key = box.keys.last;
          } catch (e) {
            key = "0";
          }
          try {
            final res = await ApiCalling.createPost(AppUrl().GetAnimalbyuserid,
                "Bearer " + Constants_Usermast.token.toString(), {
              "userID": "${Constants_Usermast.user_id}",
              "TBLSTR": "Milk_production:$key"
            });
            if (res.statusCode == 200) {
              var jsonData = json.decode(res.body);
              if (jsonData.toString() != "{}") {
                insert_table(jsonData['Milk_production:$key'],
                    Constants.Milk_production_id);
              }
            }
          } catch (e) {
            print("$pStrTableName sync = $e");
          }
          break;
        case "Animal_Details_id":
          var box = await Hive.openBox<Animal_Details_id>("Animal_Details_id");
          String key;
          try {
            key = box.keys.last;
          } catch (e) {
            key = "0";
          }
          try {
            final res = await ApiCalling.createPost(AppUrl().GetAnimalbyuserid,
                "Bearer " + Constants_Usermast.token.toString(), {
              "userID": "${Constants_Usermast.user_id}",
              "TBLSTR": "Animal_Details:$key"
            });

            if (res.statusCode == 200) {
              var jsonData = json.decode(res.body);
              if (jsonData.toString() != "{}") {
                insert_table(jsonData['Animal_Details:$key'],
                    Constants.Animal_Details_id);
              }
            }
          } catch (e) {
            print("$pStrTableName sync = $e");
          }
          break;
        case "Breeding_reproduction_id":
          var box = await Hive.openBox<Breeding_reproduction_id>(
              "Breeding_reproduction_id");
          String key;
          try {
            key = box.keys.last;
          } catch (e) {
            key = "0";
          }
          try {
            final res = await ApiCalling.createPost(AppUrl().GetAnimalbyuserid,
                "Bearer " + Constants_Usermast.token.toString(), {
              "userID": "${Constants_Usermast.user_id}",
              "TBLSTR": "Breeding_reproduction:$key"
            });
            if (res.statusCode == 200) {
              var jsonData = json.decode(res.body);
              if (jsonData.toString() != "{}") {
                insert_table(jsonData['Breeding_reproduction:$key'],
                    Constants.Breeding_reproduction_id);
              }
            }
          } catch (e) {
            print("$pStrTableName sync = $e");
          }
          break;
        case "Animal_treatment":
          var box = await Hive.openBox<Animal_Treatment>("Animal_Treatment");
          String key;
          try {
            key = box.keys.last;
          } catch (e) {
            key = "0";
          }
          try {
            final res = await ApiCalling.createPost(AppUrl().GetAnimalbyuserid,
                "Bearer " + Constants_Usermast.token.toString(), {
              "userID": "${Constants_Usermast.user_id}",
              "TBLSTR": "Health_treatment:$key"
            });
            if (res.statusCode == 200) {
              var jsonData = json.decode(res.body);
              if (jsonData.toString() != "{}") {
                insert_table(jsonData['Health_treatment:$key'],
                    Constants.Tbl_Health_treatment);
              }
            }
          } catch (e) {
            print("$pStrTableName sync = $e");
          }
          break;
        case "Health_treatmentDetails":
          var box = await Hive.openBox<Animal_Treatment_details>(
              "Health_treatmentDetails");
          String key;
          try {
            key = box.keys.last;
          } catch (e) {
            key = "0";
          }
          try {
            final res = await ApiCalling.createPost(AppUrl().GetAnimalbyuserid,
                "Bearer " + Constants_Usermast.token.toString(), {
              "userID": "${Constants_Usermast.user_id}",
              "TBLSTR": "Health_treatmentDetails:$key"
            });
            if (res.statusCode == 200) {
              var jsonData = json.decode(res.body);
              if (jsonData.toString() != "{}") {
                insert_table(jsonData['Health_treatmentDetails:$key'],
                    Constants.Tbl_Health_treatmentDetails);
              }
            }
          } catch (e) {
            print("$pStrTableName sync = $e");
          }
          break;

        case "sireStock":
          try {
            Con_List.M_sire.where((e) => e.Syncstatus == "0").forEach(
                (e) async => await Sync_Api.insert_Api(
                    NoteList: [],
                    note: e.toJson(e),
                    pStrTableName: "Update_Sire"));
            final res =
                await http.get(Uri.parse(AppUrl().Get_sirestock), headers: {
              'authorization': "Bearer " + Constants_Usermast.token,
              "Accept": "application/json"
            });
            List resBody = json.decode(res.body);


            insert_table(resBody, Constants.Tbl_Master_sire);
          } catch (e) {
            print("erore $e");
          }
          break;
        case "VISITREGISTRATION":
          final res = await http.get(
              Uri.parse(
                  AppUrl().getVisitRegistration + Constants_Usermast.user_id),
              headers: {
                'authorization': "Bearer " + Constants_Usermast.token,
                "Accept": "application/json"
              });
          print(res.statusCode);
          print(res.body);

          if (res.statusCode == 200) {
            var jsonData = json.decode(res.body);
            insert_table(jsonData['data'], Constants.Tbl_VISITREGISTRATION);

            List Data = jsonData['data'].where((element)=> element['Date'].toString().substring(0,10) == DateTime.now().toString().substring(0,10) && (element['Status'].toString() == "Pending" || element['Status'].toString() == "Canceled") ).toList();
            List<Map> updateBody = [];
            if(Data.isNotEmpty){

              Data.forEach((e){
                updateBody.add({
                  'visitId': e['VisitID'],
                  'deliveryTime': DateTime.now().toString()
                });
              });
              Sync_Api.showNotification(tital: "You have New Visit Registration",body: Data[0]['VisitID'].toString());
            final res1 = await http.post(
                Uri.parse(
                    AppUrl().updateDeliveryTime),
                body: jsonEncode(updateBody),
                headers: {
                  'authorization': "Bearer " + Constants_Usermast.token,
                  "Accept": "application/json"
                });
            print(res1.statusCode);
            print(res1.body);
          }}
          break;
        case "Vehicle_purpose":
          final res =
              await http.get(Uri.parse(AppUrl().vehiclePurposes), headers: {
            'authorization': "Bearer " + Constants_Usermast.token,
          });
          if (res.statusCode == 200) {
            var jsonData = json.decode(res.body);
            insert_table(jsonData, Constants.Tbl_vehicle_purpose);
          }
          break;
        case "Vehicle_data":
          final res = await http.get(Uri.parse(AppUrl().vehicleData), headers: {
            'authorization': "Bearer " + Constants_Usermast.token,
          });
          print(res.body);
          if (res.statusCode == 200) {
            var jsonData = json.decode(res.body);
            insert_table(jsonData, Constants.Tbl_vehicle_data);
          }
          break;
      }
    } catch (e) {}
  }

  static SyncUserData() async {
    Constants_Usermast.user_id =
        await SharedPref.read_string(SrdPrefkey.spUserid);
    Constants_Usermast.user_name =
        await SharedPref.read_string(SrdPrefkey.spUserName);
    Constants_Usermast.password =
        await SharedPref.read_string(SrdPrefkey.sppassword);
    Constants_Usermast.status_code =
        await SharedPref.read_string(SrdPrefkey.spstatus_code);
    Constants_Usermast.company =
        await SharedPref.read_string(SrdPrefkey.spcompany);
    Constants_Usermast.id = await SharedPref.read_string(SrdPrefkey.spid);
    Constants_Usermast.staff = await SharedPref.read_string(SrdPrefkey.spstaff);
    Constants_Usermast.SyncPendingData =
        await SharedPref.read_string(SrdPrefkey.spSyncPendingData);
    Constants_Usermast.token = await SharedPref.read_string(SrdPrefkey.sptoken);
    Constants_Usermast.groupId =
        await SharedPref.read_int(SrdPrefkey.spgroupId);
    Constants_Usermast.farmerId =
        await SharedPref.read_int(SrdPrefkey.spfarmerId);
    Constants_Usermast.zone =
        await SharedPref.read_string(SrdPrefkey.spzone);
    Constants_Usermast.mobileNumber =
        await SharedPref.read_string(SrdPrefkey.spmobileNumber);
    Constants_Usermast.is_deleted =
        await SharedPref.read_string(SrdPrefkey.spis_deleted);
    Constants_Usermast.QRCode =
        await SharedPref.read_string(SrdPrefkey.spQRCode);
    Constants_Usermast.language =
        await SharedPref.read_string(SrdPrefkey.language);
    Sync_Json.Get_Master_Data('language');
  }

  static updatevisitid(String visitid) async {
    var box = await Hive.openBox<Visit_Registration>("VISITREGISTRATION");
    final boxdata = box.get(visitid.toString());
    boxdata!.status == 'Canceled';
    await box.put(visitid.toString(), boxdata);
    Sync_Json.Get_Master_Data('VISITREGISTRATION');
    var res = await ApiCalling.createPut(AppUrl().cancelvisit + "/" + visitid,
        "Bearer " + Constants_Usermast.token.toString(), {
      "status": "N",
    });
  }

  static Visit_Complete(String visitid, String animalID) async {
    Con_List.M_Visitragistration.forEach((element) {
      if (element.visitID.toString() == visitid) {
        element.status = "Compeleted";
        element.syncStaus = '0';
        element.animalID = animalID;
      }
    });
    var box = await Hive.openBox<Visit_Registration>("VISITREGISTRATION");
    final boxdata = box.get(visitid.toString());
    boxdata!.status = 'Compeleted';
    boxdata.syncStaus = '0';
    boxdata.animalID = animalID;
    await box.put(visitid.toString(), boxdata);
    Sync_Json.Get_Master_Data('VISITREGISTRATION');
    List<Visit_Registration> nonsyncvisit =
        Con_List.M_Visitragistration.where((e) => e.syncStaus == "0").toList();

    if (nonsyncvisit.isNotEmpty) {
      List backendUpadteBody = List.generate(
          nonsyncvisit.length,
          (index) => {
                "status": "C",
                "id": nonsyncvisit[index].visitID,
                "animalTagId": animalID,
                "attendingTime": nonsyncvisit[index].arrivaltime.toString()
              });
      final result = await ApiCalling.patchRequest(
          AppUrl().upDateVisitRegistration, backendUpadteBody);
      if (result.statusCode == 200) {
        boxdata.syncStaus = '1';
      }
    }
  }

  static Future loadallData() async {
    await SyncDB.SyncTable("sireStock", true);
    await SyncDB.SyncTable("Master_Farmer", true);
    await SyncDB.SyncTable("Master_lot", true);
    await SyncDB.SyncTable("Animal_Details_id", true);
    await SyncDB.SyncTable("Milk_production_id", true);
    await SyncDB.SyncTable("Breeding_reproduction_id", true);
    await SyncDB.SyncTable("Animal_treatment", true);
    await SyncDB.SyncTable("Health_treatmentDetails", true);
    await SyncDB.SyncTable("VISITREGISTRATION", true);
    await SyncDB.SyncTable("Vehicle_purpose", true);
    await SyncDB.SyncTable("Vehicle_data", true);
    return Future.value();
  }

  static update_milk_production(
      String boxname, String key, List<String> newvalue) async {
    try {
      var box = await Hive.openBox<Animal_Production>(boxname);
      final myobject = box.get(key);
      myobject!.morningYield = newvalue[0];
      myobject.eveningYield = newvalue[1];
      myobject.dayMilkTotal = newvalue[2];
      await box.put(key, myobject);
    } catch (e) {
      print("erore in update_milk_prodcation$e");
    }
  }

  static cheakcattlelist(String tagid) async {
    var res = await ApiCalling.getdata(AppUrl().checkCattleAvailable + tagid,
        Constants_Usermast.token.toString());
    return res.body;
  }

  static get_new_custom_report(String ReportBy, String Cond, String FilterBy,
      String HerdStr, String LotStr, String FarmerSTR, int ValueInt) async {
    String value = "";
    if (LotStr.isEmpty && FarmerSTR.isEmpty) {
      value = Constants_Usermast.staff.toString();
    }
    var res = await ApiCalling.createPost(AppUrl().getCustomReport,
        "Bearer ${Constants_Usermast.token}", {
      "reportBy": ReportBy,
      "cond": Cond.toString(),
      "valueInt": FilterBy.toString(),
      "herd": "",
      "lot": LotStr.toString(),
      "farmer": FarmerSTR.toString()
    });
  }

  static getAlarm(String Taskid, String route, String report) async {

    var res = await ApiCalling.createPost(AppUrl().getAlarmDone,
        "Bearer ${Constants_Usermast.token}", {
      "taskId": "all",
      "route": "Paravet",
      "dcs": route,
      "farmer": "Coop"
    });

    if (res.statusCode == 200) {
      List<dynamic> list = jsonDecode(res.body);

      return list;
    }
  }

  static Future GetActionDetails(String staff) async {
    final res = await ApiCalling.createPost(AppUrl().getDailyActionDone,
        "Bearer " + Constants_Usermast.token.toString(), {
      "action": "all",
      "reportBy": "Paravet",
      "herd": "$staff",
      "copcom": "Coop"
    });
    if (res.statusCode == 200) {
      Con_List.AllActionList = jsonDecode(res.body);
    }
  }

  static Future language(String element) async {
    var res;
    res = await ApiCalling.createPost(
        AppUrl().getlanguage, "Bearer " + Constants_Usermast.token.toString(), {
      "language": element,
    });
    if (res.statusCode == 200) {
      List<dynamic> formList = jsonDecode(res.body);
      var box = await Hive.openBox<Language_model>("Language_model");
      try {
        formList.forEach((e) {
          box.put("$element-${e['ID']}", Language_model.fromJson(e, element));
        });
      } catch (e) {
        print("eoreeoreoreoroeroeroer$e");
      }
      Sync_Json.Get_Master_Data("language");
    }
  }
}
