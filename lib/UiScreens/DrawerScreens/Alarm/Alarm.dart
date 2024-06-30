import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

import '../../../Excel.dart';
import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Database.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../component/Gobal_Widgets/Con_Icons.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../Dashboard/Dashboard.dart';

class AlarmScreen extends StatefulWidget {
  String? farmer, task, society;

  AlarmScreen([this.farmer, this.task, this.society]);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  List<String> society = [];
  List<String> society1 = [];
  List<String> lotlist = [];
  List<String> Societyselected = [];
  List<String> mSelctSocietycode = [];
  List<String> farmerSelected = [];
  List<String> mSelctFarmercode = [];
  List<String> taskselected = [];
  Color Header = Colors.yellow;
  List<String> farmer = [];
  String route = "";
  bool loading = false;
  String mStringtaskselect = "PD Not Checked > 90 days";
  String Report = "Paravet";
  String staffId = "${Constants_Usermast.staff.toString()}";
  List<dynamic> mAlarmdata = [];
  List<dynamic> filteredUsers = [];
  List<dynamic> onclosefilteredUsers = [];
  bool visible_search_bar = false, selected = true;
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    getAlldata();
    getList();
    setState(() {});
  }

  getAlldata() async {
    if (mAlarmdata.isEmpty) {
      mAlarmdata = await SyncDB.getAlarm(
          "all", "${Constants_Usermast.staff.toString()}", "Paravet");
      filteredUsers = mAlarmdata;
      onclosefilteredUsers = filteredUsers;

      setState(() {
        loading = true;
      });
    }
  }

  getdata() {
    if (Con_List.M_smsSetting.isEmpty ||
        Con_List.M_Userlots.isEmpty ||
        Con_List.M_Farmer.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_smsSetting);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_lot);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_farmer);
    }
  }

  GetAlarmDetails() async {
    if (widget.society!.isNotEmpty) {
      Report = "Dcs";
      staffId = widget.society.toString().trim();
    }
    if (widget.farmer!.isNotEmpty) {
      if (widget.society!.isEmpty) {
        Report = "Dcs";
        staffId = widget.farmer.toString().trim();
      }
      Report = "Farmer";
      staffId = widget.farmer.toString().trim();
    }
    if (widget.task!.isNotEmpty) {
      mStringtaskselect = widget.task.toString().trim();
    }
    mAlarmdata = await SyncDB.getAlarm(mStringtaskselect, staffId, Report);
    filteredUsers = mAlarmdata;
  }

  getList() {
    Con_List.M_Userlots.forEach(
        (e) => society.add("${e.id}-${e.name.toString()}"));
    Con_List.M_Farmer.forEach((e) {
      farmer.add(e.id.toString() + "-" + e.name.toString());
    });
    lotlist.add("PD Not Checked > 90 days");
    lotlist.add("Open Unbred > 90 days");
    lotlist.add("Open Animals");
    lotlist.add("Open Bred > 120 days");
    lotlist.add("No of A.I > 3");
    lotlist.add("Gestation Days > 280 days");
    lotlist.add("Low Milk Yield");
    lotlist.add("Low Avg Yield");
  }

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
                        filteredUsers = mAlarmdata
                            .where((u) => (u['TagId']
                                    .toString()
                                    .contains(value.toLowerCase()) ||
                                u['Farmer Name']
                                    .toLowerCase()
                                    .contains(value) ||
                                u['Phno']
                                    .toString()
                                    .contains(value.toLowerCase()) ||
                                u['Alarm']
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                u['Farmer Code']
                                    .toString()
                                    .contains(value.toLowerCase()) ||
                                u['HMB Code']
                                    .toString()
                                    .contains(value.toLowerCase()) ||
                                u['HMB Name']
                                    .toLowerCase()
                                    .contains(value.toLowerCase())))
                            .toList();
                        setState(() {});
                      });
                    },
                    controller: search,
                    style:
                        TextStyle(color: Colors.white, fontFamily: "poppins"),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 15),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
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
                        filteredUsers = onclosefilteredUsers;
                        setState(() {});
                      },
                      icon: Own_Close)
                ],
              )
            : Con_Wid.appBar(
                title: "Alarm",
                Actions: [
                  Con_Wid.mIconButton(
                      onPressed: () {
                        visible_search_bar = true;
                        setState(() {});
                      },
                      icon: Own_Search),
                  Con_Wid.mIconButton(
                      onPressed: () {
                        ExcelSheet.generateExcelFromJson(filteredUsers,"Alarm");
                        Con_Wid.Con_Show_Toast(context, "Excel Downloaded");
                      },
                      icon: Icon(Icons.download))

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
             loading ?Center(
                    child: CircularProgressIndicator(),
                  ):
             filteredUsers.isEmpty
                      ? Center(
                          child: Image(
                              height: 150,
                              width: 150,
                              image: AssetImage(
                                  "assets/images/No-Data-Found.webp")),
                        )
                      : con_clr.ConClr2
                          ? ListView.builder(
                              itemCount: filteredUsers.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  height: 160,
                                  width: double.infinity,
                                  child: Column(children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(right: 5, left: 5),
                                      height: 44,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: ConClrAppbarGreadiant),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              topLeft: Radius.circular(10))),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "${filteredUsers[index]['Alarm']}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    fontFamily: "Poppins",
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                "ID NO: ${filteredUsers[index]['TagId']}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    fontFamily: "Poppins",
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ]),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(right: 5, left: 5),
                                      height: 115,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: fontwhiteColor,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight:
                                                  Radius.circular(10))),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                height: 40,
                                                width: 210,
                                                child: Text(
                                                    "   ${filteredUsers[index]['Farmer Name']}",
                                                    style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                              Con_Wid.width(10),
                                              Icon(
                                                Icons.phone,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                              filteredUsers[index]['Phno'] != ""
                                                  ? InkWell(
                                                onTap: () {
                                                  _callNumber(filteredUsers[index]['Phno']);
                                                },
                                                    child: Text(
                                                        "  ${filteredUsers[index]['Phno']}",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins")),
                                                  )
                                                  : Text("  Null",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Poppins"))
                                            ]),
                                            // Row(
                                            //   children: [
                                            //     Text(
                                            //         "  Farmer Code : ${filteredUsers[index]['Farmer Code']}"),
                                            //   ],
                                            // ),
                                            Text(
                                                "   Society Name : ${filteredUsers[index]['HMB Name']}",
                                                style: TextStyle(
                                                    fontFamily: "Poppins")),
                                            Con_Wid.height(5),
                                            Row(children: [
                                              Text(
                                                  "   Society Code : ${filteredUsers[index]['HMB Code']}",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins")),
                                              Spacer(),
                                              Text(
                                                  "${filteredUsers[index]['Days']}   ",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins")),
                                            ]),
                                          ]),
                                    ),
                                  ]),
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: filteredUsers.length,
                              itemBuilder: (context, index) {
                                if (filteredUsers[index]['Alarm'] ==
                                    "PD Not Checked > 90 days") {
                                  Header = Color(0xFFD5AD03);
                                } else if (filteredUsers[index]['Alarm'] ==
                                    "Open Unbred > 90 days") {
                                  Header = Color(0xFF08B964);
                                } else if (filteredUsers[index]['Alarm'] ==
                                    "Open Bred > 120 days") {
                                  Header = Color(0xFF64A4D9);
                                } else if (filteredUsers[index]['Alarm'] ==
                                    "No of A.I > 3") {
                                  Header = Color(0xFF004F9E);
                                } else if (filteredUsers[index]['Alarm'] ==
                                    "Gestation Days > 280 days") {
                                  Header = Color(0xFFDC5555);
                                } else if (filteredUsers[index]['Alarm'] ==
                                    "Low Milk Yield") {
                                  Header = Color(0xFF965AA5);
                                } else if (filteredUsers[index]['Alarm'] ==
                                    "Low Avg Yield") {
                                  Header = Color(0xFF137747);
                                } else if (filteredUsers[index]['Alarm'] ==
                                    "Open Animals") {
                                  Header = Color(0xFF0895AB);
                                }
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  margin: const EdgeInsets.only(
                                      left: 5, right: 5, top: 10),
                                  borderOnForeground: true,
                                  color: whiteColor,
                                  child: Container(
                                    height: 160,
                                    width: double.infinity,
                                    child: Column(children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                            height: 30,
                                            child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Image.asset(
                                                    fit: BoxFit.fill,
                                                    width: 220,
                                                    "assets/images/Rectangle 199.png",
                                                    color: Header,
                                                  ),
                                                  Center(
                                                      child: Text(
                                                    "${filteredUsers[index]['Alarm']}",
                                                    style: TextStyle(
                                                        color: whiteColor,
                                                        fontSize: 11),
                                                  ))
                                                ]),
                                          )

                                              ),
                                          Expanded(
                                              child: Container(
                                            height: 20,
                                            child: Center(
                                                child: Text(
                                              "ID NO: ${filteredUsers[index]['TagId']}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: fontColorSelected),
                                            )),
                                          ))
                                        ],
                                      ),
                                      Con_Wid.height(5),
                                      Row(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            Icons.phone,
                                            color: Colors.red,
                                            size: 14,
                                          ),
                                          filteredUsers[index]['Phno'] != ""
                                              ? InkWell(
                                            onTap: () {
                                              _callNumber(filteredUsers[index]['Phno']);
                                            },
                                                child: Text(
                                                    "  ${filteredUsers[index]['Phno']}  ",
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        color: Colors.red,
                                                        fontSize: 11)),
                                              )
                                              : Text("  Null  ",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Colors.red,
                                                      fontSize: 11)),
                                          Con_Wid.width(5)
                                        ],
                                      ),
                                      Con_Wid.height(5),
                                      Row(
                                        children: [
                                          Con_Wid.width(5),
                                          Text(
                                              "   ${filteredUsers[index]['Farmer Name']}",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 11)),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Con_Wid.width(5),
                                          Text(
                                              "   Lot Name : ${filteredUsers[index]['HMB Name']}",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 11)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Con_Wid.width(5),
                                          Text(
                                              "   Days : ${filteredUsers[index]['Days']}",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 11)),
                                        ],
                                      ),
                                      Row(children: [
                                        Con_Wid.width(5),
                                        Text(
                                            "   Lote Code : ${filteredUsers[index]['HMB Code']}",
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 11)),
                                        Spacer(),
                                        Text(
                                            "${filteredUsers[index]['Days']}   ",
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 11)),
                                      ]),
                                    ]),
                                  ),
                                );
                              },
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
                        child:
                            Icon(Icons.filter_alt_rounded, color: Colors.white),
                      ),
                    ),
                    AnimatedContainer(
                      margin: EdgeInsets.only(top: 40),
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
                              selected ? Color(0xFFDBE7F9) : Color(0xFFDBE7F9),
                          border: Border.all(width: 2, color: Colors.white)),
                      width: selected
                          ? 0
                          : MediaQuery.of(context).size.width / 1.5,
                      height: selected
                          ? MediaQuery.of(context).size.height / 2.2
                          : MediaQuery.of(context).size.height / 2.2,
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
                              ? BoxDecoration(
                                  gradient: LinearGradient(
                                  colors: ConClrAppbarGreadiant,
                                ))
                              : BoxDecoration(color: ConClrDialog),
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
                          ),
                        ),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Con_Wid.paddingWithText(
                              //     "Society", Conclrfontmain),
                              SizedBox(height: 5),
                              CondropDown(
                                isMultiSelect: true,
                                title: 'Select Society',
                                itemList: Con_List.M_Userlots.map(
                                    (e) => "${e.code}-${e.name}").toList(),
                                SelectedList: Societyselected,
                                onSelected: (List<String> value) {
                                  setState(() {
                                    Societyselected = value;
                                    mSelctSocietycode =
                                        Con_List.M_Userlots.where((e) => value
                                                .any((u) => u.contains(e.code)))
                                            .map((e) => "${e.id}")
                                            .toList();
                                  });
                                },
                              ),
                              SizedBox(height: 5),
                              // Con_Wid.paddingWithText(
                              //     "Farmer", Conclrfontmain),
                              CondropDown(
                                isMultiSelect: true,
                                color1: ConsfontBlackColor,
                                title: 'Select Farmer',
                                itemList: Con_List.M_Farmer.where((e) =>
                                        Societyselected.isNotEmpty
                                            ? mSelctSocietycode.any((u) =>
                                                u.contains(e.lot.toString()))
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
                                    mSelctFarmercode = Con_List.M_Farmer.where(
                                            (e) => value.any((u) =>
                                                u.toString().contains(
                                                    e.code.toString()) &&
                                                u.toString().contains(
                                                    e.name.toString())))
                                        .map((e) => "${e.id}")
                                        .toList();
                                  });
                                },
                              ),
                              SizedBox(height: 5),
                              // Con_Wid.paddingWithText(
                              //     "Task", Conclrfontmain),
                              CondropDown(
                                isMultiSelect: true,
                                title: 'Select Task',
                                itemList: lotlist,
                                SelectedList: taskselected,
                                onSelected: (List<String> value) {
                                  setState(() {
                                    taskselected = value;
                                  });
                                },
                              ),
                              Con_Wid.height(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Con_Wid.MainButton(
                                      OnTap: () {
                                        filteredUsers = mAlarmdata;
                                        setState(() {
                                          filteredUsers = mAlarmdata
                                              .where((e) =>
                                                  (mSelctSocietycode.isNotEmpty
                                                      ? mSelctSocietycode.any((q) =>
                                                          q.contains(e['HMB Code']
                                                              .toString()))
                                                      : true) &&
                                                  (farmerSelected.isNotEmpty
                                                      ? mSelctFarmercode.any(
                                                          (s) => s.contains(
                                                              e['Farmer Code']
                                                                  .toString()))
                                                      : true) &&
                                                  (taskselected.isNotEmpty
                                                      ? taskselected.any((r) => r.contains(e['Alarm'].toString()))
                                                      : true))
                                              .toList();
                                        });
                                      },
                                      pStrBtnName: "Apply",
                                      height: 40,
                                      width: 100,
                                      fontSize: 12)
                                ],
                              )
                            ],
                          ),
                        ))
                      ]),
                    )
                  ]),
            )
          ]),
        ),
      ),
    );
  }
  _callNumber(String nom) async{
    String number = nom.toString(); //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
class FlutterPhoneDirectCaller {
  static const MethodChannel _channel =
  MethodChannel('flutter_phone_direct_caller');

  static Future<bool?> callNumber(String number) async {
    return await _channel.invokeMethod(
      'callNumber',
      <String, Object>{
        'number': number,
      },
    );
  }
}