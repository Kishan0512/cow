// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herdmannew/UiScreens/Dashboard/visit_request.dart';
import 'package:herdmannew/UiScreens/DrawerWidget.dart';
import 'package:herdmannew/component/DataBaseHelper/Sync_Json.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/component/Gobal_Widgets/tost.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../component/DataBaseHelper/Con_List.dart';
import '../../component/DataBaseHelper/LotTransfer.dart';
import '../../component/DataBaseHelper/Sync_Database.dart';
import '../../component/DataBaseHelper/Sync_firebase.dart';
import '../../component/Gobal_Widgets/Con_Color.dart';
import '../../component/Gobal_Widgets/Con_Icons.dart';
import '../../component/Gobal_Widgets/Con_Textstyle.dart';
import '../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../component/Gobal_Widgets/Constants.dart';
import '../../main.dart';
import '../../temp.dart';
import '../DrawerScreens/VisitRegistration/VisitRegistration.dart';
import '../FloatingButton/CattleRegistrationScreen.dart';

class DashBoardScreen extends StatefulWidget {
  //const DashBoardScreen({Key? key}) : super(key: key);
  String? onetime;

  DashBoardScreen({this.onetime});

  static var mCampare = [];
  static int onrtime = 0;

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final pdf = pw.Document();
  var mStrFromdate = DateTime.now().toString().substring(0, 10);
  var mStrtodate = DateTime.now().toString().substring(0, 10);
  List reportInfo = [
    "Heat / AI",
    "Heifer Heat / AI",
    "PD",
    "Calving",
    "Dry Off",
    "Vaccination",
    "De Worming"
  ];
  List<MilkingDetail> mStrMlkDetTitle = [];
  late final AnimationController _controller;
  late final Animation<double> _rotationAnimation;
  List<dynamic> mWorkDone = [];
  List<dynamic> Activity_Done = [];
  List<dynamic> Terated_Done = [];
  List<dynamic> Dispose_Done = [];
  List<dynamic> MIlking_done = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getVisit();
    Ges();
    Sync_Firebase();
    Con_List.Getalldata.forEach((element) {
      Sync_Json.Get_Master_Data(element);
    });
    if (Con_List.Br_insemination.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Br_insemination);
    } else if (Con_List.A_Treatment.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Health_treatment);
    } else if (Con_List.AllActionList.isEmpty) {
      SyncDB.GetActionDetails(Constants_Usermast.staff);
    }

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    //get_data();
    milkingrecord();
    Workdonedetail();

    if (Constants_Usermast.groupId == 9 || Constants_Usermast.groupId == 4) {
      Draweritem.FinalDraweritem = Draweritem.first;
    } else if (Constants_Usermast.groupId == 5 ||
        Constants_Usermast.groupId == 6 ||
        Constants_Usermast.groupId == 20 ||
        Constants_Usermast.groupId == 24 ||
        Constants_Usermast.groupId == 8) {
      Draweritem.FinalDraweritem = Draweritem.second;
    } else if (Constants_Usermast.groupId == 22) {
      Draweritem.FinalDraweritem = Draweritem.third;
    } else if (Constants_Usermast.groupId == 12) {
      Draweritem.FinalDraweritem = Draweritem.fourth;
    } else if (Constants_Usermast.groupId == 32 ||
        Constants_Usermast.groupId == 34) {
      Draweritem.FinalDraweritem = Draweritem.fifth32;
    } else if (Constants_Usermast.groupId == 16) {
      Draweritem.FinalDraweritem = Draweritem.six;
    } else if (Constants_Usermast.groupId == 2) {
      Draweritem.FinalDraweritem = Draweritem.seven;
    }

    Con_List.M_Farmer.sort(
      (a, b) => a.code.toString().compareTo(b.code.toString()),
    );

    setState(() {});
  }
  getVisit() async {
   Timer.periodic(Duration(seconds: 20), (timer) async {
     final res = await http.get(Uri.parse(AppUrl().getNonSyncedVisits), headers: {
       'authorization': "Bearer " + Constants_Usermast.token,
       "Accept": "application/json"
     });
     if(res.statusCode==200) {
      Map data = jsonDecode(res.body);
      List<dynamic> temp = data['data'];
       if(temp.any((element) => element['Status'] == "Pending"))
         {
           showToast(temp[0]);
       await SyncDB.SyncTable("VISITREGISTRATION", true);

     }
     }
   });
  }
  Ges() async {
    final Response = await http
        .get(Uri.parse("http://worldtimeapi.org/api/timezone/Asia/Kolkata"));
    String s = jsonDecode(Response.body)['datetime'];
    String globle =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(s).toLocal());
    String local = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    DateTime endTime = DateTime.parse(local);
    DateTime startTime = DateTime.parse(globle);

    int difference = endTime.difference(startTime).inMinutes;
    if (difference > 2) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                "Your device time is $difference minutes behind please set your device on time"),
          actions: [ElevatedButton(onPressed: () {
            Navigator.pop(context);
          }, child: const Text("OK"))],
          );
        },
      );

    }else if (difference < 0) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                "Your device time is $difference minutes Ahead please set your device on time"),
            actions: [ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Text("OK"))],
          );
        },
      );
    }
    var Response1 = await ApiCalling.getdata(
        AppUrl().GET_CENTER + Constants_Usermast.company,
        Constants_Usermast.token);
    Con_List.CenterList = jsonDecode(Response1.body);

    var Response2 = await ApiCalling.getdata(
        AppUrl().GET_DCS,
        Constants_Usermast.token);

    Con_List.DcsList = jsonDecode(Response2.body);

    setState(() {});
  }

  get_data() async {
    await SyncDB.loadallData();
  }

  _getAnimalsByRouteNew() async {
    {
      String societyData = "1571";
      var body = {
        "lotId": societyData,
      };
      final res = await ApiCalling.createPost(AppUrl().animalDataDcsViseNew,
          "Bearer " + Constants_Usermast.token.toString(), body);
      if (res.statusCode == 200) {
        var animalsData = json.decode(res.body);
        var animals;
        animals = animalsData['details'];
        if (animals.length > 0) {
          SyncDB.SyncTable(Constants.API_ANIMAL_DATA, true, animals);
        }
      }
    }
  }

  milkingrecord() {
    setState(() {
      String milk_anim = Con_List.id_Animal_Details
          .where((e) => e.status == 4 || e.status == 5)
          .toList()
          .length
          .toString();
      String Milk_reco = Con_List.id_Milk_production
          .where((e) =>
              e.date.toString().split("T").first ==
              DateTime.now().toString().substring(0, 10))
          .length
          .toString();

      mStrMlkDetTitle
          .add(MilkingDetail(Title: 'Milking Animals', Count: milk_anim));
      mStrMlkDetTitle
          .add(MilkingDetail(Title: 'Milking Recorded', Count: Milk_reco));
    });
  }

  @override
  Widget build(BuildContext context) {
    milkingrecord();
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future(() => true);
      },
      child: SafeArea(
        child: Scaffold(
          key: _globalKey,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            flexibleSpace: Con_Wid.appBarColor(),
            leading: Con_Wid.mIconButton(
                onPressed: () {
                  _globalKey.currentState?.openDrawer();
                },
                icon: Own_menu),
            title: Con_Wid.gText(
              "Daily Report",
              style: ConStyle.Style_white_16s_700w(),
            ),
            actions: [
              AppUrl.CheckNewUrl.value
                  ? InkWell(
                      onTap: () {
                        _controller
                          ..forward()
                          ..repeat();
                        LotTransfer.Sync_Lot(
                                context, Constants_Usermast.user_id, "0")
                            .then((value) => _controller.reset());
                        setState(() {});
                      },
                      child: RotationTransition(
                        turns: _rotationAnimation,
                        child: const Icon(Icons.refresh, size: 30),
                      ),
                    )
                  : Container(),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return visit_request();
                    },
                  ));
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 45,
                  width: 45,
                  child: Image.asset("assets/images/profile.webp",
                      color: BlackColor),
                ),
              ),
            ],
          ),
          drawer: DrawerWidget.drawer(context),
          floatingActionButton: Con_Wid.floatingButton(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return CattleRegistrationScreen();
                  },
                ));
              },
              height: 75,
              width: 75),
          body: DefaultTabController(
              length: 2,
              child: TabBarView(
                children: [
                  Daily_Report(false),
                  Daily_Report(true),
                ],
              )),
        ),
      ),
    );
  }

  Widget Daily_Report(bool isworkdone) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Con_Wid.height(5),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: con_clr.ConClr2
                      ? ConClrLightBack
                      : ConClrSelectedLightBack1,
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: isworkdone
                          ? [
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Con_Wid.gText("Animal Registered",
                                    style: ConStyle.style_white_14s_100w()),
                              ),
                              Column(children: [
                                Con_Wid.gText("Total",
                                    style: ConStyle.style_white_14s_100w()),
                                Text("${Con_List.id_Animal_Details.length}",
                                    style: ConStyle.style_white_14s_100w()),
                              ]),
                              Column(children: [
                                Con_Wid.gText("Today",
                                    style: ConStyle.style_white_14s_100w()),
                                Text(
                                    "${Con_List.id_Animal_Details.where((e) => e.registrationDate != null ? e.registrationDate.toString().substring(0, 10) == DateFormat("yyyy-MM-dd").format(DateTime.now()) : false).toList().length}",
                                    style: ConStyle.style_white_14s_100w()),
                              ]),
                              GestureDetector(
                                onTap: () {},
                                child: Stack(children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 5.0, right: 10),
                                    child: Icon(
                                      Icons.notifications,
                                      color: fontwhiteColor,
                                      size: 30,
                                    ),
                                  ),
                                  Positioned(
                                    top: -20,
                                    right: -8,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 20, right: 10),
                                      child: const CircleAvatar(
                                        radius: 11,
                                        backgroundColor: Colors.red,
                                        child: Text("0",
                                            style: TextStyle(fontSize: 12)),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            ]
                          : [
                              Container(
                                child: InkWell(
                                  onTap: () async {
                                    mStrFromdate = await Con_Wid.GlbDatePicker(
                                        formate: "11", pcontext: context);
                                    setState(() {});
                                    ;
                                  },
                                  child: Column(
                                    children: [
                                      Con_Wid.gText("From Date",
                                          style:
                                              ConStyle.style_white_12s_600w()),
                                      Text(
                                          "${mStrFromdate.toString().substring(0, 10)}",
                                          style:
                                              ConStyle.style_white_12s_600w()),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  onTap: () async {
                                    mStrtodate = await Con_Wid.GlbDatePicker(
                                        formate: "11", pcontext: context);
                                    setState(() {});
                                  },
                                  child: Column(
                                    children: [
                                      Con_Wid.gText("To Date",
                                          style:
                                              ConStyle.style_white_12s_600w()),
                                      Text(
                                          "${mStrtodate.toString().substring(0, 10)}",
                                          style:
                                              ConStyle.style_white_12s_600w()),
                                    ],
                                  ),
                                ),
                              ),
                              Con_Wid.MainButton(
                                  OnTap: () {
                                    setState(() {
                                      loading = false;
                                      DashBoardScreen.onrtime = 0;
                                      Workdonedetail();
                                    });
                                  },
                                  pStrBtnName: "Apply",
                                  height: 35,
                                  width: 75,
                                  fontSize: 12),
                              Con_Wid.MainButton(
                                  OnTap: () {
                                    sharePDF();
                                  },
                                  pStrBtnName: "Share",
                                  height: 35,
                                  width: 75,
                                  fontSize: 12),
                            ]),
                ),
              ),
            ],
          ),
          Con_Wid.height(10),
          loading
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2.8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: con_clr.ConClr2
                            ? ConClrMainLight
                            : Color(0xFFCBE4F9),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        margin: const EdgeInsets.only(right: 15, left: 15),
                        child: Column(
                          children: [heading_entry()],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: con_clr.ConClr2
                            ? ConClrLightBack
                            : Color(0xFFAECFEB),
                      ),
                      child: Activity_Details(),
                    ),
                  ],
                )
              : CircularProgressIndicator(),
          Con_Wid.height(10),
          loading
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3.8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: con_clr.ConClr2
                            ? ConClrMainLight
                            : Color(0xFFFAF3D6),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(right: 15, left: 15),
                        child: Column(
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: Con_Wid.gText("Milking Detail",
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: con_clr.ConClr2
                            ? ConClrLightBack
                            : Color(0xFFECE3BA),
                      ),
                      child: Milking_Done(),
                    ),
                  ],
                )
              : Container(),
          Con_Wid.height(10),
          loading
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 4.6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: con_clr.ConClr2
                            ? ConClrMainLight
                            : Color(0xFFD0F9FA),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(right: 15, left: 15),
                        child: Column(
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: Con_Wid.gText("Treatment Details",
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 6.4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: con_clr.ConClr2
                            ? ConClrLightBack
                            : Color(0xFF95E6E8),
                      ),
                      child: Treatment_details(),
                    ),
                  ],
                )
              : Container(),
          Con_Wid.height(10),
          loading
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: con_clr.ConClr2
                            ? ConClrMainLight
                            : Color(0xFFFDE6C8),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(right: 15, left: 15),
                        child: Column(
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: Con_Wid.gText("Dispose Details",
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: con_clr.ConClr2
                            ? ConClrLightBack
                            : Color(0xFFF1CEA0),
                      ),
                      child: Dispose_details(),
                    ),
                  ],
                )
              : Container(),
          Con_Wid.height(90)
        ],
      ),
    );
  }

  Milking_Detail() => ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 30),
                width: double.infinity,
                height: 38,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(left: 25, right: 30),
                        child: Con_Wid.gText(mStrMlkDetTitle[index].Title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Montserrat', color: Colors.black)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text('${mStrMlkDetTitle[index].Count}',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontFamily: 'Montserrat', color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
              index != 2 - 1 ? Con_Wid.gLineDivider() : Container(),
            ],
          );
        },
      );

  Activity_Details() => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: Activity_Done.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 30),
                width: double.infinity,
                height: 38,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Con_Wid.text_font(
                            "${Activity_Done[index]['WORK']}",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Conclrfontmain,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "${Activity_Done[index]['Target']}",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Conclrfontmain,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "${Activity_Done[index]['Done']}",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Conclrfontmain,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              index != Activity_Done.length - 1
                  ? Con_Wid.gLineDivider()
                  : Container(),
            ],
          );
        },
      );

  Milking_Done() => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: MIlking_done.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 30),
                width: double.infinity,
                height: 38,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Con_Wid.text_font(
                            "${MIlking_done[index]['WORK']}",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Conclrfontmain,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "${MIlking_done[index]['Done'] == null ? "-" : MIlking_done[index]['Done']}",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Conclrfontmain,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              index != MIlking_done.length - 1
                  ? Con_Wid.gLineDivider()
                  : Container(),
            ],
          );
        },
      );

  Treatment_details() => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: Terated_Done.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 30),
                width: double.infinity,
                height: 38,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Con_Wid.text_font(
                            "${Terated_Done[index]['WORK']}",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Conclrfontmain,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "${Terated_Done[index]['Done']}",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Conclrfontmain,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              index != Terated_Done.length - 1
                  ? Con_Wid.gLineDivider()
                  : Container(),
            ],
          );
        },
      );

  Dispose_details() => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: Dispose_Done.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 30),
                width: double.infinity,
                height: 38,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Con_Wid.text_font(
                            "${Dispose_Done[index]['WORK']}",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Conclrfontmain,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "${Dispose_Done[index]['Done']}",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Conclrfontmain,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              index != Dispose_Done.length - 1
                  ? Con_Wid.gLineDivider()
                  : Container(),
            ],
          );
        },
      );

  heading_entry() => Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(left: 30),
                child: Con_Wid.gText(
                  "Activity",
                  style: ConStyle.style_theme_14s_600w(),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Con_Wid.gText(
                    "Expected",
                    style: ConStyle.style_theme_14s_600w(),
                    textAlign: TextAlign.center,
                  )),
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Con_Wid.gText(
                    "Observed",
                    style: ConStyle.style_theme_14s_600w(),
                    textAlign: TextAlign.center,
                  )),
            ),
          ],
        ),
      );

  Workdonedetail({String? To, String? From}) async {
    mWorkDone = [];
    if (DashBoardScreen.onrtime == 0) {
      final res = await ApiCalling.createPost(AppUrl().getWorkDone,
          "Bearer " + Constants_Usermast.token.toString(), {
        "fromDate": mStrFromdate.toString(),
        "toDate": mStrtodate.toString(),
        "uid": Constants_Usermast.id.toString(),
        "staff": Constants_Usermast.staff.toString() == "null"
            ? ""
            : Constants_Usermast.staff.toString()
      });

      setState(() {
        if (res.statusCode == 200) {
          Activity_Done = [];
          Terated_Done = [];
          Dispose_Done = [];
          MIlking_done = [];
          mWorkDone = jsonDecode(res.body);
          DashBoardScreen.mCampare = mWorkDone;
          Activity_Done.add(mWorkDone[0]);
          Activity_Done.add(mWorkDone[1]);
          Activity_Done.add(mWorkDone[2]);
          Activity_Done.add(mWorkDone[3]);
          Activity_Done.add(mWorkDone[4]);
          Terated_Done.add(mWorkDone[5]);
          Terated_Done.add(mWorkDone[6]);
          Terated_Done.add(mWorkDone[7]);
          Dispose_Done.add(mWorkDone[8]);
          MIlking_done.add(mWorkDone[9]);
          MIlking_done.add(mWorkDone[10]);
          MIlking_done.add(mWorkDone[11]);
          MIlking_done.add(mWorkDone[12]);
          loading = true;
        } else {
          mWorkDone = [
            {"WORK": "Registration", "Target": 0, "Done": 0},
            {"WORK": "Heat / A.I", "Target": 0, "Done": 0},
            {"WORK": "PD Checked", "Target": 0, "Done": 0},
            {"WORK": "Calving Done", "Target": 0, "Done": 0},
            {"WORK": "Dry off Done", "Target": 0, "Done": 0},
            {"WORK": "Vaccination", "Target": 0, "Done": 0},
            {"WORK": "Deworming", "Target": 0, "Done": 0},
            {"WORK": "Milking", "Target": 0, "Done": 0}
          ];
          Activity_Done.add(mWorkDone[0]);
          Activity_Done.add(mWorkDone[1]);
          Activity_Done.add(mWorkDone[2]);
          Activity_Done.add(mWorkDone[3]);
          Activity_Done.add(mWorkDone[4]);
          Terated_Done.add(mWorkDone[5]);
          Terated_Done.add(mWorkDone[6]);
          Terated_Done.add(mWorkDone[7]);
          Dispose_Done.add(mWorkDone[8]);
          MIlking_done.add(mWorkDone[9]);
          MIlking_done.add(mWorkDone[10]);
          MIlking_done.add(mWorkDone[11]);
          MIlking_done.add(mWorkDone[12]);
          DashBoardScreen.onrtime++;
        }
      });
    } else {
      mWorkDone = [
        {"WORK": "Registration", "Target": 0, "Done": 0},
        {"WORK": "Heat / A.I", "Target": 0, "Done": 0},
        {"WORK": "PD Checked", "Target": 0, "Done": 0},
        {"WORK": "Calving Done", "Target": 0, "Done": 0},
        {"WORK": "Dry off Done", "Target": 0, "Done": 0},
        {"WORK": "Vaccination", "Target": 0, "Done": 0},
        {"WORK": "Deworming", "Target": 0, "Done": 0},
        {"WORK": "Milking", "Target": 0, "Done": 0}
      ];
      Activity_Done.add(mWorkDone[0]);
      Activity_Done.add(mWorkDone[1]);
      Activity_Done.add(mWorkDone[2]);
      Activity_Done.add(mWorkDone[3]);
      Activity_Done.add(mWorkDone[4]);
      Terated_Done.add(mWorkDone[5]);
      Terated_Done.add(mWorkDone[6]);
      Terated_Done.add(mWorkDone[7]);
      Dispose_Done.add(mWorkDone[8]);
      MIlking_done.add(mWorkDone[9]);
      MIlking_done.add(mWorkDone[10]);
      MIlking_done.add(mWorkDone[11]);
      MIlking_done.add(mWorkDone[12]);
      loading = true;
      setState(() {});
    }
  }

  Widget _eachItem(
      {required double paddingRight,
      required String information,
      required int index}) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0, top: 8.0, right: 15.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: ConClrBtntxt,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(40))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 25),
                child: Con_Wid.text_font(
                  "${mWorkDone[index]['WORK']}",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: ConClrBtntxt,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "${mWorkDone[index]['Target']}",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: ConClrBtntxt,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "${mWorkDone[index]['Done']}",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: ConClrBtntxt,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _eachItem1(
      {required double paddingRight,
      required String information,
      required int index}) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0, top: 8.0, right: 15.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: ConClrBtntxt,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(40))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  "${DashBoardScreen.mCampare[index]['WORK']}",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: ConClrBtntxt,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "${DashBoardScreen.mCampare[index]['Target']}",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: ConClrBtntxt,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "${DashBoardScreen.mCampare[index]['Done']}",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: ConClrBtntxt,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static workText(String text, double left, double right) {
    return pw.Padding(
      padding:
          pw.EdgeInsets.only(left: left, top: 10, bottom: 10, right: right),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.left,
        style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.normal),
      ),
    );
  }

  static headText(String text, double left, double right) {
    return pw.Padding(
      padding: pw.EdgeInsets.only(left: left, top: 4, bottom: 4, right: right),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.left,
        style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.normal),
      ),
    );
  }

  static headingText(String text, double left, double right) {
    return pw.Padding(
      padding: pw.EdgeInsets.only(left: left, top: 9, bottom: 9, right: right),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.left,
        style: pw.TextStyle(
          fontSize: 15,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  Future sharePDF() async {
    final pw.Document pdf = pw.Document(deflate: zlib.encode);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a3,
        build: (pw.Context context) {
          return [
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.symmetric(
                  vertical: pw.BorderSide(width: 1),
                  horizontal: pw.BorderSide(width: 0.4),
                ),
              ),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: headText(
                          "UserName : " +
                              Constants_Usermast.user_name.toString(),
                          55,
                          0),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Align(
                      alignment: pw.Alignment.center,
                      child: headText("Daily Report", 0, 0),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Align(
                      alignment: pw.Alignment.centerRight,
                      child: headText("", 0, 45),
                    ),
                  ),
                ],
              ),
            ),
            pw.Table.fromTextArray(
              context: context,
              data: <List<String>>[
                <String>[
                  ' Start Period : ' +
                      "${mStrFromdate}" +
                      "       " +
                      ' End Period : ' +
                      mStrtodate,
                ],
              ],
            ),
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.symmetric(
                  vertical: pw.BorderSide(width: 1),
                  horizontal: pw.BorderSide(width: 0.4),
                ),
              ),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: headingText("Work", 55, 0),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Align(
                      alignment: pw.Alignment.center,
                      child: headingText("Target", 0, 0),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Align(
                      alignment: pw.Alignment.centerRight,
                      child: headingText("Done", 0, 45),
                    ),
                  ),
                ],
              ),
            ),
            pw.ListView.builder(
              itemCount: mWorkDone.length,
              itemBuilder: (context, index) {
                return pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border.symmetric(
                      vertical: pw.BorderSide(width: 1),
                      horizontal: pw.BorderSide(width: 0.4),
                    ),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: workText(mWorkDone[index]['WORK'], 37, 0),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Align(
                          alignment: pw.Alignment.center,
                          child: workText(
                              mWorkDone[index]['Target'].toString(), 0, 0),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: workText(
                              mWorkDone[index]['Done'].toString(), 0, 60),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ];
        },
      ),
    );
    final String dir = (await getExternalStorageDirectory())!.path;
    final String path = '$dir/herdman_daily_report.pdf';
    final File file = File(path);
    file.writeAsBytes(List.from(await pdf.save()));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    try {
      Share.shareFiles(['${path}'], text: 'Great picture');
    } catch (e) {}
  }
  refreshevery(){
    Timer.periodic(Duration(minutes: 2), (timer) async {
      await SyncDB.SyncTable("VISITREGISTRATION", true);
    });
  }
}

class MilkingDetail {
  String Title;
  String Count;

  MilkingDetail({required this.Title, required this.Count});
}
void showToast(Map Data) {
  OverlayEntry? overlayEntry;
   overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(alignment: Alignment.center, children: [
          Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),boxShadow: [BoxShadow(color: Colors.grey,spreadRadius: 2,blurRadius: 5,offset: Offset(3, 8))]),
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width / 1.5,
              
              child: Column(children: [
                Container(
                    decoration: BoxDecoration( color: Colors.blue.shade900,borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 15,
                    width: double.infinity,

                    child: const Text(
                      "You Have New Visit",
                      style: TextStyle(color: Colors.white),
                    )),
                Spacer(),
                Padding(
                  // {"date" :"400","id":"145823","Dcs":"45821856"}
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("You Have New ${Data['VisitCost'].toString() == "100" ? "Normal":"Emergency"} Visit from ${Data['lotname']} DCS and Visit ID is ${Data['VisitID']}",textAlign: TextAlign.center),
                ),
                Spacer(),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          overlayEntry!.remove();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.blue.shade900)),
                          margin: const EdgeInsets.all(8),
                          height: 35,
                          width: MediaQuery.of(context).size.width / 4.8,
                          alignment: Alignment.center,
                          child: Text("Close",style: TextStyle(color: Colors.blue.shade900)),
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return VisitRegistrationScreen();
                          },));
                          overlayEntry!.remove();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.all(8),
                          height: 35,
                          width: MediaQuery.of(context).size.width / 4.4,
                          alignment: Alignment.center,
                          child: const Text("Go To Visit",style: TextStyle(color: Colors.white)),
                        )),
                  ],
                )
              ]),
            ),
          )
        ]);
      });

  MyApp.navigatorKey.currentState?.overlay?.insert(overlayEntry);

}