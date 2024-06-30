import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/VisitRegistration/VisitRegistration.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Textstyle.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Database.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/ButtonState.dart';
import '../../../component/Gobal_Widgets/Con_Icons.dart';
import '../../../component/Gobal_Widgets/Con_Toast.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../../component/Gobal_Widgets/DatePicker.dart';
import '../../../component/Gobal_Widgets/MyCustomWidget.dart';
import '../../../model/Animal_Details_id.dart';
import '../../../model/Animal_Treatment.dart';
import '../../../model/Animal_Treatment_details.dart';
import '../../../model/Master_medicineLedger.dart';
import '../../../model/Visit_Registration.dart';
import '../Action/Action.dart';
import '../Alarm/Alarm.dart';
import 'CattleStatusTimeline.dart';

class Treatmentandvaccination extends StatefulWidget {
  Visit_Registration? Visitmodel;
  String? index;
  String? path;

  Treatmentandvaccination({this.Visitmodel,this.index,required this.path});

  @override
  State<Treatmentandvaccination> createState() =>
      _TreatmentvndvaccinationState();
}

class _TreatmentvndvaccinationState extends State<Treatmentandvaccination>
    with TickerProviderStateMixin {
  ButtonState stateTextWithIcon = ButtonState.idle;
double sum =0;
  TextEditingController visitnumber = TextEditingController(),
      cost = TextEditingController(),
      batch = TextEditingController(),
      noofdose = TextEditingController(),
      Dewcost = TextEditingController(),
      Dewbatch = TextEditingController(),
      Dewnoofdose = TextEditingController(),
      heatRate = TextEditingController(),
      temperature = TextEditingController(),
      pluses = TextEditingController(),
      respiration = TextEditingController(),
      observation = TextEditingController(),
      ladTest = TextEditingController(),
      note = TextEditingController(),
      ticketId = TextEditingController(),
      recepitNo = TextEditingController(),
      treatmentCost = TextEditingController(),
      dose = TextEditingController(),
      followup = TextEditingController();
  List medicinetype = [];
  String CodeUnit = "";
  List doses = [];
  List followday = [];
  List medicineroute = [];
  bool botton1 = true,
      sSemon = false,
      sammatipatraValue = false,
      botton2 = false,
      botton3 = false;
  String mStrFromdate = DateTime.now().toString(),
      dropdownValue_med_dose = "",
      med_name = "",
      med_auto_id = "",
      unit = "",
      lat = "",
      long = "",
      system = "",
      dygnsis = "",
      managerStaff = "",
      extensionOfficerStaff = "",
      zone = "";
  TabController? tabController;
  List treatment = ["Treatment", "Deworking", "Vaccination"];

  List<String> SelectedComplaint = [],
      Selectedinseminator = [],
      SelectedSystem = [],
      Selecteddiagnosis = [],
      Selectedmedicinetype = [],
      Selectedmedicineroute = [],
      Selectedworm = [],
      SelectedDewormer = [],
      Selectedroute = [],
      Selecteddiseases = [];
  List<Master_medicineLedger> medicinetype1 = [];
  Animal_Details_id? Mdetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    treatmentCost.text = "100";
    if(widget.Visitmodel != null)
      {
        ticketId.text = widget.Visitmodel!.visitID.toString();
        SelectedComplaint.add(widget.Visitmodel!.complaint.toString());
        Selectedinseminator.add(Con_List.M_inseminator.where((element) => element.id.toString() == widget.Visitmodel!.extensionOfficerStaff.toString()).first.name);

      }

    tabController = TabController(length: 3, vsync: this);
    get();
    getdata();
    getLoc();
    medicinetype1 = Con_List.M_medicineLedger;
  }

  getlastid() async {
    var box = await Hive.openBox<Animal_Treatment>("Health_treatment");
    var box1 = await Hive.openBox<Animal_Treatment_details>(
        "Health_treatmentDetails");
    try {
      Constants.Last_id_Treatment = int.parse(box.keys.last.toString());
      Constants.Last_id_Treatment_detail = int.parse(box1.keys.last.toString());
    } catch (e) {
      print(e);
      Constants.Last_id_Treatment = 0;
      Constants.Last_id_Treatment_detail = 0;
    }
  }

  Future getLoc() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    lat = position.latitude.toString();
    long = position.longitude.toString();
  }

  get() {
    Mdetail = Con_List.id_Animal_Details
        .firstWhere((element) => element.tagId == widget.index);
    managerStaff = Mdetail!.zone.toString();
    //todo managestaff and extentionofficerstaff
  }

  getstaff() {
    Con_List.M_Userherds.forEach((element) {
      if (element.Name == Selectedroute[0]) {
        // routecode = element.id.toString();
        managerStaff = element.managerStaff.toString();
        extensionOfficerStaff = element.extensionOfficerStaff.toString();
        zone = element.zone.toString();
      }
    });
  }

  getdata() {
    if (Con_List.M_inseminator.isEmpty ||
        Con_List.M_status.isEmpty ||
        Con_List.M_systemAffected.isEmpty ||
        Con_List.M_medicineLedger.isEmpty ||
        Con_List.M_vaccinationType.isEmpty ||
        Con_List.M_treatmentComplaint.isEmpty ||
        Con_List.M_diagnosis.isEmpty ||
        Con_List.M_medicineType.isEmpty ||
        Con_List.M_medicineRoute.isEmpty ||
        Con_List.M_dewormingType.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_staff);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_status);
      Sync_Json.Get_Master_Data(Constants.Tbl_Health_systemAffected);
      Sync_Json.Get_Master_Data(Constants.Tbl_Account_medicineLedger);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_vaccinationType);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_treatmentComplaint);
      Sync_Json.Get_Master_Data(Constants.Tbl_Health_diagnosis);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_medicineRoute);
      Sync_Json.Get_Master_Data(Constants.Tbl_Account_medicineType);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_dewormingType);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        widget.path == "Action"
            ? Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return ActionScreen();
          },
        ))
            : widget.path == "Activity"
            ? Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return cattlestatustimeline(index: widget.index!);
          },
        ))
            : widget.path == "Alarm"
            ? Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return AlarmScreen();
          },
        ))
            : widget.path == "Visit"
            ? Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return VisitRegistrationScreen();
          },
        ))
            : null;
        return Future.value(false);
      },
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "Treatment And vaccination",
          Actions: [],
          onBackTap: () {
            widget.Visitmodel != null ?Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return VisitRegistrationScreen();
              },
            )):
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return cattlestatustimeline(index: widget.index!);
              },
            ));
          },
        ),
        body: Treatment(),
      ),
    );
  }

  Widget Treatment() =>
      SingleChildScrollView(
        child: Column(
          children: [
            con_clr.ConClr2
                ? Con_Wid.fullContainer(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Farmer Name : ",
                              style: ConStyle.Style_white_10s_500w(
                                  fontBlackColor),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              width: 200,
                              child: widget.index == null
                                  ? Text("")
                                  : Text("  ${Mdetail!.farmername}",
                                  style: TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis),
                            )
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Society Code :-",
                            style:
                            ConStyle.Style_white_10s_500w(fontBlackColor),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 20,
                            width: 200,
                            child: widget.index == null
                                ? Text("")
                                : Text("  ${Mdetail!.lot}",
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Society Name :-",
                            style:
                            ConStyle.Style_white_10s_500w(fontBlackColor),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 20,
                            width: 200,
                            child: widget.index == null
                                ? Text("")
                                : Text("  ${Mdetail!.lotname}",
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Animal.ID :-",
                            style:
                            ConStyle.Style_white_10s_500w(fontBlackColor),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 20,
                            width: 200,
                            child: widget.index == null
                                ? Text("")
                                : Text("  ${Mdetail!.tagId}",
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis),
                          )
                        ],
                      )
                    ],
                  ),
                ))
                : Con_Wid.fullContainer1(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Farmer Name : ",
                              style: ConStyle.Style_white_10s_500w(
                                  fontwhiteColor),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              width: 200,
                              child: widget.index == null
                                  ? Text("")
                                  : Text("  ${Mdetail!.farmername}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: fontwhiteColor),
                                  overflow: TextOverflow.ellipsis),
                            )
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Society Code :-",
                            style:
                            ConStyle.Style_white_10s_500w(fontwhiteColor),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 20,
                            width: 200,
                            child: widget.index == null
                                ? Text("")
                                : Text("  ${Mdetail!.lot}",
                                style: TextStyle(
                                    fontSize: 12, color: fontwhiteColor),
                                overflow: TextOverflow.ellipsis),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Society Name :-",
                            style:
                            ConStyle.Style_white_10s_500w(fontwhiteColor),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 20,
                            width: 200,
                            child: widget.index == null
                                ? Text("")
                                : Text("  ${Mdetail!.lotname}",
                                style: TextStyle(
                                    fontSize: 12, color: fontwhiteColor),
                                overflow: TextOverflow.ellipsis),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Animal.ID :-",
                            style:
                            ConStyle.Style_white_10s_500w(fontwhiteColor),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 20,
                            width: 200,
                            child: widget.index == null
                                ? Text("")
                                : Text("  ${Mdetail!.tagId}",
                                style: TextStyle(
                                    fontSize: 12, color: fontwhiteColor),
                                overflow: TextOverflow.ellipsis),
                          )
                        ],
                      )
                    ],
                  ),
                )),
            Con_Wid.fullContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Con_Wid.paddingWithText("Heat Date :", Conclrfontmain,context: context),
                        Con_Wid.paddingWithText("${mStrFromdate}",
                            con_clr.ConClr2 ? ConClrMain : BlackColor,context: context)
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       color: con_clr.ConClr2
                    //           ? ConClrLightBack
                    //           : ConClrDialog,
                    //       width: MediaQuery
                    //           .of(context)
                    //           .size
                    //           .width - 75,
                    //       height: 100,
                    //       child: DatePicker(
                    //         width: 50,
                    //         daysCount: 4,
                    //         DateTime.now().subtract(Duration(days: 3)),
                    //         initialSelectedDate: DateTime.now(),
                    //         selectionColor: con_clr.ConClr2
                    //             ? ConClrLightBack
                    //             : whiteColor,
                    //         selectedTextColor: con_clr.ConClr2
                    //             ? whiteColor
                    //             : BlackColor,
                    //         onDateChange: (date) {
                    //           setState(() {
                    //             mStrFromdate = date.toString().substring(0, 10);
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //     Container(
                    //       color: con_clr.ConClr2
                    //           ? ConClrLightBack
                    //           : ConClrDialog,
                    //       width: 50,
                    //       height: 100,
                    //       child: IconButton(
                    //           onPressed: () {
                    //             showDatePicker(
                    //                 context: context,
                    //                 initialDate: DateTime.now(),
                    //                 firstDate: Mdetail!.heatDate == null
                    //                     ? DateTime.parse(Mdetail!.dOB)
                    //                     : DateTime.parse(Mdetail!.heatDate),
                    //                 lastDate: DateTime.now())
                    //                 .then((value) {
                    //               setState(() {
                    //                 mStrFromdate =
                    //                     value.toString().substring(0, 10);
                    //               });
                    //             });
                    //           },
                    //           icon: const Icon(
                    //             Icons.calendar_month_outlined,
                    //             color: Colors.white,
                    //           )),
                    //     ),
                    //   ],
                    // ),
                    Date_Picker(
                      onDateChange: (date) {
                        setState(() {
                          mStrFromdate = date.toString().substring(0, 10);
                        });
                      },
                      selectionColor:
                      con_clr.ConClr2 ? ConClrLightBack : whiteColor,
                      selectedTextColor: con_clr.ConClr2
                          ? whiteColor
                          : BlackColor,
                      onPressed: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: Mdetail!.heatDate == null
                                ? DateTime.parse(Mdetail!.dOB)
                                : DateTime.parse(Mdetail!.heatDate),
                            lastDate: DateTime.now())
                            .then((value) {
                          setState(() {
                            mStrFromdate = value.toString().substring(0, 10);
                          });
                        });
                      },
                      buttencolor: con_clr.ConClr2
                          ? ConClrLightBack
                          : ConClrDialog,
                    ),
                    Con_Wid.height(5),
                    // Con_Wid.paddingWithText("Select Complaint", Conclrfontmain),
                    CondropDown(
                      title: 'Select Complaint',
                      itemList: Con_List.M_treatmentComplaint.map(
                              (e) => e.name.toString()).toList(),
                      SelectedList: SelectedComplaint,
                      onSelected: (List<String> value) {
                        setState(() {});
                      },
                    ),
                    // Con_Wid.paddingWithText("Doctor", Conclrfontmain),
                    CondropDown(
                      title: 'Select Doctor',
                      itemList: Con_List.M_inseminator.map((e) =>
                          e.name.toString())
                          .toList(),
                      SelectedList: Selectedinseminator,
                      onSelected: (List<String> value) {
                        setState(() {});
                      },
                    ),
                    Con_Wid.height(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Heat Rate\n (40-240)",
                          style: ConStyle.Style_white_10s_500w(
                              con_clr.ConClr2 ? Conclrfontmain : BlackColor),
                        ),
                        Text(
                          "Temperature\n    (97-107f)",
                          style: ConStyle.Style_white_10s_500w(
                              con_clr.ConClr2 ? Conclrfontmain : BlackColor),
                        ),
                        Text(
                          "  Pluses\n(40-200)",
                          style: ConStyle.Style_white_10s_500w(
                              con_clr.ConClr2 ? Conclrfontmain : BlackColor),
                        ),
                      ],
                    ),
                    Con_Wid.height(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Con_Wid.textFieldWithIntersmall(heatRate, ""),
                        Con_Wid.textFieldWithIntersmall(temperature, ""),
                        Con_Wid.textFieldWithIntersmall(pluses, ""),
                      ],
                    ),
                    Con_Wid.textFieldWithInter(
                        text: "Respiration (20-60)",
                        controller: respiration,
                        hintText: "Respiration (20-60)"),
                    Con_Wid.textFieldWithInter(
                        text: "Observation",
                        controller: observation,
                        hintText: "Enter Observation"),
                    Con_Wid.textFieldWithInter(
                        text: "Lad Test",
                        controller: ladTest,
                        hintText: "Enter Lab Test"),
                    Con_Wid.textFieldWithInter(
                        text: "Note", controller: note, hintText: "Enter Note"),
                    Con_Wid.textFieldWithInter(
                      readonly: widget.Visitmodel != null ? true : null,
                        text: "Ticket ID",
                        controller: ticketId,
                        hintText: "Enter Ticket ID"),
                    // Con_Wid.paddingWithText("System", Conclrfontmain),
                    CondropDown(
                      title: 'Select System',
                      itemList:
                      Con_List.M_systemAffected.map((e) => e.name.toString())
                          .toList(),
                      SelectedList: SelectedSystem,
                      onSelected: (List<String> value) {
                        setState(() {
                          system = Con_List.M_systemAffected
                              .where(
                                  (e) =>
                              e.name.toString() == value[0].toString())
                              .first
                              .id
                              .toString();

                        });
                      },
                    ),
                    CondropDown(
                      title: 'Select Diagnosis',
                      itemList: Con_List.M_diagnosis.where(
                              (u) => u.systemAffected.toString() == system)
                          .map((e) => "${e.name}")
                          .toList()..sort((a, b) => a.toString().compareTo(b.toString())),
                      SelectedList: Selecteddiagnosis,
                      onSelected: (List<String> value) {
                        setState(() {
                          dygnsis = Con_List.M_diagnosis.where((element) =>
                          element.name.toString() == value[0].toString())
                              .first
                              .id
                              .toString();
                        });
                      },
                    ),
                    Row(
                      children: [
                        Con_Wid.paddingWithText("Sammatipatra", Conclrfontmain,context: context),
                        Spacer(),
                        Checkbox(
                          value: sSemon,
                          onChanged: (value) {
                            double visitCost =
                                widget.Visitmodel?.visitCost.toDouble() ?? 0;

                            if (value == true && sum + visitCost < 400) {
                              treatmentCost.text = (250).toString();
                            } else {
                              treatmentCost.text =
                                  (sum + widget.Visitmodel!.visitCost)
                                      .toString();
                            }

                            sSemon = value!;
                            setState(() {});
                          },
                        )
                      ],
                    ),
                    Con_Wid.textFieldWithInter(
                        text: "Recepit no",
                        controller: recepitNo,
                        hintText: "Enter Recepit Num."),
                    Con_Wid.height(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 260,
                          decoration: BoxDecoration(
                            color: con_clr.ConClr2
                                ? ConClrMain
                                : ConClrSelected,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  maxRadius: 26,
                                  backgroundColor: con_clr.ConClr2
                                      ? ConClrGryBtn
                                      : const Color(0xE689B7E8),
                                  child: IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              child: SingleChildScrollView(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                        color: con_clr.ConClr2
                                                            ? ConClrMainLight
                                                            : whiteColor),
                                                    child: Column(children: [
                                                      Container(
                                                        height: 60,
                                                        width: double.infinity,
                                                        color: con_clr.ConClr2
                                                            ? ConClrMain
                                                            : ConClrDialog,
                                                        child: Stack(children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                            children: [
                                                              Con_Wid
                                                                  .mIconButton(
                                                                  color: Colors
                                                                      .white,
                                                                  onPressed: () {
                                                                    Navigator
                                                                        .pop(
                                                                        context);
                                                                  },
                                                                  icon: Own_Close)
                                                            ],
                                                          ),
                                                          Center(
                                                            child:
                                                            Con_Wid
                                                                .paddingWithText(
                                                                "Medicine Given",
                                                                fontwhiteColor,context: context),
                                                          )
                                                        ]),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .only(
                                                            right: 20,
                                                            left: 20),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            // Con_Wid.paddingWithText(
                                                            //     "Medicine Type",
                                                            //     Conclrfontmain),
                                                            CondropDown(
                                                              title:
                                                              'Select Medicine type',
                                                              itemList: Con_List
                                                                  .M_medicineLedger
                                                                  .map((e) =>
                                                              "${e.code}-${e.name}")
                                                                  .toList()..sort((a, b) => a.toString().compareTo(b.toString())),
                                                              SelectedList:
                                                              Selectedmedicinetype,
                                                              onSelected:
                                                                  (List<
                                                                  String> value) {
                                                                setState(() {
                                                                  Selectedmedicinetype =
                                                                      value;
                                                                  CodeUnit = Con_List.M_medicineLedger.where((element) => "${element.code}-${element.name}" == Selectedmedicinetype[0].toString()).first.dosageUnit.toString();
                                                                });

                                                              },
                                                            ),
                                                            Con_Wid.height(15),
                                                            Con_Wid.textFieldWithInter(
                                                                text: "Dose",
                                                                controller: dose,
                                                                hintText:
                                                                "Enter No of Dose",Trealing: Text(CodeUnit)),
                                                            Con_Wid
                                                                .textFieldWithInter(
                                                                text: "Follow uo Days",
                                                                controller: followup,
                                                                hintText:
                                                                "Enter Followup days"),
                                                            // Con_Wid.paddingWithText(
                                                            //     "Medicine Route",
                                                            //     Conclrfontmain),
                                                            CondropDown(
                                                              title:
                                                              'Select MedicineRoute',
                                                              itemList: Con_List
                                                                  .M_medicineRoute
                                                                  .map((e) =>
                                                                  e.name
                                                                      .toString())
                                                                  .toList(),
                                                              SelectedList:
                                                              Selectedmedicineroute,
                                                              onSelected:
                                                                  (List<
                                                                  String> value) {
                                                                setState(() {
                                                                  Selectedmedicineroute =
                                                                      value;
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Con_Wid.height(15),
                                                      Con_Wid.MainButton(
                                                          width: 170,
                                                          height: 51,
                                                          fontSize: 16,
                                                          pStrBtnName: 'Save',
                                                          OnTap: () {
                                                            medicinetype.add(Selectedmedicinetype[0]);
                                                            medicineroute.add(Selectedmedicineroute[0]);
                                                            doses.add(dose.text);
                                                            followday.add(followup.text);
                                                            Selectedmedicinetype = [];
                                                            Selectedmedicineroute =[];
                                                            dose.text = "";
                                                            followup.text = "";

                                                            setState(() {});
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                      Con_Wid.height(5)
                                                    ]),
                                                  )),
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: con_clr.ConClr2
                                            ? BlackColor
                                            : whiteColor,
                                      ))),
                              Con_Wid.div(),
                              Con_Wid.paddingWithText(
                                  "Medicine", fontwhiteColor,context: context)
                            ],
                          ),
                        ),
                      ],
                    ),
                    medicinetype.isNotEmpty
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 80 *
                              double.parse(medicinetype.length.toString()),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: medicinetype.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(4),
                                padding: EdgeInsets.only(right: 5, left: 5),
                                height: 71,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text('${medicinetype[index]}',
                                            style: TextStyle(
                                                overflow:
                                                TextOverflow.ellipsis)),
                                      ),
                                      IconButton(
                                          splashRadius: 20,
                                          splashColor: Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              medicinetype.removeAt(index);
                                              medicineroute.removeAt(index);
                                              doses.removeAt(index);
                                              followday.removeAt(index);
                                            });
                                          },
                                          icon: Own_delete,color: Colors.black,)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Dose : ${doses[index]}"),
                                      Text(
                                          "Follow up days : ${followday[index]}"),
                                    ],
                                  ),
                                ]),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                        : Container(),
                    Con_Wid.textFieldWithInter(
                        text: "Treatment Cost",
                        controller: treatmentCost,
                        hintText: "Enter Treatment Cost"),
                    Con_Wid.height(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyCustomWidget(
                            Onchanged: () {
                              if (SelectedComplaint.isEmpty) {
                                CustomToast.show(context, "Select Complaints");
                              }
                              else if (SelectedSystem.isEmpty) {
                                CustomToast.show(context, "Select System");
                              }
                              else if (Selecteddiagnosis.isEmpty) {
                                CustomToast.show(context, "Select Diagnosis");
                              } else if (Selectedinseminator.isEmpty) {
                                CustomToast.show(context, "Select Doctor");
                              } else {
                                String formattedDate =
                                DateFormat('yyyy-MM-dd').format(DateTime.now());
                                List<Animal_Treatment> details = [
                                  Animal_Treatment(
                                      tagId: "${widget.index}",
                                      fromDate: formattedDate,
                                      toDate: formattedDate,
                                      treatmentSequence: null,
                                      noTreatment:
                                      sammatipatraValue == true ? 1 : 0,
                                      dateOfTreatment: formattedDate,
                                      temperature: temperature.text.trim() != ""
                                          ? int.parse(temperature.text)
                                          : 0,
                                      pulse: pluses.text != ""
                                          ? int.parse(pluses.text)
                                          : null,
                                      respiration: respiration.text != ""
                                          ? int.parse(respiration.text)
                                          : null,
                                      observation: observation.text,
                                      labTest: ladTest.text,
                                      cost: treatmentCost.text,
                                      followUpDate: null,
                                      treatmentComplaint: int.parse(
                                          Con_List.M_treatmentComplaint
                                              .where(
                                                  (e) =>
                                              e.name == SelectedComplaint[0])
                                              .first
                                              .id
                                              .toString()),
                                      systemAffected: int.parse(system),
                                      diagnosis: int.parse(dygnsis),
                                      doctor: int.parse(Con_List.M_inseminator
                                          .where(
                                              (e) =>
                                          e.name == Selectedinseminator[0])
                                          .first
                                          .id
                                          .toString()),
                                      details: null,
                                      SyncStatus: "0",
                                      id:  1,
                                      createdAt: DateTime.now().toString(),
                                      updatedAt: DateTime.now().toString(),
                                      lastUpdatedByUser: int.parse(
                                          Constants_Usermast.user_id),
                                      createdByUser: int.parse(
                                          Constants_Usermast.user_id),
                                      lat: lat,
                                      long: long,
                                      managerStaff:
                                      managerStaff != "" ? managerStaff : null,
                                      extensionOfficerStaff:
                                      extensionOfficerStaff != ""
                                          ? extensionOfficerStaff
                                          : null,
                                      zone: zone != "null" ? zone : null,
                                      // visitID: widget.index.visitRegistrationModel?.visitId?.toString(),
                                      receiptNo: recepitNo.text,
                                      herd: int.parse(Mdetail!.herd.toString()),
                                      lot: int.parse(Mdetail!.lot.toString()),
                                      farmer: int.parse(
                                          Mdetail!.farmer.toString()),
                                      serverID: 0,
                                      clientID: "",
                                      visitID: null)
                                ];
                                List<Map> weights_sync_medidetails = [];
                                if (medicinetype.isNotEmpty) {
                                  for (int i = 0; i <
                                      medicinetype.length; i++) {
                                    List<
                                        Animal_Treatment_details> animal_details = [
                                      Animal_Treatment_details(
                                          syncstatus: "0",
                                          tagId: "${widget.index}",
                                          date: mStrFromdate,
                                          treatmentSequence: null,
                                          tradeName: null,
                                          doseRate: 0,
                                          totalDose: int.parse(doses[i]),
                                          batchNo: null,
                                          medicineCode: Con_List
                                              .M_medicineLedger
                                              .where((element) =>
                                          "${element.code}-${element.name}" ==
                                              medicinetype[i])
                                              .first
                                              .id,
                                          medicineLedger: Con_List
                                              .M_medicineLedger
                                              .where((element) =>
                                          "${element.code}-${element.name}" ==
                                              medicinetype[i])
                                              .first
                                              .medicineCode,
                                          medicineRoute: Con_List
                                              .M_medicineRoute
                                              .where((e) =>
                                          e.name.toString() == medicineroute[i])
                                              .first
                                              .id,
                                          details: "details",
                                          id: i+1,
                                          createdAt: DateTime.now().toString(),
                                          updatedAt: DateTime.now().toString(),
                                          lastUpdatedByUser: Constants_Usermast
                                              .user_id,
                                          createdByUser: Constants_Usermast
                                              .user_id,
                                          herd: int.parse(
                                              Mdetail!.herd.toString()),
                                          lot: int.parse(
                                              Mdetail!.lot.toString()),
                                          farmer: int.parse(
                                              Mdetail!.farmer.toString()),
                                          serverID: 0,
                                          clientID: null)
                                    ];
                                    Animal_Treatment_details medidetails =
                                    animal_details[math.Random().nextInt(
                                        animal_details.length)];
                                    weights_sync_medidetails.add(
                                        medidetails.toJson(medidetails));
                                  }
                                }
                                Animal_Treatment prods =
                                details[math.Random().nextInt(details.length)];
                                List<Map> weights_sync_datas = [];
                                weights_sync_datas.add(prods.toJson(prods));
                                SyncDB.insert_table(weights_sync_datas,
                                    Constants.Tbl_Health_treatment);
                                SyncDB.insert_table(weights_sync_medidetails,
                                    Constants.Tbl_Health_treatmentDetails);
                                switch (stateTextWithIcon) {
                                  case ButtonState.idle:
                                    stateTextWithIcon = ButtonState.loading;
                                    Future.delayed(
                                      Duration(seconds: 3),
                                          () {
                                        setState(() {
                                          stateTextWithIcon =
                                              ButtonState.success;
                                          if (stateTextWithIcon ==
                                              ButtonState.success) {
                                            Future.delayed(Duration(seconds: 1),
                                                    () {
                                                      if(widget.Visitmodel != null)
                                                      {
                                                        SyncDB.Visit_Complete(widget.Visitmodel!.visitID.toString(), widget.Visitmodel!.animalID.toString());
                                                      }
                                                      widget.path == "Action"
                                                          ? Navigator.pushReplacement(context, MaterialPageRoute(
                                                        builder: (context) {
                                                          return ActionScreen();
                                                        },
                                                      ))
                                                          : widget.path == "Activity"
                                                          ? Navigator.pushReplacement(context, MaterialPageRoute(
                                                        builder: (context) {
                                                          return cattlestatustimeline(index: widget.index!);
                                                        },
                                                      ))
                                                          : widget.path == "Alarm"
                                                          ? Navigator.pushReplacement(context, MaterialPageRoute(
                                                        builder: (context) {
                                                          return AlarmScreen();
                                                        },
                                                      ))
                                                          : widget.path == "Visit"
                                                          ? Navigator.pushReplacement(context, MaterialPageRoute(
                                                        builder: (context) {
                                                          return VisitRegistrationScreen();
                                                        },
                                                      )):Navigator.pushReplacement(context, MaterialPageRoute(
                                                        builder: (context) {
                                                          return VisitRegistrationScreen();
                                                        },
                                                      ));



                                                  Navigator.pop(context);
                                                });
                                          }
                                        });
                                      },
                                    );
                                    break;
                                  case ButtonState.loading:
                                    break;
                                  case ButtonState.success:
                                    stateTextWithIcon = ButtonState.idle;
                                    break;
                                  case ButtonState.fail:
                                    stateTextWithIcon = ButtonState.idle;
                                    break;
                                }
                                setState(() {
                                  stateTextWithIcon = stateTextWithIcon;
                                });
                              }
                            },
                            Title: "Save",
                            color: con_clr.ConClr2
                                ? ConClrBtntxt
                                : ConClrDialog,
                            stateTextWithIcon: stateTextWithIcon)
                      ],
                    )
                  ],
                )),
          ],
        ),
      );

}
