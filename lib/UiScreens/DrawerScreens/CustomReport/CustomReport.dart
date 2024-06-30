import 'package:flutter/material.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../Dashboard/Dashboard.dart';
import 'CustomReportsDetail.dart';

class CustomReportScreen extends StatefulWidget {
  const CustomReportScreen({Key? key}) : super(key: key);

  @override
  State<CustomReportScreen> createState() => _CustomReportScreenState();
}

class _CustomReportScreenState extends State<CustomReportScreen> {
  TextEditingController txtValue = TextEditingController(),
      txtRoutes = TextEditingController(),
      txtSociety = TextEditingController(),
      txtFarmer = TextEditingController();
  List<String> repoerby = [
        'Open Animals',
        'Open Unbred',
        'Open Bred',
        'PD Check',
        'Gestation Days',
        'Dry Period',
        'No of AI',
        'Milk Yield',
        'Average Yield'
      ],
      routeSelected = [],
      reportSelected = [],
      Filter = ['<', '>', '=', '<=', '>='],
      FilterSelected = [],
      societySelected = [],
      farmerSelected = [];
  List<String> mSelctSocietycode = [];
  List<String> mSelctFarmercode = [];
  List<String> mSelctRoutecode = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() {
    if (Con_List.M_Userherds.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_herd);
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
          title: "Custom Report",
          Actions: [],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return DashBoardScreen();
              },
            ));
          },
        ),
        body: Con_Wid.backgroundContainer(
          child: Con_Wid.fullContainer(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Con_Wid.paddingWithText("Report By", Conclrfontmain),
                  //todo CondropDown
                  CondropDown(
                    title: 'Select Report',
                    itemList: repoerby,
                    SelectedList: reportSelected,
                    onSelected: (List<String> value) {
                      setState(() {
                        reportSelected = value;
                      });
                    },
                  ),
                  //Con_Wid.paddingWithText("Filter", Conclrfontmain),
                  //todo CondropDown
                  CondropDown(
                    title: 'Select Filter',
                    itemList: Filter,
                    SelectedList: FilterSelected,
                    onSelected: (List<String> value) {
                      setState(() {
                        // DDData.dddata.selectedList1.contains(value);
                        // DDData.dddata.selectedList1 = value;
                      });
                    },
                  ),
                  Con_Wid.textFieldWithInter(
                      text: "Value",
                      TextInput_Type: TextInputType.number,
                      controller: txtValue,
                      hintText: "Enter Value"),
                  CondropDown(
                    isMultiSelect: true,
                    title: 'Select Route',
                    itemList:
                        Con_List.M_Userherds.map((e) => "${e.code}-${e.Name}")
                            .toList(),
                    SelectedList: routeSelected,
                    onSelected: (List<String> value) {
                      setState(() {
                        routeSelected = value;
                        mSelctRoutecode = Con_List.M_Userherds.where((e) =>
                                e.code.toString() ==
                                routeSelected[0]
                                    .toString()
                                    .split("-")
                                    .first
                                    .toString())
                            .map((e) => e.id.toString())
                            .toList();
                      });
                    },
                  ),
                  CondropDown(
                    isMultiSelect: true,
                    title: 'Select Society',
                    itemList: Con_List.M_Userlots.where((e) =>
                        mSelctRoutecode.isNotEmpty
                            ? mSelctRoutecode
                                .any((u) => u.contains(e.herd.toString()))
                            : true).map((e) => "${e.code}-${e.name}").toList(),
                    SelectedList: societySelected,
                    onSelected: (List<String> value) {
                      setState(() {
                        societySelected = value;
                        mSelctSocietycode = Con_List.M_Userlots.where(
                                (e) => value.any((u) => u.contains(e.code)))
                            .map((e) => "${e.id}")
                            .toList();
                        farmerSelected.clear();
                        mSelctFarmercode.clear();
                      });
                    },
                  ),
                  CondropDown(
                    isMultiSelect: true,
                    color1: ConsfontBlackColor,
                    title: 'Select Farmer',
                    itemList: Con_List.M_Farmer.where((e) =>
                        societySelected.isNotEmpty
                            ? mSelctSocietycode
                                .any((u) => u.contains(e.lot.toString()))
                            : true).map((e) => "${e.code}-${e.name}").toList()
                      ..sort((a, b) =>
                          a.split('-').first.compareTo(b.split('-').first)),
                    SelectedList: farmerSelected,
                    onSelected: (List<String> value) {
                      setState(() {
                        farmerSelected = value;
                        mSelctFarmercode = Con_List.M_Farmer.where((e) =>
                                value.any((u) =>
                                    u.toString().contains(e.code.toString()) &&
                                    u.toString().contains(e.name.toString())))
                            .map((e) => "${e.id}")
                            .toList();
                      });
                    },
                  ),
                  Con_Wid.height(MediaQuery.of(context).size.height / 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Con_Wid.MainButton(
                          OnTap: () {
                            String parameter = "";
                            if (reportSelected.isNotEmpty) {
                              if ((reportSelected[0] == ('Open Animals')) ||
                                  (reportSelected[0] == ('Open Unbred')) ||
                                  (reportSelected[0] == ('Open Bred'))) {
                                parameter = "Open Bred";
                              } else if (reportSelected[0] == "PD Check") {
                                parameter = "Days From AI";
                              } else if (reportSelected[0].isNotEmpty) {
                                parameter = reportSelected[0];
                              } else {
                                parameter = "";
                              }
                            } else {
                              parameter = "";
                            }


                            String reportSelected1 = reportSelected.join("");
                            String FilterSelected1 = FilterSelected.join("");
                            String routeSelected1 = routeSelected.join("");
                            String societySelected1 = societySelected.join("");
                            String farmerSelected1 = mSelctFarmercode.join("");
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return CustomReportsDetail(
                                    reportSelected[0].toString(),
                                    FilterSelected1,
                                    txtValue.text.isEmpty ? "0" : txtValue.text,
                                    mSelctRoutecode.isNotEmpty
                                        ? mSelctRoutecode[0]
                                        : "",
                                    mSelctSocietycode.isNotEmpty
                                        ? mSelctSocietycode[0]
                                        : "",
                                    mSelctFarmercode.isNotEmpty
                                        ? mSelctFarmercode[0]
                                        : "",
                                    parameter);
                              },
                            ));
                          },
                          pStrBtnName: "Apply",
                          fontSize: 12,
                          height: 46,
                          width: 170),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
