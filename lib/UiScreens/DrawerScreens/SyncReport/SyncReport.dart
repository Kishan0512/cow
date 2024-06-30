import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:herdmannew/UiScreens/Dashboard/Dashboard.dart';
import 'package:herdmannew/component/DataBaseHelper/Sync_Api.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:hive/hive.dart';

import '../../../Model_local/Breeding_insemination.dart';
import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../../model/Animal_Details_id.dart';
import '../../../model/Animal_registration.dart';
import '../../../model/Breeding_reproduction_id.dart';
import '../AllCattleList/AnimalTransfer.dart';

class SyncReportScreen extends StatefulWidget {
  const SyncReportScreen({Key? key}) : super(key: key);

  @override
  State<SyncReportScreen> createState() => _SyncReportScreenState();
}

class _SyncReportScreenState extends State<SyncReportScreen>
    with SingleTickerProviderStateMixin {
  List<bool> mListCheckBox = [];
  bool isloading = false;
  bool isTransfer = false;
  String TransferTag = '';
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    setState(() {
      Sync_report.getdata();
      mListCheckBox = List.filled(
        Con_List.mListPanding.length,
        false,
      );
    });
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
  }

  @override
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
          title: "Sync Report",
          Actions: [
            Con_Wid.AnimSyncBtn(
                OnTap: () async {
                  _controller!.forward();
                  final connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.mobile ||
                      connectivityResult == ConnectivityResult.bluetooth ||
                      connectivityResult == ConnectivityResult.ethernet ||
                      connectivityResult == ConnectivityResult.vpn ||
                      connectivityResult == ConnectivityResult.other ||
                      connectivityResult == ConnectivityResult.wifi) {
                    await Sync_report.Sync_data();
                    setState(() {});
                  }
                  Future.delayed(Duration(seconds: 5)).then((value) {
                    setState(() {
                      _controller!.stop();
                      _controller!.reset();
                      Con_List.mListPanding.clear();
                      Sync_report.getdata();
                      setState(() {
                        Con_List.mListPanding.clear();
                      });
                      mListCheckBox = List.filled(
                        Con_List.mListPanding.length,
                        false,
                      );
                    });
                  });
                },
                controller: _controller!)
          ],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return DashBoardScreen();
              },
            ));
          },
        ),
        body: Con_Wid.backgroundContainer(
          child: Stack(alignment: Alignment.center, children: [
            IgnorePointer(
              ignoring: isloading || isTransfer,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                          height: 200,
                          width: 450,
                          color: con_clr.ConClr2 ? ConClrMainLight : whiteColor,
                          child: FutureBuilder(
                              future: Sync_report.getdata(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Container(
                                    width: 450,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 450,
                                          color: con_clr.ConClr2
                                              ? ConClrbluelight
                                              : ConClrDialog,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                child: rowTxt("Server"),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: rowTxt("Tag id"),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: rowTxt("Type"),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: rowTxt("Time"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView.separated(
                                            itemCount: Con_List
                                                    .mListPanding.isEmpty
                                                ? 0
                                                : Con_List.mListPanding.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                                child: Container(
                                                  height: 40,
                                                  width: 300,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () async {
                                                            final connectivityResult =
                                                                await (Connectivity()
                                                                    .checkConnectivity());
                                                            if (connectivityResult ==
                                                                    ConnectivityResult
                                                                        .mobile ||
                                                                connectivityResult ==
                                                                    ConnectivityResult
                                                                        .wifi) {
                                                              String id = Con_List
                                                                  .mListPanding[
                                                                      index]
                                                                  .Tagid
                                                                  .toString();
                                                              String table = Con_List
                                                                  .mListPanding[
                                                                      index]
                                                                  .Form_name
                                                                  .toString();
                                                              if (table ==
                                                                  "Dry off detail") {
                                                                setState(() {
                                                                  isloading =
                                                                      true;
                                                                });
                                                                List Note = Con_List
                                                                            .Dryofsave
                                                                        .where((element) =>
                                                                            element.TagId.toString() ==
                                                                            id)
                                                                    .map((e) =>
                                                                        e.toJson(
                                                                            e))
                                                                    .toList();
                                                                Sync_Api.insert_Api(
                                                                        note: {},
                                                                        pStrTableName:
                                                                            Constants
                                                                                .Tbl_Dry_off_save,
                                                                        NoteList:
                                                                            Note)
                                                                    .then(
                                                                        (value) {
                                                                  setState(() {
                                                                    isloading =
                                                                        false;
                                                                    Sync_report
                                                                        .getdata();
                                                                  });
                                                                });
                                                              } else if (table ==
                                                                  "AI") {
                                                                setState(() {
                                                                  isloading =
                                                                      true;
                                                                });
                                                                List Note = Con_List
                                                                            .Br_insemination
                                                                        .where((element) =>
                                                                            element.TagId.toString() ==
                                                                            id)
                                                                    .map((e) =>
                                                                        e.toJson(
                                                                            e))
                                                                    .toList();
                                                                Sync_Api.insert_Api(
                                                                        note: {},
                                                                        pStrTableName:
                                                                            Constants
                                                                                .Tbl_Br_insemination,
                                                                        NoteList:
                                                                            Note)
                                                                    .then(
                                                                        (value) {
                                                                  setState(() {
                                                                    isloading =
                                                                        false;
                                                                    Sync_report
                                                                        .getdata();
                                                                  });
                                                                });
                                                              } else if (table ==
                                                                  "Calving detail") {
                                                                setState(() {
                                                                  isloading =
                                                                      true;
                                                                });
                                                                List Note = Con_List
                                                                            .Br_Calving
                                                                        .where((element) =>
                                                                            element.TagId.toString() ==
                                                                            id)
                                                                    .map((e) =>
                                                                        e.toJson(
                                                                            e))
                                                                    .toList();
                                                                Sync_Api.insert_Api(
                                                                        note: {},
                                                                        pStrTableName:
                                                                            Constants
                                                                                .Tbl_Breeding_Calving,
                                                                        NoteList:
                                                                            Note)
                                                                    .then(
                                                                        (value) {
                                                                  setState(() {
                                                                    isloading =
                                                                        false;
                                                                    Sync_report
                                                                        .getdata();
                                                                  });
                                                                });
                                                              } else if (table ==
                                                                  "Disposal") {
                                                                setState(() {
                                                                  isloading =
                                                                      true;
                                                                });
                                                                List Note = Con_List
                                                                            .A_Disposal
                                                                        .where((element) =>
                                                                            element.tagId.toString() ==
                                                                            id)
                                                                    .map((e) =>
                                                                        e.toJson(
                                                                            e))
                                                                    .toList();
                                                                Sync_Api.insert_Api(
                                                                        note: {},
                                                                        pStrTableName:
                                                                            Constants
                                                                                .Tbl_Animal_diedDetails,
                                                                        NoteList:
                                                                            Note)
                                                                    .then(
                                                                        (value) {
                                                                  setState(() {
                                                                    isloading =
                                                                        false;
                                                                    Sync_report
                                                                        .getdata();
                                                                  });
                                                                });
                                                              } else if (table ==
                                                                  "PD") {
                                                                setState(() {
                                                                  isloading =
                                                                      true;
                                                                });
                                                                List Note = Con_List
                                                                            .Br_PD
                                                                        .where((element) =>
                                                                            element.TagId.toString() ==
                                                                            id)
                                                                    .map((e) =>
                                                                        e.toJson(
                                                                            e))
                                                                    .toList();
                                                                Sync_Api.insert_Api(
                                                                        note: {},
                                                                        pStrTableName:
                                                                            Constants
                                                                                .Tbl_Br_Pd,
                                                                        NoteList:
                                                                            Note)
                                                                    .then(
                                                                        (value) {
                                                                  setState(() {
                                                                    isloading =
                                                                        false;
                                                                    Sync_report
                                                                        .getdata();
                                                                  });
                                                                });
                                                              } else if (table ==
                                                                  "Animal") {
                                                                setState(() {
                                                                  isloading =
                                                                      true;
                                                                });
                                                                List Note = Con_List
                                                                            .Animal_regisrtration
                                                                        .where((element) =>
                                                                            element.tagId.toString() ==
                                                                            id)
                                                                    .map((e) =>
                                                                        e.toJson(
                                                                            e))
                                                                    .toList();
                                                                await _checkInServer(
                                                                        Tagid: Note[0]['tagId']
                                                                            .toString())
                                                                    .then(
                                                                        (value) {
                                                                  if (value) {
                                                                    insertintoApi(
                                                                            note: {},
                                                                            pStrTableName: Constants
                                                                                .Tbl_Animal_Registration,
                                                                            NoteList:
                                                                                Note)
                                                                        .then(
                                                                            (value1) {
                                                                      setState(
                                                                          () {
                                                                        isloading =
                                                                            false;
                                                                        Sync_report
                                                                            .getdata();
                                                                      });
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      TransferTag =
                                                                          Note[0]['tagId']
                                                                              .toString();
                                                                      isloading =
                                                                          false;
                                                                      isTransfer =
                                                                          true;
                                                                    });
                                                                  }
                                                                });
                                                              } else if (table ==
                                                                  "Milk") {
                                                                if (Con_List
                                                                        .mListPanding
                                                                        .where((element) =>
                                                                            element.Form_name ==
                                                                            "Animal")
                                                                        .length ==
                                                                    0) {
                                                                  setState(() {
                                                                    isloading =
                                                                        true;
                                                                  });
                                                                  List Note = Con_List
                                                                      .id_reproduction
                                                                      .where((element) =>
                                                                          element.tagId.toString() ==
                                                                              id &&
                                                                          element.TableNAme.toString() ==
                                                                              "MILK")
                                                                      .map((e) =>
                                                                          e.toJson(
                                                                              e))
                                                                      .toList();
                                                                  insertintoApi(
                                                                          note: {},
                                                                          pStrTableName: Constants
                                                                              .Breeding_reproduction_id,
                                                                          NoteList:
                                                                              Note)
                                                                      .then(
                                                                          (value) {
                                                                    setState(
                                                                        () {
                                                                      isloading =
                                                                          false;
                                                                      Sync_report
                                                                          .getdata();
                                                                    });
                                                                  });
                                                                } else {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return const AlertDialog(
                                                                        content:
                                                                            Text("First finish all animal entry"),
                                                                      );
                                                                    },
                                                                  );
                                                                }
                                                              } else if (table ==
                                                                  "Production") {
                                                                if ((Con_List
                                                                            .mListPanding
                                                                            .where((element) =>
                                                                                element.Form_name ==
                                                                                "Milk")
                                                                            .length ==
                                                                        0) &&
                                                                    Con_List.mListPanding
                                                                            .where((element) =>
                                                                                element.Form_name ==
                                                                                "Animal")
                                                                            .length ==
                                                                        0) {
                                                                  setState(() {
                                                                    isloading =
                                                                        true;
                                                                  });
                                                                  List Note = Con_List
                                                                      .id_reproduction
                                                                      .where((element) =>
                                                                          element.tagId.toString() ==
                                                                              id &&
                                                                          element.TableNAme.toString() ==
                                                                              "Repoduction")
                                                                      .map((e) =>
                                                                          e.toJson(
                                                                              e))
                                                                      .toList();
                                                                  insertintoApi(
                                                                          note: {},
                                                                          pStrTableName: Constants
                                                                              .Breeding_reproduction_id,
                                                                          NoteList:
                                                                              Note)
                                                                      .then(
                                                                          (value) {
                                                                    setState(
                                                                        () {
                                                                      isloading =
                                                                          false;
                                                                      Sync_report
                                                                          .getdata();
                                                                    });
                                                                  });
                                                                } else {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return const AlertDialog(
                                                                        content:
                                                                            Text("First finish all animal and milk entry"),
                                                                      );
                                                                    },
                                                                  );
                                                                }
                                                              }
                                                            } else {
                                                              Con_Wid.Con_Show_Toast(
                                                                  context,
                                                                  "Please Connect Internet");
                                                            }
                                                          },
                                                          child: Text("Retry")),
                                                      Expanded(
                                                        flex: 2,
                                                        child: TableTxt(
                                                            "${Con_List.mListPanding[index].Tagid}"),
                                                      ),
                                                      Expanded(
                                                        child: TableTxt(
                                                            "${Con_List.mListPanding[index].Form_name}"),
                                                      ),
                                                      Expanded(
                                                        child: TableTxt(
                                                            "${Con_List.mListPanding[index].Time.substring(0, 10)}"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return const Divider(
                                                height: 2,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              })),
                    ),
                  ],
                ),
              ),
            ),
            isloading
                ? Container(
                    color: Color(0xFFCCCCCC),
                    child: Con_Wid.Con_Loding(),
                  )
                : Container(),
            isTransfer ? _transferWidget(Tagid: TransferTag) : Container()
          ]),
        ),
      ),
    );
  }

  void continuousFunction() {
    Timer.periodic(Duration(microseconds: 500), (timer) {
      // Your code logic here
      setState(() {
        Sync_report.getdata();
      });
    });
  }

  rowTxt(String txt) {
    return Con_Wid.popinsfont(
        txt, ConClrMainLight, FontWeight.w600, 10, context);
  }

  TableTxt(String txt) {
    return Con_Wid.popinsfont(
        txt, Conclrfontmain, FontWeight.w300, 10, context);
  }

  Future<bool> _checkInServer({required String Tagid}) async {
    var res = await ApiCalling.getdata(
        AppUrl().checkCattleAvailable + "${Tagid}",
        Constants_Usermast.token.toString());
    if (res.body != null) {
      var response = res.body;
      if (mounted) {
        setState(() {});
      }
      if (response == "No Data Found") {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  Widget _transferWidget({required String Tagid}) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      contentPadding: EdgeInsets.all(0.0),
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 80.0,
          decoration: con_clr.ConClr2
              ? BoxDecoration(
                  gradient: LinearGradient(
                      colors: ConClrAppbarGreadiant,
                      transform: GradientRotation(1.55),
                      begin: Alignment(-1, 0)),
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(5.0),
                    topRight: const Radius.circular(5.0),
                  ))
              : BoxDecoration(
                  color: ConClrDialog,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(5.0),
                    topRight: const Radius.circular(5.0),
                  )),
          child: Stack(alignment: Alignment.topRight, children: <Widget>[
            GestureDetector(
                onTap: () {
                  setState(() {
                    isTransfer = false;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 6.0, right: 6.0),
                  child: Icon(
                    Icons.close,
                    color: con_clr.ConClr2
                        ? Colors.white.withOpacity(0.3)
                        : whiteColor,
                    size: 30.0,
                  ),
                )),
            Center(
              child: Text(
                'QR code not present in the database',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: 19.0),
                textAlign: TextAlign.center,
              ),
            )
          ]),
        ),
        Column(children: [
          Container(
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
              alignment: Alignment.center,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Do you want to transfer the cattle?',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: const Color(0xFF082451),
                        fontSize: 17.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
          Con_Wid.height(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Con_Wid.MainButton(
                  OnTap: () async {
                    var box = await Hive.openBox<Animal_Registration>(
                        "Animal_Registration");
                    await box.delete(Tagid.toString());
                    var box1 = await Hive.openBox<Animal_Details_id>(
                        'Animal_Details_id');
                    var tagId = Tagid.toString();
                    var animalDetails = box1.values
                        .firstWhere((item) => item.tagId == tagId)
                        .id;
                    await box1.delete(animalDetails);
                    var box2 = await Hive.openBox<Breeding_reproduction_id>(
                        "Breeding_reproduction_id");
                    var inseid = box2.values
                        .firstWhere((element) => element.tagId == Tagid)
                        .id;
                    await box2.delete(inseid);
                    Con_List.Animal_regisrtration.removeWhere(
                        (element) => element.tagId == Tagid);
                    Con_List.id_reproduction
                        .removeWhere((element) => element.tagId == Tagid);

                    setState(() {
                      isTransfer = false;
                      isloading = false;
                      Sync_report.getdata();
                    });
                  },
                  pStrBtnName: "Delete",
                  height: 51,
                  width: 100,
                  fontSize: 16),
              Con_Wid.MainButton(
                  OnTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        int index2 = int.parse(Tagid);
                        return animalTransfer(index2);
                      },
                    ));
                    isTransfer = false;
                  },
                  pStrBtnName: "Yes",
                  height: 51,
                  width: 100,
                  fontSize: 16),
            ],
          ),
          Con_Wid.height(20)
        ])
      ],
    );
  }

  Future insertintoApi(
      {int? count,
      required Map note,
      required String pStrTableName,
      required List NoteList}) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      switch (pStrTableName) {
        case "Animal_Registration":
          for (int i = 0; i < NoteList.length; i++) {
            NoteList[i].remove('SyncStatus');
            try {
              var response = await ApiCalling.createPost(AppUrl().Animal_Save,
                  "Bearer " + Constants_Usermast.token.toString(), NoteList[i]);

              if (response.statusCode == 200) {
                var resBody = json.decode(response.body);

                var box = await Hive.openBox<Animal_Registration>(
                    "Animal_Registration");
                final boxdata = box.get(NoteList[i]['id'].toString());
                boxdata!.SyncStatus = "1";
                await box.put(NoteList[i]['id'].toString(), boxdata);
                _showNotification(
                    tital: "Registration Done",
                    body:
                        "ID no : ${NoteList[i]['TagId']} \n Date : ${NoteList[i]['createdAt']}",
                    map: note);
              }
            } catch (e) {}
          }
          break;
        case "Breeding_insemination":
          for (int i = 0; i < NoteList.length; i++) {
            NoteList[i].remove('ServerId');
            NoteList[i].remove('SyncStatus');
            try {
              var response = await ApiCalling.createPost(AppUrl().AISave,
                  "Bearer " + Constants_Usermast.token.toString(), NoteList[i]);

              if (response.statusCode == 200) {
                var resBody = json.decode(response.body);
                var box = await Hive.openBox<Breeding_insemination>(
                    "Breeding_insemination");
                final boxdata = box.get(NoteList[i]['id'].toString());
                boxdata!.ServerId = "${(resBody['id'])}";
                boxdata.SyncStatus = "1";
                await box.put(NoteList[i]['id'].toString(), boxdata);
                _showNotification(
                    tital: "Insemination Done",
                    body:
                        "ID no : ${NoteList[i]['TagId']} \n Date : ${NoteList[i]['createdAt']}",
                    map: note);
              } else {}
            } catch (e) {}
          }
          break;
      }
    } else {
      Con_Wid.Con_Show_Toast(context, "Please connect the internet");
    }
  }

  static Future<void> _showNotification(
      {required String tital, String? body, Map? map}) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      '${tital}', // Notification title
      '${body}', // Notification body
      platformDetails, // Notification details
      payload: 'data', // Optional payload
    );
  }
}

class Sync_report {
  String Form_name;
  String Tagid;
  String Time;
  var Status;

  Sync_report({
    required this.Form_name,
    required this.Tagid,
    required this.Time,
    required this.Status,
  });

  static Future<List<Sync_report>> getdata() {
    Con_List.mListPanding.clear();
    Con_List.Br_insemination.where((e) => e.SyncStatus == "0")
        .map((e) => Con_List.mListPanding.add(Sync_report(
            Form_name: "AI",
            Tagid: e.TagId,
            Time: e.createdAt,
            Status: e.SyncStatus)))
        .toList();
    Con_List.Br_Calving.where((e) => e.SyncStatus == "0")
        .map((e) => Con_List.mListPanding.add(Sync_report(
            Form_name: "Calving detail",
            Tagid: e.TagId,
            Time: e.createdAt,
            Status: e.SyncStatus)))
        .toList();
    Con_List.Dryofsave.where((e) => e.SyncStatus == "0")
        .map((e) => Con_List.mListPanding.add(Sync_report(
            Form_name: "Dry off detail",
            Tagid: e.TagId,
            Time: e.createdAt,
            Status: e.SyncStatus)))
        .toList();
    Con_List.A_Disposal.where((e) => e.SyncStatus == "0")
        .map((e) => Con_List.mListPanding.add(Sync_report(
            Form_name: "Disposal",
            Tagid: e.tagId,
            Time: e.createdAt,
            Status: e.SyncStatus)))
        .toList();
    Con_List.Br_PD.where((e) => e.SyncStatus == "0")
        .map((e) => Con_List.mListPanding.add(Sync_report(
            Form_name: "PD",
            Tagid: e.TagId,
            Time: e.createdAt,
            Status: e.SyncStatus)))
        .toList();
    Con_List.A_Treatment.where((e) => e.SyncStatus == "0")
        .map((e) => Con_List.mListPanding.add(Sync_report(
            Form_name: "Treatment",
            Tagid: e.tagId,
            Time: e.createdAt,
            Status: e.SyncStatus)))
        .toList();
    Con_List.A_Deworming.where((e) => e.SyncStatus == "0")
        .map((e) => Con_List.mListPanding.add(Sync_report(
            Form_name: "Deworming",
            Tagid: e.tagId,
            Time: e.createdAt,
            Status: e.SyncStatus)))
        .toList();
    Con_List.A_Vaccination.where((e) => e.SyncStatus == "0")
        .map((e) => Con_List.mListPanding.add(Sync_report(
            Form_name: "Vaccination",
            Tagid: e.TagId,
            Time: e.createdAt,
            Status: e.SyncStatus)))
        .toList();
    Con_List.Animal_regisrtration.where((e) => e.SyncStatus == "0")
        .map((e) => Con_List.mListPanding.add(Sync_report(
            Form_name: "Animal",
            Tagid: e.tagId,
            Time: e.createdAt,
            Status: e.SyncStatus)))
        .toList();
    Con_List.id_reproduction
        .where((e) => e.SyncStatus == "0" && e.TableNAme.toString() == "MILK")
        .map((e) => Con_List.mListPanding.add(Sync_report(
            Form_name: "Milk",
            Tagid: e.tagId,
            Time: e.createdAt,
            Status: e.SyncStatus)))
        .toList();
    Con_List.id_reproduction
        .where((e) =>
            e.SyncStatus == "0" && e.TableNAme.toString() == "Repoduction")
        .map((e) => Con_List.mListPanding.add(Sync_report(
            Form_name: "Production",
            Tagid: e.tagId,
            Time: e.createdAt,
            Status: e.SyncStatus)))
        .toList();
    return Future.value(Con_List.mListPanding);
  }

  static Future Sync_data() async {
    if (Con_List.mListPanding.where((e) => e.Form_name == "AI").length != 0) {
      await Sync_Json.Get_Master_Data(Constants.Tbl_Br_insemination);
    }
    if (Con_List.mListPanding
            .where((e) => e.Form_name == "Calving detail")
            .length !=
        0) {
      await Sync_Json.Get_Master_Data(Constants.Tbl_Breeding_Calving);
    }
    if (Con_List.mListPanding
            .where((e) => e.Form_name == "Dry off detail")
            .length !=
        0) {
      await Sync_Json.Get_Master_Data(Constants.Tbl_Dry_off_save);
    }
    if (Con_List.mListPanding.where((e) => e.Form_name == "Disposal").length !=
        0) {
      await Sync_Json.Get_Master_Data(Constants.Tbl_Animal_diedDetails);
    }
    if (Con_List.mListPanding.where((e) => e.Form_name == "PD").length != 0) {
      await Sync_Json.Get_Master_Data(Constants.Tbl_Br_Pd);
    }
  }
}
