import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:herdmannew/component/DataBaseHelper/SharedPref.dart';
import 'package:herdmannew/component/DataBaseHelper/Sync_Database.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Constants.dart';

Sync_Firebase() async {
  var company;
  var id;
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    company = Constants_Usermast.company;
    id = Constants_Usermast.id;
    String collection_id = 'C-' + company.toString();
    String doc_id = id.toString();
    DocumentReference docRef = FirebaseFirestore.instance
        .collection(collection_id + '.User')
        .doc(doc_id);
    docRef.get().then((value) {
    });

    DocumentReference mod_permission = FirebaseFirestore.instance
        .collection(collection_id + '.Feature')
        .doc(doc_id);

    mod_permission.get().then((value) async {
      Map<String, dynamic>? m = value.data() as Map<String, dynamic>?;
      if (m!.isNotEmpty) {
        String main_date = await SharedPref.read_string('Master_Date');
        String Get_Date = m['updatedAt'].toDate().toString();
        if (main_date.isNotEmpty) {
          if (m.toString().isNotEmpty) {


            int diff = DateTime.parse(Get_Date)
                .difference(DateTime.parse(main_date))
                .inSeconds;
            if (diff > 0) {
              await SyncDB.SyncTable(Constants.API_MASTER_DATA, true);
            }
          }
        } else {
          await SharedPref.save_string('Master_Date', Get_Date);
          await SyncDB.SyncTable(Constants.API_MASTER_DATA, true);
        }
      }
    });
    // DocumentReference docRef1 = FirebaseFirestore.instance
    //     .collection(collection_id + '.SyncDetailsLog')
    //     .doc('[Master].[herd]');
    // docRef1.get().then((docSnapShots) async {
    //   Map<String, dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   if (Data!.isNotEmpty) {
    //     String main_date = await SharedPref.read_string('Master_Herd_Date');
    //     if (Data.toString().isNotEmpty) {
    //       if (main_date.isNotEmpty) {
    //         String Get_Date = Data['updatedAt'].toDate.toString();
    //         int diff = DateTime.parse(Get_Date)
    //             .difference(DateTime.parse(main_date))
    //             .inSeconds;
    //         if (diff >= 0) {
    //           await SyncDB.SyncTable("MASTER_DATA", true);
    //         }
    //       } else {
    //         String Get_Date = Data['updatedAt'].toDate.toString();
    //         await SharedPref.save_string('Master_Herd_Date', Get_Date);
    //         await SyncDB.SyncTable(Constants.API_MASTER_DATA, true);
    //       }
    //     }
    //   }
    // });

    // DocumentReference docRef2 = FirebaseFirestore.instance
    //     .collection(collection_id + '.SyncDetailsLog')
    //     .doc('[Master].[lot]');
    // docRef2.get().then((docSnapShots) async {
    //   Map<String, dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   if (Data!.isNotEmpty) {
    //     String main_date = await SharedPref.read_string('Master_Lot_Date');
    //     String Get_Date = Data['updatedAt'].toDate.toString();
    //     if (main_date.isNotEmpty) {
    //       if (Data.toString().isNotEmpty) {
    //         int diff = DateTime.parse(Get_Date)
    //             .difference(DateTime.parse(main_date))
    //             .inSeconds;
    //         if (diff >= 0) {
    //           await SyncDB.SyncTable("MASTER_DATA", true);
    //         }
    //       }
    //     } else {
    //       await SharedPref.save_string('Master_Lot_Date', Get_Date);
    //       await SyncDB.SyncTable(Constants.API_MASTER_DATA, true);
    //     }
    //   }
    // });

    // DocumentReference docRef3 = FirebaseFirestore.instance
    //     .collection(collection_id + '.SyncDetailsLog')
    //     .doc('[Master].[farmer]');
    // docRef3.get().then((docSnapShots) async {
    //   Map<String, dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   if (Data.toString().isNotEmpty) {
    //     String main_date = await SharedPref.read_string('Master_Farmer_Date');
    //     String Get_Date = Data!['updatedAt'].toDate.toString();
    //     if (main_date.isNotEmpty) {
    //       if (Data.toString().isNotEmpty) {
    //         int diff = DateTime.parse(Get_Date)
    //             .difference(DateTime.parse(main_date))
    //             .inSeconds;
    //         if (diff >= 0) {
    //           await SyncDB.SyncTable("Master_Farmer", true);
    //         }
    //       }
    //     } else {
    //       await SharedPref.save_string('Master_Farmer_Date', Get_Date);
    //       await SyncDB.SyncTable(Constants.API_MASTER_DATA, true);
    //     }
    //   }
    // });

//other master data starts

    // DocumentReference medicineType = FirebaseFirestore.instance
    //     .collection(collection_id + '.MasterAndCommonSync')
    //     .doc('[Account].[medicineType]');
    // medicineType.get().then((docSnapShots) async {
    //   Map<String,dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   DateTime date;
    //   if (Data!.isNotEmpty) {
    //     date = Data["updatedAt"].toDate();
    //
    //     await sync_all_master_data(date.toString(), '[Account].[medicineType]',
    //         'medicineType_table_date');
    //   }
    // });

    // DocumentReference medicineLedger = FirebaseFirestore.instance
    //     .collection(collection_id + '.MasterAndCommonSync')
    //     .doc('[Account].[medicineLedger]');
    // medicineLedger.get().then((docSnapShots) async {
    //   Map<String,dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   DateTime date;
    //   if (Data!.isNotEmpty) {
    //     date = Data["updatedAt"].toDate();
    //     await sync_all_master_data(
    //         date.toString(), '[Account].[medicineLedger]',
    //         'medicineLedger_table_date');
    //   }
    // });

    DocumentReference Common_breed = FirebaseFirestore.instance
        .collection(collection_id + '.MasterAndCommonSync')
        .doc('[Common].[breed]');
    Common_breed.get().then((docSnapShots) async {
      Map<String, dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
      if (Data!.isNotEmpty) {
        String main_date = await SharedPref.read_string('Master_Breed_Date');
        var get = Data['updatedAt'].toDate();
        String Get_Date = get.toString();
        if (main_date.isNotEmpty) {
          if (Data.toString().isNotEmpty) {
            int diff = DateTime.parse(Get_Date)
                .difference(DateTime.parse(main_date))
                .inSeconds;
            if (diff > 0) {
              await SyncDB.SyncTable("MASTER_DATA", true);
            }
          }
        } else {
          await SharedPref.save_string('Master_Breed_Date', Get_Date);
          await SyncDB.SyncTable(Constants.API_MASTER_DATA, true);
        }
      }
    });

    // DocumentReference Common_dryOffReason = FirebaseFirestore.instance
    //     .collection(collection_id + '.MasterAndCommonSync')
    //     .doc('[Common].[dryOffReason]');
    // Common_dryOffReason.get().then((docSnapShots) async {
    //   Map<String,dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   DateTime date;
    //   if (Data!.isNotEmpty) {
    //     date = Data["updatedAt"].toDate();
    //     await sync_all_master_data(date.toString(), '[Common].[dryOffReason]',
    //         'Common_dryOffReason_table_date');
    //   }
    // });

    // DocumentReference Common_reproductiveProblem = FirebaseFirestore.instance
    //     .collection(collection_id + '.MasterAndCommonSync')
    //     .doc('[Common].[reproductiveProblem]');
    // Common_reproductiveProblem.get().then((docSnapShots) async {
    //   Map<String,dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   DateTime date;
    //   if (Data!.isNotEmpty) {
    //     date = Data["updatedAt"].toDate();
    //     await sync_all_master_data(
    //         date.toString(), '[Common].[reproductiveProblem]',
    //         'Common_reproductiveProblem_table_date');
    //   }
    // });
    // DocumentReference Common_species = FirebaseFirestore.instance
    //     .collection(collection_id + '.MasterAndCommonSync')
    //     .doc('[Common].[species]');
    // Common_species.get().then((docSnapShots) async {
    //   Map<String,dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   DateTime date;
    //   if (Data!.isNotEmpty) {
    //     date = Data["updatedAt"].toDate();
    //     await sync_all_master_data(
    //         date.toString(), '[Common].[species]', 'Common_species_table_date');
    //   }
    // });

    // DocumentReference Common_treatmentComplaint = FirebaseFirestore.instance
    //     .collection(collection_id + '.MasterAndCommonSync')
    //     .doc('[Common].[treatmentComplaint]');
    // Common_treatmentComplaint.get().then((docSnapShots) async {
    //   Map<String,dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   DateTime date;
    //   if (Data!.isNotEmpty) {
    //     date = Data["updatedAt"].toDate();
    //     await sync_all_master_data(
    //         date.toString(), '[Common].[treatmentComplaint]',
    //         'Common_treatmentComplaint_table_date');
    //   }
    // });

    // DocumentReference Common_vaccinationType = FirebaseFirestore.instance
    //     .collection(collection_id + '.MasterAndCommonSync')
    //     .doc('[Common].[vaccinationType]');
    // Common_vaccinationType.get().then((docSnapShots) async {
    //   Map<String,dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   DateTime date;
    //   if (Data!.isNotEmpty) {
    //     date = Data["updatedAt"].toDate();
    //     await sync_all_master_data(
    //         date.toString(), '[Common].[vaccinationType]',
    //         'Common_vaccinationType_table_date');
    //   }
    // });

    // DocumentReference Health_diagnosis = FirebaseFirestore.instance
    //     .collection(collection_id + '.MasterAndCommonSync')
    //     .doc('[Health].[diagnosis]');
    // Health_diagnosis.get().then((docSnapShots) async {
    //   Map<String,dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   DateTime date;
    //   if (Data!.isNotEmpty) {
    //     date = Data["updatedAt"].toDate();
    //     await sync_all_master_data(date.toString(), '[Health].[diagnosis]',
    //         'Health_diagnosis_table_date');
    //   }
    // });

    // DocumentReference Health_systemAffected = FirebaseFirestore.instance
    //     .collection(collection_id + '.MasterAndCommonSync')
    //     .doc('[Health].[systemAffected]');
    // Health_systemAffected.get().then((docSnapShots) async {
    //   Map<String,dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   DateTime date;
    //   if (Data!.isNotEmpty) {
    //     date = Data["updatedAt"].toDate();
    //
    //     await sync_all_master_data(date.toString(), '[Health].[systemAffected]',
    //         'Health_systemAffected_table_date');
    //   }
    // });

    // DocumentReference Health_calfSchedule = FirebaseFirestore.instance
    //     .collection(collection_id + '.MasterAndCommonSync')
    //     .doc('[Master].[calfSchedule]');
    // Health_calfSchedule.get().then((docSnapShots) async {
    //   Map<String,dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   DateTime date;
    //   if (Data!.isNotEmpty) {
    //     date = Data["updatedAt"].toDate();
    //     await sync_all_master_data(date.toString(), '[Master].[calfSchedule]',
    //         'Health_calfSchedule_table_date');
    //   }
    // });

    // DocumentReference Master_cc = FirebaseFirestore.instance
    //     .collection(collection_id + '.MasterAndCommonSync')
    //     .doc('[Master].[cc]');
    // Master_cc.get().then((docSnapShots) async {
    //   Map<String,dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   DateTime date;
    //   if (Data!.isNotEmpty) {
    //     date = Data["updatedAt"].toDate();
    //     await sync_all_master_data(
    //         date.toString(), '[Master].[cc]', 'Master_cc_table_date');
    //   }
    // });

    // DocumentReference Master_dewormingType = FirebaseFirestore.instance
    //     .collection(collection_id + '.MasterAndCommonSync')
    //     .doc('[Master].[dewormingType]');
    // Master_dewormingType.get().then((docSnapShots) async {
    //   Map<String,dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   DateTime date;
    //   if (Data!.isNotEmpty) {
    //     date = Data["updatedAt"].toDate();
    //
    //     await sync_all_master_data(date.toString(), '[Master].[dewormingType]',
    //         'Master_dewormingType_table_date');
    //   }
    // });

    // DocumentReference Master_medicineRoute = FirebaseFirestore.instance
    //     .collection(collection_id + '.MasterAndCommonSync')
    //     .doc('[Master].[medicineRoute]');
    // Master_medicineRoute.snapshots().listen((docSnapShots) async {
    //   DateTime date;
    //   if (docSnapShots.data != null) {
    //     date = docSnapShots.data["updatedAt"].toDate();
    //     await sync_all_master_data(date.toString(), '[Master].[medicineRoute]',
    //         'Master_medicineRoute_table_date');
    //   }
    // });

    DocumentReference Master_sire = FirebaseFirestore.instance
        .collection(collection_id + '.MasterAndCommonSync')
        .doc('[Master].[sire]');
    Master_sire.get().then((docSnapShots) async {
      Map<String, dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
      if (Data!.isNotEmpty) {
        String main_date = await SharedPref.read_string('Master_Sire_Date');
        DateTime get = Data['updatedAt'].toDate();
        String Get_Date = get.toString();
        if (main_date.isNotEmpty) {
          if (Data.toString().isNotEmpty) {
            int diff = DateTime.parse(Get_Date)
                .difference(DateTime.parse(main_date))
                .inSeconds;
            if (diff > 0) {
              await SyncDB.SyncTable("sireStock", true);
            }
          }
        } else {
          await SharedPref.save_string('Master_Sire_Date', Get_Date);
          await SyncDB.SyncTable(Constants.API_MASTER_DATA, true);
        }
      }
    });

    // DocumentReference Master_smsSetting = FirebaseFirestore.instance
    //     .collection(collection_id + '.MasterAndCommonSync')
    //     .doc('[Master].[smsSetting]');
    // Master_smsSetting.get().then((docSnapShots) async {
    //   Map<String,dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   DateTime date;
    //   if (Data!.isNotEmpty) {
    //     date = Data["updatedAt"].toDate();
    //     sync_all_master_data(date.toString(), '[Master].[smsSetting]',
    //         'Master_smsSetting_table_date');
    //   }
    // });

    // DocumentReference Master_source = FirebaseFirestore.instance
    //     .collection(collection_id + '.MasterAndCommonSync')
    //     .doc('[Master].[source]');
    // Master_source.get().then((docSnapShots) async {
    //   Map<String,dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   DateTime date;
    //   if (Data!.isNotEmpty) {
    //     date = Data["updatedAt"].toDate();
    //     await sync_all_master_data(
    //         date.toString(), '[Master].[source]', 'Master_source_table_date');
    //   }
    // });

    DocumentReference Master_staff = FirebaseFirestore.instance
        .collection(collection_id + '.MasterAndCommonSync')
        .doc('[Master].[staff]');
    Master_staff.get().then((docSnapShots) async {
      Map<String, dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
      if (Data!.isNotEmpty) {
        String main_date = await SharedPref.read_string('Master_staff_Date');
        DateTime get = Data['updatedAt'].toDate();
        String Get_Date = get.toString();
        if (main_date.isNotEmpty) {
          if (Data.toString().isNotEmpty) {

            int diff = DateTime.parse(Get_Date)
                .difference(DateTime.parse(main_date))
                .inSeconds;
            if (diff > 0) {
              await SyncDB.SyncTable("MASTER_DATA", true);
            }
          }
        } else {
          await SharedPref.save_string('Master_staff_Date', Get_Date);
          await SyncDB.SyncTable(Constants.API_MASTER_DATA, true);
        }
      }
    });

    // DocumentReference Master_zone = FirebaseFirestore.instance
    //     .collection(collection_id + '.MasterAndCommonSync')
    //     .doc('[Master].[zone]');
    // Master_zone.get().then((docSnapShots) async {
    //   Map<String,dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;
    //   DateTime date;
    //   if (Data!.isNotEmpty) {
    //     date = Data["updatedAt"].toDate();
    //     await sync_all_master_data(
    //         date.toString(), '[Master].[zone]', 'Master_zone_table_date');
    //   }
    // });

    //other master data ends

    var counterFirebaseCall = 0;
    DocumentReference docRef4 = FirebaseFirestore.instance
        .collection(collection_id + '.AnimalDetailsUserSync')
        .doc(doc_id);
    DateTime date;
    docRef4.get().then((docSnapShots) async {
      Map<String, dynamic>? Data = docSnapShots.data() as Map<String, dynamic>?;


      if (Data != null) {
        date = Data["updatedAt"].toDate();
        if (await SharedPref.read_string('back_sync_date') == null) {
          await SharedPref.save_string("back_sync_date", date.toString());
        } else {
          await SharedPref.read_string('back_sync_date').toString();
        }
        DateTime currentTime =
            DateTime.parse(await SharedPref.read_string('back_sync_date'));
        int dateDiff = date.difference(currentTime).inSeconds;
        await SharedPref.save_string("back_sync_date", date.toString());
        if (dateDiff > 0) {
          if (Data['TableUniqueName'].toString() == "[Milk].[production]") {

            await SyncDB.SyncTable("Milk_production_id", true);
          } else if (Data['TableUniqueName'].toString() ==
              "[Animal].[details]") {

            await SyncDB.SyncTable("Animal_Details_id", true);
          } else if (Data['TableUniqueName'].toString() ==
              "[Breeding].[reproduction]") {

            await SyncDB.SyncTable("Breeding_reproduction_id", true);
          }
        }
      }
    });
  }
}
