import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:herdmannew/Excel.dart';
import 'package:herdmannew/UiScreens/Activity/add_pd_details.dart';
import 'package:herdmannew/UiScreens/Dashboard/Dashboard.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/CalvingDetails.dart';
import 'package:herdmannew/component/DataBaseHelper/Con_List.dart';
import 'package:herdmannew/component/DataBaseHelper/Sync_Database.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../component/Gobal_Widgets/Con_Icons.dart';
import '../../../component/Gobal_Widgets/Con_Textstyle.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../../model/Animal_Details_id.dart';
import '../../../model/Animal_Disposal.dart';
import '../Alarm/Alarm.dart';
import '../AllCattleList/Add_dryoff_details.dart';
import '../AllCattleList/InsemiationDetails.dart';
import '../AllCattleList/Milking.dart';

class ActionScreen extends StatefulWidget {
  String? farmer, task, society;

  ActionScreen([this.farmer, this.task, this.society]);

  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
  TextEditingController soldTo = TextEditingController(),
      price = TextEditingController();

  String actual_date = "";
  String formattedDate = "";
  Animal_Details_id? Mdetail;
  String formattedDate1 = "";
  List<String> disposaltypeadd = [];
  String mStrFromdate = DateFormat('MM/dd/yyyy HH:mm').format(DateTime.now());
  List<String> Msystem = [];
  List<String> Mreason = [];
  List<String> Task = [];
  List<String> id = [];
  List<String> ListTask = [];
  List<String> societySelected = [];
  List<String> mSelctSocietycode = [];
  List<String> farmerSelected = [];
  List<String> mSelctFarmercode = [];
  String Act = "ALL";
  bool isLoadinr = false;
  Color Header = Colors.yellow;
  String Report = "Paravet";
  String staffId = "${Constants_Usermast.staff.toString()}";
  List<dynamic> filteredUsers = [];
  bool visible_search_bar = false,
      selected = true,
      fillsoc = true,
      fillfar = true,
      botton1 = true,
      botton2 = false,
      botton3 = false;
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Con_List.AllActionList.clear();
    getdata();
  }

  getdata() async {
    var box = await Hive.openBox<Animal_Disposal>("Animal_diedDetails");
    try {
      Constants.Last_id_Animal_diedDetails =
          int.parse(box.keys.last.toString());
    } catch (e) {
      Constants.Last_id_Animal_diedDetails = 0;
    }
    if (Con_List.AllActionList.isEmpty) {
      SyncDB.GetActionDetails(staffId).then((value) {
        filteredUsers = Con_List.AllActionList;

        for (var e in Con_List.AllActionList) {
          if (!ListTask.contains(e['Action'])) {
            ListTask.add(e['Action']);
          }
        }
        filteredUsers =
            Con_List.AllActionList.where((e) =>
            (societySelected.isNotEmpty
                ? mSelctSocietycode.any((q) =>
                q.contains(
                    e['lot'].toString()))
                : true) &&
                (farmerSelected.isNotEmpty
                    ? mSelctFarmercode
                    .any((s) =>
                    s.contains(e['Farmer']
                        .toString()))
                    : true) &&
                (Task.isNotEmpty
                    ? Task.any((r) =>
                    r.contains(e['Action']
                        .toString()))
                    : true)).toList();
        setState(() {
          isLoadinr = true;
        });
      });
    } else {
      filteredUsers = Con_List.AllActionList;

      Con_List.AllActionList.forEach((e) {
        if (!ListTask.contains(e['Action'])) {
          ListTask.add(e['Action']);
        }
      });
      setState(() {
        isLoadinr = true;
      });
    }
  }


  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return DashBoardScreen();
          },
        ));
        return Future(() => true);
      },
      child: Scaffold(
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
                  filteredUsers = Con_List.AllActionList.where((u) =>
                  (u['Tagid']
                      .toString()
                      .contains(value.toLowerCase()) ||
                      u['Days from A.I']
                          .toString()
                          .contains(value.toLowerCase()) ||
                      u['Heat Date']
                          .toString()
                          .contains(value.toLowerCase()) ||
                      u['Action']
                          .toLowerCase()
                          .contains(value.toLowerCase()) ||
                      u['Mobile Number'].toString().contains(value) ||
                      u['Farmer Name']
                          .toString()
                          .contains(value.toLowerCase()) ||
                      u['DCS Name']
                          .toLowerCase()
                          .contains(value.toLowerCase()))).toList();
                  setState(() {});
                });
              },
              controller: search,
              style:
              const TextStyle(color: Colors.white, fontFamily: "poppins"),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: 1, horizontal: 15),
                border:
                OutlineInputBorder(borderSide: BorderSide.none),
                hintText: ("Search Tag id"),
                hintStyle:
                TextStyle(color: Colors.white, fontFamily: "poppins"),
              ),
            ),
          ),
          actions: [
            Con_Wid.mIconButton(
                onPressed: () {
                  visible_search_bar = false;
                  setState(() {});
                },
                icon: Own_Close)
          ],
        )
            : Con_Wid.appBar(
          title: "Action",
          Actions: [
            Con_Wid.mIconButton(
                onPressed: () {
                  visible_search_bar = true;
                  setState(() {});
                },
                icon: Own_Search),
            Con_Wid.mIconButton(
                onPressed: () {
                  ExcelSheet.generateExcelFromJson(filteredUsers, "Action");
                  Con_Wid.Con_Show_Toast(context, "Excel Downloaded");
                },
                icon: const Icon(Icons.download))
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
          child: Stack(alignment: Alignment.centerRight, children: [
            isLoadinr
                ? filteredUsers.isEmpty
                ? const Center(
              child: Image(
                  height: 150,
                  width: 150,
                  image:
                  AssetImage("assets/images/No-Data-Found.webp")),
            )
                : con_clr.ConClr2
                ? ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 175,
                  width: double.infinity,
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.only(right: 5, left: 5),
                      height: 44,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: ConClrAppbarGreadiant),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "ID NO: ${filteredUsers[index]['Tagid']}(${filteredUsers[index]['Days from A.I']})",
                                style: const TextStyle(
                                    color: fontwhiteColor,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold)),
                            Text(
                                "AI Date : ${filteredUsers[index]['Heat Date']
                                    .toString()
                                    .substring(0, 10)}",
                                style: const TextStyle(
                                    color: fontwhiteColor,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold)),
                          ]),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      height: 125,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: fontwhiteColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    var action = filteredUsers[index]
                                    ['Action']
                                        .toString();
                                    if (action ==
                                        "Check for Heat" ||
                                        action ==
                                            "Check for First Heat" ||
                                        action ==
                                            "Check for Non Return") {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Insemiationdetails(
                                                index: filteredUsers[
                                                index]['Tagid'],
                                              );
                                            },
                                          ));
                                    } else if (action ==
                                        "Check PD1" ||
                                        action == "Check PD2") {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return add_pd_details(
                                                  index:
                                                  filteredUsers[
                                                  index]
                                                  ['Tagid']);
                                            },
                                          ));
                                    } else if (action ==
                                        "Expected Calving") {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return CalvingDetails(
                                                  index:
                                                  filteredUsers[
                                                  index]
                                                  ['Tagid']);
                                            },
                                          ));
                                    } else if (action ==
                                        "Expected Milking") {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Milking(
                                                  filteredUsers[index]
                                                  ['Tagid']);
                                            },
                                          ));
                                    } else if (action ==
                                        "Dry off") {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Add_dryoff_details(
                                                  index: filteredUsers[index]
                                                  ['Tagid']);
                                            },
                                          ));
                                    }
                                  },
                                  child: Text(
                                      " ${filteredUsers[index]['Action']}",
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontFamily: "Poppins")),
                                ),
                                Spacer(),
                                Con_Wid.mIconButton(
                                    onPressed: () async {},
                                    icon: OwnM_number,
                                    iconSize: 20),
                                InkWell(onTap: () {
                                  _callNumber(filteredUsers[
                                  index][
                                  'Mobile Number']);
                                },
                                  child: Text(
                                      "${filteredUsers[index]['Mobile Number']}   ",
                                      style: const TextStyle(
                                          fontFamily: "Poppins")),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Text(
                            //         "  Farmer Code : ${filteredUsers[index]['Farmer']}"),
                            //   ],
                            // ),
                            Text(
                                "  ${filteredUsers[index]['Farmer Name']}",
                                style: const TextStyle(
                                    fontFamily: "Poppins")),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                "  ${filteredUsers[index]['DCS Name']}",
                                style: const TextStyle(
                                    fontFamily: "Poppins")),
                          ]),
                    ),
                  ]),
                );
              },
            )
                : ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                if (filteredUsers[index]['Action'] ==
                    "Heat Check") {
                  Header = const Color(0xFFD5AD03);
                } else if (filteredUsers[index]['Action'] ==
                    "First Service") {
                  Header = const Color(0xFF08B964);
                } else if (filteredUsers[index]['Action'] ==
                    "Check PD1") {
                  Header = const Color(0xFF64A4D9);
                } else if (filteredUsers[index]['Action'] ==
                    "Check PD2") {
                  Header = const Color(0xFF004F9E);
                } else if (filteredUsers[index]['Action'] ==
                    "Check PD2") {
                  Header = const Color(0xFFDC5555);
                } else if (filteredUsers[index]['Action'] ==
                    "Expected Calving") {
                  Header = const Color(0xFF965AA5);
                } else if (filteredUsers[index]['Action'] ==
                    "Expected Milking") {
                  Header = const Color(0xFF137747);
                } else if (filteredUsers[index]['Action'] ==
                    "Expected Dry") {
                  Header = const Color(0xFF0895AB);
                } else if (filteredUsers[index]['Action'] ==
                    "First Heat") {
                  Header = const Color(0xFFAD1C6F);
                } else if (filteredUsers[index]['Action'] ==
                    "Non Return") {
                  Header = const Color(0xFFE16B36);
                }
                if (filteredUsers[index]['Heat Date']
                    .toString()
                    .isNotEmpty) {
                  String inputDate =
                  filteredUsers[index]['Heat Date'].toString().substring(
                      0, 10);
                  DateTime date = DateTime.parse(inputDate);
                  formattedDate =
                      DateFormat('dd MMM').format(date);
                  formattedDate1 =
                      DateFormat('EEEE yyyy').format(date);
                }
                return Card(
                  margin:
                  const EdgeInsets.only(left: 5, right: 5, top: 10),
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: whiteColor,
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(15))),
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Stack(
                              children: [
                                Image.asset(
                                  fit: BoxFit.fill,
                                  width: 220,
                                  "assets/images/Rectangle 199.png",
                                  color: Header,
                                ),
                                Positioned(
                                  top: 3,
                                  bottom: 3,
                                  left: 3,
                                  right: 3,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          "${filteredUsers[index]['Action']}",
                                          style: const TextStyle(
                                              color: whiteColor,
                                              fontSize: 12))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Container(
                                height: 20,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.only(
                                        topRight:
                                        Radius.circular(
                                            10))),
                                child: Center(
                                    child: Text(
                                      "ID NO : ${filteredUsers[index]['Tagid']}",
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: fontColorSelected),
                                    )),
                              ))
                        ],
                      ),
                      Con_Wid.height(5),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  Text(
                                    " $formattedDate",
                                    style:
                                    const TextStyle(fontSize: 11),
                                  ),
                                  Text(
                                    "$formattedDate1",
                                    style: const TextStyle(
                                        color: fontColorSelected,
                                        fontSize: 11),
                                  ),
                                  Con_Wid.height(5),
                                  Text(
                                    "Days : ${filteredUsers[index]['Days from A.I']}",
                                    style:
                                    const TextStyle(fontSize: 11),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(children: [
                                  Row(
                                    children: [
                                      const Spacer(),
                                      InkWell(
                                          onTap: () {

                                          },
                                          child: const SizedBox(
                                            height: 14,
                                            width: 14,
                                            child: Icon(
                                                Icons.phone,
                                                color: Colors.red,
                                                size: 14),
                                          )),
                                      Con_Wid.width(5),
                                      InkWell(
                                        onTap: () {
                                          _callNumber(filteredUsers[
                                          index][
                                          'Mobile Number']);
                                        },
                                        child: Text(
                                            "${filteredUsers[index]['Mobile Number']}",
                                            style: const TextStyle(
                                                fontSize: 11,
                                                color: Colors.red)),
                                      ),
                                      Con_Wid.width(5)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            "${filteredUsers[index]['Farmer Name']}",
                                            style: const TextStyle(
                                                fontSize: 11,
                                                fontFamily:
                                                "Poppins")),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "${filteredUsers[index]['DCS Name']}",
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontFamily:
                                              "Poppins")),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "${filteredUsers[index]['DCS Code']}",
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontFamily:
                                              "Poppins")),
                                    ],
                                  )
                                ]),
                              ))
                        ],
                      ),
                      Con_Wid.height(5),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Disposal_dialog(filteredUsers[index]
                              ['Tagid']
                                  .toString());
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: whiteColor1,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)),
                              ),
                              height: 25,
                              width: 120,
                              child: Con_Wid.gText("Disposal Entry",
                                  style: TextStyle(fontSize: 12)),
                            ),
                          ),
                          Con_Wid.width(20),
                          InkWell(
                            onTap: () {
                              if(!Con_List.id_Animal_Details.any((element) => element.tagId.toString() == filteredUsers[index]['Tagid'].toString()))
                                {
                                  Con_Wid.Con_Show_Toast(context, "Animal not Found");
                                }else
                                {
                              var action = filteredUsers[index]['Action']
                                  .toString();
                              if (action == "Heat Check" ||
                                  action == "First Heat" ||
                                  action == "Non Return") {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Insemiationdetails(
                                          path: "Action",
                                          index: filteredUsers[index]
                                          ['Tagid'],
                                        );
                                      },
                                    ));
                              } else if (action == "Check PD1" ||
                                  action == "Check PD2") {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return add_pd_details(
                                            path: "Action",
                                            index:
                                            filteredUsers[index]
                                            ['Tagid']);
                                      },
                                    ));
                              } else if (action ==
                                  "Expected Calving") {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return CalvingDetails(
                                            path: "Action",
                                            index:
                                            filteredUsers[index]
                                            ['Tagid']);
                                      },
                                    ));
                              } else if (action ==
                                  "Expected Milking") {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Milking(
                                            filteredUsers[index]
                                            ['Tagid']);
                                      },
                                    ));
                              } else if (action ==
                                  "Expected Dry") {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Add_dryoff_details(
                                          index: filteredUsers[index]
                                          ['Tagid'], path: "Action",);
                                      },
                                    ));
                              }}
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 25,
                              width: 120,
                              decoration: const BoxDecoration(
                                color: whiteColor1,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)),
                              ),
                              child: Text(
                                  "${filteredUsers[index]['Action']}",
                                  style: const TextStyle(fontSize: 12)),
                            ),
                          )
                        ],
                      )
                    ]),
                  ),
                );
              },
            )
                : const Center(child: CircularProgressIndicator()),
            Row(
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
                      child:
                      const Icon(
                          Icons.filter_alt_rounded, color: Colors.white),
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
                        color:
                        selected ? const Color(0xFFDBE7F9) : const Color(
                            0xFFDBE7F9),
                        border: Border.all(width: 2, color: Colors.white)),
                    width: selected
                        ? 0
                        : MediaQuery
                        .of(context)
                        .size
                        .width / 1.5,
                    height: selected
                        ? MediaQuery
                        .of(context)
                        .size
                        .height / 2.2
                        : MediaQuery
                        .of(context)
                        .size
                        .height / 2.2,
                    alignment: selected
                        ? Alignment.center
                        : AlignmentDirectional.topCenter,
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.fastOutSlowIn,
                    child: Column(children: [
                      Container(
                          height: 60,
                          width: double.infinity,
                          decoration: con_clr.ConClr2
                              ? const BoxDecoration(
                              gradient: LinearGradient(
                                colors: ConClrAppbarGreadiant,
                              ))
                              : const BoxDecoration(color: ConClrDialog),
                          child: Stack(
                            children: [
                              Center(
                                child: Con_Wid.popinsfont(
                                    "Filter",
                                    fontwhiteColor,
                                    FontWeight.w600,
                                    15,
                                    context),
                              )
                            ],
                          )),
                      Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Con_Wid.height(20),
                                CondropDown(
                                  isMultiSelect: true,
                                  title: 'Select Society',
                                  itemList: Con_List.M_Userlots.map(
                                          (e) => "${e.code}-${e.name}")
                                      .toList(),
                                  SelectedList: societySelected,
                                  onSelected: (List<String> value) {
                                    setState(() {
                                      societySelected = value;
                                      farmerSelected.clear();
                                      mSelctFarmercode.clear();
                                      mSelctSocietycode =
                                          Con_List.M_Userlots.where((e) =>
                                              value
                                                  .any((u) =>
                                                  u.contains(e.code)))
                                              .map((e) => "${e.id}")
                                              .toList();
                                    });
                                  },
                                ),
                                CondropDown(
                                  isMultiSelect: true,
                                  color1: ConsfontBlackColor,
                                  title: 'Select Farmer',
                                  itemList: Con_List.M_Farmer.where((e) =>
                                  societySelected.isNotEmpty
                                      ? mSelctSocietycode.any((u) =>
                                      u.contains(e.lot.toString()))
                                      : true)
                                      .map((e) => "${e.code}-${e.name}")
                                      .toList()
                                    ..sort((a, b) =>
                                        a
                                            .split('-')
                                            .first
                                            .compareTo(b
                                            .split('-')
                                            .first)),
                                  SelectedList: farmerSelected,
                                  onSelected: (List<String> value) {
                                    setState(() {
                                      farmerSelected = value;
                                      mSelctFarmercode =
                                          Con_List.M_Farmer.where(
                                                  (e) =>
                                                  value.any((u) =>
                                                  u.toString().contains(
                                                      e.code.toString()) &&
                                                      u.toString().contains(
                                                          e.name.toString())))
                                              .map((e) => "${e.id}")
                                              .toList();
                                    });
                                  },
                                ),
                                CondropDown(
                                  isMultiSelect: true,
                                  title: 'Select Task',
                                  itemList: ListTask,
                                  SelectedList: Task,
                                  onSelected: (List<String> value) {
                                    setState(() {
                                      Task = value;
                                    });
                                  },
                                ),
                                CondropDown(
                                  title: 'Select Staff',
                                  itemList: Con_List.M_inseminator.map((
                                      e) => "${e.id}-${e.name}").toList(),
                                  SelectedList: id,
                                  onSelected: (List<String> value) {
                                    setState(() {
                                      staffId = value[0].toString().substring(
                                          0, value[0].indexOf("-"));
                                    });
                                  },
                                ),
                                Con_Wid.height(10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Con_Wid.MainButton(
                                        OnTap: () {
                                          selected = true;
                                          setState(() {});
                                          filteredUsers =
                                              Con_List.AllActionList;
                                          if (id.isEmpty) {
                                            setState(() {
                                              filteredUsers =
                                                  Con_List.AllActionList
                                                      .where((e) =>
                                                  (societySelected.isNotEmpty
                                                      ? mSelctSocietycode
                                                      .any((q) =>
                                                      q.contains(
                                                          e['lot']
                                                              .toString()))
                                                      : true) &&
                                                      (farmerSelected
                                                          .isNotEmpty
                                                          ? mSelctFarmercode
                                                          .any((s) =>
                                                          s.contains(
                                                              e['Farmer']
                                                                  .toString()))
                                                          : true) &&
                                                      (Task.isNotEmpty
                                                          ? Task.any((r) =>
                                                          r.contains(
                                                              e['Action']
                                                                  .toString()))
                                                          : true)).toList();
                                            });
                                          }
                                          else {
                                            isLoadinr = false;
                                            setState(() {});
                                            Con_List.AllActionList = [];
                                            getdata();
                                            filteredUsers =
                                                Con_List.AllActionList.where((
                                                    e) =>
                                                (societySelected.isNotEmpty
                                                    ? mSelctSocietycode.any((
                                                    q) =>
                                                    q.contains(
                                                        e['lot'].toString()))
                                                    : true) &&
                                                    (farmerSelected.isNotEmpty
                                                        ? mSelctFarmercode
                                                        .any((s) =>
                                                        s.contains(e['Farmer']
                                                            .toString()))
                                                        : true) &&
                                                    (Task.isNotEmpty
                                                        ? Task.any((r) =>
                                                        r.contains(e['Action']
                                                            .toString()))
                                                        : true)).toList();
                                            setState(() {});
                                          }
                                        },
                                        pStrBtnName: "Apply",
                                        height: 45,
                                        width: 180,
                                        fontSize: 16)
                                  ],
                                )
                              ],
                            ),
                          ))
                    ]),
                  )
                ])
          ]),
        ),
      ),
    );
  }

  Disposal_dialog(String tagID) {
    Mdetail = Con_List.id_Animal_Details
        .firstWhere((element) => element.tagId == tagID);
    print(formattedDate);
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState1) {
            return Material(
              color: Colors.transparent,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 50, vertical: con_clr.ConClr2 ? 220 : 150),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, right: 10, left: 10, bottom: 20),
                        height: double.infinity,
                        width: double.infinity,
                        decoration: con_clr.ConClr2
                            ? BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: ConClrAppbarGreadiant,
                            ))
                            : BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ConClrSelected),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, left: 10),
                              child: Con_Wid.gText(
                                "Disposal Entry",
                                style: ConStyle.style_white_14s_500w(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 65),
                        child: Container(
                          decoration: con_clr.ConClr2
                              ? BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            color: con_clr.ConClr2
                                ? ConClrMainLight
                                : whiteColor,
                          )
                              : BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                            color: con_clr.ConClr2
                                ? ConClrMainLight
                                : whiteColor,
                          ),
                          child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Con_Wid.height(10),
                                  Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Con_Wid.selectionContainer(
                                            height: 44,
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width /
                                                5,
                                            text: "Today",
                                            textcolor: botton1
                                                ? Colors.white
                                                : ConClrSelected,
                                            ontap: () {
                                              mStrFromdate =
                                                  DateFormat('dd/MM/yyyy HH:mm')
                                                      .format(DateTime.now());

                                              setState1(() {
                                                botton2 = false;
                                                botton3 = false;
                                                botton1 = true;
                                              });
                                            },
                                            Color: botton1
                                                ? ConClrSelected
                                                : Colors.white54,
                                            context: context),
                                        Con_Wid.selectionContainer(
                                            height: 44,
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width /
                                                5,
                                            text: "Yesterday",
                                            textcolor: botton2
                                                ? Colors.white
                                                : ConClrSelected,
                                            ontap: () {
                                              mStrFromdate = DateFormat(
                                                  'dd/MM/yyyy HH:mm')
                                                  .format(DateTime.now()
                                                  .subtract(
                                                  Duration(days: 1)));
                                              setState1(() {
                                                botton3 = false;
                                                botton1 = false;
                                                botton2 = true;
                                              });
                                            },
                                            Color: botton2
                                                ? ConClrSelected
                                                : Colors.white54,
                                            context: context),
                                        Con_Wid.selectionContainer(
                                            height: 44,
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width /
                                                5,
                                            text: "Calender",
                                            textcolor: botton3
                                                ? Colors.white
                                                : ConClrSelected,
                                            ontap: () async {
                                              mStrFromdate =
                                              await Con_Wid.GlbDatePicker(
                                                  pcontext: context);
                                              setState1(() {
                                                botton1 = false;
                                                botton2 = false;
                                                botton3 = true;
                                              });
                                            },
                                            Color: botton3
                                                ? ConClrSelected
                                                : Colors.white54,
                                            context: context),
                                      ],
                                    ),
                                  ),
                                  Con_Wid.height(10),
                                  Wrap(
                                    children: [
                                      Text("Disposal Date : $mStrFromdate"),
                                    ],
                                  ),
                                  Con_Wid.height(10),
                                  CondropDown(
                                    title: 'Select Disposal Type',
                                    itemList: Con_List.M_disposal.map(
                                            (e) => e.name.toString()).toList(),
                                    SelectedList: disposaltypeadd,
                                    onSelected: (List<String> value) {
                                      setState1(() {
                                        disposaltypeadd.contains(value);
                                        disposaltypeadd = value;
                                      });
                                    },
                                  ),
                                  listEquals(disposaltypeadd, ["Sold"])
                                      ? Container(
                                    child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Con_Wid.textFieldWithInter(
                                              text: "Sold To",
                                              controller: soldTo,
                                              hintText: "Sold To"),
                                          Con_Wid.textFieldWithInter(
                                              TextInput_Type:
                                              TextInputType.number,
                                              text: "Price",
                                              controller: price,
                                              hintText: "Enter price")
                                        ]),
                                  )
                                      : Container(),
                                  listEquals(disposaltypeadd, ["Died"])
                                      ? Container(
                                    child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CondropDown(
                                            title: 'Select System',
                                            itemList: Con_List
                                                .M_systemAffected
                                                .map((e) =>
                                                e.name.toString())
                                                .toList(),
                                            SelectedList: Msystem,
                                            onSelected:
                                                (List<String> value) {
                                              setState1(() {
                                                Msystem = value;
                                              });
                                            },
                                          )
                                        ]),
                                  )
                                      : Container(),
                                  listEquals(disposaltypeadd, ["Unknown"])
                                      ? Container()
                                      : Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Con_Wid.height(5),
                                            CondropDown(
                                              title: 'Select Reason',
                                              itemList: Con_List
                                                  .M_disposalSubOptions
                                                  .map((e) =>
                                              e.name).toList(),
                                              SelectedList: Mreason,
                                              onSelected:
                                                  (List<String> value) {
                                                setState1(() {
                                                  Mreason = value;
                                                });
                                              },
                                            ),
                                          ]),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Con_Wid.selectionContainer(
                                          height: 38,
                                          width: 87,
                                          text: "Cancel",
                                          ontap: () {
                                            Navigator.pop(context);
                                          },
                                          textcolor: con_clr.ConClr2
                                              ? whiteColor
                                              : ConClrSelected,
                                          Color: con_clr.ConClr2
                                              ? ConClrLightBack
                                              : whiteColor,
                                          context: context),
                                      Con_Wid.selectionContainer(
                                          height: 38,
                                          width: 87,
                                          text: "Submit",
                                          context: context,
                                          ontap: () {
                                            String reason1 = "";
                                            String died = "";
                                            if (Mreason.isNotEmpty) {
                                              Con_List.M_disposalSubOptions
                                                  .forEach((element) {
                                                if (element.name ==
                                                    Mreason[0].toString()) {
                                                  reason1 =
                                                      element.id.toString();
                                                }
                                              });
                                            }
                                            if (Msystem.isNotEmpty) {
                                              Con_List.M_systemAffected.forEach(
                                                      (element) {
                                                    if (element.name ==
                                                        Msystem[0].toString()) {
                                                      died =
                                                          element.id.toString();
                                                    }
                                                  });
                                            }

                                            var date;
                                            if (mStrFromdate == null) {
                                              date =  DateTime.now();
                                              var formatter1 =  DateFormat(
                                                  'MM/dd/yyyy HH:mm');
                                              actual_date =
                                                  formatter1.format(date);

                                            } else {
                                              actual_date =
                                                  mStrFromdate.toString();
                                            }
                                            List<Animal_Disposal>
                                            animalDetails = [
                                              Animal_Disposal(
                                                  oldTagId: "${Mdetail!.tagId}",
                                                  tagId: "${Mdetail!.tagId}",
                                                  date: actual_date,
                                                  soldTo: soldTo.text != ""
                                                      ? soldTo.text
                                                      : "",
                                                  soldPrice: price.text != ""
                                                      ? double.parse(price.text)
                                                      : "0.0",
                                                  herd: int.parse(
                                                      Mdetail!.herd.toString()),
                                                  lot: int.parse(
                                                      Mdetail!.lot.toString()),
                                                  farmer: int.parse(Mdetail!
                                                      .farmer
                                                      .toString()),
                                                  oldDetails:
                                                  "${Mdetail!.tagId}",
                                                  details: null,
                                                  disposalReason: reason1 != ""
                                                      ? int.parse(reason1)
                                                      : 0,
                                                  diedReason: died != ""
                                                      ? int.parse(died)
                                                      : null,
                                                  id: Constants
                                                      .Last_id_Animal_diedDetails +
                                                      1,
                                                  createdAt: DateFormat(
                                                      'MM/dd/yyyy HH:mm')
                                                      .format(DateTime.now())
                                                      .toString(),
                                                  updatedAt: null,
                                                  lastUpdatedByUser: null,
                                                  createdByUser: int.parse(
                                                      Constants_Usermast.user_id
                                                          .toString()),
                                                  staff: 1,
                                                  disposaltype: 1,
                                                  SyncStatus: "0",
                                                  ServerId: "")
                                            ];
                                            Animal_Disposal rnd = animalDetails[
                                            math.Random().nextInt(
                                                animalDetails.length)];
                                            List<Map> weights_sync_datas = [];
                                            weights_sync_datas
                                                .add(rnd.toJson(rnd));
                                            SyncDB.insert_table(
                                                weights_sync_datas,
                                                Constants
                                                    .Tbl_Animal_diedDetails);
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return ActionScreen();
                                                  },
                                                ));
                                            setState1(() {});
                                          },
                                          textcolor: whiteColor,
                                          Color: con_clr.ConClr2
                                              ? ConClrbluelight
                                              : ConClrSelected),
                                    ],
                                  ),
                                  Con_Wid.height(10),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  _callNumber(String nom) async {
    String number = nom.toString(); //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
