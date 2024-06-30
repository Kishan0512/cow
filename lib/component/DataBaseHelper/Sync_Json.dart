import 'dart:developer';

import 'package:herdmannew/Model_local/Language_model.dart';
import 'package:herdmannew/Model_local/Milk_PD.dart';
import 'package:herdmannew/model/Animal_Deworming.dart';
import 'package:herdmannew/model/Animal_Treatment.dart';
import 'package:herdmannew/model/Animal_Treatment_details.dart';
import 'package:herdmannew/model/Animal_Vaccination.dart';
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

import '../../Model_local/Bredding_Calving.dart';
import '../../Model_local/Breeding_Abortion.dart';
import '../../Model_local/Breeding_Dry.dart';
import '../../Model_local/Breeding_PD.dart';
import '../../Model_local/Breeding_insemination.dart';
import '../../model/Animal_Details_id.dart';
import '../../model/Animal_Disposal.dart';
import '../../model/Animal_registration.dart';
import '../../model/Animal_timeline.dart';
import '../../model/Breeding_reproduction_id.dart';
import '../../model/Master_UserHerds.dart';
import '../../model/Milk_production_id.dart';
import '../../model/Vehicle_data.dart';
import '../../model/Visit_Registration.dart';
import 'Con_List.dart';
import 'Sync_Api.dart';

class Sync_Json {
  static Future Get_Master_Data(String pStrTableName) async {
    try {
      switch (pStrTableName) {
        case 'Animal_Registration':

          var box = await Hive.openBox<Animal_Registration>("Animal_Registration").asStream();
          box.listen((event) {
            Con_List.Animal_regisrtration = event.values.toList();
            List Note = Con_List.Animal_regisrtration.where((e) => e.SyncStatus == "0")
                .map((e) => e.toJson(e))
                .toList();
            Sync_Api.insert_Api(
              NoteList: Note,
              note: {},
              pStrTableName: "Animal_Registration",
            );
          });
          break;
        case "Account_medicineLedger":
          var box =
              await Hive.openBox<Master_medicineLedger>("Master_medicineLedger")
                  .asStream();
          box.listen((event) {
            Con_List.M_medicineLedger = event.values.toList();
          });
          break;
        case "Milk_Pd_Test":
          var box = await Hive.openBox<Milk_PDTest>("Milk_Pd_Test").asStream();
          box.listen((event) {
            Con_List.Milk_PDtest = event.values.toList();
            List Note = Con_List.Milk_PDtest.where((e) => e.SyncStatus == "0")
                .map((e) => e.toJson(e))
                .toList();
            Sync_Api.insert_Api(
              NoteList: Note,
              note: {},
              pStrTableName: "Milk_Pd_Test",
            );
          });
          break;
        case "Breeding_pd":
          var box = await Hive.openBox<Breeding_PD>("Breeding_pd").asStream();
          box.listen((event) {
            Con_List.Br_PD = event.values.toList();
            List Note = Con_List.Br_PD.where((e) => e.SyncStatus == "0")
                .map((e) => e.toJson(e))
                .toList();
            Sync_Api.insert_Api(
              NoteList: Note,
              note: {},
              pStrTableName: "Breeding_pd",
            );
          });

          break;
        case "Breeding_Abortion":
          var box = await Hive.openBox<Breeding_Abortion>("Breeding_Abortion")
              .asStream();
          box.listen((event) {
            Con_List.Br_Ab = event.values.toList();
            List Note = Con_List.Br_Ab.where((e) => e.SyncStatus == "0")
                .map((e) => e.toJson(e))
                .toList();
            Sync_Api.insert_Api(
              NoteList: Note,
              note: {},
              pStrTableName: "Breeding_Abortion",
            );
          });

          break;
        case "Breeding_insemination":
          var box =
              await Hive.openBox<Breeding_insemination>("Breeding_insemination")
                  .asStream();
          box.listen((event) {
            Con_List.Br_insemination = event.values.toList();
            List Note = Con_List.Br_insemination.where(
                    (element) => element.SyncStatus.toString() == "0")
                .map((e) => e.toJson(e))
                .toList();
            Sync_Api.insert_Api(
                NoteList: Note,
                note: {},
                pStrTableName: "Breeding_insemination");
          });
          break;
        case "Dryoff_save":
          var box = await Hive.openBox<Breeding_Dry>("Dryoff_save").asStream();
          box.listen((event) {
            Con_List.Dryofsave = event.values.toList();
            List Note = Con_List.Dryofsave.where((e) => e.SyncStatus == "0")
                .map((e) => e.toJson(e))
                .toList();
            Sync_Api.insert_Api(
                NoteList: Note, note: {}, pStrTableName: "Dryoff_save");
          });
          break;
        case "Breeding_Calving":
          var box = await Hive.openBox<Breeding_Calving>("Breeding_Calving")
              .asStream();
          box.listen((event) {
            Con_List.Br_Calving = event.values.toList();
            List Note = Con_List.Br_Calving.where((e) => e.SyncStatus == "0")
                .map((e) => e.toJson(e))
                .toList();
            Sync_Api.insert_Api(
                NoteList: Note, note: {}, pStrTableName: "Breeding_Calving");
          });
          break;
        case "Health_treatmentDetails":
          var box = await Hive.openBox<Animal_Treatment_details>(
                  "Health_treatmentDetails")
              .asStream();
          box.listen((event) {
            Con_List.A_Treatment_details = event.values.toList();

            List Noted = Con_List.A_Treatment_details.where(
                    (element) => element.syncstatus.toString() == "0")
                .map((e) => e.toJson(e))
                .toList();
            Sync_Api.insert_Api(
              NoteList: Noted,
              note: {},
              pStrTableName: "Health_treatmentDetails",
            );
          });
          break;
        case "Health_deworming":
          var box = await Hive.openBox<Animal_Deworming>("Animal_Deworming")
              .asStream();
          box.listen((event) {
            Con_List.A_Deworming = event.values.toList();
            List Noted = Con_List.A_Deworming.where(
                    (element) => element.SyncStatus.toString() == "0")
                .map((e) => e.toJson(e))
                .toList();
            Sync_Api.insert_Api(
                note: {}, pStrTableName: "Health_deworming", NoteList: Noted);
          });
          break;
        case "Health_vaccination":
          var box = await Hive.openBox<Animal_Vaccination>("Animal_Vaccination")
              .asStream();
          box.listen((event) {
            Con_List.A_Vaccination = event.values.toList();
            List Noted = Con_List.A_Vaccination.where(
                    (element) => element.SyncStatus.toString() == "0")
                .map((e) => e.toJson(e))
                .toList();
            Sync_Api.insert_Api(
              NoteList: Noted,
              note: {},
              pStrTableName: "Health_vaccination",
            );
          });
          break;
        case "Account_medicineType":
          var box =
              await Hive.openBox<Master_medicineType>("Master_medicineType")
                  .asStream();
          box.listen((event) {
            Con_List.M_medicineType = event.values.toList();
          });
          break;
        case "Common_breed":
          var box = await Hive.openBox<Master_breed>("Master_breed").asStream();
          box.listen((event) {
            Con_List.M_breed = event.values.toList();
          });

          break;
        case "Common_calvingType":
          var box = await Hive.openBox<Master_calvingType>("Master_calvingType")
              .asStream();
          box.listen((event) {
            Con_List.M_calvingType = event.values.toList();
          });

          break;
        case "language":
          var box =
              await Hive.openBox<Language_model>("Language_model").asStream();
          box.listen((event) {
            Con_List.GlbLanguageData = event.values.toList();
          });
          break;
        case "Common_calvingTypeOption":
          var box = await Hive.openBox<Master_calvingTypeOption>(
                  "Master_calvingTypeOption")
              .asStream();
          box.listen((event) {
            Con_List.M_calvingTypeOption = event.values.toList();
          });
          break;
        case "Common_disposal":
          var box =
              await Hive.openBox<Master_disposal>("Master_disposal").asStream();
          box.listen((event) {
            Con_List.M_disposal = event.values.toList();
          });
          break;
        case "Common_disposalSubOptions":
          var box = await Hive.openBox<Master_disposalSubOptions>(
                  "Master_disposalSubOptions")
              .asStream();
          box.listen((event) {
            Con_List.M_disposalSubOptions = event.values.toList();
          });
          break;
        case "Common_dryOffReason":
          var box =
              await Hive.openBox<Master_dryOffReason>("Master_dryOffReason")
                  .asStream();
          box.listen((event) {
            Con_List.M_dryOffReason = event.values.toList();
          });
          break;
        case "Common_pd1":
          var box = await Hive.openBox<Master_pd1>("Master_pd1").asStream();
          box.listen((event) {
            Con_List.M_pd1 = event.values.toList();
          });
          break;
        case "Common_pd2":
          var box = await Hive.openBox<Master_pd2>("Master_pd2").asStream();
          box.listen((event) {
            Con_List.M_pd2 = event.values.toList();
          });
          break;
        case "Common_reproductiveProblem":
          var box = await Hive.openBox<Master_reproductveProblem>(
                  "Master_reproductveProblem")
              .asStream();
          box.listen((event) {
            Con_List.M_reproductveProblem = event.values.toList();
          });
          break;
        case "Common_service":
          var box =
              await Hive.openBox<Master_service>("Master_service").asStream();
          box.listen((event) {
            Con_List.M_Service = event.values.toList();
          });
          break;
        case "Common_sex":
          var box = await Hive.openBox<Master_sex>("Master_sex").asStream();
          box.listen((event) {
            Con_List.M_sex = event.values.toList();
          });
          break;
        case "Common_species":
          var box =
              await Hive.openBox<Master_species>("Master_species").asStream();
          box.listen((event) {
            Con_List.M_species = event.values.toList();
          });
          break;
        case "Common_status":
          var box =
              await Hive.openBox<Master_status>("Master_status").asStream();
          box.listen((event) {
            Con_List.M_status = event.values.toList();
          });
          break;
        case "Common_treatmentComplaint":
          var box = await Hive.openBox<Master_treatmentComplaint>(
                  "Master_treatmentComplaint")
              .asStream();
          box.listen((event) {
            Con_List.M_treatmentComplaint = event.values.toList();
          });
          break;
        case "Common_vaccinationType":
          var box = await Hive.openBox<Master_vaccinationType>(
                  "Master_vaccinationType")
              .asStream();
          box.listen((event) {
            Con_List.M_vaccinationType = event.values.toList();
          });
          break;
        case "Health_diagnosis":
          var box = await Hive.openBox<Master_diagnosis>("Master_diagnosis")
              .asStream();
          box.listen((event) {
            Con_List.M_diagnosis = event.values.toList();
          });
          break;
        case "Health_systemAffected":
          var box =
              await Hive.openBox<Master_systemAffected>("Master_systemAffected")
                  .asStream();
          box.listen((event) {
            Con_List.M_systemAffected = event.values.toList();
          });
          break;
        case "Master_dewormingType":
          var box =
              await Hive.openBox<Master_dewormingType>("Master_dewormingType")
                  .asStream();
          box.listen((event) {
            Con_List.M_dewormingType = event.values.toList();
          });
          break;
        case "Master_farmer":
          var box =
              await Hive.openBox<Get_Master_Farmer>("Master_Farmer").asStream();
          box.listen((event) {
            Con_List.M_Farmer = event.values.toList();
          });

          Con_List.M_Farmer.sort(
            (a, b) => a.code.toString().compareTo(b.code.toString()),
          );
          break;
        case "Master_herd":
          var box = await Hive.openBox<Master_UserHerds>("Master_UserHerds")
              .asStream();
          box.listen((event) {
            Con_List.M_Userherds = event.values.toList();
          });

          break;
        case "Master_lot":
          var box =
              await Hive.openBox<Master_Userlots>("Master_Userlots").asStream();
          box.listen((event) {
            Con_List.M_Userlots = event.values.toList();
          });

          if (Con_List.M_Userlots.isNotEmpty) {
            Con_List.M_Userlots.sort(
              (a, b) => a.name.toString().compareTo(b.name.toString()),
            );
          }
          break;
        case "Master_medicineRoute":
          var box =
              await Hive.openBox<Master_medicineRoute>("Master_medicineRoute")
                  .asStream();
          box.listen((event) {
            Con_List.M_medicineRoute = event.values.toList();
          });
          break;
        case "Master_parameter":
          var box =
              await Hive.openBox<Master_paramter>("Master_paramter").asStream();
          box.listen((event) {
            Con_List.M_paramter = event.values.toList();
          });
          break;
        case "Master_sire":
          var box = await Hive.openBox<Master_sire>("Master_sire").asStream();
          box.listen((event) {
            Con_List.M_sire = event.values.toList();
          });
          break;
        case "Master_smsSetting":
          var box = await Hive.openBox<Master_smsSetting>("Master_smsSetting")
              .asStream();
          box.listen((event) {
            Con_List.M_smsSetting = event.values.toList();
            //     " = " +
            //     Con_List.M_smsSetting.length.toString());
          });
          break;
        case "Master_staff":
          var box = await Hive.openBox<Master_inseminator>("Master_inseminator")
              .asStream();
          box.listen((event) {
            Con_List.M_inseminator = event.values.toList();

          });

          break;

        case "Milk_parameter":
          var box = await Hive.openBox<Master_paramter>("Master_Milk_paramter")
              .asStream();
          box.listen((event) {
            Con_List.M_Milk_paramter = event.values.toList();
          });
          break;
        case "RoleAuthAndLogs_feature":
          var box =
              await Hive.openBox<Master_feature>("Master_feature").asStream();
          box.listen((event) {
            Con_List.M_feature = event.values.toList();
          });
          break;
        case "RoleAuthAndLogs_featureuseraccesstxn":
          var box = await Hive.openBox<Master_userFeatureAccessDetail>(
                  "Master_userFeatureAccessDetail")
              .asStream();
          box.listen((event) {
            Con_List.M_userFeatureAccessDetail = event.values.toList();
            //     " = " +
            //     Con_List.M_userFeatureAccessDetail.length.toString());
          });
          break;
        case "Timeline":
          var box = await Hive.openBox<Animal_timeline>("Timeline").asStream();
          box.listen((event) {
            Con_List.A_timeline = event.values.toList();
          });
          break;

        case "Health_weightGainDiet":
          var box = await Hive.openBox<Animal_weight_entry_model>(
                  "Health_weightGainDiet")
              .asStream();
          box.listen((event) {
            Con_List.A_weight_entry_model = event.values.toList();
          });
          break;
        case "Health_vaccination":
          var box = await Hive.openBox<Animal_Vaccination>("Health_vaccination")
              .asStream();
          box.listen((event) {
            Con_List.A_Vaccination = event.values.toList();
            Con_List.A_Vaccination.where((element) => element.SyncStatus == "0")
                .forEach((e) {
              Sync_Api.insert_Api(
                  NoteList: [],
                  note: e.toJson(e),
                  pStrTableName: "Health_vaccination");
            });
          });
          break;
        case "Health_treatment":
          var box = await Hive.openBox<Animal_Treatment>("Animal_Treatment")
              .asStream();
          box.listen((event) {
            Con_List.A_Treatment = event.values.toList();

            List Noted = Con_List.A_Treatment.where(
                    (element) => element.SyncStatus.toString() == "0")
                .map((e) => e.toJson(e))
                .toList();
            Sync_Api.insert_Api(
                NoteList: Noted, note: {}, pStrTableName: pStrTableName);
          });
          break;
        case "Animal_diedDetails":
          var box = await Hive.openBox<Animal_Disposal>("Animal_diedDetails")
              .asStream();
          box.listen((event) {
            Con_List.A_Disposal = event.values.toList();
            List Note = Con_List.A_Disposal.where((e) => e.SyncStatus == "0")
                .map((p) => p.toJson(p))
                .toList();
            Sync_Api.insert_Api(
                NoteList: Note, note: {}, pStrTableName: pStrTableName);
          });
          break;
        case "Milk_production_id":
          var box = await Hive.openBox<Milk_production_id>("Milk_production_id")
              .asStream();
          box.listen((event) {
            Con_List.id_Milk_production = event.values.toList();

            List Noted = Con_List.id_Milk_production
                .where((element) => element.SyncStatus.toString() == "0")
                .map((e) => e.toJson(e))
                .toList();
            Sync_Api.insert_Api(
              NoteList: Noted,
              note: {},
              pStrTableName: pStrTableName,
            );
          });
          break;
        case "Animal_Details_id":
          var box = await Hive.openBox<Animal_Details_id>("Animal_Details_id")
              .asStream();
          box.listen((event) {
            Con_List.id_Animal_Details = event.values.toList();

          });

          break;
        case "Breeding_reproduction_id":
          var box = await Hive.openBox<Breeding_reproduction_id>(
                  "Breeding_reproduction_id")
              .asStream();
          box.listen((event) {
            Con_List.id_reproduction = event.values.toList();


            Con_List.id_reproduction.sort(
              (a, b) => a.id.toString().compareTo(b.id.toString()),
            );
            List Note = Con_List.id_reproduction
                .where((e) => e.SyncStatus == "0")
                .map((e) => e.toJson(e))
                .toList();

            if (Note.isNotEmpty) {
              Sync_Api.insert_Api(
                  NoteList: Note,
                  note: {},
                  pStrTableName: "Breeding_reproduction_id");
            }
          });
          break;
        case "VISITREGISTRATION":
          var box = await Hive.openBox<Visit_Registration>("VISITREGISTRATION")
              .asStream();
          box.listen((event) {
            Con_List.M_Visitragistration = event.values.toList();


          });
          break;
        case "Vehicle_purpose":
          var box =
              await Hive.openBox<Vehicle_purpose>("Vehicle_purpose").asStream();
          box.listen((event) {
            Con_List.M_Vehicle_purpose = event.values.toList();
          });
          break;
        case "Vehicle_data":
          var box = await Hive.openBox<Vehicle_data>("Vehicle_data").asStream();
          box.listen((event) {
            Con_List.M_Vehicle_data = event.values.toList();
          });
          break;
      }
    } catch (e) {}
  }
}
