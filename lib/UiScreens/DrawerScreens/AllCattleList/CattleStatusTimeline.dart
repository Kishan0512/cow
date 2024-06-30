// ignore_for_file: non_constant_identifier_names
// ignore_for_file: must_be_immutable
// ignore_for_file: unnecessary_null_comparison
// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/CattleStatusWeight.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/TreatmentAndVaccination.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/profile.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Icons.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Textstyle.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/model/Animal_Details_id.dart';
import 'package:herdmannew/model/Master_sire.dart';
import 'package:intl/intl.dart';
import '../../../Model_local/Timeline.dart';
import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Con_Toast.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../../model/Breeding_reproduction_id.dart';
import '../../Activity/add_pd_details.dart';
import 'Abortion_page.dart';
import 'Add_dryoff_details.dart';
import 'CalvingDetails.dart';
import 'InsemiationDetails.dart';
import 'Milking.dart';
import 'PdTestByMilk.dart';

class cattlestatustimeline extends StatefulWidget {
  String index;
  String? id;

  cattlestatustimeline({super.key, required this.index, this.id});

  @override
  State<cattlestatustimeline> createState() => _cattlestatustimelineState();
}

class _cattlestatustimelineState extends State<cattlestatustimeline>
    with SingleTickerProviderStateMixin {
  TextEditingController FarmerName = TextEditingController();
  TextEditingController Parity = TextEditingController();
  bool botton1 = false,
      botton2 = false,
      botton3 = false,
      enable_abort_entry = false,
      enable_calving_entry = false,
      enable_insem_btn = false,
      enable_pd_entry = false,
      enable_dryoff_entry = false;
  late final AnimationController _controller;
  late final Animation<double> _rotationAnimation;
  final streamController = StreamController();
  List<String> PARITY = [];
  List<String> PARITY_data = [];
  Animal_Details_id? Mdetail;
  List<String> parity = [];
  String ExHeatDate = "";
  String ExPDDate = "";
  String changeDate = "";
  List<Timeline> mListData = [];
  List<Timeline> mListData1 = [];
  String mStrheatdays = "";
  String TapToExpandIt = "Breeding details";
  bool isExpanded = false;
  bool selected = true;
  Breeding_reproduction_id? temp;

  @override
  void initState() {
    super.initState();
    rote();
    setState(() {});
    get();
    filter();
  }

  rote() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(_controller);
  }

  filter() {


    print(Mdetail!.statusname);

    if (Mdetail!.heatDate != null &&
        Mdetail!.heatDate.toString().trim() != "" &&
        Mdetail!.heatDate.toString().toLowerCase() != "null" &&
        Mdetail!.heatDate.toString().isNotEmpty) {
      mStrheatdays = DateTime.now()
          .difference(DateTime.parse("${Mdetail!.heatDate}"))
          .inDays
          .toString();
      print(mStrheatdays);
    }
    if (Mdetail!.statusname.toString().toLowerCase() ==
            'Heifer'.toLowerCase() ||
        Mdetail!.statusname.toString().toLowerCase() ==
            'null'.toLowerCase() ||
            Mdetail!.breedingStatus.toString().toLowerCase() ==
                'Open Unbred'.toLowerCase()||
            Mdetail!.breedingStatus.toString().toLowerCase() ==
                'Open bred'.toLowerCase() ||
            Mdetail!.breedingStatus.toString().toLowerCase() ==
                'Heifer Unbred'.toLowerCase()||
            Mdetail!.breedingStatus.toString().toLowerCase() ==
                'Aborted'.toLowerCase()

    ) {
      setState(() {
        enable_insem_btn = true;
      });
    }
    if ((Mdetail!.breedingStatus.toString().toLowerCase() ==
            'Pregnant'.toLowerCase()) &&
        int.parse(mStrheatdays) > 240) {
      setState(() {
        enable_calving_entry = true;
      });
    }
    enable_pd_entry = false;
    if ((Mdetail!.breedingStatus.toString().toLowerCase() ==
                'Open Bred'.toLowerCase() ||
            Mdetail!.breedingStatus.toString().toLowerCase() ==
                'Heifer Bred'.toLowerCase()) &&
        (AppUrl.CheckNewUrl.value
            ? int.parse(mStrheatdays) > 21
            : int.parse(mStrheatdays) > 45)) {
      setState(() {
        enable_pd_entry = true;
      });
    }

    if ((Mdetail!.breedingStatus.toString().toLowerCase() ==
            'Pregnant'.toLowerCase()) &&
        int.parse(mStrheatdays) > 45) {
      setState(() {
        enable_abort_entry = true;
      });
    }
    if (Mdetail!.breedingStatus.toString().toLowerCase() ==
        'Aborted'.toLowerCase()) {
      setState(() {
        enable_insem_btn = true;
      });
    }
    if (Mdetail!.statusname.toString().toLowerCase() ==
            'Pregnant Milking'.toLowerCase() ||
        Mdetail!.statusname.toString().toLowerCase() ==
            'Milking'.toLowerCase()) {
      setState(() {
        enable_dryoff_entry = true;
      });
    }
  }

  get() {
    if (Con_List.M_inseminator.isEmpty || Con_List.M_sire.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_staff);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_sire);
    }
    Sync_Json.Get_Master_Data(Constants.Breeding_reproduction_id);
    int index = 0;
    Mdetail = Con_List.id_Animal_Details
        .firstWhere((e) => e.tagId == widget.index.toString());
    changeDate = Mdetail!.calvingDate == null || Mdetail!.calvingDate == ""
        ? Mdetail!.dOB.toString()
        : Mdetail!.calvingDate.toString();
    Con_List.id_reproduction.sort(
      (a, b) => a.heatDate.toString().compareTo(b.heatDate.toString()),
    );
    PARITY = Con_List.id_reproduction
        .where((e) => e.tagId == widget.index.toString())
        .map((e) => e.parity.toString() != "null" ? e.parity.toString() : "0")
        .toList();

    PARITY.sort(
      (b, a) => b.toString().compareTo(a.toString()),
    );
    PARITY = PARITY.toSet().toList();
    print(Con_List.id_reproduction
        .where((e) => e.tagId == widget.index.toString()).length);
    Con_List.id_reproduction
        .where((e) => e.tagId == widget.index.toString())
        .toList()
        .forEach((e) {
      if (Mdetail!.currentParity.toString() == e.parity.toString()) {
        if (e.heatDate.toString().isNotEmpty) {
          DateTime calving =
              Mdetail!.calvingDate == null || Mdetail!.calvingDate == ""
                  ? DateTime.parse(Mdetail!.dOB.toString())
                  : DateTime.parse(Mdetail!.calvingDate.toString());
          DateTime heat = DateFormat("yyyy-MM-dd")
              .parse(e.heatDate.toString().replaceAll("/", "-"));
          Duration difference = heat.difference(calving);
          if (difference.inDays >= 0) {
            // print(e.sire);
            // print(e.Sirename.toString().isEmpty?Con_List.M_sire.firstWhere((element) => element.id.toString()==e.sire.toString()).name:e.Sirename);
            mListData.add(Timeline(
              count: 1,
              id: 0,
              date_text: e.heatDate.toString().substring(0, 10),
              actual_date: "actual_date",
              center_text:
                  (difference.inDays + 1).toString().replaceFirst("-", ""),
              heading_text: "AI Done",
              LastDays: index == 0
                  ? "First A.I"
                  : mListData[index - 1].center_text.toString().isEmpty
                      ? ""
                      : ("Days From AI : ${int.parse(difference.inDays.toString()) - int.parse(mListData[index - 1].center_text.toString())}"),
              PregDays: "Last Sire : ${e.Sirename.toString().isEmpty?"":e.Sirename}",
              status_text:
                  "AIT : ${e.AITname.toString() == "" ? Con_List.M_inseminator.where((element) => element.id.toString() == e.inseminatorStaff.toString()).isEmpty ? "" : Con_List.M_inseminator.where((element) => element.id.toString() == e.inseminatorStaff.toString()).first.name.toString() : e.AITname}/Code : ${Con_List.M_inseminator.where((element) => element.id.toString() == e.inseminatorStaff.toString()).isEmpty ? "" : Con_List.M_inseminator.firstWhere((element) => element.id.toString() == e.inseminatorStaff.toString()).code}",
              tagno: "tagno",
            ));
            index++;
          }
        }
        if (e.pDDate.toString().isNotEmpty) {
          DateTime calving = Mdetail!.calvingDate == null ||
                  Mdetail!.calvingDate == ""
              ? DateFormat("yyyy-MM-dd").parse(Mdetail!.dOB.toString())
              : DateFormat("yyyy-MM-dd").parse(Mdetail!.calvingDate.toString());
          if (e.pDDate.toString().substring(0, 10).contains('/')) {
            // date string is in the format "dd/MM/yyyy"
            DateTime pd = DateFormat('dd/MM/yyyy')
                .parse(e.pDDate.toString().substring(0, 10));
            Duration difference1 = pd.difference(calving);
            if (difference1.inDays >= 0) {
              mListData.add(Timeline(
                id: 0,
                count: 1,
                date_text: e.pDDate.toString().substring(0, 10),
                actual_date: "actual_date1",
                center_text:
                    difference1.inDays.toString().replaceFirst("-", ""),
                heading_text: e.pd2 == 4 ? "Abortion" : "PD Done",
                LastDays: ("Days From AI : ${int.parse(difference1.inDays.toString().replaceFirst("-", "")) - int.parse(mListData[index - 1].center_text.toString())}"),
                PregDays:
                    e.pd2 == 1 ? "Empty" : e.pd2 == 2 ? "Doubtful" : e.pd2 == 3 ? "Days of Pregnant : ${int.parse(difference1.inDays.toString()) - int.parse(mListData[index - 1].center_text.toString())}" : e.pd2 == 4 ? "Abortion" : "",
                status_text: "PD Date ${e.pDDate.substring(0, 10)}",
                tagno: "tagno1",
              ));
            }
          } else {
            DateTime pd = DateFormat('yyyy-MM-dd')
                .parse(e.pDDate.toString().substring(0, 10));
            Duration difference1 = pd.difference(calving);
            if (difference1.inDays >= 0) {
              mListData.add(Timeline(
                id: 0,
                count: 1,
                date_text: e.pDDate.toString().substring(0, 10),
                actual_date: "actual_date1",
                center_text:
                    difference1.inDays.toString().replaceFirst("-", ""),
                heading_text: e.pd2 == 4 ? "Abortion" : "PD Done",
                LastDays: ("Days From AI : ${int.parse(difference1.inDays.toString().replaceFirst("-", "")) - int.parse(mListData[index==0?index:index - 1].center_text.toString())}"),
                PregDays:
                    e.pd2 == 1 ? "Empty" : e.pd2 == 2 ? "Doubtful" : e.pd2 == 3 ? "Days of Pregnant : ${int.parse(difference1.inDays.toString()) - int.parse(mListData[index - 1].center_text.toString())}": e.pd2 == 4 ? "Abortion" : "",
                status_text: "PD Date ${e.pDDate.substring(0, 10)}",
                tagno: "tagno1",
              ));
            }
          }
        }
      }
    });

    if ('${Mdetail!.breedingStatus}' == 'Open Bred' ||
        '${Mdetail!.breedingStatus}' == 'Heifer Bred') {
      ExHeatDate = DateTime.parse(Mdetail!.heatDate.toString())
          .add(const Duration(days: 21))
          .toString();
      ExPDDate = DateTime.parse(Mdetail!.heatDate.toString())
          .add(const Duration(days: 90))
          .toString();
    }
    if ('${Mdetail!.breedingStatus}' == 'Open Unbread') {
      ExHeatDate = DateTime.parse(Mdetail!.calvingDate.toString())
          .add(const Duration(days: 60))
          .toString();
    }
    if ('${Mdetail!.breedingStatus}' == 'Pregnant' &&
        '${Mdetail!.speciesname}' == 'Cow') {
      ExHeatDate = DateTime.parse(Mdetail!.heatDate.toString())
          .add(const Duration(days: 270))
          .toString();
    }
    if ('${Mdetail!.breedingStatus}' == 'Pregnant' &&
        '${Mdetail!.speciesname}' == 'Buffalo') {
      ExHeatDate = DateTime.parse(Mdetail!.heatDate.toString())
          .add(const Duration(days: 310))
          .toString();
    }
    mListData1 == mListData;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(
          () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return profile(widget.index.toString());
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "Cattle Status Timeline",
          Actions: [
            Con_Wid.mIconButton(
                onPressed: () {
                  setState(() {
                    Sync_Json.Get_Master_Data(
                            Constants.Breeding_reproduction_id)
                        .then((value) => Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return cattlestatustimeline(
                                    index: widget.index);
                              },
                            )));
                  });
                },
                icon: Own_Refresh)
          ],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return profile(widget.index.toString());
              },
            ));
          },
          elevation: 3,
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
        ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
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
                padding:
                    const EdgeInsets.only(right: 10, left: 10, top: 5.0),
                height: isExpanded ? 70 : 188,
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(milliseconds: 1200),
                decoration: con_clr.ConClr2
                    ? BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: ConClrbluelight.withOpacity(0.5),
                            blurRadius: 5,
                            offset: const Offset(5, 5),
                          ),
                        ],
                        gradient: const LinearGradient(
                            colors: ConClrAppbarGreadiant),
                        borderRadius: const BorderRadius.only(),
                      )
                    : BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: ConClrDialog.withOpacity(0.5),
                            blurRadius: 2,
                            offset: const Offset(5, 5),
                          ),
                        ],
                        color: ConClrSelectedlight,
                      ),
                child: ListView(children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Con_Wid.width(10),
                          Con_Wid.gText(
                            "Animal.ID : ${Mdetail!.tagId}",
                            style: const TextStyle(
                              color: Colors.white,
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
                                  Con_Wid.gText(
                                    "Farmer Name",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor),
                                  ),
                                  Text(":  ${Mdetail!.farmername}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor)),
                                  const Expanded(child: SizedBox()),
                                  Con_Wid.gText(
                                    "Farmer Code",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor),
                                  ),
                                  Text(":  ${Mdetail!.farmer}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor)),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Con_Wid.gText(
                                  "Society Code",
                                  style: ConStyle.Style_white_12_700w(
                                      fontwhiteColor),
                                ),
                                Text(":  ${Mdetail!.lot}",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor)),
                                const Expanded(child: SizedBox()),
                                Con_Wid.gText(
                                  "Society Name",
                                  style: ConStyle.Style_white_12_700w(
                                      fontwhiteColor),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 20,
                                  width: 50,
                                  child: Text(":  ${Mdetail!.lotname}",
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
                                  "Farmer Code",
                                  style: ConStyle.Style_white_12_700w(
                                      fontwhiteColor),
                                ),
                                Text(":  ${Mdetail!.farmerCode}",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor)),
                                const Expanded(child: SizedBox()),
                                Con_Wid.gText(
                                  "Farmer Name",
                                  style: ConStyle.Style_white_12_700w(
                                      fontwhiteColor),
                                ),
                                Text(":  ${Mdetail!.farmername}",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor)),
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Con_Wid.gText(
                                "Society Code",
                                style: ConStyle.Style_white_12_700w(
                                    fontwhiteColor),
                              ),
                              Text(":  ${Mdetail!.lotcode}",
                                  style: ConStyle.Style_white_12_700w(
                                      fontwhiteColor)),
                              const Expanded(child: SizedBox()),
                              Con_Wid.gText(
                                "Society Name",
                                style: ConStyle.Style_white_12_700w(
                                    fontwhiteColor),
                              ),
                              Text(":  ${Mdetail!.lotname}",
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
                                  "assets/images/${Mdetail!.speciesname.toString().toLowerCase()}${Mdetail!.statusname.toString().toLowerCase() == "null" ? "" : '-${Mdetail!.statusname.toString().toLowerCase()}'}.webp"),
                            ),
                            title: Row(
                              children: [
                                Con_Wid.gText(
                                  "${Mdetail!.calvingDate == null || Mdetail!.calvingDate == "" ? "Birth Date" : "Calving Date" } : ${changeDate.substring(0, 10)}",
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.white),
                                ),
                                Spacer(),
                                Con_Wid.gText(
                                  "Repeat Heat : ${Mdetail!.heatSeq}",
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.white),
                                ),

                              ],
                            ),
                            subtitle: Con_Wid.gText(
                              "${Mdetail!.statusname}",
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.orange),
                            ),
                          ),
                          const Divider(
                            height: 2,
                            thickness: 1,
                            color: ConClrLightBack2,
                          ),
                          Row(
                            children: [
                              Con_Wid.width(5),
                              Con_Wid.gText(
                                "Expected Heat Date",
                                style: const TextStyle(
                                    color: fontwhiteColor, fontSize: 12),
                              ),
                              const Spacer(),
                              Text(
                                ExHeatDate == ""
                                    ? ""
                                    : ExHeatDate.substring(0, 10),
                                style: const TextStyle(
                                    color: fontwhiteColor, fontSize: 12),
                              )
                            ],
                          ),
                          Mdetail!.breedingStatus == "Open Bred"
                              ? Row(
                                  children: [
                                    Con_Wid.width(5),
                                    Con_Wid.gText(
                                      "Expected PD Date",
                                      style: const TextStyle(
                                          color: fontwhiteColor,
                                          fontSize: 12),
                                    ),
                                    const Spacer(),
                                    Text(
                                      ExPDDate == ""
                                          ? ""
                                          : ExPDDate.substring(0, 10),
                                      style: const TextStyle(
                                          color: fontwhiteColor,
                                          fontSize: 12),
                                    )
                                  ],
                                )
                              : Container(),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //get_user_info(),

                ListView.builder(
                    padding: const EdgeInsets.only(top: 20.0),
                    //reverse: true,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: mListData.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      mListData.sort((a, b) => a.date_text
                          .toString()
                          .compareTo(b.date_text.toString()));
                      return SizedBox(
                        height: 90,
                        width: MediaQuery.of(context).size.width - 30,
                        child: Stack(children: <Widget>[
                          index % 2 == 0
                              ? mListData[index].heading_text == "PD Done"
                                  ? Image.asset(
                                      'assets/images/Left Green.webp',
                                      height: 200.0,
                                      width: double.infinity,

                                    )
                                  : mListData[index].heading_text ==
                                          "AI Done"
                                      ? Image.asset(
                                          'assets/images/Left Blue.webp',
                                          height: 200.0,
                                          width: double.infinity,

                                        )
                                      : Image.asset(
                                          'assets/images/Left Red.webp',
                                          height: 200.0,
                                          width: double.infinity,

                                        )
                              : mListData[index].heading_text == "PD Done"
                                  ? Image.asset(
                                      'assets/images/Right Green.webp',
                                      height: 200.0,
                                      width: double.infinity,

                                    )
                                  : mListData[index].heading_text ==
                                          "AI Done"
                                      ? Image.asset(
                                          'assets/images/Right Blue.webp',
                                          height: 200.0,
                                          width: double.infinity,

                                        )
                                      : Image.asset(
                                          'assets/images/Right Red.webp',
                                          height: 200.0,
                                          width: double.infinity,

                                        ),
                          index % 2 == 0
                              ? Container(
                                  padding: EdgeInsets.only(
                                      top: 16,
                                      right: MediaQuery.of(context)
                                              .size
                                              .width /
                                          4.5),
                                  width: MediaQuery.of(context).size.width,
                                  height: 50.0,
                                  child: Con_Wid.gText(
                                    "${mListData[index].center_text} Days",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.only(
                                      top: 2,
                                      left: MediaQuery.of(context)
                                              .size
                                              .width /
                                          4.5),
                                  width: MediaQuery.of(context).size.width,
                                  height: 50.0,
                                  child: Center(
                                    child: Con_Wid.gText(
                                      "${mListData[index].center_text} Days",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                          index % 2 == 0
                              ? Container(
                                  padding: EdgeInsets.only(
                                      top: 15,
                                      left: MediaQuery.of(context)
                                              .size
                                              .width /
                                          3.5),
                                  width: MediaQuery.of(context).size.width,
                                  height: 50.0,
                                  child: Con_Wid.gText(
                                    mListData[index].heading_text,
                                    style: TextStyle(
                                        color:
                                            mListData[index].heading_text ==
                                                    "PD Done"
                                                ? g1
                                                : mListData[index]
                                                            .heading_text ==
                                                        "AI Done"
                                                    ? b1
                                                    : r1,
                                        fontSize: 16.0),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.only(
                                      top: 15,
                                      right: MediaQuery.of(context)
                                              .size
                                              .width /
                                          3.5),
                                  width: MediaQuery.of(context).size.width,
                                  height: 50.0,
                                  child: Con_Wid.gText(
                                    mListData[index].heading_text,
                                    style: TextStyle(
                                        color:
                                            mListData[index].heading_text ==
                                                    "PD Done"
                                                ? g1
                                                : mListData[index]
                                                            .heading_text ==
                                                        "AI Done"
                                                    ? b1
                                                    : r1,
                                        fontSize: 16.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                          index % 2 == 1
                              ? Container(
                                  padding: const EdgeInsets.only(
                                    top: 40,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height: 130.0,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            mListData[index].status_text !=
                                                    ''
                                                ? Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Con_Wid.gText(
                                                        mListData[index]
                                                            .status_text
                                                            .toString(),
                                                        style:
                                                            const TextStyle(
                                                                fontSize:
                                                                    10)),
                                                  )
                                                : Container(),
                                            mListData[index].PregDays != null
                                                ? Text(
                                                    mListData[index]
                                                        .PregDays
                                                        .toString(),
                                                    style:
                                                        const TextStyle(
                                                            fontSize:
                                                                10))
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                      Con_Wid.width(30),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Text(
                                                mListData[index]
                                                    .date_text
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 10),
                                              ),
                                            ),
                                            Text(
                                              mListData[index]
                                                  .LastDays
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.only(
                                    top: 40,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height: 130.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Text(
                                                mListData[index]
                                                    .date_text
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 10),
                                              ),
                                            ),
                                            Text(
                                              mListData[index]
                                                  .LastDays
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Con_Wid.width(30),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            mListData[index].status_text !=
                                                    ''
                                                ? Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Text(
                                                        mListData[index]
                                                            .status_text
                                                            .toString(),
                                                        style:
                                                            const TextStyle(
                                                                fontSize:
                                                                    10)),
                                                  )
                                                : Container(),
                                            mListData[index].PregDays !=
                                                    null
                                                ? Text(
                                                    mListData[index]
                                                        .PregDays
                                                        .toString(),
                                                    style:
                                                        const TextStyle(
                                                            fontSize:
                                                                10))
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                        ]),
                      );
                    }),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Con_Wid.floatingButtontimeline12(
                          onTap: () {
                            if (enable_abort_entry == true ||
                                enable_calving_entry == true ||
                                enable_insem_btn == true ||
                                enable_pd_entry == true ||
                                enable_dryoff_entry == true) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Container(
                                      width: 100,
                                      color: con_clr.ConClr2
                                          ? ConClrMainLight
                                          : whiteColor,
                                      child: SingleChildScrollView(
                                        child: Column(children: [
                                          Container(
                                              height: 60,
                                              width: double.infinity,
                                              decoration: con_clr.ConClr2
                                                  ? const BoxDecoration(
                                                      gradient:
                                                          LinearGradient(
                                                      colors:
                                                          ConClrAppbarGreadiant,
                                                    ))
                                                  : const BoxDecoration(
                                                      color: ConClrDialog),
                                              child: Stack(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .end,
                                                    children: [
                                                      Con_Wid.mIconButton(
                                                          color:
                                                              fontwhiteColor,
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: Own_Close),
                                                    ],
                                                  ),
                                                  Center(
                                                    child:
                                                        Con_Wid.popinsfont(
                                                            "Activity",
                                                            fontwhiteColor,
                                                            FontWeight.w600,
                                                            15,
                                                            context),
                                                  )
                                                ],
                                              )),
                                          Container(
                                            margin: const EdgeInsets.all(5),
                                            child: Visibility(
                                              visible: enable_insem_btn,
                                              child: Con_Wid.MainButton(
                                                  width: 170,
                                                  height: 45,
                                                  fontSize: 16,
                                                  pStrBtnName:
                                                      'Insemination',
                                                  OnTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return Insemiationdetails(
                                                            path:
                                                                "Activity",
                                                            date: mListData1
                                                                    .where((e) =>
                                                                        e.heading_text.toString() ==
                                                                        "AI Done")
                                                                    .isNotEmpty
                                                                ? mListData1
                                                                    .where((element) =>
                                                                        element.heading_text.toString() ==
                                                                        "AI Done")
                                                                    .last
                                                                    .date_text
                                                                : "",
                                                            index: widget
                                                                .index);
                                                      },
                                                    ));
                                                  }),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(5),
                                            child: Visibility(
                                              visible: enable_calving_entry,
                                              child: Con_Wid.MainButton(
                                                  width: 170,
                                                  height: 45,
                                                  fontSize: 16,
                                                  pStrBtnName:
                                                      'Calving Details',
                                                  OnTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return CalvingDetails(
                                                            path:
                                                                "Activity",
                                                            index: widget
                                                                .index);
                                                      },
                                                    ));
                                                  }),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(5),
                                            child: Visibility(
                                              visible: enable_pd_entry,
                                              child: Con_Wid.MainButton(
                                                  width: 170,
                                                  height: 45,
                                                  fontSize: 16,
                                                  pStrBtnName: 'PD Details',
                                                  OnTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return add_pd_details(
                                                          path: "Activity",
                                                          date: mListData1
                                                                  .where((e) =>
                                                                      e.heading_text
                                                                          .toString() ==
                                                                      "AI Done")
                                                                  .isNotEmpty
                                                              ? mListData1
                                                                  .where((element) =>
                                                                      element
                                                                          .heading_text
                                                                          .toString() ==
                                                                      "AI Done")
                                                                  .last
                                                                  .date_text
                                                              : "",
                                                          index:
                                                              widget.index,
                                                        );
                                                      },
                                                    ));
                                                  }),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(5),
                                            child: Visibility(
                                              visible: enable_pd_entry,
                                              child: Con_Wid.MainButton(
                                                  width: 170,
                                                  height: 45,
                                                  fontSize: 16,
                                                  pStrBtnName:
                                                      'PD Test By Milk',
                                                  OnTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return pdtestbymilk(
                                                          date: mListData1
                                                                  .where((e) =>
                                                                      e.heading_text
                                                                          .toString() ==
                                                                      "AI Done")
                                                                  .isNotEmpty
                                                              ? mListData1
                                                                  .where((element) =>
                                                                      element
                                                                          .heading_text
                                                                          .toString() ==
                                                                      "AI Done")
                                                                  .last
                                                                  .date_text
                                                              : "",
                                                          index:
                                                              widget.index,
                                                        );
                                                      },
                                                    ));
                                                  }),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(5),
                                            child: Visibility(
                                              visible: enable_abort_entry,
                                              child: Con_Wid.MainButton(
                                                  width: 170,
                                                  height: 45,
                                                  fontSize: 16,
                                                  pStrBtnName: 'Abortion',
                                                  OnTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return Abortion_Details(
                                                          path: "Activity",
                                                          index:
                                                              widget.index,
                                                          date: mListData1
                                                                  .where((e) =>
                                                                      e.heading_text
                                                                          .toString() ==
                                                                      "PD Done")
                                                                  .isNotEmpty
                                                              ? mListData1
                                                                  .where((element) =>
                                                                      element
                                                                          .heading_text
                                                                          .toString() ==
                                                                      "PD Done")
                                                                  .last
                                                                  .date_text
                                                              : "",
                                                        );
                                                      },
                                                    ));
                                                  }),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(5),
                                            child: Visibility(
                                              visible: enable_dryoff_entry,
                                              child: Con_Wid.MainButton(
                                                  width: 170,
                                                  height: 45,
                                                  fontSize: 16,
                                                  pStrBtnName: 'Dry Off',
                                                  OnTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return Add_dryoff_details(
                                                            index: widget
                                                                .index);
                                                      },
                                                    ));
                                                  }),
                                            ),
                                          ),
                                          Con_Wid.height(15),
                                        ]),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              Con_Wid.Keybord(context: context);
                              Con_Wid.Con_Show_Toast(context,
                                  "No available entry for this animal");
                            }
                          },
                          height: 50,
                          width: MediaQuery.of(context).size.width / 3),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 50,
            )
          ],
        ),
        AnimatedContainer(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(30)),
          alignment: Alignment.center,
          duration: const Duration(seconds: 1),
          width: selected ? 0 : MediaQuery.of(context).size.width / 1.3,
          curve: Curves.fastOutSlowIn,
          height: selected ? 0 : MediaQuery.of(context).size.height / 15,
          child: CondropDown(
            title: "Select distinct parity",
            itemList: PARITY,
            SelectedList: parity,
            onSelected: (value) {
              setState(() {
                Filter(value[0]);
              });
            },
          ),
        ),
        InkWell(
          onTap: () {
            selected = !selected;
            setState(() {});
            selected ? _controller.forward() : _controller.reverse();

            setState(() {});
          },
          child: RotationTransition(
            turns: _rotationAnimation,
            child: const Icon(Icons.keyboard_arrow_down, size: 50),
          ),
        ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
            elevation: 0,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Con_Wid.selectionContainer(
                      text: "Weights",
                      context: context,
                      ontap: () {
                        setState(() {
                          botton3 = false;
                          botton2 = false;
                          botton1 = true;
                        });
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return cattlestatusweight(widget.index);
                          },
                        ));
                      },
                      Color: botton1
                          ? con_clr.ConClr2
                              ? ConClrLightBack
                              : ConClrSelected
                          : con_clr.ConClr2
                              ? ConClrbluelight
                              : whiteColor,
                      textcolor: botton1
                          ? whiteColor
                          : con_clr.ConClr2
                              ? whiteColor
                              : ConClrSelected,
                      height: 50,
                      width: MediaQuery.of(context).size.width / 3.4),
                  Con_Wid.width(5),
                  Con_Wid.selectionContainer(
                      text: "Milking",
                      context: context,
                      ontap: () {
                        setState(() {
                          botton3 = false;
                          botton1 = false;
                          botton2 = true;
                        });
                        if (Mdetail!.statusname == 'Milking' ||
                            Mdetail!.statusname == 'Pregnant Milking') {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Milking(widget.index);
                            },
                          ));
                        } else {
                          CustomToast.show(context,
                              "Milk entry not available for this cattle");
                        }
                      },
                      Color: (Mdetail!.statusname == 'Milking' ||
                              Mdetail!.statusname == 'Pregnant Milking')
                          ? botton2
                              ? con_clr.ConClr2
                                  ? ConClrLightBack
                                  : ConClrSelected
                              : con_clr.ConClr2
                                  ? ConClrbluelight
                                  : whiteColor
                          : con_clr.ConClr2
                              ? ConClrMainLight
                              : Colors.blue.shade400,
                      height: 50,
                      textcolor: (Mdetail!.statusname == 'Milking' ||
                              Mdetail!.statusname == 'Pregnant Milking')
                          ? botton2
                              ? whiteColor
                              : con_clr.ConClr2
                                  ? whiteColor
                                  : ConClrSelected
                          : BlackColor,
                      width: MediaQuery.of(context).size.width / 3.4),
                  Con_Wid.width(5),
                  Con_Wid.selectionContainer(
                      text: "Treatment",
                      context: context,
                      ontap: () {
                        setState(() {
                          botton1 = false;
                          botton2 = false;
                          botton3 = true;
                        });
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Treatmentandvaccination(index: widget.index,path: "Activity",);
                          },
                        ));
                      },
                      Color: botton3
                          ? con_clr.ConClr2
                              ? ConClrLightBack
                              : ConClrSelected
                          : con_clr.ConClr2
                              ? ConClrbluelight
                              : whiteColor,
                      textcolor: botton3
                          ? whiteColor
                          : con_clr.ConClr2
                              ? whiteColor
                              : ConClrSelected,
                      height: 50,
                      width: MediaQuery.of(context).size.width / 3.4)
                ],
              ),
            )),
      ),
    );
  }

  Filter(String Parity) {
    if (Mdetail!.currentParity.toString().toLowerCase() == "null" ||
        Mdetail!.currentParity.toString() == "") {
    } else {
      if (Parity != Mdetail!.currentParity.toString()) {
        mListData.clear();
        int index = 0;
        Con_List.id_reproduction
            .where((e) => e.tagId == widget.index.toString())
            .toList()
            .forEach((e) {
          if (Parity == e.parity.toString()) {
            changeDate = e.dateOfCalving.toString();
            if (e.heatDate.toString().isNotEmpty) {
              DateTime calving = DateTime.parse(e.dateOfCalving.toString());
              DateTime heat = DateFormat("yyyy-MM-dd")
                  .parse(e.heatDate.toString().replaceAll("/", "-"));
              Duration difference = heat.difference(calving);
              if (difference.inDays <= 0) {
                mListData.add(Timeline(
                  count: 1,
                  id: 0,
                  date_text: e.heatDate.toString().substring(0, 10),
                  actual_date: "actual_date",
                  center_text:
                      (difference.inDays + 1).toString().replaceFirst("-", ""),
                  heading_text: "AI Done",
                  LastDays: index == 0
                      ? "First A.I"
                      : mListData[index - 1].center_text.toString().isEmpty
                          ? ""
                          : ("Days From AI : ${int.parse(difference.inDays.toString()) - int.parse(mListData[index - 1].center_text.toString())}"),
                  PregDays: "Last Sire : ${e.Sirename.toString().isEmpty?Con_List.M_sire.where((element) => element.id.toString()==e.sire).first.name:e.Sirename}",
                  status_text:
                      "AIT : ${e.AITname.toString() == "" ? Con_List.M_inseminator.where((element) => element.code.toString() == e.inseminatorStaff.toString()).first.name.toString() : e.AITname}/Code : ${Con_List.M_inseminator.where((element) => element.code.toString() == e.inseminatorStaff.toString()).first.code.toString()}",
                  tagno: "tagno",
                ));
                index++;
              }
            }
            if (e.pDDate.toString().isNotEmpty) {
              DateTime calving = DateTime.parse(e.dateOfCalving.toString());
              if (e.pDDate.toString().substring(0, 10).contains('/')) {
                DateTime pd = DateFormat('dd/MM/yyyy')
                    .parse(e.pDDate.toString().substring(0, 10));
                Duration difference1 = pd.difference(calving);

                if (difference1.inDays <= 0) {
                  mListData.add(Timeline(
                    id: 0,
                    count: 1,
                    date_text: e.pDDate.toString().substring(0, 10),
                    actual_date: "actual_date1",
                    center_text:
                        difference1.inDays.toString().replaceFirst("-", ""),
                    heading_text: e.pd2 == 4 ? "Abortion" : "PD Done",
                    LastDays: "Days From AI : ${e.PDdays.toString()}",
                    PregDays:
                    e.pd2 == 1 ? "Empty" : e.pd2 == 2 ? "Doubtful" : e.pd2 == 3 ? "Days of Pregnant : ${int.parse(difference1.inDays.toString()) - int.parse(mListData[index - 1].center_text.toString())}": e.pd2 == 4 ? "Abortion" : "",

                    status_text: "PD Date ${e.pDDate.substring(0, 10)}",
                    tagno: "tagno1",
                  ));
                }
              } else {
                // date string is in the format "yyyy-MM-dd"
                DateTime pd = DateFormat('yyyy-MM-dd')
                    .parse(e.pDDate.toString().substring(0, 10));
                Duration difference1 = pd.difference(calving);

                if (difference1.inDays <= 0) {
                  mListData.add(Timeline(
                    id: 0,
                    count: 1,
                    date_text: e.pDDate.toString().substring(0, 10),
                    actual_date: "actual_date1",
                    center_text:
                        difference1.inDays.toString().replaceFirst("-", ""),
                    heading_text: e.pd2 == 4 ? "Abortion" : "PD Done",
                    LastDays: "Days From AI : ${e.PDdays.toString()}",
                    PregDays:
                    e.pd2 == 1 ? "Empty" : e.pd2 == 2 ? "Doubtful" : e.pd2 == 3 ? "Days of Pregnant : ${int.parse(difference1.inDays.toString()) - int.parse(mListData[index - 1].center_text.toString())}": e.pd2 == 4 ? "Abortion" : "",
                    status_text: "PD Date ${e.pDDate.substring(0, 10)}",
                    tagno: "tagno1",
                  ));
                }
              }
            }
          }
        });
        setState(() {});
      } else {
        mListData.clear();
        get();
      }
    }
  }
}
