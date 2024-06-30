import 'package:flutter/material.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

import '../../../../component/DataBaseHelper/Con_List.dart';
import '../../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../../component/Gobal_Widgets/Constants.dart';
import '../BulkEntry.dart';
import 'DeWormingInDetail.dart';

class DeWorming extends StatefulWidget {
  const DeWorming({Key? key}) : super(key: key);

  @override
  State<DeWorming> createState() => _DeWormingState();
}

class _DeWormingState extends State<DeWorming> {
  List<String> Selectedroute = [];
  List<String> Selectedsociety = [];
  List<String> SelectedFarmer = [];
  List<String> Animal_data = [];
  String farmercode = "";
  String Routecode = "";
  String societycode = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() {
    if (Con_List.M_Userherds.isEmpty ||
        Con_List.M_inseminator.isEmpty ||
        Con_List.M_status.isEmpty ||
        Con_List.M_medicineLedger.isEmpty ||
        Con_List.M_dewormingType.isEmpty ||
        Con_List.M_Userlots.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_herd);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_staff);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_status);
      Sync_Json.Get_Master_Data(Constants.Tbl_Account_medicineLedger);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_dewormingType);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_lot);
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(
          () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return BulkEntryScreen();
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "Deworming",
          Actions: [],
          onBackTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return BulkEntryScreen();
              },
            ));
          },
        ),
        body: Con_Wid.backgroundContainer(
          child: Column(
            children: [
              Container(
                // color: Colors.white,
                child: Container(
                  margin: const EdgeInsets.all(7),
                  padding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
                  decoration: BoxDecoration(
                    color: ConClrLightBack2,
                    // border: Border.all(width: 5, color: Colors.white),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Con_Wid.showTypesDetailContainer(
                              "Select type of entry", context),
                        ],
                      ),
                      // Con_Wid.paddingWithText("Route", Conclrfontmain),
                      // Todo CondropDown
                      CondropDown(
                        color1: ConsfontBlackColor,
                        title: 'Select Route',
                        itemList: Con_List.M_Userherds.map(
                            (e) => "${e.code}-${e.Name}").toList(),
                        SelectedList: Selectedroute,
                        onSelected: (List<String> value) {
                          Selectedsociety.clear();
                          setState(() {
                            Selectedroute = value;
                            Routecode = Con_List.M_Userherds.firstWhere((e) =>
                                    e.code.toString() ==
                                    value[0].split("-").first.toString())
                                .id
                                .toString();
                          });
                        },
                      ),
                      //Con_Wid.paddingWithText("Society", Conclrfontmain),
                      CondropDown(
                        color1: ConsfontBlackColor,
                        title: 'Select Society',
                        itemList: Con_List.M_Userlots.where((e) =>
                                e.herd.toString() ==
                                (Routecode != "" ? Routecode : ""))
                            .map((e) => "${e.code}-${e.name}")
                            .toList(),
                        SelectedList: Selectedsociety,
                        onSelected: (List<String> value) {
                          SelectedFarmer.clear();
                          setState(() {
                            Selectedsociety = value;
                            societycode = Con_List.M_Userlots.firstWhere((e) =>
                                    e.code.toString() ==
                                    value[0].split("-").first.toString())
                                .id
                                .toString();
                          });
                        },
                      ),
                      CondropDown(
                        color1: ConsfontBlackColor,
                        title: 'Select Farmer',
                        itemList: Con_List.M_Farmer.where((e) =>
                                e.lot.toString() ==
                                (societycode != "" ? societycode : ""))
                            .map((e) => "${e.code}-${e.name}")
                            .toList()
                          ..sort((a, b) =>
                              a.split('-').first.compareTo(b.split('-').first)),
                        SelectedList: SelectedFarmer,
                        onSelected: (List<String> value) {
                          setState(() {
                            SelectedFarmer = value;
                            farmercode = Con_List.M_Farmer.firstWhere(
                                    (e) => "${e.code}-${e.name}" == value[0])
                                .id
                                .toString();
                          });
                        },
                      ),
                      Con_Wid.div(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Con_Wid.MainButton(
                              width: 170,
                              height: 51,
                              fontSize: 16,
                              pStrBtnName: 'Continue',
                              OnTap: () {
                                if (Selectedroute.isEmpty) {
                                  Con_Wid.Con_Show_Toast(
                                      context, "Select Route");
                                } else if (Selectedsociety.isEmpty) {
                                  Con_Wid.Con_Show_Toast(
                                      context, "Select Society");
                                } else if (SelectedFarmer.isEmpty) {
                                  Con_Wid.Con_Show_Toast(
                                      context, "Select Farmer");
                                } else {
                                  Con_List.id_Animal_Details.forEach((e) {
                                    if (e.farmer.toString() ==
                                        farmercode.toString()) {
                                      Animal_data.add(e.tagId.toString());
                                    }
                                  });
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return DeWormingInDetail(Animal_data);
                                    },
                                  ));
                                }
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
