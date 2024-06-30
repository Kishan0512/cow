import 'package:flutter/material.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

import '../../../../component/DataBaseHelper/Con_List.dart';
import '../../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../../component/Gobal_Widgets/Constants.dart';
import '../BulkEntry.dart';
import 'MilkEntryInDetail.dart';

class MilkEntry extends StatefulWidget {
  const MilkEntry({Key? key}) : super(key: key);

  @override
  State<MilkEntry> createState() => _MilkEntryState();
}

class _MilkEntryState extends State<MilkEntry> {
  List<String> society = [], route = [], mListfarmer = [];
  String mStrFarmer = '', strsociety = '', strroute = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() {
    if (Con_List.M_Userherds.isEmpty ||
        Con_List.M_status.isEmpty ||
        Con_List.M_Userlots.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_herd);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_status);
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
            title: "Milk Entry",
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
                  child: Container(
                    margin: const EdgeInsets.all(7),
                    padding: const EdgeInsets.symmetric(
                        vertical: 17, horizontal: 10),
                    decoration: BoxDecoration(
                      color: ConClrLightBack2,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Con_Wid.showTypesDetailContainer(
                                "Select type of bulk entry", context),
                          ],
                        ),
                        //Con_Wid.paddingWithText("Route", Conclrfontmain),
                        CondropDown(
                          title: 'Select Route',
                          itemList: Con_List.M_Userherds.map(
                              (e) => "${e.code}-${e.Name}").toList(),
                          SelectedList: route,
                          onSelected: (List<String> value) {
                            setState(() {
                              society.clear();
                              route = value;
                              strroute = Con_List.M_Userherds.firstWhere((e) =>
                                      e.code.toString() ==
                                      value[0].split("-").first.toString())
                                  .id
                                  .toString();
                            });
                          },
                        ),
                        CondropDown(
                          title: 'Select Society',
                          itemList: Con_List.M_Userlots.where((e) =>
                                  e.herd.toString() ==
                                  (strroute != ""
                                      ? strroute.split("-").first
                                      : ""))
                              .map((e) => "${e.code}-${e.name}")
                              .toList(),
                          SelectedList: society,
                          onSelected: (List<String> value) {
                            setState(() {
                              mListfarmer.clear();
                              society = value;
                              strsociety = Con_List.M_Userlots.firstWhere((e) =>
                                      e.code.toString() ==
                                      value[0].split("-").first.toString())
                                  .id
                                  .toString();
                            });
                          },
                        ),
                        //Con_Wid.paddingWithText("Society", Conclrfontmain),
                        //Con_Wid.paddingWithText("Owner", Conclrfontmain),
                        CondropDown(
                          color1: ConsfontBlackColor,
                          title: 'Select Farmer',
                          itemList: Con_List.M_Farmer.where((e) =>
                                  e.lot.toString() ==
                                  (strsociety != ""
                                      ? strsociety.split("-").first
                                      : ""))
                              .map((e) => "${e.code}-${e.name}")
                              .toList()
                            ..sort((a, b) => a
                                .split('-')
                                .first
                                .compareTo(b.split('-').first)),
                          SelectedList: mListfarmer,
                          onSelected: (List<String> value) {
                            setState(() {
                              mListfarmer = value;
                              mStrFarmer = Con_List.M_Farmer.firstWhere((e) =>
                                  "${e.code}-${e.name}" ==
                                  value[0].toString()).id.toString();
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
                                  if (route.isEmpty) {
                                    Con_Wid.Con_Show_Toast(
                                        context, "Select Route");
                                  } else if (society.isEmpty) {
                                    Con_Wid.Con_Show_Toast(
                                        context, "Select Society");
                                  } else {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return MilkEntryInDetail(
                                          pStrFarmerid: mStrFarmer,
                                          pListSocietycode: strsociety,
                                        );
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
          )),
    );
  }
}
