import 'dart:math' as math;

import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herdmannew/Model_local/Milk_PD.dart';
import 'package:herdmannew/UiScreens/Dashboard/Dashboard.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/CattleStatusTimeline.dart';
import 'package:herdmannew/component/DataBaseHelper/Sync_Api.dart';
import 'package:hive/hive.dart';

import '../../../Model_local/Breeding_PD.dart';
import '../../../camera.dart';
import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Database.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/ButtonState.dart';
import '../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../component/Gobal_Widgets/Con_Textstyle.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../../component/Gobal_Widgets/Con_Widget.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../../component/Gobal_Widgets/DatePicker.dart';
import '../../../model/Animal_Details_id.dart';

class pdtestbymilk extends StatefulWidget {
  String? index;
  String? date;

  pdtestbymilk({this.index, this.date});

  @override
  State<pdtestbymilk> createState() => _pdtestbymilkState();
}

class _pdtestbymilkState extends State<pdtestbymilk> {
  ButtonState stateTextWithIcon = ButtonState.idle;
  String mStrFromdate = DateTime.now().toString();
  TextEditingController Qrvalue = TextEditingController();
  bool PDcheck = false;
  String dates = "",
      last_date = "",
      actual_date = "",
      l_date = "",
      diff = "",
      QRData = "";
  TextEditingController Ticketno = TextEditingController();
  List<String> PD1 = [],
      PD2 = [],
      Inseminator = [],
      mPD1 = [],
      mPD2 = [],
      mInseminator = [];
  Animal_Details_id? mDetails;
   late final connectivityResult ;
  bool isExpanded = true;
  String lat = '', long = '';
  late Duration difference;
  String ExHeatDate = "";
  String ExPDDate = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Ticketno.text = "100";
    getdata();
    getlist();
    getlastid();
    setState(() {});
  }

  getlastid() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<Breeding_PD>("Breeding_pd");

    try {
      Constants.Last_id_Breed_PD = int.parse(box.keys.last.toString());
    } catch (e) {
      Constants.Last_id_Breed_PD = 0;
    }
  }

  getdata() async {
    if (Con_List.M_sire.isEmpty ||
        Con_List.M_inseminator.isEmpty ||
        Con_List.M_status.isEmpty ||
        Con_List.M_Service.isEmpty ||
        Con_List.M_pd1.isEmpty ||
        Con_List.id_reproduction.isEmpty ||
        Con_List.M_pd2.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_sire);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_staff);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_status);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_service);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_pd1);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_pd2);
      Sync_Json.Get_Master_Data(Constants.Breeding_reproduction_id);
    }
    var box = await Hive.openBox<Milk_PDTest>("Milk_Pd_Test");
    try {
      Constants.Last_milk_PD = int.parse(box.keys.last.toString());
    } catch (e) {
      print(e);
      Constants.Last_milk_PD = 0;
    }
    if (Con_List.M_inseminator.where(
            (e) => e.id.toString() == Constants_Usermast.staff.toString())
        .isNotEmpty) {
      mInseminator.add(Con_List.M_inseminator.where(
              (e) => e.id.toString() == Constants_Usermast.staff.toString())
          .first
          .name
          .toString());
    }
    setState(() {});
  }

  getlist() async {
    mDetails = Con_List.id_Animal_Details
        .firstWhere((element) => element.tagId == widget.index.toString());
    Con_List.M_pd1.forEach((element) {
      PD1.add(element.name);
    });
    Con_List.M_pd2.forEach((element) {
      PD2.add(element.name);
    });
    Con_List.M_inseminator.forEach((element) {
      Inseminator.add(element.name);
    });
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    lat = position.latitude.toString();
    long = position.longitude.toString();

    setState(() {});
    if ('${mDetails!.breedingStatus}' == 'Open Bred' ||
        '${mDetails!.breedingStatus}' == 'Heifer Bred') {
      ExHeatDate = DateTime.parse(mDetails!.heatDate.toString())
          .add(Duration(days: 21))
          .toString();
      ExPDDate = DateTime.parse(mDetails!.heatDate.toString())
          .add(Duration(days: 90))
          .toString();
    }
    if ('${mDetails!.breedingStatus}' == 'Open Unbred') {
      ExHeatDate = DateTime.parse(mDetails!.calvingDate.toString())
          .add(Duration(days: 60))
          .toString();
    }
    if ('${mDetails!.breedingStatus}' == 'Pregnant' &&
        '${mDetails!.speciesname}' == 'Cow') {
      ExHeatDate = DateTime.parse(mDetails!.heatDate.toString())
          .add(Duration(days: 270))
          .toString();
    }
    if ('${mDetails!.breedingStatus}' == 'Pregnant' &&
        '${mDetails!.speciesname}' == 'Buffalo') {
      ExHeatDate = DateTime.parse(mDetails!.heatDate.toString())
          .add(Duration(days: 310))
          .toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(
              () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return cattlestatustimeline(index: widget.index!);
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "PD Test By Milk",
          Actions: [],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return cattlestatustimeline(index: widget.index!);
              },
            ));
          },
        ),
        body: Con_Wid.backgroundContainer(
            child: SingleChildScrollView(
          child: Column(
            children: [
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
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  height: isExpanded ? 70 : 188,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(milliseconds: 1200),
                  decoration: con_clr.ConClr2
                      ? BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: ConClrbluelight.withOpacity(0.5),
                              blurRadius: 20,
                              offset: Offset(5, 10),
                            ),
                          ],
                          gradient: LinearGradient(colors: ConClrAppbarGreadiant),
                        )
                      : BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: ConClrbluelight.withOpacity(0.5),
                            blurRadius: 20,
                            offset: Offset(5, 10),
                          ),
                        ], color: ConClrDialog),
                  child: ListView(children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Con_Wid.width(10),
                            Text(
                              "Animal.ID : ${mDetails!.tagId}",
                              style: TextStyle(
                                color: fontwhiteColor,
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
                                      "Farmer Code : ",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor),
                                    ),
                                    Text("${mDetails!.farmerCode}",
                                        style: ConStyle.Style_white_12_700w(
                                            fontwhiteColor)),
                                    const Expanded(child: SizedBox()),
                                    Text(
                                      "Farmer Name : ",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor),
                                    ),
                                    Text("${mDetails!.farmername}",
                                        style: ConStyle.Style_white_12_700w(
                                            fontwhiteColor)),
                                  ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Society Code :",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor),
                                  ),
                                  Text("${mDetails!.lotcode}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor)),
                                  const Expanded(child: SizedBox()),
                                  Text(
                                    "Society Name :",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 20,
                                    width: 50,
                                    child: Text("${mDetails!.lotname}",
                                        style: ConStyle.Style_white_12_700w(
                                            fontwhiteColor)),
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
                              color: ConClrLightBack2,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Con_Wid.gText(
                                    "Farmer Name : ",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor),
                                  ),
                                  Text("${mDetails!.farmername}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor)),
                                  const Expanded(child: SizedBox()),
                                  Con_Wid.gText(
                                    "Farmer Code : ",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor),
                                  ),
                                  Text("${mDetails!.farmer}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor)),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Con_Wid.gText(
                                  "Society Code :",
                                  style: ConStyle.Style_white_12_700w(
                                      fontwhiteColor),
                                ),
                                Text("${mDetails!.lot}",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor)),
                                const Expanded(child: SizedBox()),
                                Con_Wid.gText(
                                  "Society Name :",
                                  style: ConStyle.Style_white_12_700w(
                                      fontwhiteColor),
                                ),
                                Text("${mDetails!.lotname}",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor))
                              ],
                            ),
                            Con_Wid.height(5),
                            const Divider(
                              height: 2,
                              thickness: 1,
                              color: ConClrLightBack2,
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                foregroundImage: AssetImage(
                                    "assets/images/${mDetails!.speciesname.toString().toLowerCase()}${mDetails!.statusname.toString().toLowerCase() == "null" ? "" : '-' + mDetails!.statusname.toString().toLowerCase()}.webp"),
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    "${mDetails!.calvingDate == null || mDetails!.calvingDate == "" ? "Birth Date " : "Calving Date :"}   Repeat Heat ",
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                  Text(
                                    "    ${mDetails!.statusname}",
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.orange),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                " ${mDetails!.calvingDate == null || mDetails!.calvingDate == "" ? mDetails!.dOB.toString().substring(0, 10) : mDetails!.calvingDate.toString().substring(0, 10)}              0",
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                            const Divider(
                              height: 2,
                              thickness: 1,
                              color: ConClrDialog,
                            ),
                            Row(
                              children: [
                                Con_Wid.width(5),
                                const Text(
                                  "Expected Heat Date",
                                  style: TextStyle(
                                      color: fontBlackColor, fontSize: 12),
                                ),
                                const Spacer(),
                                Text(
                                  ExHeatDate == ""
                                      ? ""
                                      : "${ExHeatDate.substring(0, 10)}",
                                  style: TextStyle(
                                      color: fontBlackColor, fontSize: 12),
                                )
                              ],
                            ),
                            mDetails!.breedingStatus == "Open Bred"
                                ? Row(
                                    children: [
                                      Con_Wid.width(5),
                                      const Text(
                                        "Expected PD Date",
                                        style: TextStyle(
                                            color: fontBlackColor, fontSize: 12),
                                      ),
                                      const Spacer(),
                                      Text(
                                        ExPDDate == ""
                                            ? ""
                                            : "${ExPDDate.substring(0, 10)}",
                                        style: TextStyle(
                                            color: fontBlackColor, fontSize: 12),
                                      )
                                    ],
                                  )
                                : Container(),
                            Divider(
                              height: 2,
                              thickness: 1,
                              color: ConClrLightBack2,
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
              Con_Wid.fullContainer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Date_Picker(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: widget.date != ""
                                  ? DateTime.parse(widget.date.toString())
                                      .add(Duration(days: 1))
                                  : mDetails!.calvingDate == null
                                      ? DateTime.parse(mDetails!.dOB)
                                      : DateTime.parse(mDetails!.calvingDate),
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
                    selectionColor:
                        con_clr.ConClr2 ? ConClrborderdrop : whiteColor,
                    selectedTextColor: con_clr.ConClr2 ? BlackColor : BlackColor,
                    onDateChange: (value) {
                      setState(() {
                        mStrFromdate = value.toString();
                      });
                    },
                    buttencolor:
                        con_clr.ConClr2 ? ConClrborderdrop : ConClrDialog,
                  ),
                  Con_Wid.height(10),
                  CondropDown(
                    title: 'Select Inseminator',
                    itemList: Inseminator,
                    SelectedList: mInseminator,
                    onSelected: (List<String> value) {
                      setState(() {
                        mInseminator = value;
                      });
                    },
                  ),
                  QRData != ""
                      ? Con_Wid.textFieldWithInter(
                          controller: Qrvalue, hintText: "", readonly: true)
                      : Container(),
                  Con_Wid.height(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedButton(
                        height: 40,
                        width: 150,
                        child: Text(
                          'Scan BarCode',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () async {
                          var qrResult = await BarcodeScanner.scan();
                          QRData = qrResult.rawContent;
                          Qrvalue.text = QRData;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Con_Wid.height(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedButton(
                          height: 40,
                          width: 100,
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () {
                            if (mInseminator.isEmpty) {
                              Con_Wid.Con_Show_Toast(
                                  context, "Select Inseminater");
                            } else if (QRData == "") {
                              Con_Wid.Con_Show_Toast(context, "Scan BarCode");
                            } else  {
                              List<Milk_PDTest> milkpd = [
                                Milk_PDTest(
                                    id: Constants.Last_milk_PD + 1,
                                    HeatDate: mDetails!.heatDate.toString(),
                                    testDate: mStrFromdate,
                                    TagId: widget.index,
                                    AIT: Con_List.M_inseminator.where((element) =>
                                        element.name ==
                                        mInseminator[0].toString()).first.id,
                                    QRCodeResult: QRData,
                                    Note: "1245",
                                    createdByUser: Constants_Usermast.user_id,
                                    SyncStatus: "0")
                              ];
                               if (connectivityResult == ConnectivityResult.mobile ||
                                    connectivityResult == ConnectivityResult.wifi) {
                                 Sync_Api.insert_Api(note: {}, pStrTableName: "Milk_Pd_Test", NoteList: milkpd.map((e) => Milk_PDTest.toJson1(e)).toList()).then((value){
                                   if(value.toString().contains("200") )
                                     {
                                   showDialog(context: context, builder: (context) {
                                     return Material(
                                       child: Container(
                                         width: MediaQuery.of(context).size.width,
                                         height: MediaQuery.of(context).size.height - kToolbarHeight,
                                         child: Column(children: [
                                           Container(
                                               margin: EdgeInsets.only(
                                                   bottom: 20, top: MediaQuery.of(context).size.height / 10),
                                               width: MediaQuery.of(context).size.width / 2.9,
                                               height: MediaQuery.of(context).size.height / 3.9 - kToolbarHeight,
                                               child: Image.asset("assets/images/check1.gif")
                                           ),
                                           Container(
                                               alignment: Alignment.center,
                                               width: MediaQuery.of(context).size.width / 1.5,
                                               child: const Text("Pd Test By MIlk\nSuccessfully",
                                                 style: TextStyle(
                                                   color: fontBlackColor,
                                                   fontSize: 18,
                                                   fontWeight: FontWeight.bold,
                                                 ),textAlign: TextAlign.center,)
                                           ),
                                           Container(
                                             margin: const EdgeInsets.only(top: 10),
                                             alignment: Alignment.center,
                                             width: MediaQuery.of(context).size.width / 2,
                                             child: Text(DateTime.now().toString().substring(0, 10),
                                                 style: ConStyle.style_white_18s_600w()),
                                           ),
                                           Container(
                                             padding: EdgeInsets.all(10),
                                             margin: EdgeInsetsDirectional.only(top: 30),
                                             height: MediaQuery.of(context).size.height / 2.7,
                                             width: MediaQuery.of(context).size.width / 1.2,
                                             decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.all(Radius.circular(10)),
                                                 border: Border.all(color: Colors.grey, width: 1)),
                                             child:
                                             Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                               Expanded(
                                                 flex: 2,
                                                 child: Container(
                                                     alignment: Alignment.center,
                                                     width: MediaQuery.of(context).size.width / 1.2,
                                                     height: MediaQuery.of(context).size.height / 10,
                                                     decoration: const BoxDecoration(
                                                         border: Border(
                                                             bottom: BorderSide(width: 1, color: Colors.grey))),
                                                     child:  Text(
                                                         "Order No : ${value.toString().substring(3,value.toString().length)}",
                                                         style: ConStyle.Style_white_13s_700w(Colors.black))
                                                 ),
                                               ),
                                               Expanded(
                                                 flex: 5,
                                                 child: Text("TagID \n $QRData",textAlign: TextAlign.center,style: TextStyle(fontSize: 18)),
                                               ),
                                             ]),
                                           ),
                                           SizedBox(
                                             height: 20,
                                           ),
                                           InkWell(
                                             onTap: () {
                                               setState(() {});
                                               Navigator.pushReplacement(context,
                                                   MaterialPageRoute(
                                                     builder: (context) {
                                                       return DashBoardScreen();
                                                     },
                                                   ));
                                             },
                                             child: Container(
                                               alignment: Alignment.center,
                                               decoration: BoxDecoration(
                                                   border: Border.all(width: 1, color: Colors.grey),
                                                   borderRadius: BorderRadius.circular(10)),
                                               height: MediaQuery.of(context).size.height / 20,
                                               width: MediaQuery.of(context).size.width / 5,
                                               child: Text("Got it"),
                                             ),
                                           ),
                                         ]),
                                       ),
                                     );
                                   },);}
                                 });
                               }else{
                               Milk_PDTest rnd =
                                  milkpd[math.Random().nextInt(milkpd.length)];
                              List<Map> weights_sync_datas = [];
                              weights_sync_datas.add(rnd.toJson(rnd));
                              SyncDB.insert_table(
                                  weights_sync_datas, Constants.Tbl_Milk_Pd);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return cattlestatustimeline(
                                      index: widget.index!);
                                },
                              ));
                            }}
                          }),
                      Con_Wid.width(20),
                      AnimatedButton(
                        color: Colors.grey,
                        height: 40,
                        width: 100,
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return cattlestatustimeline(index: widget.index!);
                            },
                          ));
                        },
                      ),
                    ],
                  )
                ],
              ))
            ],
          ),
        )),
      ),
    );
  }
}
