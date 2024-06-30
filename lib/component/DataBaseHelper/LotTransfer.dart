import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:hive/hive.dart';
import '../../model/Animal_Details_id.dart';
import '../../model/Animal_Treatment.dart';
import '../../model/Animal_Treatment_details.dart';
import '../../model/Breeding_reproduction_id.dart';
import '../../model/Get_Master_Farmer.dart';
import '../../model/Master_UserLots.dart';
import '../../model/Milk_production_id.dart';
import '../A_SQL_Trigger/A_ApiUrl.dart';
import '../A_SQL_Trigger/A_NetworkHelp.dart';
import '../Gobal_Widgets/Con_Usermast.dart';
import 'Sync_Json.dart';

class LotTransfer {
  static Future Sync_Lot(BuildContext context, String UserID, String UserLOT) async {
    Map data = {"lot": UserLOT, "userid": UserID};
    //todo lot update start
    final Lot = await ApiCalling.createPost(
        AppUrl().Getlot, "Bearer " + Constants_Usermast.token.toString(), data);
    List<dynamic> lotupdate = jsonDecode(Lot.body)['data'];
    if (lotupdate.isNotEmpty) {
      var box = await Hive.openBox<Master_Userlots>("Master_Userlots");
      lotupdate
        ..map((e) async {
          await box.delete(e['id']);
        })
        ..map((e) => box.put("${e['id']}", Master_Userlots.fromJson(e)))
            .toList();
      Sync_Json.Get_Master_Data('Master_lot');
    }

    // todo farmer update Start
    final Farmer = await ApiCalling.createPost(AppUrl().GetFarmer,
        "Bearer " + Constants_Usermast.token.toString(), data);
    List<dynamic> farmerupdate = jsonDecode(Farmer.body)['data'];
    if (farmerupdate.isNotEmpty) {
      var box = await Hive.openBox<Get_Master_Farmer>("Master_Farmer");
      farmerupdate
        ..map((e) async {
          await box.delete(e['id']);
        })
        ..map((e) => box.put("${e['id']}", Get_Master_Farmer.fromJson(e)))
            .toList();
      Sync_Json.Get_Master_Data('Master_farmer');
    }

    // todo Animal update Start
    final Animal = await ApiCalling.createPost(AppUrl().GetAnimal,
        "Bearer " + Constants_Usermast.token.toString(), data);
    List<dynamic> Animalupdate = jsonDecode(Animal.body)['data'];
    if (Animalupdate.isNotEmpty) {
      var box = await Hive.openBox<Animal_Details_id>("Animal_Details_id");
      Animalupdate
        ..map((e) async {
          await box.delete(e['id']);
        })
        ..map((e) => box.put("${e['id']}", Animal_Details_id.fromJson(e)))
            .toList();
      Sync_Json.Get_Master_Data('Animal_Details_id');
    }

    // todo production update Start
    final production = await ApiCalling.createPost(AppUrl().GetProduction,
        "Bearer " + Constants_Usermast.token.toString(), data);
    List<dynamic> productionupdate = jsonDecode(production.body)['data'];
    if (productionupdate.isNotEmpty) {
      var box = await Hive.openBox<Milk_production_id>("Milk_production_id");
      productionupdate
        ..map((e) async {
          await box.delete(e['id']);
        })
        ..map((e) => box.put("${e['id']}", Milk_production_id.fromJson(e)))
            .toList();
      Sync_Json.Get_Master_Data('Milk_production_id');
    }

    // todo Reproduction update Start
    final Reproduction = await ApiCalling.createPost(AppUrl().GetReproduction,
        "Bearer " + Constants_Usermast.token.toString(), data);
    List<dynamic> reproductionupdate = jsonDecode(Reproduction.body)['data'];
    if (reproductionupdate.isNotEmpty) {
      var box = await Hive.openBox<Breeding_reproduction_id>(
          "Breeding_reproduction_id");
      reproductionupdate
        ..map((e) async {
          await box.delete(e['id']);
        })
        ..map((e) =>
                box.put("${e['id']}", Breeding_reproduction_id.fromJson(e)))
            .toList();
      Sync_Json.Get_Master_Data('Breeding_reproduction_id');
    }

    // todo Treatment update Start
    final Treatment = await ApiCalling.createPost(AppUrl().GetTreatment,
        "Bearer " + Constants_Usermast.token.toString(), data);
    List<dynamic> treatmentupdate = jsonDecode(Treatment.body)['data'];

    if (treatmentupdate.isNotEmpty) {
      var box = await Hive.openBox<Animal_Treatment>("Animal_Treatment");
      treatmentupdate
        ..map((e) async {
          await box.delete(e['id']);
        })
        ..map((e) => box.put("${e['id']}", Animal_Treatment.fromJson(e)))
            .toList();
      Sync_Json.Get_Master_Data('Health_treatment');
    }
    // todo Treatmentdetails update Start
    final Treatmentdetails = await ApiCalling.createPost(
        AppUrl().GetTreatmentdetails,
        "Bearer " + Constants_Usermast.token.toString(),
        data);
    List<dynamic> treatmentdetailsupdate =
    jsonDecode(Treatmentdetails.body)['data'];
    if (treatmentdetailsupdate.isNotEmpty) {
      var box = await Hive.openBox<Animal_Treatment_details>(
          "Health_treatmentDetails");
      treatmentdetailsupdate
        ..map((e) async {
          await box.delete(e['id']);
        })
        ..map((e) =>
            box.put("${e['id']}", Animal_Treatment_details.fromJson(e)))
            .toList();
      Sync_Json.Get_Master_Data('Health_treatmentDetails');
    }
    //todo toast
    Con_Wid.Con_Show_Toast(context, "Data Update Successfully");
  }
}
