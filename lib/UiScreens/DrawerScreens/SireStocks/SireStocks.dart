import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Icons.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Database.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../../model/Master_sire.dart';
import '../../Dashboard/Dashboard.dart';

class SireStockScreen extends StatefulWidget {
  const SireStockScreen({Key? key}) : super(key: key);

  @override
  State<SireStockScreen> createState() => _SireStockScreenState();
}

class _SireStockScreenState extends State<SireStockScreen> {
  TextEditingController Semon = TextEditingController();
  TextEditingController NormalSemon = TextEditingController();
  int totalMinStock = 0;
  int totalBirthWeight = 0;
  List<Master_sire> sire = [];
  List<String> mStrsireSelected = [];
  List<Master_sire> temp = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    //getLst();
    setState(() {});
  }

  getdata() {
    Sync_Json.Get_Master_Data(Constants.Tbl_Master_sire);
    temp = Con_List.M_sire.where((element) => element.name.toString().toLowerCase() != "unknown").toList();

    temp.forEach((e) {
      print(e.name+" "+ e.birthWeight.toString()+" "+e.minStrawStock.toString());
      if(int.parse(e.minStrawStock.toString())>0 || int.parse(e.birthWeight.toString())>0){
      sire.add(e);
      totalMinStock += int.parse(e.minStrawStock.toString());
      totalBirthWeight += int.parse(e.birthWeight.toString());
    }});
    setState(() {});
  }

  AddSirestock() async {
    if (mStrsireSelected.isNotEmpty) {
      String sire = "";
      sire = mStrsireSelected.join("");
      final res = await ApiCalling.createPost(AppUrl().saveSireStock,
          "Bearer " + Constants_Usermast.token.toString(), {
        "staffId": Constants_Usermast.staff.toString(),
        "currentStock": Semon.text,
        "sire": sire,
        "sorted": "1",
      });
      if (res.statusCode == 200) {
        Con_Wid.Con_Show_Toast(context, 'Data Saved successfully');
      }
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(
          () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return DashBoardScreen();
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
        appBar: Con_Wid.appBar(
            title: sire.length > 0
                ? "Sire stocks ( ${sire.length} )"
                : "Sire stocks",
            Actions: [
              Con_Wid.mIconButton(
                  onPressed: () async {
                    final connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile ||
                        connectivityResult == ConnectivityResult.wifi) {
                      await SyncDB.SyncTable("sireStock", true);
                    }
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return SireStockScreen();
                      },
                    ));
                  },
                  icon: Own_Refresh),
            ],
            onBackTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return DashBoardScreen();
                },
              ));
            }),
        body: Con_Wid.backgroundContainer(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: con_clr.ConClr2 ? ConClrMainLight : whiteColor1,
              border: Border.all(
                  color: con_clr.ConClr2 ? ConClrLightBack : whiteColor1,
                  width: 4),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Container(height: 25,width: double.infinity,child: Text("User Name : "+Constants_Usermast.user_name)),
                Container(
                  height: 50,
                  width: double.infinity,
                  color: con_clr.ConClr2 ? ConClrbluelight : ConClrDialog,
                  child: table(fontwhiteColor, "Name", "Sorted\nStraws",
                      "Normal\nStraws", FontWeight.w600),
                ),

                Expanded(
                  child: Container(
                    //height: 27.h,
                    width: double.infinity,
                    color: ConClrLightBack1,
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: ListView.builder(
                        itemBuilder: (context, index) {

                          return (sire[index].birthWeight.toString().contains("-") || sire[index].birthWeight.toString()=="0") && (sire[index].minStrawStock.toString().contains("-") || sire[index].minStrawStock.toString()=="0")?Container():Padding(
                            padding: EdgeInsets.only(top: index == 0 ? 10 : 0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: table(
                                      Conclrfontmain,
                                      "${sire[index].name}",
                                      "${sire[index].birthWeight}",
                                      "${sire[index].minStrawStock}",
                                      FontWeight.normal),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: whiteColor,
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: sire.length),
                  ),
                ),
                Container(
                  height: 45,
                  width: double.infinity,
                  color: con_clr.ConClr2 ? ConClrbluelight : ConClrDialog,
                  child: table(fontwhiteColor, "Total", "$totalBirthWeight",
                      "$totalMinStock", FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  table(Color tColor, String name, String sorted, String normal,
      FontWeight fontWeight) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width / 2,
          child: Con_Wid.popinsfont(name, tColor, fontWeight, 10, context),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 8,
          child: Con_Wid.popinsfont(sorted, tColor, fontWeight, 10, context),
        ),
        Con_Wid.width(MediaQuery.of(context).size.width / 50),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 8,
          child: Con_Wid.popinsfont(normal, tColor, fontWeight, 10, context),
        ),
      ],
    );
  }
}