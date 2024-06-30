import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Textstyle.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/component/Gobal_Widgets/MyCustomWidget.dart';
import 'package:intl/intl.dart';

import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Database.dart';
import '../../../component/Gobal_Widgets/ButtonState.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../../component/Gobal_Widgets/DatePicker.dart';
import '../../../model/Animal_Details_id.dart';
import '../../../model/Animal_weight_entry_model.dart';
import 'CattleStatusTimeline.dart';

class cattlestatusweight extends StatefulWidget {
  String index;
  cattlestatusweight(this.index);

  @override
  State<cattlestatusweight> createState() => _cattlestatusweightState();
}

class _cattlestatusweightState extends State<cattlestatusweight> {
  ButtonState stateTextWithIcon = ButtonState.idle;
  TextEditingController chest = TextEditingController();
  TextEditingController grith = TextEditingController();
  TextEditingController weight = TextEditingController();
  String mStrFromdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  bool botton1 = true;
  bool botton2 = false;
  bool botton3 = false;
  bool formula = true;
  bool Weight = false;
  String lat = "", long = "";
  String managerStaff = "";
  String extensionOfficerStaff = "";
  String zone = "";
  List<Animal_weight_entry_model> animaldetails = [];
  var total = 000.000, chest_data = 000.000, girth_data = 000.000;
  Animal_Details_id? Mdetail;
  get() {
    Mdetail = Con_List.id_Animal_Details
        .firstWhere((element) => element.tagId == widget.index.toString());
  }

  getdata() async {
    animaldetails = Con_List.A_weight_entry_model.where(
        (e) => e.TagId.toString() == widget.index.toString()).toList();
    if (animaldetails.isNotEmpty) {
      managerStaff = animaldetails[0].managerStaff.toString();
      extensionOfficerStaff = animaldetails[0].extensionOfficerStaff.toString();
      zone = animaldetails[0].zone.toString();
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    lat = position.latitude.toString();
    long = position.longitude.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(
          () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return cattlestatustimeline(index: widget.index);
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "Weight",
          Actions: [],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return cattlestatustimeline(index: widget.index);
              },
            ));
          },
        ),
        body: Con_Wid.backgroundContainer(
            child: SingleChildScrollView(
          child: Column(
            children: [
              con_clr.ConClr2
                  ? Con_Wid.fullContainer(
                      child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Farmer Name : ",
                                  style: ConStyle.Style_white_10s_500w(
                                      fontBlackColor),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 20,
                                  width: 200,
                                  child: widget.index == null
                                      ? Text("")
                                      : Text(" ${Mdetail!.farmername}",
                                          style: TextStyle(fontSize: 12),
                                          overflow: TextOverflow.ellipsis),
                                )
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Society Code : ",
                                style: ConStyle.Style_white_10s_500w(
                                    fontBlackColor),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 20,
                                width: 200,
                                child: widget.index == null
                                    ? Text("")
                                    : Text(" ${Mdetail!.lot}",
                                        style: TextStyle(fontSize: 12),
                                        overflow: TextOverflow.ellipsis),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Society Name : ",
                                style: ConStyle.Style_white_10s_500w(
                                    fontBlackColor),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 20,
                                width: 200,
                                child: widget.index == null
                                    ? Text("")
                                    : Text(" ${Mdetail!.name}",
                                        style: TextStyle(fontSize: 12),
                                        overflow: TextOverflow.ellipsis),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Animal.ID : ",
                                style: ConStyle.Style_white_10s_500w(
                                    fontBlackColor),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 20,
                                width: 200,
                                child: widget.index == null
                                    ? Text("")
                                    : Text(" ${Mdetail!.tagId}",
                                        style: TextStyle(fontSize: 12),
                                        overflow: TextOverflow.ellipsis),
                              )
                            ],
                          )
                        ],
                      ),
                    ))
                  : Con_Wid.fullContainer1(
                      child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Farmer Name : ",
                                  style: ConStyle.Style_white_10s_500w(
                                      fontwhiteColor),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 20,
                                  width: 200,
                                  child: widget.index == null
                                      ? Text("")
                                      : Text(" ${Mdetail!.farmername}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: fontwhiteColor),
                                          overflow: TextOverflow.ellipsis),
                                )
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Society Code : ",
                                style: ConStyle.Style_white_10s_500w(
                                    fontwhiteColor),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 20,
                                width: 200,
                                child: widget.index == null
                                    ? Text("")
                                    : Text(" ${Mdetail!.lot}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: fontwhiteColor),
                                        overflow: TextOverflow.ellipsis),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Society Name : ",
                                style: ConStyle.Style_white_10s_500w(
                                    fontwhiteColor),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 20,
                                width: 200,
                                child: widget.index == null
                                    ? Text("")
                                    : Text(" ${Mdetail!.name}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: fontwhiteColor),
                                        overflow: TextOverflow.ellipsis),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Animal.ID : ",
                                style: ConStyle.Style_white_10s_500w(
                                    fontwhiteColor),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 20,
                                width: 200,
                                child: widget.index == null
                                    ? Text("")
                                    : Text(" ${Mdetail!.tagId}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: fontwhiteColor),
                                        overflow: TextOverflow.ellipsis),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
              Con_Wid.fullContainer(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Con_Wid.paddingWithText("Heat Date :", Conclrfontmain,
                          context: context),
                      Con_Wid.paddingWithText("${mStrFromdate}",
                          con_clr.ConClr2 ? ConClrMain : BlackColor,
                          context: context),
                    ],
                  ),
                  Con_Wid.height(10),
                  Date_Picker(
                    selectionColor:
                        con_clr.ConClr2 ? ConClrLightBack : whiteColor,
                    selectedTextColor: BlackColor,
                    onDateChange: (date) {
                      setState(() {
                        mStrFromdate = date.toString().substring(0, 10);
                      });
                    },
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: Mdetail!.heatDate == null
                                  ? DateTime.parse(Mdetail!.dOB)
                                  : DateTime.parse(Mdetail!.heatDate),
                              lastDate: DateTime.now())
                          .then((value) {
                        setState(() {
                          mStrFromdate = value.toString().substring(0, 10);
                        });
                      });
                    },
                    buttencolor:
                        con_clr.ConClr2 ? ConClrLightBack : ConClrDialog,
                  ),

                  Con_Wid.height(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Con_Wid.paddingWithText(
                          "Weight Selection", Conclrfontmain,
                          context: context),
                    ],
                  ),
                  Con_Wid.height(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Con_Wid.selectionContainer(
                          height: 44,
                          width: 100,
                          text: "Formula",
                          context: context,
                          ontap: () {
                            setState(() {
                              formula = true;
                              Weight = false;
                            });
                          },
                          Color: formula
                              ? con_clr.ConClr2
                                  ? ConClrbluelight
                                  : ConClrDialog
                              : con_clr.ConClr2
                                  ? ConClrLightBack
                                  : whiteColor,
                          textcolor: formula
                              ? whiteColor
                              : con_clr.ConClr2
                                  ? whiteColor
                                  : ConClrDialog),
                      Con_Wid.width(5),
                      Con_Wid.selectionContainer(
                          height: 44,
                          width: 100,
                          text: "Weight",
                          context: context,
                          ontap: () {
                            setState(() {
                              Weight = true;
                              formula = false;
                            });
                          },
                          Color: Weight
                              ? con_clr.ConClr2
                                  ? ConClrbluelight
                                  : ConClrDialog
                              : con_clr.ConClr2
                                  ? ConClrLightBack
                                  : whiteColor,
                          textcolor: Weight
                              ? whiteColor
                              : con_clr.ConClr2
                                  ? whiteColor
                                  : ConClrDialog),
                    ],
                  ),
                  formula
                      ? Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Con_Wid.textFieldWithInter(
                                  text: "Chest",
                                  controller: chest,
                                  hintText: "Enter Chest Size",
                                  Onchanged: (p0) {
                                    if (chest != "") {
                                      chest_data = double.parse('$p0');
                                      if (chest_data <= 65) {
                                        total = ((double.parse('$p0') *
                                                    girth_data) /
                                                9) /
                                            2.5;
                                        int decimals = 3;
                                        num fac = pow(10, decimals);

                                        total = (total * fac).round() / fac;
                                      } else if (chest_data > 65 &&
                                          chest_data <= 80) {
                                        total = ((double.parse('$p0') *
                                                    girth_data) /
                                                8.5) /
                                            2.5;
                                        int decimals = 3;
                                        num fac = pow(10, decimals);

                                        total = (total * fac).round() / fac;
                                      } else if (chest_data > 80) {
                                        total = ((double.parse('$p0') *
                                                    girth_data) /
                                                8) /
                                            2.5;
                                        int decimals = 3;
                                        num fac = pow(10, decimals);

                                        total = (total * fac).round() / fac;
                                      }
                                      weight.text = '$total';
                                      setState(() {});
                                    }
                                  },
                                ),
                                Con_Wid.textFieldWithInter(
                                  text: "Grith",
                                  controller: grith,
                                  hintText: "Enter Grith Size",
                                  Onchanged: (p0) {
                                    if (grith != "") {
                                      girth_data = double.parse('$p0');
                                      if (chest_data <= 65) {
                                        total = ((double.parse('$p0') *
                                                    chest_data) /
                                                9) /
                                            2.5;
                                        int decimals = 3;
                                        num fac = pow(10, decimals);

                                        total = (total * fac).round() / fac;
                                      } else if (chest_data > 65 &&
                                          chest_data <= 80) {
                                        total = ((double.parse('$p0') *
                                                    chest_data) /
                                                8.5) /
                                            2.5;
                                        int decimals = 3;
                                        num fac = pow(10, decimals);

                                        total = (total * fac).round() / fac;
                                      } else if (chest_data > 80) {
                                        total = ((double.parse('$p0') *
                                                    chest_data) /
                                                8) /
                                            2.5;
                                        int decimals = 3;
                                        num fac = pow(10, decimals);

                                        total = (total * fac).round() / fac;
                                      }
                                      weight.text = '$total';
                                      setState(() {});
                                    }
                                  },
                                ),
                                Con_Wid.height(5)
                              ]),
                        )
                      : Container(),
                  Con_Wid.textFieldWithInter(
                      text: "Total Weight",
                      controller: weight,
                      hintText: "Enter Weight"),
                  Con_Wid.height(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyCustomWidget(
                          Onchanged: () {
                            if (chest.text == "") {
                              Con_Wid.Con_Show_Toast(context, "Enter Chest");
                            } else if (grith.text == "") {
                              Con_Wid.Con_Show_Toast(context, "Enter Grith");
                            } else {
                              List<Animal_weight_entry_model> testClients = [
                                Animal_weight_entry_model(
                                  TagId: '${widget.index}',
                                  Date: mStrFromdate,
                                  ChestGirth:
                                      chest.text != "" ? chest.text : "",
                                  Weight: weight.text != "" ? weight.text : "",
                                  Length: grith.text != "" ? grith.text : "",
                                  WeightGain: "",
                                  AutoNo: 0,
                                  details: 0,
                                  SyncStatus: "0",
                                  id: 0,
                                  createdAt: "",
                                  updatedAt: "",
                                  lastUpdatedByUser: 0,
                                  createdByUser: 0,
                                  Lat: lat,
                                  Long: long,
                                  managerStaff: managerStaff != ""
                                      ? int.parse(managerStaff)
                                      : 0,
                                  extensionOfficerStaff:
                                      extensionOfficerStaff != ""
                                          ? int.parse(extensionOfficerStaff)
                                          : 0,
                                  zone: zone != "" ? int.parse(zone) : 0,
                                )
                              ];
                              Animal_weight_entry_model rnd = testClients[
                                  math.Random().nextInt(testClients.length)];
                              List<Map> weights_sync_datas = [];
                              weights_sync_datas.add(rnd.toJson(rnd));
                              SyncDB.insert_table(weights_sync_datas,
                                  Constants.Tbl_Health_weightGainDiet);
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
                            }
                          },
                          Title: "Save",
                          color:
                              con_clr.ConClr2 ? ConClrBtntxt : ConClrSelected,
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
