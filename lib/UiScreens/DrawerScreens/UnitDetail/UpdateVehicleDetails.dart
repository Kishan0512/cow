// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/UnitDetail/UnitDetail.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_NetworkHelp.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:intl/intl.dart';

import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/DataBaseHelper/Con_List.dart';

class upadtevehicledetails extends StatefulWidget {
  Map Vehical;

  upadtevehicledetails(this.Vehical);

  @override
  State<upadtevehicledetails> createState() => _upadtevehicledetailsState();
}

class _upadtevehicledetailsState extends State<upadtevehicledetails> {
  TextEditingController starttime = TextEditingController(),
      endtime = TextEditingController(),
      startKM = TextEditingController(),
      endKM = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController outsideDCS = TextEditingController();
  String totaltime = "";
  double totalKM = 0;
  bool iskmvalid = false;
  String Regularvahicle = "yes";
  List<String> vehicalpurpose = [];
  List<String> Selectedcenter = [];
  List<String> SelecteDCS = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    date.text = DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime.parse(widget.Vehical['createdAt'].toString()));
    endtime.text = DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime.parse(DateTime.now().toIso8601String()));
    starttime.text = DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime.parse(widget.Vehical['StartDatetime'].toString()));
    DateTime one = DateTime.parse(DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime.parse(DateTime.now().toString())));
    DateTime two = DateTime.parse(DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime.parse(widget.Vehical['StartDatetime'])));
    startKM.text = widget.Vehical['StartUnit'].toString();
    Duration diff = one.difference(two);
    int hours = diff.inMinutes ~/ 60;
    int remainingMinutes = diff.inMinutes % 60;
    totaltime = "$hours.${remainingMinutes.toString().padLeft(2,'0')}";
    print(totaltime);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(
          () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return UnitDetailScreen();
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "Vehicle Registration",
          Actions: [],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return UnitDetailScreen();
              },
            ));
          },
        ),
        body: Stack(children: [
          Con_Wid.backgroundContainer(
              child: Con_Wid.fullContainer(
                  child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Con_Wid.Datepicker(date, "Select Date", context, "Date"),
                Con_Wid.paddingWithText("Start Time.", Conclrfontmain,
                    context: context),
                Con_Wid.onlyreadContainer(starttime.text),
                Con_Wid.paddingWithText("End Time.", Conclrfontmain,
                    context: context),
                Container(
                  height: 45,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8, right: 10, left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(
                      width: 2,
                      color: ConClrborderdrop,
                    ),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        Duration diff = DateTime.parse(endtime.text)
                            .difference(DateTime.parse(starttime.toString()));
                      });
                    },
                    readOnly: true,
                    controller: endtime,
                    style: Con_Wid.googleInterFont(),
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now())
                          .then((value) {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: false),
                              child: child!,
                            );
                          },
                        ).then((value1) {
                          endtime.text =
                              "${value!.year.toString()}-${value.month.toString().padLeft(2, "0")}-${value.day.toString().padLeft(2, "0")} ${value1!.hour.toString().padLeft(2, "0")}:${value1.minute.toString().padLeft(2, "0")}:00.000";
                          String s = endtime.text;
                          endtime.text = DateFormat("yyyy-MM-dd HH:mm:ss")
                              .format(DateTime.parse(endtime.text));
                          DateTime one = DateTime.parse(
                              DateFormat("yyyy-MM-dd HH:mm:ss")
                                  .format(DateTime.parse(endtime.text)));
                          DateTime two = DateTime.parse(DateFormat(
                                  "yyyy-MM-dd HH:mm:ss")
                              .format(DateTime.parse(
                                  widget.Vehical['StartDatetime'].toString())));
                          Duration diff = one.difference(two);
                          int hours = diff.inMinutes ~/ 60;
                          int remainingMinutes = diff.inMinutes % 60;
                          totaltime = "$hours.${remainingMinutes.toString().padLeft(2,'0')}";
                          setState(() {});
                        });
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 15),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "End Time",
                      hintStyle: Con_Wid.googleInterFont(),
                    ),
                  ),
                ),
                //todo
                Con_Wid.paddingWithText("Total Time.", Conclrfontmain,
                    context: context),
                Con_Wid.onlyreadContainer("${totaltime}"),

                Con_Wid.paddingWithText("Start K.M", Conclrfontmain,
                    context: context),
                Con_Wid.onlyreadContainer("${startKM.text}"),
                Con_Wid.textFieldWithInter(
                    Onchanged: (p0) {
                      var one = double.parse(startKM.text);
                      String r = p0.toString();
                      // String r = endKM.text;
                      var two = double.parse(r);
                      setState(() {
                        if (two < one) {
                          iskmvalid = true;
                          totalKM = 0.0;
                        } else {
                          iskmvalid = false;
                          totalKM = two - one;
                        }
                      });
                    },
                    eRror: iskmvalid ? "Please Enter Valid Value" : "",
                    text: "End K.M",
                    TextInput_Type: TextInputType.number,
                    controller: endKM,
                    hintText: "End K.M"),
                Con_Wid.paddingWithText(
                    "Total K.M", context: context, Conclrfontmain),
                Con_Wid.onlyreadContainer("${totalKM}"),
                CondropDown(
                  isMultiSelect: true,
                  title: "DCS",
                  itemList: Con_List.DcsList.map((e) => e['name'].toString())
                      .toList(),
                  SelectedList: SelecteDCS,
                  onSelected: (value) {
                    setState(() {
                      SelecteDCS = value;
                    });
                  },
                ),
                CondropDown(
                  title: "Center",
                  itemList: Con_List.CenterList.map((e) => e['Name'].toString())
                      .toList(),
                  SelectedList: Selectedcenter,
                  onSelected: (value) {
                    setState(() {
                      Selectedcenter = value;
                    });
                  },
                ),
                Con_Wid.textFieldWithInter(
                    controller: outsideDCS, hintText: "Outside Dcs"),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Con_Wid.selectionContainer(
                            text: "Reset",
                            context: context,
                            ontap: () {},
                            Color:
                                con_clr.ConClr2 ? ConClrLightBack : whiteColor,
                            textcolor:
                                con_clr.ConClr2 ? whiteColor : ConClrDialog,
                            height: 40,
                            width: 100)),
                    Con_Wid.div(),
                    Expanded(
                        child: Con_Wid.selectionContainer(
                            text: "Submit",
                            context: context,
                            ontap: () async {
                              setState(() {
                                loading = true;
                              });
                              print(loading);
                              if (endtime.text == "") {
                                Con_Wid.Con_Show_Toast(
                                    context, "Enter end time");
                                setState(() {
                                  loading = false;
                                });
                              } else if (totalKM.toString() == "0.0") {
                                Con_Wid.Con_Show_Toast(
                                    context, "Enter valid end K.M.");
                                setState(() {
                                  loading = false;
                                });
                              } else {
                                List<int> temp = [];
                                SelecteDCS.forEach((e) {
                                  String id = Con_List.DcsList.firstWhere(
                                          (element) =>
                                              element['name'] ==
                                              e.toString())['ID']
                                      .toString();
                                  temp.add(int.parse(id));
                                });

                                var r = double.parse(totaltime);
                                Map m = {
                                  "TotalUnit": totalKM.toInt(),
                                  "TotalTravelHr": r.toInt(),
                                  "EndDatetime": endtime.text,
                                  "EndUnit": int.parse(endKM.text),
                                  "EndLat": null,
                                  "EndLong": null,
                                };
                                // Map DATA = {
                                //   "Date": date.text,
                                //   "EndUnit": int.parse(endKM.text),
                                //   "FromTime": DateFormat("HH:mm")
                                //       .format(DateTime.parse(starttime.text)),
                                //   "ID": null,
                                //   "NoOfVisit": "0",
                                //   "Note": "none",
                                //   "Purpose": Con_List.M_Vehicle_purpose.where(
                                //           (element) =>
                                //               element.visitPurpose.toString() ==
                                //               widget.Vehical['PurposeName'])
                                //       .first
                                //       .iD,
                                //   "StartUnit": int.parse(
                                //       widget.Vehical['StartUnit'].toString()),
                                //   "ToTime": DateFormat("HH:mm")
                                //       .format(DateTime.parse(endtime.text)),
                                //   "TotalCost": null,
                                //   "TotalUnit": 0,
                                //   "UsedBy":
                                //       Constants_Usermast.user_id.toString(),
                                //   "centername": Selectedcenter[0],
                                //   "outsideDisc": outsideDCS.text,
                                //   "selectedLots": temp,
                                //   "vehicleNo": widget.Vehical['VehicleNo']
                                // };
                                Map outside = {
                                  "outsideDCS": outsideDCS.text,
                                  "givenDate": date.text,
                                  "unitDetailId": widget.Vehical['ID'],
                                  "id": "0"
                                };
                                Map INside = {
                                  "lotUnits": temp,
                                  "givenDate": date.text,
                                  "unitDetailId": widget.Vehical['ID'],
                                  "id": "0"
                                };
                                try {
                                  final vehicleres = await ApiCalling.createPost(
                                      '${AppUrl().vehicleUnitDetailsUpdate}/${widget.Vehical['ID']}',
                                      "Bearer ${Constants_Usermast.token}",
                                      m);
                                  if(outsideDCS.text == "")
                                    {
                                      final vehicleoutside =
                                      await ApiCalling.createPost(
                                          AppUrl().Get_OutsideDcs,
                                          "Bearer ${Constants_Usermast.token}",
                                          outside);
                                    }
                                  if(temp.isNotEmpty)
                                    {
                                      final vehicleINside =
                                      await ApiCalling.createPost(
                                          AppUrl().Get_InsideDcs,
                                          "Bearer ${Constants_Usermast.token}",
                                          INside);
                                    }



                                  // var response = await ApiCalling.createPut(
                                  //     AppUrl().GET_UNITCRUD+"/${widget.Vehical['ID']}",
                                  //     "Bearer ${Constants_Usermast.token}",
                                  //     DATA);
                                  Con_Wid.Con_Show_Toast(
                                      context, "Data insert successfully");
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return UnitDetailScreen();
                                    },
                                  ));
                                } catch (e) {
                                  print(e);
                                  Con_Wid.Con_Show_Toast(
                                      context, "Something went wrong");
                                }
                              }
                            },
                            Color: con_clr.ConClr2
                                ? ConClrbluelight
                                : ConClrDialog,
                            height: 40,
                            width: 100))
                  ],
                )
              ],
            ),
          ))),
          loading == true ?  Center(child: CircularProgressIndicator(),) : Container()
        ]),
      ),
    );
  }
}
