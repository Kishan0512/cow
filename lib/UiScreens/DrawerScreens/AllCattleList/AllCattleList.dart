import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/Dashboard/Dashboard.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/profile.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Icons.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/model/Animal_Details_id.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../FloatingButton/CattleRegistrationScreen.dart';
import '../../Splesh/SplashScreen.dart';

class AllCattleListScreen extends StatefulWidget {
  const AllCattleListScreen({Key? key}) : super(key: key);

  @override
  State<AllCattleListScreen> createState() => _AllCattleListScreenState();
}

class _AllCattleListScreenState extends State<AllCattleListScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  bool visible_search_bar = false;
  TextEditingController search = TextEditingController();

  List<Animal_Details_id> filteredUsers = [];
  List<Animal_Details_id> Closefilter = [];
  List mImageList = [];
  List mStatusList = [];
  int bre = 0,
      cal = 0,
      dra = 0,
      dry = 0,
      hei = 0,
      mil = 0,
      pradry = 0,
      pramil = 0,
      pra = 0,
      nul = 0;
  String status = '', A_farmer = "";
  bool selected = true;
  List<String> routeSelected = [],
      farmerSelected = [],
      societySelected = [],
      ReportSelected = [];
  String mSelctRoutecode = '', mSelctSocietycode = '', mSelctFarmercode = '';
  List<AnimalChart> chartData = [];
  List<AnimalChart> chartData1 = [];
  double width = 0;
  double safePadding = 0;
  List<AnimalChart> _chartData = [];
  TooltipBehavior _tooltipBehavior = TooltipBehavior();
  bool showcahrt = false;
  bool getstatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    getCart();
    _tooltipBehavior = TooltipBehavior(enable: true);
    chartData1 = [
      AnimalChart('Pregnant', pra),
      AnimalChart('Breeding', bre),
      AnimalChart('Calf', cal),
      AnimalChart('Draft', dra),
      AnimalChart('Dry', dry),
      AnimalChart('Milking', mil),
      AnimalChart('P. Dry', pradry),
      AnimalChart('P. Milk', pramil),
      AnimalChart('Null', nul),
      AnimalChart('Heifer', hei),
    ];
    chartData = chartData1.where((element) => element.count != 0).toList();
    _chartData = chartData;

    setState(() {});
    //updateListView();
  }

  getdata() async {
    if (Con_List.M_status.isEmpty ||
        Con_List.id_Animal_Details.isEmpty ||
        Con_List.M_Userherds.isEmpty ||
        Con_List.M_Userlots.isEmpty ||
        Con_List.M_Farmer.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_status);
      Sync_Json.Get_Master_Data(Constants.Animal_Details_id);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_farmer);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_herd);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_lot);

    }

    setState(() {
      filteredUsers = Con_List.id_Animal_Details.toSet().toList();
      Closefilter = Con_List.id_Animal_Details.toSet().toList();
    });
  }

  getCart() {
    Con_List.id_Animal_Details.forEach((e) {
      if (e.statusname.toString().toLowerCase() == "null") {
        nul++;
      } else if (e.statusname.toString().toLowerCase() == "breeding") {
        bre++;
      } else if (e.statusname.toString().toLowerCase() == "calf") {
        cal++;
      } else if (e.statusname.toString().toLowerCase() == "draft") {
        dra++;
      } else if (e.statusname.toString().toLowerCase() == "heifer") {
        hei++;
      } else if (e.statusname.toString().toLowerCase() == "milking") {
        mil++;
      } else if (e.statusname.toString().toLowerCase() == "pregnant dry") {
        pradry++;
      } else if (e.statusname.toString().toLowerCase() == "pregnant milking") {
        pramil++;
      } else if (e.statusname.toString().toLowerCase() == "pregnant") {
        pra++;
      } else if (e.statusname.toString().toLowerCase() == "dry") {
        dry++;
      }
    });
  }

  Future<bool> onBackPress() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return DashBoardScreen();
      },
    ));
    return Future.value(false);
  }

  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width / 1.5;
    safePadding = MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop: () => onBackPress(),
      child: Scaffold(
        key: _globalKey,
          appBar: visible_search_bar
              ? AppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: Con_Wid.appBarColor(),
                  title: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(
                        width: 2,
                        color: ConClrborderdrop,
                      ),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          filteredUsers = Con_List.id_Animal_Details
                              .where((u) => (u.tagId
                                      .toString()
                                      .contains(value.toLowerCase()) ||
                                  u.breedingStatus
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  u.statusname
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  u.name
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toLowerCase())))
                              .toList();
                          setState(() {});
                        });
                      },
                      controller: search,
                      style:
                          TextStyle(color: Colors.white, fontFamily: "poppins"),
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: ("Search by Tag id, Name, Status"),
                        hintStyle: TextStyle(
                            color: Colors.white, fontFamily: "poppins"),
                      ),
                    ),
                  ),
                  actions: [
                    Con_Wid.mIconButton(
                        onPressed: () {
                          visible_search_bar = false;
                          search.clear();
                          filteredUsers = Closefilter;
                          setState(() {});
                        },
                        icon: Own_Close)
                  ],
                )
              : Con_Wid.appBar(
                  cTile: "no",
                  title: "Registered Animals - ${filteredUsers.length}",
                  Actions: [
                    Con_Wid.mIconButton(
                        onPressed: () {
                          visible_search_bar = true;
                          setState(() {});
                        },
                        icon: Own_Search),
                  ],
                  onBackTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return DashBoardScreen();
                      },
                    ));
                  },
                ),
          floatingActionButton: Con_Wid.floatingButton(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return CattleRegistrationScreen();
                  },
                ));
              },
              height: 75,
              width: 75),
          body: Con_Wid.backgroundContainer(
              child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  showcahrt
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(children: [
                            SfCircularChart(
                              title:
                                  ChartTitle(text: 'Status wise Animal Chart'),
                              tooltipBehavior: _tooltipBehavior,
                              series: <CircularSeries>[
                                PieSeries<AnimalChart, String>(
                                  radius: "100",
                                  dataSource: _chartData,
                                  xValueMapper: (AnimalChart data, _) =>
                                      data.status,
                                  yValueMapper: (AnimalChart data, _) =>
                                      data.count,
                                  dataLabelMapper: (AnimalChart data, _) {
                                    return "${data.status}(${data.count})";
                                  },
                                  dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      labelPosition:
                                          ChartDataLabelPosition.outside),
                                  enableTooltip: true,
                                )
                              ],
                            )
                          ]),
                        )
                      : Container(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showcahrt = !showcahrt;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Colors.blue),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.pie_chart,
                            // Replace with your desired chart icon
                            color: Colors.blue,
                          ),
                          SizedBox(width: 8),
                          // Adjust the spacing between the icon and text
                          showcahrt ? Text("Hide Chart") : Text("Show Chart"),
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        height: showcahrt
                            ? MediaQuery.of(context).size.height - 481
                            : MediaQuery.of(context).size.height - 182,
                        child: ListView.builder(
                          itemCount: filteredUsers.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return profile(filteredUsers[index]
                                          .tagId
                                          .toString());
                                    },
                                  ));
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      right: 5, left: 5, bottom: 7),
                                  //margin: const EdgeInsets.symmetric(vertical: 7),
                                  height: 45,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: con_clr.ConClr2
                                          ? ConClrCattle
                                          : Color(0xFF5C99E8),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.blueGrey, width: 1)),
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 45,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          decoration: BoxDecoration(
                                              color: con_clr.ConClr2
                                                  ? ConClrMainLight
                                                  : Color(0xFFBCD5FA),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  topLeft: Radius.circular(5))),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    topLeft:
                                                        Radius.circular(5))),
                                            child: Image.asset(
                                                fit: BoxFit.fill,
                                                "assets/images/${filteredUsers[index].speciesname.toString().toLowerCase()}${filteredUsers[index].statusname.toString().toLowerCase() == "null" ? "" : '-' + filteredUsers[index].statusname.toString().toLowerCase()}.webp"),
                                          )),
                                      Con_Wid.width(10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Con_Wid.popinsfont(
                                              "ID No. ${filteredUsers[index].tagId} - ${filteredUsers[index].name ?? ""}",
                                              con_clr.ConClr2
                                                  ? Color(0XFF223347)
                                                  : whiteColor,
                                              FontWeight.w100,
                                              9,
                                              context),
                                          Row(
                                            children: [

                                              Con_Wid.popinsfont(
                                                  "${filteredUsers[index].statusname}",
                                                  Colors.red,
                                                  FontWeight.w600,
                                                  9,
                                                  context),
                                              Con_Wid.popinsfont(
                                                  "  -  ",
                                                  Colors.white,
                                                  FontWeight.w600,
                                                  9,
                                                  context),
                                              Con_Wid.popinsfont(
                                                  "${filteredUsers[index].breedingStatus}",
                                                  Colors.yellow,
                                                  FontWeight.w600,
                                                  9,
                                                  context),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ),
                      Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = !selected;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        )
                                      ],
                                      color: Color(0xFF1E4468),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      )),
                                  height: 40,
                                  width: 40,
                                  child: Icon(Icons.filter_alt_rounded,
                                      color: Colors.white),
                                ),
                              ),
                              AnimatedContainer(
                                margin: const EdgeInsets.only(top: 40),
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(
                                          5.0,
                                          5.0,
                                        ),
                                        blurRadius: 10.0,
                                        spreadRadius: 2.0,
                                      )
                                    ],
                                    color: selected
                                        ? Color(0xFFDBE7F9)
                                        : Color(0xFFDBE7F9),
                                    border: Border.all(
                                        width: 2, color: Colors.white)),
                                width: selected
                                    ? 0
                                    : MediaQuery.of(context).size.width / 1.5,
                                height: selected
                                    ? MediaQuery.of(context).size.height / 3
                                    : MediaQuery.of(context).size.height / 3,
                                alignment: selected
                                    ? Alignment.center
                                    : AlignmentDirectional.topCenter,
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.fastOutSlowIn,
                                child: Column(children: [
                                  Con_Wid.height(10),
                                  CondropDown(
                                    title: 'Select Route',
                                    itemList: Con_List.M_Userherds.map(
                                        (e) => "${e.code}-${e.Name}").toList(),
                                    SelectedList: routeSelected,
                                    onSelected: (List<String> value) {
                                      setState(() {
                                        routeSelected = value;
                                        mSelctRoutecode =
                                            Con_List.M_Userherds.where((e) =>
                                                    e.code.toString() ==
                                                    routeSelected[0]
                                                        .toString()
                                                        .split("-")
                                                        .first
                                                        .toString())
                                                .first
                                                .id
                                                .toString();
                                      });
                                    },
                                  ),
                                  Con_Wid.height(10),
                                  CondropDown(
                                    title: 'Select Society',
                                    itemList: Con_List.M_Userlots.where((e) =>
                                            mSelctRoutecode.isNotEmpty
                                                ? e.herd.toString() ==
                                                    mSelctRoutecode.toString()
                                                : true)
                                        .map((e) => "${e.code}-${e.name}")
                                        .toList(),
                                    SelectedList: societySelected,
                                    onSelected: (List<String> value) {
                                      setState(() {
                                        societySelected = value;
                                        mSelctSocietycode =
                                            Con_List.M_Userlots.where((e) =>
                                                    e.code.toString() ==
                                                    societySelected[0]
                                                        .toString()
                                                        .split("-")
                                                        .first
                                                        .toString())
                                                .first
                                                .id
                                                .toString();
                                      });
                                    },
                                  ),
                                  Con_Wid.height(10),
                                  CondropDown(
                                    color1: ConsfontBlackColor,
                                    title: 'Select Farmer',
                                    itemList: Con_List.M_Farmer.where((e) =>
                                            societySelected.isNotEmpty
                                                ? e.lot.toString() ==
                                                    mSelctSocietycode.toString()
                                                : true)
                                        .map((e) => "${e.code}-${e.name}")
                                        .toList()
                                      ..sort((a, b) => a
                                          .split('-')
                                          .first
                                          .compareTo(b.split('-').first)),
                                    SelectedList: farmerSelected,
                                    onSelected: (List<String> value) {
                                      setState(() {
                                        farmerSelected = value;
                                        mSelctFarmercode =
                                            Con_List.M_Farmer.where((e) =>
                                                    "${e.code}-${e.name}" ==
                                                    value[0])
                                                .map((e) => "${e.id}")
                                                .first;
                                        print(Con_List.M_Farmer.where((e) =>
                                        "${e.code}-${e.name}" ==
                                            value[0])
                                            .map((e) => "${e.mobile}")
                                            .first);
                                      });
                                    },
                                  ),
                                  Con_Wid.height(20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Con_Wid.MainButton(
                                          OnTap: () {
                                            setState(() {
                                              selected = true;
                                              getstatus = !getstatus;
                                            });
                                          },
                                          pStrBtnName: "Status",
                                          height: 35,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          fontSize: 10),
                                      Con_Wid.MainButton(
                                          OnTap: () {
                                            if (routeSelected.isNotEmpty) {
                                              filteredUsers = [];
                                              Con_List.id_Animal_Details
                                                  .forEach((e) {
                                                if (e.herd.toString() ==
                                                    mSelctRoutecode) {
                                                  filteredUsers.add(e);
                                                }
                                              });

                                              setState(() {});
                                            }
                                            if (societySelected.isNotEmpty) {
                                              filteredUsers = [];
                                              Con_List.id_Animal_Details
                                                  .forEach((e) {
                                                if (e.lot.toString() ==
                                                    mSelctSocietycode) {
                                                  filteredUsers.add(e);
                                                }
                                              });
                                              setState(() {});
                                            }
                                            if (mSelctFarmercode.isNotEmpty) {
                                              filteredUsers = [];
                                              Con_List.id_Animal_Details
                                                  .forEach((e) {
                                                if (e.farmer.toString() ==
                                                    mSelctFarmercode) {
                                                  filteredUsers.add(e);
                                                }
                                              });
                                              setState(() {});
                                            }
                                            setState(() {
                                              bre = 0;
                                              cal = 0;
                                              dra = 0;
                                              dry = 0;
                                              hei = 0;
                                              mil = 0;
                                              pradry = 0;
                                              pramil = 0;
                                              pra = 0;
                                              nul = 0;
                                              filteredUsers.forEach((e) {
                                                if (e.statusname
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "null") {
                                                  nul++;
                                                } else if (e.statusname
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "breeding") {
                                                  bre++;
                                                } else if (e.statusname
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "calf") {
                                                  cal++;
                                                } else if (e.statusname
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "draft") {
                                                  dra++;
                                                } else if (e.statusname
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "heifer") {
                                                  hei++;
                                                } else if (e.statusname
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "milking") {
                                                  mil++;
                                                } else if (e.statusname
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "pregnant dry") {
                                                  pradry++;
                                                } else if (e.statusname
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "pregnant milking") {
                                                  pramil++;
                                                } else if (e.statusname
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "pregnant") {
                                                  pra++;
                                                } else if (e.statusname
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "dry") {
                                                  dry++;
                                                }
                                              });
                                              final List<AnimalChart>
                                                  chartData = [
                                                AnimalChart('Pregnant', pra),
                                                AnimalChart('Breeding', bre),
                                                AnimalChart('Calf', cal),
                                                AnimalChart('Draft', dra),
                                                AnimalChart('Dry', dry),
                                                AnimalChart('Milking', mil),
                                                AnimalChart(
                                                    'Pregnant Dry', pradry),
                                                AnimalChart(
                                                    'Pregnant Milking', pramil),
                                                AnimalChart('Null', nul),
                                                AnimalChart('Heifer', hei),
                                              ];
                                              _chartData = chartData;
                                            });

                                            setState(() {
                                              selected = false;
                                            });
                                          },
                                          pStrBtnName: "Apply",
                                          height: 40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          fontSize: 16),
                                    ],
                                  ),
                                ]),
                              )
                            ]),
                      ),
                      getstatus
                          ? Container(
                              height:
                                  MediaQuery.of(context).size.height / 1.5 + 10,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Color(0xFFDBE7F9),
                              ),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Center(
                                      child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              getstatus = false;
                                            });
                                          },
                                          child: Own_Close),
                                    )
                                  ],
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        filteredUsers = [];
                                        Con_List.id_Animal_Details.forEach((e) {
                                          if (e.statusname.toString() ==
                                              "Pregnant") {
                                            filteredUsers.add(e);
                                          }
                                        });
                                        getstatus = false;
                                      });
                                    },
                                    child: Con_Wid.gText("Pregnant")),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        filteredUsers = [];
                                        Con_List.id_Animal_Details.forEach((e) {
                                          if (e.statusname.toString() ==
                                              "Breeding") {
                                            filteredUsers.add(e);
                                          }
                                        });
                                        getstatus = false;
                                      });
                                    },
                                    child: Con_Wid.gText("Breeding")),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        filteredUsers = [];
                                        Con_List.id_Animal_Details.forEach((e) {
                                          if (e.statusname.toString() ==
                                              "Calf") {
                                            filteredUsers.add(e);
                                          }
                                        });
                                        getstatus = false;
                                      });
                                    },
                                    child: Con_Wid.gText("Calf")),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        filteredUsers = [];
                                        Con_List.id_Animal_Details.forEach((e) {
                                          if (e.statusname.toString() ==
                                              "Draft") {
                                            filteredUsers.add(e);
                                          }
                                        });
                                        getstatus = false;
                                      });
                                    },
                                    child: Con_Wid.gText("Draft")),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        filteredUsers = [];
                                        Con_List.id_Animal_Details.forEach((e) {
                                          if (e.statusname.toString() ==
                                              "Dry") {
                                            filteredUsers.add(e);
                                          }
                                        });
                                        getstatus = false;
                                      });
                                    },
                                    child: Con_Wid.gText("Dry")),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        filteredUsers = [];
                                        Con_List.id_Animal_Details.forEach((e) {
                                          if (e.statusname.toString() ==
                                              "Milking") {
                                            filteredUsers.add(e);
                                          }
                                        });
                                        getstatus = false;
                                      });
                                    },
                                    child: Con_Wid.gText("Milking")),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        filteredUsers = [];
                                        Con_List.id_Animal_Details.forEach((e) {
                                          if (e.statusname.toString() ==
                                              "Pregnant Dry") {
                                            filteredUsers.add(e);
                                          }
                                        });
                                        getstatus = false;
                                      });
                                    },
                                    child: Con_Wid.gText("Pregnant Dry")),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        filteredUsers = [];
                                        Con_List.id_Animal_Details.forEach((e) {
                                          if (e.statusname.toString() ==
                                              "Pregnant Milking") {
                                            filteredUsers.add(e);
                                          }
                                        });
                                        getstatus = false;
                                      });
                                    },
                                    child: Con_Wid.gText("Pregnant Milking")),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        filteredUsers = [];
                                        Con_List.id_Animal_Details.forEach((e) {
                                          if (e.statusname.toString() ==
                                              "null") {
                                            filteredUsers.add(e);
                                          }
                                        });
                                        getstatus = false;
                                      });
                                    },
                                    child: Con_Wid.gText("Null")),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        filteredUsers = [];
                                        Con_List.id_Animal_Details.forEach((e) {
                                          if (e.statusname.toString() ==
                                              "Heifer") {
                                            filteredUsers.add(e);
                                          }
                                        });

                                        getstatus = false;
                                      });
                                    },
                                    child: Con_Wid.gText("Heifer")),
                              ]),
                            )
                          : Container()
                    ],
                  ),
                ],
              ),
            ),
          ))),
    );
  }
}

class AnimalChart {
  AnimalChart(this.status, this.count);

  final String status;
  final int count;
}
