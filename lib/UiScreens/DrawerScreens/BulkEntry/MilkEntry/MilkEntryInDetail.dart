import 'dart:convert';
import 'dart:core';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/BulkEntry/MilkEntry/MilkEntry.dart';
import 'package:herdmannew/component/DataBaseHelper/Con_List.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/component/Gobal_Widgets/Constants.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../../../component/DataBaseHelper/Sync_Api.dart';
import '../../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../../component/Gobal_Widgets/ButtonState.dart';
import '../../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../../component/Gobal_Widgets/DatePicker.dart';
import '../../../../component/Gobal_Widgets/MyCustomWidget.dart';
import '../../../../model/Milk_production_id.dart';
import '../BulkEntry.dart';

class MilkEntryInDetail extends StatefulWidget {
  String pListSocietycode;
  String pStrFarmerid;

  MilkEntryInDetail(
      {required this.pListSocietycode, required this.pStrFarmerid});

  @override
  State<MilkEntryInDetail> createState() => _MilkEntryInDetailState();
}

class _MilkEntryInDetailState extends State<MilkEntryInDetail> {
  ButtonState stateTextWithIcon = ButtonState.idle;
  List<TextEditingController> _mor_controllers = [];
  List<TextEditingController> _eve_controllers = [];
  List<TextEditingController> _tot_controllers = [];
  List<Milk_production_id> filteredMilkProduction = [];
  String mStrFromdate = "";
  String lat = "", long = "", Lactation_Total = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mStrFromdate = DateTime.now().toString().substring(0, 10);
    getdata(mStrFromdate);
  }

  getdata(String mStrFromdate) async {
    if (Con_List.id_Animal_Details.isEmpty ||
        Con_List.id_Milk_production.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Animal_Details_id);
      Sync_Json.Get_Master_Data(Constants.Tbl_Milk_production);
    }
    var box = await Hive.openBox<Milk_production_id>("Milk_production_id");
    try {
      Constants.Last_id_milk = int.parse(box.keys.last.toString());
    } catch (e) {
      print(e);
      Constants.Last_id_milk = 0;
    }

    try {
      setState(() {
        if (widget.pStrFarmerid.isNotEmpty) {
          print("hello");
          setState(() {
            filteredMilkProduction = Con_List.id_Milk_production
                .where((milk) => Con_List.id_Animal_Details
                    .where((animal) =>
                        animal.lot.toString() == widget.pListSocietycode &&
                        animal.farmer.toString() == widget.pStrFarmerid &&
                        [4, 5].contains(animal.status) &&
                        (animal.disposalFlag == 'null' ||
                            animal.disposalFlag == '0' ||
                            animal.disposalFlag == null))
                    .map((animal) => animal.tagId.toString())
                    .toList()
                    .contains(milk.tagId.toString()))
                .toList();
          });
        } else {
          setState(() {
            filteredMilkProduction = Con_List.id_Milk_production
                .where((milk) => Con_List.id_Animal_Details
                    .where((animal) =>
                        animal.lot.toString() == widget.pListSocietycode &&
                        [4, 5].contains(animal.status) &&
                        (animal.disposalFlag == 'null' ||
                            animal.disposalFlag == '0' ||
                            animal.disposalFlag == null))
                    .map((animal) => animal.tagId.toString())
                    .toList()
                    .contains(milk.tagId.toString()))
                .toList();
          });
        }
        // filteredMilkProduction = Con_List.id_Milk_production
        //     .where((milk) =>
        //         Con_List.id_Animal_Details
        //             .where((animal) => animal.lot.toString() ==
        //                         widget.pListSocietycode &&
        //                     animal.farmer.toString() == widget.pStrFarmerid &&
        //                     [4, 5].contains(animal.status) &&
        //                     (animal.disposalFlag == 'null' ||
        //                         animal.disposalFlag == '0' ||
        //                         animal.disposalFlag == null) &&
        //                     animal.calvingDate != null
        //                 ? DateFormat('yyyy-mm-dd')
        //                     .parse(
        //                         animal.calvingDate.toString().substring(0, 10))
        //                     .isBefore(
        //                         DateFormat('yyyy-mm-dd').parse(mStrFromdate))
        //                 : false)
        //             .map((animal) => animal.tagId.toString())
        //             .toList()
        //             .contains(milk.tagId.toString()) &&
        //         milk.date.toString().substring(0, 10) == mStrFromdate)
        //     .toList();
      });
    } catch (e) {}
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    lat = position.latitude.toString();
    long = position.longitude.toString();
  }

  Widget build(BuildContext context) {
    Con_List.id_Milk_production.forEach((element) {});
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
                return MilkEntry();
              },
            ));
          },
        ),
        body: Con_Wid.backgroundContainer(
          child: Con_Wid.fullContainer(
              child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Con_Wid.popinsfont(
                    "Date : ", Conclrfontmain, FontWeight.w600, 13, context),
                Con_Wid.popinsfont(
                    "${mStrFromdate}",
                    con_clr.ConClr2 ? ConClrMain : BlackColor,
                    FontWeight.w600,
                    13,
                    context),
              ],
            ),
            Date_Picker(
              onDateChange: (date) {
                setState(() {
                  mStrFromdate = date.toString().substring(0, 10);
                  getdata(mStrFromdate);
                });
              },
              selectionColor: con_clr.ConClr2 ? ConClrLightBack : whiteColor,
              selectedTextColor: con_clr.ConClr2 ? whiteColor : BlackColor,
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime.now())
                    .then((value) {
                  setState(() {
                    mStrFromdate = value.toString().substring(0, 10);
                    getdata(mStrFromdate);
                  });
                });
              },
              buttencolor: con_clr.ConClr2 ? ConClrLightBack : ConClrDialog,
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 50,
                  color: con_clr.ConClr2 ? ConClrMain : ConClrDialog,
                  child: Row(children: [
                    Con_Wid.width(10),
                    Expanded(
                        flex: 2,
                        child: Con_Wid.popinsfont("ID", fontwhiteColor,
                            FontWeight.w600, 10, context)),
                    Expanded(
                        child: Con_Wid.popinsfont("Morning", fontwhiteColor,
                            FontWeight.w600, 10, context)),
                    Expanded(
                        child: Con_Wid.popinsfont("Evening", fontwhiteColor,
                            FontWeight.w600, 10, context)),
                    Expanded(
                        child: Con_Wid.popinsfont("Total(kg)", fontwhiteColor,
                            FontWeight.w600, 10, context)),
                  ]),
                ))
              ],
            ),
            Con_Wid.height(2),
            Expanded(
              child: Container(
                color: ConClrLightBack1,
                child: ListView.separated(
                  itemCount: filteredMilkProduction.length,
                  itemBuilder: (context, index) {
                    _mor_controllers.add(TextEditingController(
                        text: (filteredMilkProduction[index].morningYield !=
                                    null &&
                                filteredMilkProduction[index]
                                        .morningYield
                                        .toString() !=
                                    "null")
                            ? filteredMilkProduction[index]
                                .morningYield
                                .toString()
                            : "0"));
                    _eve_controllers.add(TextEditingController(
                        text: (filteredMilkProduction[index].eveningYield !=
                                    null &&
                                filteredMilkProduction[index]
                                        .eveningYield
                                        .toString() !=
                                    "null")
                            ? filteredMilkProduction[index]
                                .eveningYield
                                .toString()
                            : "0"));
                    _tot_controllers.add(TextEditingController(
                        text: filteredMilkProduction[index]
                                    .dayMilkTotal
                                    .toString() !=
                                "null"
                            ? filteredMilkProduction[index]
                                .dayMilkTotal
                                .toString()
                            : "0"));

                    return Row(
                      children: <Widget>[
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(top: 1.0, left: 5),
                          child: Con_Wid.popinsfont(
                              "${filteredMilkProduction[index].tagId}",
                              Conclrfontmain,
                              FontWeight.w600,
                              9,
                              context),
                        )),
                        Expanded(
                          child: Container(
                            height: 35,
                            margin:
                                const EdgeInsets.only(left: 5.0, right: 10.0),
                            child: TextField(
                              controller: _mor_controllers[index],
                              onChanged: (m1_value) {
                                _tot_controllers[index].text = (double.parse(
                                            _eve_controllers[index].text) +
                                        double.parse(
                                            _mor_controllers[index].text))
                                    .toString();
                              },
                              autofocus: false,
                              cursorColor: fontwhiteColor,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: ConClrMain,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                hintText: '',
                                fillColor: ConClrMainLight,
                                filled: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: con_clr.ConClr2
                                            ? ConClrGryBtn
                                            : ConClrDialog)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 35,
                            margin:
                                const EdgeInsets.only(left: 5.0, right: 10.0),
                            child: TextField(
                              controller: _eve_controllers[index],
                              onChanged: (e1_value) {
                                if (e1_value.isNotEmpty) {
                                  _tot_controllers[index].text = (double.parse(
                                              _eve_controllers[index]
                                                  .text
                                                  .toString()) +
                                          double.parse(_mor_controllers[index]
                                              .text
                                              .toString()))
                                      .toString();
                                }
                              },
                              autofocus: false,
                              cursorColor: fontwhiteColor,
                              //controller: e1,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: ConClrMain,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                hintText: '',
                                fillColor: ConClrMainLight,
                                filled: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: con_clr.ConClr2
                                            ? ConClrGryBtn
                                            : ConClrDialog)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 35,
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: TextField(
                              controller: _tot_controllers[index],
                              autofocus: false,
                              cursorColor: fontwhiteColor,
                              //controller: t1,
                              style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: fontwhiteColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                hintText: '',
                                fillColor: ConClrbluelight,
                                filled: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: con_clr.ConClr2
                                            ? ConClrGryBtn
                                            : whiteColor)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                ),
              ),
            ),
            Con_Wid.height(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyCustomWidget(
                    Onchanged: () {
                      String dateDifference = "";
                      for (int index = 0;
                          index < filteredMilkProduction.length;
                          index++) {
                        String LastMilk = filteredMilkProduction[index]
                            .dayMilkTotal
                            .toString();
                        if (mStrFromdate != null) {
                          DateTime first_date = DateTime.parse(
                              filteredMilkProduction[index].date.toString());
                          final date1 = DateTime(first_date.year,
                              first_date.month, first_date.day);
                          final date2 = DateTime.parse(
                              Con_Wid.change_date_format(mStrFromdate));
                          final difference = date2.difference(date1).inDays;
                          dateDifference = difference.toString();

                          int? diff = int.tryParse(dateDifference);
                          if (diff != null) {
                            double? lastMilk = double.tryParse(LastMilk);
                            double? currentMilk =
                                double.tryParse(_tot_controllers[index].text);
                            if (lastMilk != null && currentMilk != null) {
                              if (diff <= 30) {
                                double lac_tot =
                                    (lastMilk + currentMilk) / 2 * diff;
                                Lactation_Total = lac_tot.toString();
                              } else {
                                double lac_tot =
                                    (lastMilk + currentMilk) / 2 * 30;
                                Lactation_Total = lac_tot.toString();
                              }
                            }
                          } else {
                            String maxDateCalvingDetails =
                                filteredMilkProduction[index].date.toString();
                            maxDateCalvingDetails =
                                maxDateCalvingDetails.replaceAll('(', "");
                            maxDateCalvingDetails =
                                maxDateCalvingDetails.replaceAll(')', "");
                            var formatter2 = new DateFormat('yyyy-MM-dd');
                            maxDateCalvingDetails = formatter2
                                .format(DateTime.parse(maxDateCalvingDetails));
                            DateTime first_date =
                                DateTime.parse(maxDateCalvingDetails);
                            final date1 = DateTime(first_date.year,
                                first_date.month, first_date.day);

                            final date2 = DateTime.parse(
                                Con_Wid.change_date_format(mStrFromdate));
                            final difference = date2.difference(date1).inDays;

                            dateDifference = difference.toString();
                            int? diff = int.tryParse(dateDifference);
                            if (diff != null) {
                              if (diff <= 30) {
                                double lac_tot = ((double.parse(LastMilk)) +
                                        double.parse(
                                            _tot_controllers[index].text)) /
                                    2 *
                                    diff;
                                Lactation_Total = lac_tot.toString();
                              } else {
                                double lac_tot = ((double.parse(LastMilk)) +
                                        double.parse(
                                            _tot_controllers[index].text)) /
                                    2 *
                                    30;
                                Lactation_Total = lac_tot.toString();
                              }
                            }
                          }
                          setState(() {});
                          List<dynamic> demo =[{
                      "tagId": filteredMilkProduction[index].tagId,
                      "inputDate":mStrFromdate,
                      "parity":filteredMilkProduction[index].parity,
                      "morningYield":_mor_controllers[index].text != ""
                          ? _mor_controllers[index].text
                          : null,
                      "eveningYield":_eve_controllers[index].text != ""
                          ? _eve_controllers[index].text
                          : null,
                      "nightYield":null,
                      "midnightYield":null,
                      "fat":null,
                      "snf":null,
                      "lactose":null,
                      "protein":null,
                      "officialMilk":null,
                      "createdAt":DateTime.now().toString().substring(0,10),
                      // "createdByUser":Constants_Usermast.user_id.toString()
                       }];
                          print(demo.toString());
                          // List<Milk_production_id> prod = [
                          //   Milk_production_id(
                          //       tagId: filteredMilkProduction[index].tagId,
                          //       date: mStrFromdate,
                          //       parity: filteredMilkProduction[index].parity,
                          //       morningYield: _mor_controllers[index].text != ""
                          //           ? _mor_controllers[index].text
                          //           : null,
                          //       eveningYield: _eve_controllers[index].text != ""
                          //           ? _eve_controllers[index].text
                          //           : null,
                          //       nightYield: null,
                          //       midnightYield: null,
                          //       fat: null,
                          //       snf: null,
                          //       lactose: null,
                          //       protein: null,
                          //       fatC: null,
                          //       snfC: null,
                          //       lactoseC: null,
                          //       proteinC: null,
                          //       cumulativeMilkTotal: null,
                          //       lactationMilkTotal: Lactation_Total,
                          //       daysCount: dateDifference,
                          //       officialMilk: null,
                          //       lat: lat,
                          //       long: long,
                          //       dayMilkTotal: _tot_controllers[index].text != ""
                          //           ? _tot_controllers[index].text
                          //           : null,
                          //       details: null,
                          //       id: Constants.Last_id_milk + index + 1,
                          //       herd: null,
                          //       lot: null,
                          //       farmer: null,
                          //       boxno: null,
                          //       bottleno: null,
                          //       staff: null,
                          //       serverID: null,
                          //       clientID: null,
                          //       SyncStatus: "0")
                          //   Milk_production_id(
                          //       tagId: filteredMilkProduction[index].tagId,
                          //       date: mStrFromdate,
                          //       parity: filteredMilkProduction[index].parity,
                          //       morningYield: _mor_controllers[index].text != ""
                          //           ? _mor_controllers[index].text
                          //           : null,
                          //       eveningYield: _eve_controllers[index].text != ""
                          //           ? _eve_controllers[index].text
                          //           : null,
                          //       nightYield: null,
                          //       midnightYield: null,
                          //       fat: null,
                          //       snf: null,
                          //       lactose: null,
                          //       protein: null,
                          //       fatC: null,
                          //       snfC: null,
                          //       lactoseC: null,
                          //       proteinC: null,
                          //       cumulativeMilkTotal: null,
                          //       lactationMilkTotal: Lactation_Total,
                          //       daysCount: dateDifference,
                          //       officialMilk: null,
                          //       lat: lat,
                          //       long: long,
                          //       dayMilkTotal: _tot_controllers[index].text != ""
                          //           ? _tot_controllers[index].text
                          //           : null,
                          //       details: null,
                          //       id: Constants.Last_id_milk + index + 1,
                          //       herd: null,
                          //       lot: null,
                          //       farmer: null,
                          //       boxno: null,
                          //       bottleno: null,
                          //       staff: null,
                          //       serverID: null,
                          //       clientID: null,
                          //       SyncStatus: "0")
                          // ];
                          // Milk_production_id prods =
                          //     prod[math.Random().nextInt(prod.length)];
                          // List<Map> weights_sync_datas = [];
                          // weights_sync_datas.add(prods.toJson(prods));

                          switch (stateTextWithIcon) {
                            case ButtonState.idle:
                              stateTextWithIcon = ButtonState.loading;
                              Future.delayed(
                                Duration(seconds: 3),
                                () async {
                                  var m = {'production': jsonEncode(demo)};
                                  var response = await ApiCalling.createPost(
                                      "https://dudhsagar.herdman.in/v1/api/web/milk/save-milk-entry",
                                      "Bearer " + Constants_Usermast.token.toString(),
                                      demo[0]);
                                  print(response.statusCode);
                                  print(response.body);
                                  Sync_Api.showNotification(tital: "Bulk Milk Entry Done", body: "");
                                  // await SyncDB.insert_table(weights_sync_datas,
                                  //     Constants.Milk_production_id);
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
                          // SyncDB.insert_table(weights_sync_datas,
                          //     Constants.Tbl_Health_vaccination);
                        }

                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return BulkEntryScreen();
                          },
                        ));
                      }
                    },
                    Title: "Save",
                    color: con_clr.ConClr2 ? ConClrBtntxt : ConClrDialog,
                    stateTextWithIcon: stateTextWithIcon)
              ],
            )
          ])),
        ),
      ),
    );
  }
}
