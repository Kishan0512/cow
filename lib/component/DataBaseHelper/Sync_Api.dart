import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:herdmannew/Model_local/Breeding_Abortion.dart';
import 'package:herdmannew/component/DataBaseHelper/Con_List.dart';
import 'package:herdmannew/component/DataBaseHelper/Sync_Json.dart';
import 'package:herdmannew/model/Animal_Deworming.dart';
import 'package:herdmannew/model/Animal_Disposal.dart';
import 'package:herdmannew/model/Animal_Treatment_details.dart';
import 'package:herdmannew/model/Animal_Vaccination.dart';
import 'package:herdmannew/model/Notification_Gloable.dart';
import 'package:hive/hive.dart';
import '../../Model_local/Bredding_Calving.dart';
import '../../Model_local/Breeding_Dry.dart';
import '../../Model_local/Breeding_PD.dart';
import '../../Model_local/Breeding_insemination.dart';
import '../../model/Animal_Details_id.dart';
import '../../model/Animal_Treatment.dart';
import '../../model/Animal_registration.dart';
import '../../model/Breeding_reproduction_id.dart';
import '../../model/Milk_production_id.dart';
import '../A_SQL_Trigger/A_ApiUrl.dart';
import '../A_SQL_Trigger/A_NetworkHelp.dart';
import '../Gobal_Widgets/Con_Usermast.dart';
import '../Gobal_Widgets/Constants.dart';
import 'Sync_Database.dart';

class Sync_Api extends ChangeNotifier {
  static bool Snackabr = false;
  static ValueNotifier<bool> Issync = ValueNotifier(false);
  static String MstrResponse = "";
  static String MstrResponsecode = "";

  static Future<bool?> ring({bool? result}) async {
    return result;
  }

  static Future<Object> insert_Api(
      {int? count,
      required Map note,
      required String pStrTableName,
      required List NoteList}) async {
    MstrResponse = "";
    MstrResponsecode = "";
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      switch (pStrTableName) {
        // case "Animal_Registration":
        //   for (int i = 0; i < NoteList.length; i++) {
        //     NoteList[i].remove('SyncStatus');
        //     try {
        //       var response = await ApiCalling.createPost(AppUrl().Animal_Save,
        //           "Bearer " + Constants_Usermast.token.toString(), NoteList[i]);
        //
        //
        //       if (response.statusCode == 200) {
        //         var resBody = json.decode(response.body);
        //
        //
        //         var box = await Hive.openBox<Animal_Registration>(
        //             "Animal_Registration");
        //         final boxdata = box.get(NoteList[i]['id'].toString());
        //         boxdata!.SyncStatus = "1";
        //         await box.put(NoteList[i]['id'].toString(), boxdata);
        //         MstrResponsecode = response.statusCode.toString();
        //         MstrResponse = resBody['id'].toString();
        //         Snackabr = true;
        //         ring(result: Snackabr);
        //         _showNotification(
        //             tital: "Registration Done",
        //             body:
        //             "ID no : ${NoteList[i]['TagId']} \n Date : ${NoteList[i]['createdAt']}",
        //             map: note);
        //       } else {
        //         MstrResponse = response.body.toString();
        //       }
        //     } catch (e) {}
        //   }
        //   break;
        case "Breeding_insemination":
          for (int i = 0; i < NoteList.length; i++) {
            NoteList[i].remove('ServerId');
            NoteList[i].remove('SyncStatus');
            try {
              var response = await ApiCalling.createPost(AppUrl().AISave,
                  "Bearer " + Constants_Usermast.token.toString(), NoteList[i]);
              print(response.statusCode);
              print(response.body);
              if (response.statusCode == 200) {
                Constants.insemination_res.value = true;
                var resBody = json.decode(response.body);
                var box = await Hive.openBox<Breeding_insemination>(
                    "Breeding_insemination");
                final boxdata = box.get(NoteList[i]['id'].toString());
                boxdata!.ServerId = "${(resBody['id'])}";
                boxdata.SyncStatus = "1";
                await box.put(NoteList[i]['id'].toString(), boxdata);
                MstrResponsecode = response.statusCode.toString();
                MstrResponse = resBody['id'].toString();
                Snackabr = true;
                ring(result: Snackabr);
                if (NoteList[i]['Visit'] != "100") {
                  SyncDB.Visit_Complete(
                      NoteList[i]['Visit'], NoteList[i]['TagId']);
                }

                showNotification(
                    tital: "Insemination Done",
                    body:
                        "ID no : ${NoteList[i]['TagId']}",
                    map: note);
                refreh(NoteList[i]['TagId']);
              } else {
                MstrResponse = response.body.toString();
              }
            } catch (e) {}
          }
          break;
        case "Breeding_pd":
          for (int i = 0; i < NoteList.length;) {
            NoteList[i].remove('SyncStatus');
            NoteList[i].remove('ServerId');
            var response = await ApiCalling.createPost(AppUrl().Breed_pd,
                "Bearer " + Constants_Usermast.token.toString(), NoteList[i]);
            if (response.statusCode == 200) {
              var resBody = json.decode(response.body);
              var box = await Hive.openBox<Breeding_PD>("Breeding_pd");
              final boxdata = box.get(NoteList[i]['id'].toString());
              boxdata!.SyncStatus = "1";
              boxdata.ServerId = "${resBody['id']}";
              await box.put(NoteList[i]['id'].toString(), boxdata);
              if (NoteList[i]['visit'] != "100") {
                SyncDB.Visit_Complete(
                    NoteList[i]['visit'], NoteList[i]['TagId']);
              }

              MstrResponse = "PD Done ID=${resBody['id']}";
              if (MstrResponse != "") {
                Sync_Api.Snackabr = true;
              }
              showNotification(
                  tital: "PD Done",
                  body: "ID no : ${NoteList[i]['TagId']}",
                  map: note);
              refreh(NoteList[i]['TagId']);
            }

            MstrResponse = response.body.toString();
            i++;
          }
          break;
        case "Breeding_Abortion":
          for (int i = 0; i < NoteList.length;) {
            NoteList[i].remove('SyncStatus');
            NoteList[i].remove('OrderNumber');
            NoteList[i].remove('OTP');
            NoteList[i].remove('details');
            NoteList[i].remove('updatedAt');
            NoteList[i].remove('lastUpdatedByUser');
            var response = await ApiCalling.createPost(AppUrl().abortion,
                "Bearer " + Constants_Usermast.token.toString(), NoteList[i]);

            if (response.statusCode == 200) {
              var resBody = json.decode(response.body);
              var box1 =
                  await Hive.openBox<Breeding_Abortion>("Breeding_Abortion");
              final boxdata = box1.get(NoteList[i]['id'].toString());

              boxdata!.SyncStatus = "1";
              boxdata.ServerId = "${resBody['id']}";
              await box1.put(NoteList[i]['id'].toString(), boxdata);
              if (NoteList[i]['visit'] != "0") {
                SyncDB.Visit_Complete(
                    NoteList[i]['visit'], NoteList[i]['TagId']);
              }
              MstrResponse = "Abortion Done ID=${resBody['id']}";
              if (MstrResponse != "") {
                Sync_Api.Snackabr = true;
              }
              showNotification(
                  tital: "Abortion Done",
                  body: "ID no : ${NoteList[i]['TagId']}",
                  map: NoteList[i]);
              refreh(NoteList[i]['TagId']);
            }
            MstrResponse = response.body.toString();
            i++;
          }
          break;
        case "Animal_diedDetails":
          for (int i = 0; i < NoteList.length;) {
            var box1 =
                await Hive.openBox<Animal_Details_id>('Animal_Details_id');
            var tagId = NoteList[i]['OldTagId'].toString();

            var animalDetails =
                box1.values.firstWhere((item) => item.tagId == tagId);
            NoteList[i].remove('SyncStatus');
            NoteList[i].remove('ServerId');
            var response = await ApiCalling.createPost(AppUrl().Animal_dispos,
                "Bearer " + Constants_Usermast.token.toString(), NoteList[i]);
            if (response.statusCode == 200) {
              var resBody = json.decode(response.body);
              var box =
                  await Hive.openBox<Animal_Disposal>("Animal_diedDetails");
              final boxdata = box.get(NoteList[i]['id'].toString());

              boxdata!.ServerId = "${resBody['id']}";
              boxdata.SyncStatus = "1";
              await box.put(NoteList[i]['id'].toString(), boxdata);
              showNotification(
                  tital: "Animal Dispose Done",
                  body: "ID no : ${NoteList[i]['OldTagId']}",
                  map: NoteList[i]);
              await box1.delete(animalDetails.key);
              Sync_Json.Get_Master_Data("Animal_Details_id");
            }
            MstrResponse = response.body.toString();
            i++;
          }
          break;
        case "Dryoff_save":
          for (int i = 0; i < NoteList.length;) {
            var response = await ApiCalling.createPost(AppUrl().DrySave,
                "Bearer " + Constants_Usermast.token.toString(), NoteList[i]);
            if (response.statusCode == 200) {
              var resBody = json.decode(response.body);
              var box = await Hive.openBox<Breeding_Dry>("Dryoff_save");
              final boxdata = box.get(NoteList[i]['id'].toString());
              boxdata!.ServerId = "${resBody['id']}";
              boxdata.SyncStatus = "1";
              await box.put(NoteList[i]['id'].toString(), boxdata);
              MstrResponse = "Dryoff Done ID=${resBody['id']}";
              if (MstrResponse != "") {
                Sync_Api.Snackabr = true;
              }
              showNotification(
                  tital: "Dryoff Done",
                  body: "ID no : ${NoteList[i]['TagId']}",
                  map: NoteList[i]);
              refreh(NoteList[i]['TagId']);
            }
            MstrResponse = response.body.toString();
            i++;
          }
          break;
        case "Breeding_Calving":
          for (int i = 0; i < NoteList.length;) {
            var response = await ApiCalling.createPost(
                AppUrl().Breeding_Calving,
                "Bearer " + Constants_Usermast.token.toString(),
                NoteList[i]);
            log(NoteList.toString());
            if (response.statusCode == 200) {
              var resBody = json.decode(response.body);

              var box =
                  await Hive.openBox<Breeding_Calving>("Breeding_Calving");
              final boxdata = box.get(NoteList[i]['id'].toString());

              boxdata!.ServerId = "${resBody['id']}";
              boxdata.SyncStatus = "1";
              await box.put(NoteList[i]['id'].toString(), boxdata);
              if (NoteList[i]['visit'] != "0") {
                SyncDB.Visit_Complete(
                    NoteList[i]['visit'], NoteList[i]['TagId']);
              }
              MstrResponse = "Calving Done ID=${resBody['id']}";
              if (MstrResponse != "") {
                Sync_Api.Snackabr = true;
              }
              // todo 430106199085
              showNotification(
                  tital: "Calving Done",
                  body: "ID no : ${NoteList[i]['TagId']}",
                  map: NoteList[i]);
              refreh(NoteList[i]['TagId']);
            }
            MstrResponse = response.body.toString();
            i++;
          }
          break;
        case "Health_treatment":
          var m = {'treatment': jsonEncode(NoteList)};
          var response = await ApiCalling.createPost(
              AppUrl().CATTLE_TREATMENT_ENTRY,
              "Bearer " + Constants_Usermast.token.toString(),
              m);
          if (response.statusCode == 200) {
            var resBody = json.decode(response.body);
            List treatment = resBody['treatment'];
            var box1 = await Hive.openBox<Animal_Treatment>("Animal_Treatment");
            for (int i = 0; i < treatment.length; i++) {
              final boxdata = box1.get(NoteList[i]['id'].toString());
              boxdata!.SyncStatus = "1";
              await box1.put(NoteList[i]['id'].toString(), boxdata);
            }
            showNotification(tital: "Health_treatment Done", body: "");
          }
          break;
        case "Health_treatmentDetails":
          var m = {"treatmentDetails": jsonEncode(NoteList)};
          var response = await ApiCalling.createPost(
              AppUrl().CATTLE_TREATMENT_OTHER_ENTRY,
              "Bearer " + Constants_Usermast.token.toString(),
              m);
          if (response.statusCode == 200) {
            var resBody = json.decode(response.body);
            List treatment = resBody['treatmentDetails'];
            var box = await Hive.openBox<Animal_Treatment_details>(
                "Health_treatmentDetails");

            await box.clear();
            showNotification(tital: "Health TreatmentDetails Done", body: "");
          }
          break;
        case "Health_deworming":
          var m = {'deworming': jsonEncode(NoteList)};

          var response = await ApiCalling.createPost(
              AppUrl().CATTLE_DEWORMING_ENTRY_URL,
              "Bearer " + Constants_Usermast.token.toString(),
              m);

          if (response.statusCode == 200) {
            var resBody = json.decode(response.body);
            List Deworming = resBody['Deworming'];
            var box = await Hive.openBox<Animal_Deworming>("Animal_Deworming");
            for (int i = 0; i < Deworming.length; i++) {
              await box.put(
                  Deworming[i]['id'], Animal_Deworming.fromJson(Deworming[i]));
              final boxdata = box.get(Deworming[i]['id'].toString());
              boxdata!.SyncStatus = "1";

              await box.put(Deworming[i]['id'].toString(), boxdata);
            }

            showNotification(tital: "Deworming Done", body: "");
          }
          break;
        case "Health_vaccination":
          var m = {'vaccination': jsonEncode(NoteList)};
          var response = await ApiCalling.createPost(
              AppUrl().CATTLE_VACCINATION_ENTRY_URL,
              "Bearer " + Constants_Usermast.token.toString(),
              m);
          if (response.statusCode == 200) {
            var resBody = json.decode(response.body);
            List vaccination = resBody['vaccination'];
            var box =
                await Hive.openBox<Animal_Vaccination>("Animal_Vaccination");
            for (int i = 0; i < vaccination.length; i++) {
              await box.put(vaccination[i]['id'],
                  Animal_Vaccination.fromJson(vaccination[i]));
              final boxdata = box.get(vaccination[i]['id'].toString());
              boxdata!.SyncStatus = "1";

              await box.put(vaccination[i]['id'].toString(), boxdata);
            }
            showNotification(tital: "Animal Vaccination Done", body: "");
          }
          break;
        case "Breeding_reproduction_id":
          for (int i = 0; i < NoteList.length;) {
            NoteList[i].remove('HI');
            NoteList[i].remove('Vaccine');
            NoteList[i].remove('InseminationTicketNumber');
            NoteList[i].remove('PDTicketNumber');
            NoteList[i].remove('CalvingTicketNumber');
            NoteList[i].remove('OTP');
            NoteList[i].remove('SyncStatus');
            NoteList[i].remove('OrderNumber');
            NoteList[i].remove('CI');
            NoteList[i].remove('Sirename');
            NoteList[i].remove('insertflag');
            NoteList[i].remove('AIDays');
            NoteList[i].remove('CalvingPDDays');
            NoteList[i].remove('AITname');
            NoteList[i].remove('PDname');
            NoteList[i].remove('PDResult');
            NoteList[i].remove('PDdays');
            NoteList[i].remove('Pregdays');
            var response = await ApiCalling.createPost(
                AppUrl().Save_reproduction,
                "Bearer " + Constants_Usermast.token.toString(),
                NoteList[i]);
            log(NoteList[i].toString());

            if (response.statusCode == 200) {
              var resBody = json.decode(response.body);
              var box = await Hive.openBox<Breeding_reproduction_id>(
                  "Breeding_reproduction_id");

              final boxdata = box.get(NoteList[i]['id'].toString());
              if (resBody['Reprodid'] != null) {
                boxdata!.ServerId = "${(resBody['Reprodid'])}";
                boxdata.SyncStatus = "1";
                await box.put(NoteList[i]['id'].toString(), boxdata);
                refreh(NoteList[i]['TagId']);
                showNotification(
                    tital: "Animal Registration Done",
                    body: "ID no : ${NoteList[i]['TagId']}",
                    map: NoteList[i]);
              }
              i++;
            }
            MstrResponse = response.body.toString();
          }
          break;
        case "Milk_production_id":
          var m = {'production': jsonEncode(NoteList)};
          var response = await ApiCalling.createPost(
              AppUrl().CATTLE_MILKING_ENTRY_URL,
              "Bearer " + Constants_Usermast.token.toString(),
              m);

          if (response.statusCode == 200) {
            var resBody = json.decode(response.body);

            List production = resBody['production'];
            var box =
                await Hive.openBox<Milk_production_id>("Milk_production_id");
            for (int i = 0; i < production.length; i++) {
              final boxdata = box.get(production[i]['id'].toString());
              boxdata!.SyncStatus = "1";

              await box.put(production[i]['id'].toString(), boxdata);
            }
            showNotification(tital: "Bulk Milk Entry Done", body: "");
          }
          break;
        case "Update_Sire":
          var response = await ApiCalling.createPost(AppUrl().saveSireStock,
              "Bearer " + Constants_Usermast.token.toString(), {
            "staffId": Constants_Usermast.staff.toString(),
            "currentStock": note["Selected"].toString() == "1"
                ? note['BirthWeight'].toString()
                : note['MinStrawStock'].toString(),
            "sire": note.containsKey('id') ? note['id'] : note['ID'],
            "sorted": note["Selected"].toString() == "1" ? "1" : "0",
          });

          break;
        case "Milk_Pd_Test":
          for (int i = 0; i < NoteList.length;) {
            var response = await ApiCalling.createPost(AppUrl().MilkPDTest,
                "Bearer " + Constants_Usermast.token.toString(), NoteList[i]);

            if (response.statusCode == 200) {
              showNotification(
                  tital: "Milk pd Test Done",
                  body: NoteList[i]['TagId'].toString());
              refreh(NoteList[i]['TagId'].toString());
            }
            MstrResponse = response.statusCode.toString() +
                jsonDecode(response.body)['Id'].toString();
            i++;
          }
          break;
      }
      return MstrResponse;
    }
    return MstrResponse;
  }

  static Future<void> showNotification(
      {required String tital, String? body, Map? map}) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      '${tital}', // Notification title
      '${body}', // Notification body
      platformDetails, // Notification details
      payload: 'data', // Optional payload
    );
    int notificationid =0;
    var box =
    await Hive.openBox<Notification_Gloable>("Notification_Gloable");
    try {
      notificationid = int.parse(box.keys.last.toString());
    } catch (e) {
      notificationid = 0;
    }
    Notification_Gloable Data = Notification_Gloable(TagId: body, Date: DateTime.now().toLocal().toString(), Type: tital, ID: notificationid+1);
    print(Data.Type);
    print(Data.Date);
    print(Data.TagId);
    print(Data.ID);

    box.put((notificationid+1).toString(), Data);

  }

  static refreh(String index) async {
    String id = "";
    id = Con_List.id_Animal_Details
        .where((element) => element.tagId.toString() == index)
        .first
        .id
        .toString();
    List<dynamic> data = [];
    var update_ani;

    // var res = await ApiCalling.getDataByToken(
    //     AppUrl().refreshAnimalDataInServer + index);

    var response = await ApiCalling.createPost(
        AppUrl().AnimalRefresh,
        "Bearer " + Constants_Usermast.token.toString(),
        {"tagid": index, "TBLSTR": "Animal_Details:0"});

    if (response.statusCode == 200) {
      update_ani = jsonDecode(response.body);
      data = update_ani[0];

// Open the box
      var box = await Hive.openBox<Animal_Details_id>('Animal_Details_id');

// Delete the item with the specified index
      await box.delete(id);

// Close the box after the deletion
      await box.close();

// Open the box again
      var box1 = await Hive.openBox<Animal_Details_id>('Animal_Details_id');

// Add the updated data to the box
      data.forEach((e) {
        box1.put(int.parse(e['id'].toString()), Animal_Details_id.fromJson(e));
      });

// Close the box again
      await box1.close();

      Sync_Json.Get_Master_Data('Animal_Details_id');
    }
    List<Breeding_reproduction_id> id1 = [];
    id1 = Con_List.id_reproduction
        .where((element) => element.tagId.toString() == index)
        .toList();
    var response1 = await ApiCalling.createPost(
        AppUrl().AnimalRefresh,
        "Bearer " + Constants_Usermast.token.toString(),
        {"tagid": index, "TBLSTR": "Breeding_reproduction:0"});

    if (response1.statusCode == 200) {
      var jsondecode = jsonDecode(response1.body);
      List data = jsondecode[0];
      if (data.isNotEmpty) {
        var box = await Hive.openBox<Breeding_reproduction_id>(
            'Breeding_reproduction_id');

        for (int i = 0; i < id1.length; i++) {
          box.delete(id1[i].id.toString());
        }
        // 105662524084

        data
            .map((e) =>
                box.put("${e['id']}", Breeding_reproduction_id.fromJson(e)))
            .toList();
      }
    }
  }
}
