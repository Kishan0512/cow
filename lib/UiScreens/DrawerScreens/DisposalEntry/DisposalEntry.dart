import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/component/Gobal_Widgets/MyCustomWidget.dart';
import 'package:herdmannew/model/Animal_Disposal.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Database.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/ButtonState.dart';
import '../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../../component/Gobal_Widgets/DatePicker.dart';
import '../../Dashboard/Dashboard.dart';

class DisposalEntryScreen extends StatefulWidget {
  const DisposalEntryScreen({Key? key}) : super(key: key);

  @override
  State<DisposalEntryScreen> createState() => _DisposalEntryScreenState();
}

class _DisposalEntryScreenState extends State<DisposalEntryScreen> {
  ButtonState stateTextWithIcon = ButtonState.idle;
  TextEditingController soldTo = TextEditingController(),
      price = TextEditingController();
  String mStrFromdate = DateFormat('MM/dd/yyyy HH:mm').format(DateTime.now());
  bool botton1 = true, botton2 = false, botton3 = false;
  String actual_date = "";
  String mStrFarmer = '';
  String Temproute = '';
  String Tempsoci = '';

  List<String> Msociety = [],
      Mroute = [],
      Manimalid = [],
      disposaltypeadd = [],
      Msystem = [],
      Mfarmer = [],
      Mreason = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    getlastid();
  }

  getdata() {
    if (Con_List.M_Userherds.isEmpty ||
        Con_List.M_systemAffected.isEmpty ||
        Con_List.M_diagnosis.isEmpty ||
        Con_List.M_disposal.isEmpty ||
        Con_List.M_disposalSubOptions.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_herd);
      Sync_Json.Get_Master_Data(Constants.Tbl_Health_systemAffected);
      Sync_Json.Get_Master_Data(Constants.Tbl_Health_diagnosis);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_disposal);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_disposalSubOptions);
    }
  }

  getlastid() async {
    var box = await Hive.openBox<Animal_Disposal>("Animal_diedDetails");
    try {
      Constants.Last_id_Animal_diedDetails =
          int.parse(box.keys.last.toString());
    } catch (e) {
      Constants.Last_id_Animal_diedDetails = 0;
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
          title: "Disposal Entry",
          Actions: [],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return DashBoardScreen();
              },
            ));
          },
        ),
        body: Con_Wid.backgroundContainer(
            child: Con_Wid.fullContainer(
                child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Date_Picker(
                onDateChange: (value) {
                  setState(() {
                    mStrFromdate = value.toString();
                  });
                },
                selectionColor: con_clr.ConClr2 ? ConClrborderdrop : whiteColor,
                selectedTextColor: con_clr.ConClr2 ? BlackColor : BlackColor,
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime.now())
                      .then((value) {
                    setState(() {
                      if (value == null) {
                        mStrFromdate = DateTime.now().toString();
                      } else {
                        mStrFromdate = value.toString();
                      }
                    });
                  });
                },
                buttencolor: con_clr.ConClr2 ? ConClrborderdrop : ConClrDialog,
              ),

              Con_Wid.height(5),
              CondropDown(
                title: 'Select Route',
                itemList: Con_List.M_Userherds.map((e) => "${e.code}-${e.Name}")
                    .toList(),
                SelectedList: Mroute,
                onSelected: (List<String> value) {
                  setState(() {
                    Msociety.clear();
                    Mroute = value;
                    Temproute=Con_List.M_Userherds.firstWhere((element) => "${element.code}-${element.Name}"==value[0]).id.toString();
                  });
                },
              ),
              Con_Wid.height(5),
              CondropDown(
                title: 'Select Society',
                itemList: Con_List.M_Userlots.where((e) =>
                        e.herd.toString() ==
                        (Temproute.isNotEmpty ? Temproute : ""))
                    .map((e) => "${e.code}-${e.name}")
                    .toList(),
                SelectedList: Msociety,
                onSelected: (List<String> value) {
                  setState(() {
                    Mfarmer.clear();
                    Msociety = value;
                    Tempsoci=Con_List.M_Userlots.firstWhere((element) => "${element.code}-${element.name}"==value[0]).id.toString();
                  });
                },
              ),
              Con_Wid.height(5),
              CondropDown(
                color1: ConsfontBlackColor,
                title: 'Select Farmer',
                itemList: Con_List.M_Farmer.where((e) =>
                    e.lot.toString() ==
                    (Tempsoci.isNotEmpty
                        ? Tempsoci
                        : "")).map((e) => "${e.code}-${e.name}").toList()
                  ..sort((a, b) =>
                      a.split('-').first.compareTo(b.split('-').first)),
                SelectedList: Mfarmer,
                onSelected: (List<String> value) {
                  setState(() {
                    Mfarmer = value;
                    mStrFarmer = Con_List.M_Farmer.where(
                            (e) => "${e.code}-${e.name}" == value[0])
                        .map((e) => "${e.id}")
                        .first;
                  });
                },
              ),
              Con_Wid.height(5),
              //todo
              CondropDown(
                title: 'Select Animal ID',
                itemList: Con_List.id_Animal_Details
                    .where((e) =>
                        e.farmer.toString() ==
                        (mStrFarmer.isNotEmpty ? mStrFarmer : ""))
                    .map((e) => e.tagId.toString())
                    .toList(),
                SelectedList: Manimalid,
                onSelected: (List<String> value) {
                  setState(() {
                    Manimalid = value;
                  });
                },
              ),
              Con_Wid.height(5),
              CondropDown(
                title: 'Select Disposal Type',
                itemList:
                    Con_List.M_disposal.map((e) => e.name.toString()).toList(),
                SelectedList: disposaltypeadd,
                onSelected: (List<String> value) {
                  setState(() {
                    disposaltypeadd.contains(value);
                    disposaltypeadd = value;
                  });
                },
              ),
              Con_Wid.height(5),
              //todo
              listEquals(disposaltypeadd, ["Sold"])
                  ? Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Con_Wid.textFieldWithInter(
                                text: "Sold To",
                                controller: soldTo,
                                hintText: "Sold To"),
                            Con_Wid.textFieldWithInter(
                                TextInput_Type: TextInputType.number,
                                text: "Price",
                                controller: price,
                                hintText: "Enter price")
                          ]),
                    )
                  : Container(),
              listEquals(disposaltypeadd, ["Died"])
                  ? Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CondropDown(
                              title: 'Select System',
                              itemList: Con_List.M_systemAffected.map(
                                  (e) => e.name.toString()).toList(),
                              SelectedList: Msystem,
                              onSelected: (List<String> value) {
                                setState(() {
                                  Msystem = value;
                                });
                              },
                            )
                          ]),
                    )
                  : Container(),
              listEquals(disposaltypeadd, ["Unknown"])
                  ? Container()
                  : Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Con_Wid.height(5),
                            CondropDown(
                              title: 'Select Reason',
                              itemList: Con_List.M_disposalSubOptions.map(
                                  (e) => e.name).toList(),
                              SelectedList: Mreason,
                              onSelected: (List<String> value) {
                                setState(() {
                                  Mreason = value;
                                });
                              },
                            ),
                          ]),
                    ),
              Con_Wid.height(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyCustomWidget(
                      Onchanged: () {
                        String herd = "";
                        String lot = "";
                        String farmer1 = "";
                        String reason1 = "";
                        String died = "";
                        if (Mroute.isNotEmpty) {
                          Con_List.M_Userherds.forEach((element) {
                            if (element.Name ==
                                Mroute[0].toString().split("-").last) {
                              herd = element.id.toString();
                            }
                          });
                        }
                        if (Msociety.isNotEmpty) {
                          Con_List.M_Userlots.forEach((element) {
                            if (element.name ==
                                Msociety[0].toString().split("-").last) {
                              lot = element.id.toString();
                            }
                          });
                        }
                        if (Manimalid.isNotEmpty) {
                          Con_List.id_Animal_Details.forEach((element) {
                            if (element.tagId ==
                                Manimalid[0].toString().split("-").last) {
                              farmer1 = element.farmer.toString();
                            }
                          });
                        }
                        if (Mreason.isNotEmpty) {
                          Con_List.M_disposalSubOptions.forEach((element) {
                            if (element.name == Mreason[0].toString()) {
                              reason1 = element.id.toString();
                            }
                          });
                        }
                        if (Msystem.isNotEmpty) {
                          Con_List.M_systemAffected.forEach((element) {
                            if (element.name == Msystem[0].toString()) {
                              died = element.id.toString();
                            }
                          });
                        }
                        if (Manimalid.isEmpty) {
                          Con_Wid.Con_Show_Toast(context, "Selelct Animal");
                        } else if (Mroute.isEmpty) {
                          Con_Wid.Con_Show_Toast(context, "Selelct Route");
                        } else {
                          var date;
                          if (mStrFromdate == null) {
                            date = new DateTime.now();
                            var formatter1 = new DateFormat('MM/dd/yyyy HH:mm');
                            actual_date = formatter1.format(date);
                            var formatter = new DateFormat('dd-MM-yyyy');
                          } else {
                            actual_date = mStrFromdate.toString();
                          }
                          List<Animal_Disposal> animalDetails = [
                            Animal_Disposal(
                                oldTagId: "${Manimalid[0]}",
                                tagId: "${Manimalid[0]}",
                                date: actual_date,
                                soldTo: soldTo.text != "" ? soldTo.text : "",
                                soldPrice: price.text != ""
                                    ? double.parse(price.text)
                                    : "0.0",
                                herd: herd.toString(),
                                lot: lot != "" ? lot.toString() : 0,
                                farmer: farmer1.toString(),
                                oldDetails: "${Manimalid[0]}",
                                details: null,
                                disposalReason:
                                    reason1 != "" ? int.parse(reason1) : 0,
                                diedReason: died != "" ? int.parse(died) : null,
                                id: Constants.Last_id_Animal_diedDetails + 1,
                                createdAt: DateFormat('MM/dd/yyyy HH:mm')
                                    .format(DateTime.now())
                                    .toString(),
                                updatedAt: null,
                                lastUpdatedByUser: null,
                                createdByUser: int.parse(
                                    Constants_Usermast.user_id.toString()),
                                staff: 1,
                                disposaltype: 1,
                                SyncStatus: "0",
                                ServerId: "")
                          ];
                          Animal_Disposal rnd = animalDetails[
                              math.Random().nextInt(animalDetails.length)];
                          List<Map> weights_sync_datas = [];
                          weights_sync_datas.add(rnd.toJson(rnd));

                          SyncDB.insert_table(weights_sync_datas,
                              Constants.Tbl_Animal_diedDetails);
                          switch (stateTextWithIcon) {
                            case ButtonState.idle:
                              stateTextWithIcon = ButtonState.loading;
                              Future.delayed(
                                Duration(seconds: 3),
                                () {
                                  setState(() {
                                    stateTextWithIcon = ButtonState.success;
                                    if (stateTextWithIcon ==
                                        ButtonState.success) {
                                      Future.delayed(Duration(seconds: 1), () {
                                        Navigator.pop(context);
                                      });
                                    }
                                  });
                                },
                              );
                              break;
                            case ButtonState.loading:
                              break;
                            case ButtonState.success:
                              stateTextWithIcon = ButtonState.idle;
                              break;
                            case ButtonState.fail:
                              stateTextWithIcon = ButtonState.idle;
                              break;
                          }
                          setState(
                            () {
                              stateTextWithIcon = stateTextWithIcon;
                            },
                          );
                        }
                      },
                      Title: "save",
                      color: con_clr.ConClr2 ? ConClrMain : ConClrDialog,
                      stateTextWithIcon: stateTextWithIcon)
                ],
              )
            ],
          ),
        ))),
      ),
    );
  }
}
