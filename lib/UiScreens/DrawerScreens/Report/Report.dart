import 'package:flutter/material.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/model/Master_Farmer.dart';
import 'package:herdmannew/model/Master_UserHerds.dart';
import 'package:herdmannew/model/Master_UserLots.dart';
import 'package:herdmannew/model/Master_inseminator.dart';

import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../../model/Get_Master_Farmer.dart';
import '../../Dashboard/Dashboard.dart';
import 'Report_view.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late String dropdown_repo_by;
  TextEditingController txtRoutes = TextEditingController(),
      txtSociety = TextEditingController(),
      txtFarmer = TextEditingController(),
      startPeriod = TextEditingController(),
      endPeriod = TextEditingController();
  DateTime dateTime = DateTime.now();
  bool botton1 = true, botton2 = false, botton3 = false;
  List<String> routeSelected = [],
      farmerSelected = [],
      societySelected = [],
      ReportSelected = [],
      StaffSelected = [];
  String rb_date = "%d-%m-%Y", Date = "Date", reportby = "";
  String mSelctRoutecode = '', mSelctSocietycode = '', mSelctFarmercode = '',mSelctstaffcode="";
  int mIntSelectsocityid = 0;
  List routid=[];
  List socityid=[];
  List farmerid=[];
  List Staffid=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() {
    if (Con_List.M_Userherds.isEmpty || Con_List.M_species.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_herd);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_species);
    }
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
          /*For keypad use only*/
          resizeToAvoidBottomInset: false,
          appBar: Con_Wid.appBar(
            title: "Report",
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
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Con_Wid.popinsfont("Select Date Format", Conclrfontmain,
                            FontWeight.w600, 12, context),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Date",
                            context: context,
                            ontap: () {
                              setState(() {
                                botton2 = false;
                                botton3 = false;
                                botton1 = true;
                                Date = "Date";
                              });
                            },
                            Color: botton1
                                ? con_clr.ConClr2
                                    ? ConClrbluelight
                                    : ConClrDialog
                                : con_clr.ConClr2
                                    ? ConClrLightBack
                                    : whiteColor,
                            textcolor: botton1
                                ? whiteColor
                                : con_clr.ConClr2
                                    ? whiteColor
                                    : ConClrDialog),
                        Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Month",
                            context: context,
                            ontap: () {
                              setState(() {
                                botton3 = false;
                                botton1 = false;
                                botton2 = true;
                                Date = "Month";
                                startPeriod.clear();
                                endPeriod.clear();
                                rb_date = "%d-%m-%Y";
                              });
                            },
                            Color: botton2
                                ? con_clr.ConClr2
                                    ? ConClrbluelight
                                    : ConClrDialog
                                : con_clr.ConClr2
                                    ? ConClrLightBack
                                    : whiteColor,
                            textcolor: botton2
                                ? whiteColor
                                : con_clr.ConClr2
                                    ? whiteColor
                                    : ConClrDialog),
                        Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Year",
                            context: context,
                            ontap: () {
                              setState(() {
                                botton1 = false;
                                botton2 = false;
                                botton3 = true;
                                Date = "Year";
                                startPeriod.clear();
                                endPeriod.clear();
                                rb_date = "%Y";
                              });
                            },
                            Color: botton3
                                ? con_clr.ConClr2
                                    ? ConClrbluelight
                                    : ConClrDialog
                                : con_clr.ConClr2
                                    ? ConClrLightBack
                                    : whiteColor,
                            textcolor: botton3
                                ? whiteColor
                                : con_clr.ConClr2
                                    ? whiteColor
                                    : ConClrDialog),
                      ],
                    ),
                    // Con_Wid.paddingWithText("Report By", Conclrfontmain),
                    const SizedBox(height: 13),
                    CondropDown(
                      title: 'Select Report by',
                      itemList: const [
                        'Farmer wise Registred Animals',
                        'Animals Registered',
                        'AI done',
                        'PD checked',
                        'PD test sample collection',
                        'PD test result',
                        'Calving Done',
                        'Scc Mpp test',
                        'EVM report',
                        'Dry Off Done',
                        'Milk Production',
                        'Abortion Done',
                        'Animal Sold',
                        'Animal Died',
                        'Animal Disposal',
                        'Vaccination Done',
                        'Deworming Done',
                        'Treatment Done',
                      ],
                      SelectedList: ReportSelected,
                      onSelected: (List<String> value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 13),
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
                          List<Master_UserHerds> temp = Con_List.M_Userherds.where((e) => routeSelected.any((element) => element=="${e.code}-${e.Name}")).toList();
                           routid = temp.map((e) => e.id.toString()).toList();
                          mSelctRoutecode = routid.join(',');


                        });
                      },
                    ),
                    const SizedBox(height: 13),
                    CondropDown(
                      isMultiSelect: true,
                      title: 'Select Society',
                      itemList: Con_List.M_Userlots.where((e) => mSelctRoutecode
                              .isNotEmpty
                          ? routid.any((element) => element== e.herd.toString())
                          : true).map((e) => "${e.code}-${e.name}").toList(),
                      SelectedList: societySelected,
                      onSelected: (List<String> value) {
                        setState(() {
                          societySelected = value;
                          List<Master_Userlots> temp = Con_List.M_Userlots.where((e) => societySelected.any((element) => element=="${e.code}-${e.name}")).toList();
                          socityid = temp.map((e) => e.id.toString()).toList();
                          mSelctSocietycode = socityid.join(',');

                        });
                      },
                    ),
                    const SizedBox(height: 13),
                    CondropDown(
                      isMultiSelect: true,
                      color1: ConsfontBlackColor,
                      title: 'Select Farmer',
                      itemList: Con_List.M_Farmer.where((e) =>
                          societySelected.isNotEmpty
                              ? socityid.any((element) => element== e.lot.toString())
                              : true).map((e) => "${e.code}-${e.name}").toList()
                        ..sort((a, b) =>
                            a.split('-').first.compareTo(b.split('-').first)),
                      SelectedList: farmerSelected,
                      onSelected: (List<String> value) {
                        setState(() {
                          farmerSelected = value;
                          List<Get_Master_Farmer> temp = Con_List.M_Farmer.where((e) => farmerSelected.any((element) => element=="${e.code}-${e.name}")).toList();
                          farmerid = temp.map((e) => e.id.toString()).toList();
                          mSelctFarmercode = farmerid.join(',');

                        });
                      },
                    ),
                    const SizedBox(height: 13),
                    CondropDown(
                      isMultiSelect: true,
                      color1: ConsfontBlackColor,
                      title: 'Select Staff',
                      itemList: Con_List.M_inseminator.map((e) => e.name.toString()).toList(),
                      SelectedList: StaffSelected,
                      onSelected: (List<String> value) {
                        setState(() {
                          StaffSelected = value;
                          List<Master_inseminator> temp = Con_List.M_inseminator.where((e) => StaffSelected.any((element) => element==e.name)).toList();
                          Staffid = temp.map((e) => e.id.toString()).toList();
                          mSelctstaffcode = Staffid.join(',');

                        });
                      },
                    ),
                    Con_Wid.height(10),
                    Datepicker(startPeriod, "Start Period", Date),
                    Datepicker(endPeriod, "End Period", Date),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Con_Wid.MainButton(
                            width: 170,
                            height: 51,
                            fontSize: 16,
                            pStrBtnName: 'Apply',
                            OnTap: () {
                              reportby = ReportSelected.join("");
                              var routeSelect = routeSelected
                                  .toString()
                                  .replaceAll("[", "")
                                  .replaceAll("]", "");

                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return Report_view(
                                    reportby,
                                    mSelctRoutecode.toString(),
                                    mSelctSocietycode.toString(),
                                    mSelctFarmercode.toString(),
                                    mSelctstaffcode.toString(),
                                    rb_date,
                                    startPeriod.text == ""
                                        ? "2020-01-01"
                                        : startPeriod.text,
                                    endPeriod.text == ""
                                        ? DateTime.now().toString()
                                        : endPeriod.text,
                                  );
                                },
                              ));
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
