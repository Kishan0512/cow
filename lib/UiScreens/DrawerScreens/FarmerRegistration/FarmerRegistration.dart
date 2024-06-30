import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:herdmannew/component/DataBaseHelper/Con_List.dart';
import 'package:hive/hive.dart';

import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../../component/DataBaseHelper/Sync_Database.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../../component/Gobal_Widgets/Con_Widget.dart';
import '../../../model/Animal_Details_id.dart';
import '../../../model/Get_Master_Farmer.dart';
import '../../Dashboard/Dashboard.dart';

class FarmerRegis extends StatefulWidget {
  const FarmerRegis({super.key});

  @override
  State<FarmerRegis> createState() => _FarmerRegisState();
}

class _FarmerRegisState extends State<FarmerRegis> {
  TextEditingController FarmerCode = TextEditingController(),
      FarmerName = TextEditingController(),
      FarmerSAP = TextEditingController(),
      FarmerMob = TextEditingController();
  Get_Master_Farmer? Farmer;
  List<Animal_Details_id> FarmerDetail = [];
  String lotCode = "", HerdCode = "";
  String? abd;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Con_Wid.appBar(
        title: "Farmer Registration",
        Actions: [],
        onBackTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return DashBoardScreen();
            },
          ));
        },
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          CondropDown(
            title: "Select Route",
            itemList:
                Con_List.M_Userherds.map((e) => "${e.code}-${e.Name}").toList(),
            SelectedList: [],
            onSelected: (value) {
              setState(() {
                HerdCode = Con_List.M_Userherds.firstWhere((element) =>
                        "${element.code}-${element.Name}" == value[0])
                    .id
                    .toString();

              });
            },
          ),
          CondropDown(
            title: "Select Society",
            itemList: Con_List.M_Userlots.where((element) =>
                    element.herd.toString() ==
                    (HerdCode.isNotEmpty ? HerdCode : ""))
                .map((e) => "${e.code}-${e.name}")
                .toList(),
            SelectedList: [],
            onSelected: (value) {
              setState(() {
                lotCode = Con_List.M_Userlots.firstWhere(
                    (e) => "${e.code}-${e.name}" == value[0]).id.toString();

              });
            },
          ),
          Con_Wid.textFieldWithInter(
            controller: FarmerCode,
            hintText: "Farmer Code",
            Onchanged: (text) {
              if (text != null) {
                Farmer = Con_List.M_Farmer.firstWhere(
                        (element) => element.code.toString() == text && element.lot.toString() ==lotCode.toString());
                FarmerDetail = Con_List.id_Animal_Details
                    .where((element) =>
                element.farmerCode == text.toString() &&
                    element.lot == lotCode)
                    .toList();
                if (Farmer != null) {
                  Con_Wid.Con_Show_Toast(context, 'Farmer already register with this code');
                  FarmerCode.clear();
                  setState(() {});
                }
              }
            },
          ),

          Con_Wid.height(5),
          Con_Wid.textFieldWithInter(
              controller: FarmerName, hintText: "Farmer Name"),
          Con_Wid.height(5), Con_Wid.textFieldWithInter(controller: FarmerMob, hintText: "Farmer Mobile No."),
          Con_Wid.height(5), Con_Wid.textFieldWithInter(controller: FarmerSAP, hintText: "Farmer SAP Code"),
          Con_Wid.height(20),
          Con_Wid.MainButton(OnTap: () async {
            if(FarmerCode.text.isEmpty &&FarmerSAP.text.isEmpty && FarmerName.text.isEmpty && lotCode.isEmpty && FarmerMob.text.isEmpty) {
              Con_Wid.Con_Show_Toast(context, "Please fill all fields");
            }else{
            final res = await ApiCalling.createPost(
                AppUrl().saveFarmer, "Bearer ${Constants_Usermast.token}", {
              "code": FarmerCode.text,
              "sapCode": FarmerSAP.text,
              "farmerName": FarmerName.text,
              "lot": int.parse(lotCode),
              "mobile": FarmerMob.text,
              "uid": int.parse(Constants_Usermast.user_id)
            });
            if (res.statusCode == 200) {
               List id= jsonDecode(res.body)['data'];
              List data=[{"DCSCode": null,
                "code": FarmerCode.text,
                "Name": FarmerName.text,
                "MiddleName": null,
                "LastName": null,
                "Mobile": FarmerMob.text,
                "ProducerCode": null,
                "SAPcode": FarmerSAP.text,
                "lot": int.parse(lotCode),
                "id": id[0]['ID']}];
               var box = await Hive.openBox<Get_Master_Farmer>("Master_Farmer");
               data.map((e) => box.put("${e['id']}", Get_Master_Farmer.fromJson(e)))
                     .toList();
               Sync_Json.Get_Master_Data('Master_farmer');
              Con_Wid.Con_Show_Toast(context, 'Data Saved successfully');
            } else {
              Con_Wid.Con_Show_Toast(context, res.body['msg']);
            }}
          }, pStrBtnName: "Register", height: 40, width: 100, fontSize: 14)
        ],
      )),
    );
  }
}


