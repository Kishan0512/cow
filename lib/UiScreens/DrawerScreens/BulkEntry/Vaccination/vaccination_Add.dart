import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../../../component/DataBaseHelper/Con_List.dart';
import '../../../../component/DataBaseHelper/Sync_Database.dart';
import '../../../../component/Gobal_Widgets/ButtonState.dart';
import '../../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../../component/Gobal_Widgets/Con_Toast.dart';
import '../../../../component/Gobal_Widgets/Con_Widget.dart';
import '../../../../component/Gobal_Widgets/Constants.dart';
import '../../../../component/Gobal_Widgets/DatePicker.dart';
import '../../../../model/Animal_Vaccination.dart';
import '../BulkEntry.dart';

class Vaccination_Add extends StatefulWidget {
  List<String> Animal_ids = [];

  Vaccination_Add(this.Animal_ids);

  @override
  State<Vaccination_Add> createState() => _Vaccination_AddState();
}

class _Vaccination_AddState extends State<Vaccination_Add> {
  ButtonState stateTextWithIcon = ButtonState.idle;
  String mStrFromdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  TextEditingController cost = TextEditingController(),
      batch = TextEditingController(),
      noofdose = TextEditingController();
  bool botton1 = true, botton2 = false, botton3 = false;
  List<String> Selectedinseminator = [],
      Selecteddiseases = [],
      SelectedDewormer = [],
      Selectedroute = [];
  String lat = "",
      long = "",
      managerStaff = "",
      extensionOfficerStaff = "",
      zone = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoc();
  }

  Future getLoc() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    lat = position.latitude.toString();
    long = position.longitude.toString();
  }

  getstaff() {
    Con_List.M_Userherds.forEach((element) {
      if (element.Name == Selectedroute[0]) {
        managerStaff = element.managerStaff.toString();
        extensionOfficerStaff = element.extensionOfficerStaff.toString();
        zone = element.zone.toString();
      }
    });
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
          title: "Vaccination",
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
                      Con_Wid.paddingWithText("${mStrFromdate}",
                          con_clr.ConClr2 ? ConClrMain : BlackColor,
                          context: context)
                    ],
                  ),
                  Date_Picker(
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
                    selectionColor: ConClrLightBack,
                    selectedTextColor: Colors.white,
                    onDateChange: (value) {
                      setState(() {
                        mStrFromdate =
                            "${value.day}/${value.month}/${value.year} ${value.hour}:${value.minute}";
                      });
                    },
                    buttencolor: ConClrLightBack,
                  ),
                  Con_Wid.height(10),
                  CondropDown(
                    title: 'Select Diseases',
                    itemList:
                        Con_List.M_vaccinationType.map((e) => e.name.toString())
                            .toList(),
                    SelectedList: Selecteddiseases,
                    onSelected: (List<String> value) {
                      setState(() {});
                    },
                  ),
                  CondropDown(
                    title: 'Select Vaccination',
                    itemList:
                        Con_List.M_medicineLedger.map((e) => e.name.toString())
                            .toList(),
                    SelectedList: SelectedDewormer,
                    onSelected: (List<String> value) {
                      setState(() {});
                    },
                  ),
                  Con_Wid.textFieldWithInter(
                      text: "Cost", controller: cost, hintText: "Enter Cost"),
                  Con_Wid.textFieldWithInter(
                      text: "Batch",
                      controller: batch,
                      hintText: "Enter Batch"),
                  CondropDown(
                    title: 'Select Route',
                    itemList:
                        Con_List.M_medicineRoute.map((e) => "${e.id}-${e.name}")
                            .toList(),
                    SelectedList: Selectedroute,
                    onSelected: (List<String> value) {
                      setState(() {
                        Selectedroute = value;
                      });
                    },
                  ),
                  Con_Wid.textFieldWithInter(
                      text: "No of Dose",
                      controller: noofdose,
                      hintText: "Enter NO of Dose"),
                  CondropDown(
                    title: 'Select Vaccinator',
                    itemList:
                        Con_List.M_inseminator.map((e) => e.name.toString())
                            .toList(),
                    SelectedList: Selectedinseminator,
                    onSelected: (List<String> value) {
                      setState(() {});
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Con_Wid.MainButton(
                          width: 170,
                          height: 51,
                          fontSize: 16,
                          pStrBtnName: 'Save',
                          OnTap: () {
                            if (Selectedroute.isEmpty) {
                              CustomToast.show(context, "Select Rout");
                            } else if (SelectedDewormer.isEmpty) {
                              CustomToast.show(context, "Select Vaccination");
                            } else if (Selectedinseminator.isEmpty) {
                              CustomToast.show(context, "Select Inseminator");
                            } else if (Selecteddiseases.isEmpty) {
                              CustomToast.show(context, "Select Diseases");
                            } else if (cost.text.isEmpty) {
                              CustomToast.show(context, "Select Cost");
                            } else {
                              widget.Animal_ids.forEach((element) {
                                List<Animal_Vaccination> details = [
                                  Animal_Vaccination(
                                    serverID: "",
                                    id: 0,
                                    TagId: "${element}",
                                    DateOfVaccination: mStrFromdate,
                                    BatchNo: batch.text,
                                    Dose: noofdose.text,
                                    Cost: cost.text,
                                    vaccine: int.parse(
                                        Con_List.M_medicineLedger.where((e) =>
                                                e.name == SelectedDewormer[0])
                                            .first
                                            .id
                                            .toString()),
                                    vaccinationType: int.parse(
                                        Con_List.M_vaccinationType.where((e) =>
                                                e.name == Selecteddiseases[0])
                                            .first
                                            .id
                                            .toString()),
                                    doneBy: int.parse(
                                        Con_List.M_inseminator.where((e) =>
                                                e.name ==
                                                Selectedinseminator[0])
                                            .first
                                            .id
                                            .toString()),
                                    medicineRoute: int.parse(
                                        Con_List.M_species.where((e) =>
                                                e.name == Selectedroute[0])
                                            .first
                                            .id
                                            .toString()),
                                    details: 0,
                                    SyncStatus: "0",
                                    createdAt: DateTime.now().toString(),
                                    updatedAt: "",
                                    lastUpdatedByUser: 0,
                                    createdByUser: 0,
                                    Lat: lat,
                                    Long: long,
                                    managerStaff:
                                        managerStaff != "" ? managerStaff : "",
                                    extensionOfficerStaff:
                                        extensionOfficerStaff != ""
                                            ? extensionOfficerStaff
                                            : "",
                                    zone: zone != "" ? zone : "",
                                  )
                                ];
                                Animal_Vaccination prods = details[
                                    math.Random().nextInt(details.length)];
                                List<Map> weights_sync_datas = [];
                                weights_sync_datas.add(prods.toJson(prods));
                                SyncDB.insert_table(weights_sync_datas,
                                    Constants.Tbl_Health_vaccination);
                              });
                            }
                          }),
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
