import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../../component/DataBaseHelper/Con_List.dart';
import '../../../../component/DataBaseHelper/Sync_Database.dart';
import '../../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../../component/Gobal_Widgets/ButtonState.dart';
import '../../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../../component/Gobal_Widgets/Con_Toast.dart';
import '../../../../component/Gobal_Widgets/Constants.dart';
import '../../../../component/Gobal_Widgets/DatePicker.dart';
import '../../../../component/Gobal_Widgets/MyCustomWidget.dart';
import '../../../../model/Animal_Deworming.dart';
import '../BulkEntry.dart';

class Deworming extends StatefulWidget {
  List SelectList = [];
  Deworming(this.SelectList);

  @override
  State<Deworming> createState() => _DewormingState();
}

class _DewormingState extends State<Deworming> {
  ButtonState stateTextWithIcon = ButtonState.idle;
  String mStrFromdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  bool botton1 = true;
  bool botton2 = false;
  bool botton3 = false;
  List<String> Selectedworm = [];
  String managerStaff = "";
  String extensionOfficerStaff = "";
  String zone = "";
  List<String> SelectedDewormer = [];
  List<String> Selectedspecies = [];
  String lat = "", long = "";
  List<String> Selectedinseminator = [];
  TextEditingController Dewnoofdose = TextEditingController();
  TextEditingController Dewcost = TextEditingController();
  TextEditingController Dewbatch = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    getLoc();
  }

  getdata() {
    if (Con_List.M_inseminator.isEmpty ||
        Con_List.M_medicineLedger.isEmpty ||
        Con_List.M_dewormingType.isEmpty ||
        Con_List.M_species.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_staff);
      Sync_Json.Get_Master_Data(Constants.Tbl_Account_medicineLedger);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_dewormingType);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_species);
    }
  }

  Future getLoc() async {
    var box = await Hive.openBox<Animal_Deworming>("Health_deworming");
    try {
      Constants.Last_id_Deworming = int.parse(box.keys.last.toString());
    } catch (e) {
      print(e);
      Constants.Last_id_Deworming = 0;
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    lat = position.latitude.toString();
    long = position.longitude.toString();
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
            Navigator.pop(context);
          },
        ),
        body: Con_Wid.backgroundContainer(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Con_Wid.fullContainer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Con_Wid.paddingWithText("Heat Date :", Conclrfontmain,
                          context: context),
                      Con_Wid.paddingWithText("${mStrFromdate}", ConClrMain,
                          context: context),
                    ],
                  ),

                  Date_Picker(
                    onDateChange: (value) {
                      setState(() {
                        mStrFromdate =
                            "${value.day}/${value.month}/${value.year} ${value.hour}:${value.minute}";
                      });
                    },
                    selectionColor: ConClrLightBack,
                    selectedTextColor: Colors.white,
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now())
                          .then((value) {
                        setState(() {
                          if (value == null) {
                            mStrFromdate =
                                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}";
                          } else {
                            mStrFromdate =
                                "${value.day}/${value.month}/${value.year} ${value.hour}:${value.minute}";
                          }
                        });
                      });
                    },
                    buttencolor: ConClrLightBack,
                  ),
                  // Con_Wid.paddingWithText("Worm", Conclrfontmain),
                  CondropDown(
                    title: 'Select Worm',
                    itemList:
                        Con_List.M_dewormingType.map((e) => e.name.toString())
                            .toList(),
                    SelectedList: Selectedworm,
                    onSelected: (List<String> value) {
                      setState(() {});
                    },
                  ),
                  //  Con_Wid.paddingWithText("Dewormer", Conclrfontmain),
                  CondropDown(
                    title: 'Select Dewormer',
                    itemList:
                        Con_List.M_medicineLedger.map((e) => e.name.toString())
                            .toList(),
                    SelectedList: SelectedDewormer,
                    onSelected: (List<String> value) {
                      setState(() {});
                    },
                  ),
                  Con_Wid.textFieldWithInter(
                      text: "Cost",
                      controller: Dewcost,
                      hintText: "Enter Cost"),
                  Con_Wid.textFieldWithInter(
                      text: "Batch",
                      controller: Dewbatch,
                      hintText: "Enter Batch"),
                  //Con_Wid.paddingWithText("Route", Conclrfontmain),
                  CondropDown(
                    title: 'Select Route',
                    itemList:
                        Con_List.M_medicineRoute.map((e) => "${e.id}-${e.name}")
                            .toList(),
                    SelectedList: Selectedspecies,
                    onSelected: (List<String> value) {
                      setState(() {
                        Selectedspecies = value;
                      });
                    },
                  ),
                  Con_Wid.textFieldWithInter(
                      text: "No of Dose",
                      controller: Dewnoofdose,
                      hintText: "Enter No of Dose"),
                  // Con_Wid.paddingWithText("Deworming Done", Conclrfontmain),
                  CondropDown(
                    title: 'Deworming Done by',
                    itemList:
                        Con_List.M_inseminator.map((e) => e.name.toString())
                            .toList(),
                    SelectedList: Selectedinseminator,
                    onSelected: (List<String> value) {
                      setState(() {});
                    },
                  ),
                  Con_Wid.height(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyCustomWidget(
                          Onchanged: () {
                            if (Dewcost.text.isEmpty) {
                              CustomToast.show(context, "Invalid Entry");
                            } else if (Selectedworm.isEmpty) {
                              CustomToast.show(context, "Invalid Worm");
                            } else if (SelectedDewormer.isEmpty) {
                              CustomToast.show(context, "Invalid Deworming");
                            } else if (Selectedspecies.isEmpty) {
                              CustomToast.show(context, "Invalid Route");
                            } else if (Selectedinseminator.isEmpty) {
                              CustomToast.show(context, "Invalid inseminator");
                            } else if (mStrFromdate.isEmpty) {
                              CustomToast.show(context, "Invalid Date");
                            } else {
                              widget.SelectList.forEach((element) {
                                List<Animal_Deworming> details = [
                                  Animal_Deworming(
                                    SyncStatus: "0",
                                    tagId: "${element}",
                                    date: mStrFromdate,
                                    batchNo: Dewbatch.text,
                                    dose: Dewnoofdose.text,
                                    cost: Dewcost.text,
                                    redewormingDate: mStrFromdate,
                                    dewormerMedicine: int.parse(
                                        Con_List.M_medicineLedger.where((e) =>
                                                e.name == SelectedDewormer[0])
                                            .first
                                            .id
                                            .toString()),
                                    dewormingType: int.parse(
                                        Con_List.M_dewormingType.where((e) =>
                                                e.name == Selectedworm[0])
                                            .first
                                            .id
                                            .toString()),
                                    medicineRoute: int.parse(
                                        Selectedspecies[0].split("-").first),
                                    doneBy: int.parse(
                                        Con_List.M_inseminator.where((e) =>
                                                e.name.toString() ==
                                                Selectedinseminator[0])
                                            .first
                                            .id
                                            .toString()),
                                    details: null,
                                    id: Constants.Last_id_Deworming + 1,
                                    createdAt: DateTime.now().toString(),
                                    updatedAt: DateTime.now().toString(),
                                    lastUpdatedByUser: null,
                                    createdByUser: null,
                                    lat: lat,
                                    long: long,
                                    managerStaff:
                                        managerStaff != 0 ? managerStaff : null,
                                    extensionOfficerStaff:
                                        extensionOfficerStaff != 0
                                            ? extensionOfficerStaff
                                            : null,
                                    zone: zone != 0 ? zone : null,
                                    lot: null,
                                    herd: null,
                                    farmer: null,
                                    serverID: null,
                                    clientID: null,
                                  )
                                ];

                                Animal_Deworming prods = details[
                                    math.Random().nextInt(details.length)];
                                List<Map> weights_sync_datas = [];
                                weights_sync_datas.add(prods.toJson(prods));
                                SyncDB.insert_table(weights_sync_datas,
                                    Constants.Tbl_Health_deworming);
                                switch (stateTextWithIcon) {
                                  case ButtonState.idle:
                                    stateTextWithIcon = ButtonState.loading;
                                    Future.delayed(
                                      Duration(seconds: 3),
                                      () {
                                        setState(() {
                                          stateTextWithIcon =
                                              ButtonState.success;
                                          if (stateTextWithIcon ==
                                              ButtonState.success) {
                                            Future.delayed(Duration(seconds: 1),
                                                () {
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
                              });
                            }
                          },
                          Title: "Save",
                          color: ConClrBtntxt,
                          stateTextWithIcon: stateTextWithIcon)
                    ],
                  )
                ],
              )),
            ],
          ),
        )),
      ),
    );
  }
}
