import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../component/Gobal_Widgets/Con_Icons.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../../component/Gobal_Widgets/Con_Widget.dart';
import '../../Dashboard/Dashboard.dart';
import 'ADDUnitReport.dart';

class UnitReport extends StatefulWidget {
  const UnitReport({super.key});

  @override
  State<UnitReport> createState() => _UnitReportState();
}

class _UnitReportState extends State<UnitReport> {
  List<dynamic> All_Report = [];
  List<dynamic> All_Report2 = [];
  bool loading = false;
  String FilterDate = DateTime.now().toString().substring(0, 10);
  List<String> SelectedDCS = [];
  TextEditingController outside = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.bluetooth ||
        connectivityResult == ConnectivityResult.ethernet ||
        connectivityResult == ConnectivityResult.vpn ||
        connectivityResult == ConnectivityResult.other ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        loading = false;
      });
      var response = await ApiCalling.getdata(
          AppUrl().GET_UNITREPORT, Constants_Usermast.token);
      if (response.statusCode == 200) {
        All_Report = jsonDecode(response.body)['data'];
        All_Report2 = All_Report;
        print(All_Report2);
        loading = true;
        setState(() {});
      }
      var Response = await ApiCalling.getdata(
          AppUrl().GET_CENTER + Constants_Usermast.company,
          Constants_Usermast.token);
      Con_List.CenterList = jsonDecode(Response.body);
      print(Con_List.CenterList);
      setState(() {});
    } else {
      loading = true;
      setState(() {});
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
                return DashBoardScreen();
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
          appBar: Con_Wid.appBar(
            title: "Unit Entry Report",
            Actions: [
              Con_Wid.mIconButton(
                  onPressed: () async {
                    FilterDate = await Con_Wid.GlbDatePicker(
                        pcontext: context, formate: "11");
                    All_Report = All_Report2.where((element) => element['Date'].toString().substring(0,10)==FilterDate.substring(0,10)).toList();
                    setState(() {
                    });
                  },
                  icon: Own_calendar,
                  VisualDensity: VisualDensity(
                      horizontal: VisualDensity.minimumDensity)),
              IconButton(
                  splashRadius: 20,
                  onPressed: () async {
                    await get();
                    setState(() {});
                  },
                  icon: Icon(Icons.refresh)),IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return Add_UnitReport();
                      },
                    ));
                  },
                  icon: Icon(Icons.add))
            ],
            onBackTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return DashBoardScreen();
                },
              ));
            },
          ),
          body: loading
              ? All_Report.isNotEmpty
                  ? Con_Wid.backgroundContainer(
                      child: ListView.builder(
                        itemCount: All_Report.length,
                        itemBuilder: (context, index) {
                          return Card(
                              margin: const EdgeInsets.only(
                                  left: 5, right: 5, top: 10),
                              color: whiteColor,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset(
                                                fit: BoxFit.fill,
                                                width: 150,
                                                "assets/images/Rectangle 199.png",
                                                color: (All_Report[index]
                                                                    ['End Unit']
                                                                .toString() ==
                                                            "null" ||
                                                        All_Report[index]
                                                                    ['To Time']
                                                                .toString() ==
                                                            "null")
                                                    ? Colors.red
                                                    : Colors.green,
                                              ),
                                              (All_Report[index]['End Unit']
                                                              .toString() ==
                                                          "null" ||
                                                      All_Report[index]
                                                                  ['To Time']
                                                              .toString() ==
                                                          "null")
                                                  ? Text(
                                                      "Pending",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  : const Text("Completed",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                            ],
                                          ),
                                          Spacer(),
                                          Con_Wid.mIconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return StatefulBuilder(
                                                      builder:
                                                          (context, setState1) {
                                                        return Dialog(
                                                          child: Container(
                                                            height: 300,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: con_clr
                                                                        .ConClr2
                                                                    ? fontwhiteColor
                                                                    : whiteColor),
                                                            child: Column(
                                                                children: [
                                                                  Container(
                                                                    height: 60,
                                                                    width: double
                                                                        .infinity,
                                                                    decoration: con_clr
                                                                            .ConClr2
                                                                        ? BoxDecoration(
                                                                            gradient: LinearGradient(
                                                                                colors:
                                                                                    ConClrAppbarGreadiant))
                                                                        : BoxDecoration(
                                                                            color:
                                                                                ConClrDialog),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            Con_Wid.mIconButton(
                                                                                color: fontwhiteColor,
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                icon: Own_Close),
                                                                          ],
                                                                        ),
                                                                        Center(
                                                                          child: Con_Wid.popinsfont(
                                                                              "Update DSC Route",
                                                                              fontwhiteColor,
                                                                              FontWeight.w600,
                                                                              15,
                                                                              context),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  CondropDown(
                                                                    title:
                                                                        "Select DCS",
                                                                    itemList: Con_List
                                                                        .CenterList.map((e) => e[
                                                                            'Name']
                                                                        .toString()).toList(),
                                                                    SelectedList:
                                                                        SelectedDCS,
                                                                    onSelected:
                                                                        (value) {},
                                                                  ),
                                                                  Con_Wid.textFieldWithInter(
                                                                      controller:
                                                                          outside,
                                                                      hintText:
                                                                          "Outside DCS"),
                                                                  Spacer(),
                                                                  Spacer(),
                                                                  Con_Wid.MainButton(
                                                                      OnTap:
                                                                          () {
                                                                            addDCS(All_Report[index]
                                                                            ['ID']);
                                                                          },
                                                                      pStrBtnName:
                                                                          "Update",
                                                                      height:
                                                                          45,
                                                                      width:
                                                                          100,
                                                                      fontSize:
                                                                          16),
                                                                  Spacer(),
                                                                ]),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                color: Colors.blue,
                                              )),
                                          Con_Wid.mIconButton(
                                              onPressed: () {

                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                                  return Add_UnitReport(e: All_Report[index]);
                                                },));
                                                // https://dudhsagar.herdman.in/vehicle-registeration/unit-report/95202
                                                // put APi
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.green,
                                              )),
                                          Con_Wid.mIconButton(
                                              onPressed: () {
                                                DeleteReport(All_Report[index]
                                                ['ID'].toString());
                                                // https://dudhsagar.herdman.in/vehicle-registeration/unit-report/95202
                                                // Request Method:
                                                // DELETE
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                getHeadingText(
                                                    Head: "Report ID : ",
                                                    body: All_Report[index]
                                                            ['ID']
                                                        .toString()),
                                                Spacer(),
                                                getHeadingText(
                                                    Head: "Date : ",
                                                    body: DateFormat(
                                                            "dd-MM-yyyy")
                                                        .format(DateTime.parse(
                                                            All_Report[index]
                                                                ['Date']))
                                                        .toString()),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                getHeadingText(
                                                    Head: "From Time : ",
                                                    body: All_Report[index]
                                                            ['From Time']
                                                        .toString()),
                                                Spacer(),
                                                getHeadingText(
                                                    Head: "To Time : ",
                                                    body: All_Report[index]
                                                            ['To Time']
                                                        .toString()),
                                              ],
                                            ),
                                            getHeadingText(
                                                Head: "Vehicle Number : ",
                                                body: All_Report[index]
                                                        ['vehicle No']
                                                    .toString()),
                                            getHeadingText(
                                                Head: "Vehicle Id : ",
                                                body: All_Report[index]
                                                        ['vehicle No']
                                                    .toString()),
                                            getHeadingText(
                                                Head: "Center Name : ",
                                                body: All_Report[index]
                                                        ['center name']
                                                    .toString()),
                                            Row(
                                              children: [
                                                getHeadingText(
                                                    Head: "Start Unit : ",
                                                    body: All_Report[index]
                                                            ['Start Unit']
                                                        .toString()),
                                                Spacer(),
                                                getHeadingText(
                                                    Head: "End Unit : ",
                                                    body: All_Report[index]
                                                            ['End Unit']
                                                        .toString()),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                getHeadingText(
                                                    Head: "Total Unit : ",
                                                    body: All_Report[index]
                                                            ['TotalUnit']
                                                        .toString()),
                                                Spacer(),
                                                getHeadingText(
                                                    Head: "Purpose : ",
                                                    body: All_Report[index]
                                                            ['Purpose']
                                                        .toString()),
                                              ],
                                            ),
                                            getHeadingText(
                                                Head: "OutSide DCS : ",
                                                body: All_Report[index]
                                                                ['OutSideDCS']
                                                            .toString() ==
                                                        "null"
                                                    ? "No"
                                                    : All_Report[index]
                                                            ['OutSideDCS']
                                                        .toString()),
                                            getHeadingText(
                                                Head: "Note : ",
                                                body: All_Report[index]['Note']
                                                    .toString()),
                                            Row(
                                              children: [
                                                getHeadingText(
                                                    Head: "User By : ",
                                                    body: All_Report[index]
                                                            ['usedby']
                                                        .toString()),
                                                Spacer(),
                                                getHeadingText(
                                                    Head: "No Of Visit : ",
                                                    body: All_Report[index]
                                                            ['NoOfVisit']
                                                        .toString()),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                              ));
                        },
                      ),
                    )
                  : const Center(
                      child: Image(
                          height: 150,
                          width: 150,
                          image:
                              AssetImage("assets/images/No-Data-Found.webp")),
                    )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  getHeadingText({required String Head, required String body}) {
    return Text.rich(TextSpan(children: [
      TextSpan(text: Head, style: TextStyle(color: Colors.black26)),
      TextSpan(text: body)
    ]));
  }
  addDCS( int ReportID ) async {
    var response = await ApiCalling.createPost(
        AppUrl().GET_ADDDCS,  "Bearer " + Constants_Usermast.token.toString(),{"UnitdetailsID": ReportID});

    print(response.body);
    print(response.statusCode);
  }
  DeleteReport(String ReportID) async {
    var response = await ApiCalling.Delete(
        AppUrl().GET_UNITCRUD+"/" + ReportID,  "Bearer " + Constants_Usermast.token.toString(),);
    if(response.statusCode == 200)
      {
        get();
      }

  }

}
