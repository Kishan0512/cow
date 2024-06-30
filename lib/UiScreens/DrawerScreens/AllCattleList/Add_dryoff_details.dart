import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Icons.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/MyCustomWidget.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../Model_local/Breeding_Dry.dart';
import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Database.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/ButtonState.dart';
import '../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../component/Gobal_Widgets/Con_Textstyle.dart';
import '../../../component/Gobal_Widgets/Con_Widget.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../../component/Gobal_Widgets/DatePicker.dart';
import '../../../model/Animal_Details_id.dart';
import '../../../model/Breeding_reproduction_id.dart';
import '../Action/Action.dart';
import '../Alarm/Alarm.dart';
import '../VisitRegistration/VisitRegistration.dart';
import 'CattleStatusTimeline.dart';

class Add_dryoff_details extends StatefulWidget {
  String? index;
  String? path;
  Add_dryoff_details({this.index,this.path});

  @override
  State<Add_dryoff_details> createState() => _Add_dryoff_detailsState();
}

class _Add_dryoff_detailsState extends State<Add_dryoff_details> {
  ButtonState stateTextWithIcon = ButtonState.idle;
  Color appbar = Color(0xFFF3C479);
  Color details = Color(0xFFFAD5A6);
  Color text = Color(0xFFE0B255);
  String TapToExpandIt = "Breeding details";
  bool isExpanded = true;
  Color butten = Color(0xFFF39A0A);
  Color butten1 = Color(0xB3F39A0A);

  String mStrFromdate = DateFormat('MM/dd/yyyy HH:mm').format(DateTime.now());
  bool botton1 = true;
  bool botton2 = false;
  bool botton3 = false;
  DateTime selectedDate = DateTime.now();
  String diff = "";
  TextEditingController Treatment = TextEditingController();
  List<String> DryofReason = [];
  List<String> mDryofReason = [];
  Animal_Details_id? Mdetail;
  var l_date;
  String last_date = "";
  String last_calv_date = "";
  String lat = '', long = '';
  late Duration difference;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    getList();
    getdata1();
    DateTime dateTime1 = DateTime.now();
    DateTime dateTime2 = Mdetail!.dryDate == null
        ? DateTime.parse(Mdetail!.dOB)
        : DateTime.parse(Mdetail!.dryDate);
    difference = dateTime1.difference(dateTime2);
  }

  getdata1() async {
    var box = await Hive.openBox<Breeding_Dry>("Dryoff_save");
    try {
      Constants.Last_id_dryoff = int.parse(box.keys.last.toString());
    } catch (e) {
      print(e);
      Constants.Last_id_dryoff = 0;
    }
  }

  getdata() async {
    if (Con_List.id_reproduction.isEmpty ||
        Con_List.M_status.isEmpty ||
        Con_List.M_dryOffReason.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_status);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_dryOffReason);
      Sync_Json.Get_Master_Data(Constants.Breeding_reproduction_id);
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    lat = position.latitude.toString();
    long = position.longitude.toString();
  }

  getList() {
    Mdetail = Con_List.id_Animal_Details
        .firstWhere((element) => element.tagId == widget.index.toString());
    for (int i = 0; i < Con_List.M_dryOffReason.length; i++) {
      DryofReason.add(Con_List.M_dryOffReason[i].name.toString());
    }
    Con_List.id_reproduction.forEach((element) {
      if (element.tagId.toString() == Mdetail!.tagId.toString()) {
        last_calv_date = element.dateOfCalving;
      }
    });
    if (l_date == "") {
    } else {
      if (l_date != null) {
        var formatter = new DateFormat('yyyy-MM-dd');
        last_date = formatter.format(DateTime.parse(l_date));
      }
    }
    setState(() {});
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        widget.path == "Action"
            ? Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return ActionScreen();
          },
        ))
            : widget.path == "Activity"
            ? Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return cattlestatustimeline(index: widget.index!);
          },
        ))
            : widget.path == "Alarm"
            ? Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return AlarmScreen();
          },
        ))
            : widget.path == "visitre"
            ? Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return VisitRegistrationScreen();
          },
        ))
            : null;
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Con_Wid.mIconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return cattlestatustimeline(index: widget.index!);
                  },
                ));
              },
              icon: Own_ArrowBack,
              color: Colors.black),
          centerTitle: true,
          elevation: 3,
          backgroundColor: appbar,
          title: Con_Wid.gText(
            "Dryoff Details",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(children: [
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: AnimatedContainer(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 0,
                  ),
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 5.0),
                  height: isExpanded ? 70 : 188,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(milliseconds: 1200),
                  decoration: BoxDecoration(
                    color: Color(0xFFF3C479),
                    borderRadius: BorderRadius.all(
                      Radius.circular(isExpanded ? 5 : 5),
                    ),
                  ),
                  child: ListView(children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Con_Wid.width(10),
                            Text(
                              "Animal.ID : ${Mdetail!.tagId}",
                              style: TextStyle(
                                color: fontBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_up,
                              color: Colors.white,
                              size: 27,
                            ),
                          ],
                        ),
                        AnimatedCrossFade(
                          firstChild: Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Farmer Name : ",
                                      style: ConStyle.Style_white_12_700w(
                                          fontBlackColor),
                                    ),
                                    Text("${Mdetail!.farmername}",
                                        style: ConStyle.Style_white_12_700w(
                                            fontBlackColor)),
                                    const Expanded(child: SizedBox()),
                                    Text(
                                      "Farmer Code : ",
                                      style: ConStyle.Style_white_12_700w(
                                          fontBlackColor),
                                    ),
                                    Text("${Mdetail!.farmer}",
                                        style: ConStyle.Style_white_12_700w(
                                            fontBlackColor)),
                                  ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Society Code :",
                                    style: ConStyle.Style_white_12_700w(
                                        fontBlackColor),
                                  ),
                                  Text("${Mdetail!.lot}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontBlackColor)),
                                  const Expanded(child: SizedBox()),
                                  Text(
                                    "Society Name :",
                                    style: ConStyle.Style_white_12_700w(
                                        fontBlackColor),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 20,
                                    width: 50,
                                    child: Text("${Mdetail!.lotname}",
                                        style: ConStyle.Style_white_12_700w(
                                            fontBlackColor)),
                                  )
                                ],
                              ),
                            ],
                          ),
                          secondChild: Column(children: [
                            Con_Wid.height(5),
                            const Divider(
                              height: 2,
                              thickness: 1,
                              color: Color(0xFFF39A0A),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Farmer Name : ",
                                    style: ConStyle.Style_white_12_700w(
                                        fontBlackColor),
                                  ),
                                  Text("${Mdetail!.farmername}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontBlackColor)),
                                  const Expanded(child: SizedBox()),
                                  Text(
                                    "Farmer Code : ",
                                    style: ConStyle.Style_white_12_700w(
                                        fontBlackColor),
                                  ),
                                  Text("${Mdetail!.farmer}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontBlackColor)),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Society Code :",
                                  style: ConStyle.Style_white_12_700w(
                                      fontBlackColor),
                                ),
                                Text("${Mdetail!.lot}",
                                    style: ConStyle.Style_white_12_700w(
                                        fontBlackColor)),
                                const Expanded(child: SizedBox()),
                                Text(
                                  "Society Name :",
                                  style: ConStyle.Style_white_12_700w(
                                      fontBlackColor),
                                ),
                                Text("${Mdetail!.lotname}",
                                    style: ConStyle.Style_white_12_700w(
                                        fontBlackColor))
                              ],
                            ),
                            Con_Wid.height(5),
                            const Divider(
                              height: 2,
                              thickness: 1,
                              color: Color(0xFFF39A0A),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                foregroundImage: AssetImage(
                                    "assets/images/${Mdetail!.speciesname.toString().toLowerCase()}${Mdetail!.statusname.toString().toLowerCase() == "null" ? "" : '-' + Mdetail!.statusname.toString().toLowerCase()}.webp"),
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    "${Mdetail!.calvingDate == null ? "Birth Date " : "Calving Date :"}   Repeat Heat ",
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black),
                                  ),
                                  Text(
                                    "    ${Mdetail!.statusname}",
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                " ${Mdetail!.calvingDate == null ? Mdetail!.dOB.toString().substring(0, 10) : Mdetail!.calvingDate.toString().substring(0, 10)}              0",
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.black),
                              ),
                            ),
                            const Divider(
                              height: 2,
                              thickness: 1,
                              color: Color(0xFFF39A0A),
                            ),
                            Row(
                              children: [
                                Con_Wid.width(5),
                                const Text(
                                  "Expected pregnancy Test",
                                  style: TextStyle(
                                      color: fontBlackColor, fontSize: 12),
                                ),
                                const Spacer(),
                                const Text(
                                  "April 06,2022",
                                  style: TextStyle(
                                      color: fontBlackColor, fontSize: 12),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                const Text(
                                  "-374Day(s),Left",
                                  style: TextStyle(
                                      color: fontBlackColor, fontSize: 12),
                                )
                              ],
                            ),
                            const Divider(
                              height: 2,
                              thickness: 1,
                              color: Color(0xFFF39A0A),
                            ),
                          ]),
                          crossFadeState: isExpanded
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: const Duration(milliseconds: 1200),
                          reverseDuration: Duration.zero,
                          sizeCurve: Curves.fastLinearToSlowEaseIn,
                        ),
                      ],
                    )
                  ]),
                ),
              ),
              Con_Wid.height(10),
              Container(
                  child: Column(
                children: [
                  Date_Picker(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: Mdetail!.dryDate == null
                                  ? DateTime.parse(Mdetail!.dOB)
                                  : DateTime.parse(Mdetail!.dryDate),
                              lastDate: DateTime.now())
                          .then((value) {
                        setState(() {
                          mStrFromdate = value.toString().substring(0, 10);
                        });
                      });
                    },
                    selectionColor: butten,
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      setState(() {
                        mStrFromdate = date.toString().substring(0, 10);
                      });
                    },
                    buttencolor: butten,
                  ),

                  Con_Wid.height(10),
                  CondropDown(
                    color1: text,
                    title: 'Select Dryoff Reason',
                    itemList: DryofReason,
                    SelectedList: mDryofReason,
                    onSelected: (List<String> value) {
                      setState(() {
                        mDryofReason.contains(value);
                        mDryofReason = value;
                      });
                    },
                  ),
                  Con_Wid.textFieldWithInter(
                      color1: text,
                      text: "Treatment",
                      controller: Treatment,
                      hintText: "Enter Treatment"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyCustomWidget(
                        Onchanged: () async {
                          if (mStrFromdate == "") {
                            Con_Wid.Con_Show_Toast(context, "Select Date");
                          } else if (Treatment.text.isEmpty) {
                            Con_Wid.Con_Show_Toast(context, "Enter Treatment");
                          } else if (mDryofReason == null) {
                            Con_Wid.Con_Show_Toast(context, "Select Reason");
                          } else {
                            try {
                              var box =
                                  await Hive.openBox<Breeding_reproduction_id>(
                                      "Breeding_reproduction_id");
                              final myobject = box.get(Mdetail!.id.toString());
                              if (myobject != null) {
                                myobject.SyncStatus = "0";
                                myobject.eNTRY = 'U';
                                myobject.pd2 = "3";
                                myobject.dateOfDry = "${mStrFromdate}";
                                myobject.dryReason = "${mDryofReason[0]}";
                                myobject.dryTreatment = "${Treatment.text}";
                                myobject.inseminatorStaff =
                                    "${Constants_Usermast.staff}";
                                await box.put(widget.index, myobject);
                              }
                            } catch (e) {
                              print("erore in update_Breeding_reproduction_id$e");
                            }
                            int i = 1213;
                            List<Breeding_Dry> Detail_dryoff = [
                              Breeding_Dry(
                                  id: Constants.Last_id_dryoff + 1,
                                  updatedAt: "",
                                  lastUpdatedByUser: 0,
                                  createdByUser: 0,
                                  createdAt: DateTime.now().toString(),
                                  details: "",
                                  DryDate: "${mStrFromdate}",
                                  DryReason:
                                      mDryofReason[0] == "Low Milk" ? 2 : 1,
                                  DryTreatment: "${Treatment.text}",
                                  ENTRY: "U",
                                  farmer: Mdetail!.farmer,
                                  herd: Mdetail!.herd,
                                  Lat: lat == "" ? "0.0" : lat,
                                  Long: long == "" ? "0.0" : long,
                                  lot: Mdetail!.lot,
                                  OrderNumber: "",
                                  OTP: 0,
                                  Staff: Constants_Usermast.staff,
                                  TagId: "${widget.index.toString()}",
                                  SyncStatus: "0",
                                  ServerId: "")
                            ];
                            Breeding_Dry rnd = Detail_dryoff[
                                math.Random().nextInt(Detail_dryoff.length)];
                            List<Map> weights_sync_datas = [];
                            weights_sync_datas.add(rnd.toJson(rnd));
                            SyncDB.insert_table(
                                weights_sync_datas, Constants.Tbl_Dry_off_save);
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
                                          widget.path == "Action"
                                              ? Navigator.pushReplacement(context, MaterialPageRoute(
                                            builder: (context) {
                                              return ActionScreen();
                                            },
                                          ))
                                              : widget.path == "Activity"
                                              ? Navigator.pushReplacement(context, MaterialPageRoute(
                                            builder: (context) {
                                              return cattlestatustimeline(index: widget.index!);
                                            },
                                          ))
                                              : widget.path == "Alarm"
                                              ? Navigator.pushReplacement(context, MaterialPageRoute(
                                            builder: (context) {
                                              return AlarmScreen();
                                            },
                                          ))
                                              : widget.path == "visitre"
                                              ? Navigator.pushReplacement(context, MaterialPageRoute(
                                            builder: (context) {
                                              return VisitRegistrationScreen();
                                            },
                                          ))
                                              : null;
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
                          //date difference between last activity and current activity
                        },
                        Title: "Save",
                        color: butten,
                        stateTextWithIcon: stateTextWithIcon),
                  )
                ],
              ))
            ]),
          ),
        ),
      ),
    );
  }
}
