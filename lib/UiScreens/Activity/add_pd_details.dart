import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herdmannew/Model_local/Breeding_PD.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/component/Gobal_Widgets/MyCustomWidget.dart';
import 'package:herdmannew/model/Animal_Details_id.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../component/DataBaseHelper/Con_List.dart';
import '../../component/DataBaseHelper/Sync_Database.dart';
import '../../component/DataBaseHelper/Sync_Json.dart';
import '../../component/Gobal_Widgets/ButtonState.dart';
import '../../component/Gobal_Widgets/Con_Color.dart';
import '../../component/Gobal_Widgets/Con_Textstyle.dart';
import '../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../component/Gobal_Widgets/Constants.dart';
import '../../component/Gobal_Widgets/DatePicker.dart';
import '../../model/Breeding_reproduction_id.dart';
import '../DrawerScreens/Action/Action.dart';
import '../DrawerScreens/Alarm/Alarm.dart';
import '../DrawerScreens/AllCattleList/CattleStatusTimeline.dart';
import '../DrawerScreens/VisitRegistration/VisitRegistration.dart';

class add_pd_details extends StatefulWidget {
  String? path;
  String? index;
  String? date;
  String? visitid;

  add_pd_details({this.path,this.index, this.date,this.visitid});

  @override
  State<add_pd_details> createState() => _add_pd_detailsState();
}

class _add_pd_detailsState extends State<add_pd_details> {
  ButtonState stateTextWithIcon = ButtonState.idle;
  String mStrFromdate = DateTime.now().toString();
  bool botton1 = true;
  bool botton2 = false;
  bool botton3 = false;
  bool PDcheck = false;
  String dates = "", last_date = "", actual_date = "", l_date = "", diff = "";
  TextEditingController Ticketno = TextEditingController();
  List<String> PD1 = [],
      PD2 = [],
      Inseminator = [],
      mPD1 = [],
      mPD2 = [],
      mInseminator = [];
  Animal_Details_id? mDetails;
  bool isExpanded = true;
  String lat = '', long = '';
  late Duration difference;
  String ExHeatDate = "";
  String ExPDDate = "";
  @override
  void initState() {
    // TODO: implement initState
    if(widget.visitid.toString()=="null")
      {
        Ticketno.text = "100";
      }else{
      Ticketno.text =widget.visitid!;
    }
    super.initState();

    getdata();
    getlist();
    getlastid();
    setState(() {});
  }

  getlastid() async {
    var box = await Hive.openBox<Breeding_PD>("Breeding_pd");

    try {
      Constants.Last_id_Breed_PD = int.parse(box.keys.last.toString());
    } catch (e) {
      Constants.Last_id_Breed_PD = 0;
    }

  }

  getdata() {
    if (Con_List.M_sire.isEmpty ||
        Con_List.M_inseminator.isEmpty ||
        Con_List.M_status.isEmpty ||
        Con_List.M_Service.isEmpty ||
        Con_List.M_pd1.isEmpty ||
        Con_List.id_reproduction.isEmpty ||
        Con_List.M_pd2.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_sire);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_staff);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_status);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_service);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_pd1);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_pd2);
      Sync_Json.Get_Master_Data(Constants.Breeding_reproduction_id);
    }
    setState(() {});
  }

  getlist() async {
    mDetails = Con_List.id_Animal_Details
        .firstWhere((element) => element.tagId == widget.index.toString());
    Con_List.M_pd1.forEach((element) {
      PD1.add(element.name);
    });
    Con_List.M_pd2.forEach((element) {
      PD2.add(element.name);
    });
    Con_List.M_inseminator.forEach((element) {
      Inseminator.add(element.name);
    });
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    lat = position.latitude.toString();
    long = position.longitude.toString();
    if (Con_List.M_inseminator.where(
            (e) => e.id.toString() == Constants_Usermast.staff.toString())
        .isNotEmpty) {
      mInseminator.add(Con_List.M_inseminator.where(
              (e) => e.id.toString() == Constants_Usermast.staff.toString())
          .first
          .name
          .toString());
    }
    setState(() {});
    if ('${mDetails!.breedingStatus}' == 'Open Bred' ||
        '${mDetails!.breedingStatus}' == 'Heifer Bred') {
      ExHeatDate = DateTime.parse(mDetails!.heatDate.toString())
          .add(Duration(days: 21))
          .toString();
      ExPDDate = DateTime.parse(mDetails!.heatDate.toString())
          .add(Duration(days: 90))
          .toString();
    }
    if ('${mDetails!.breedingStatus}' == 'Open Unbred') {
      ExHeatDate = DateTime.parse(mDetails!.calvingDate.toString())
          .add(Duration(days: 60))
          .toString();
    }
    if ('${mDetails!.breedingStatus}' == 'Pregnant' &&
        '${mDetails!.speciesname}' == 'Cow') {
      ExHeatDate = DateTime.parse(mDetails!.heatDate.toString())
          .add(Duration(days: 270))
          .toString();
    }
    if ('${mDetails!.breedingStatus}' == 'Pregnant' &&
        '${mDetails!.speciesname}' == 'Buffalo') {
      ExHeatDate = DateTime.parse(mDetails!.heatDate.toString())
          .add(Duration(days: 310))
          .toString();
    }
  }

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
            : widget.path == "visitre"
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
          elevation: 3,
          title: "PD Details",
          Actions: [],
          onBackTap: () {
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
                  ? Navigator.pushReplacement(context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AlarmScreen();
                    },
                  ))
                  : Navigator.pushReplacement(context,
                  MaterialPageRoute(
                    builder: (context) {
                      return VisitRegistrationScreen();
                    },
                  ));
            },

        ),
        body: Con_Wid.backgroundContainer(
            child: SingleChildScrollView(
          child: Column(
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
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  height: isExpanded ? 70 : 188,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(milliseconds: 1200),
                  decoration: con_clr.ConClr2
                      ? BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: ConClrbluelight.withOpacity(0.5),
                              blurRadius: 20,
                              offset: Offset(5, 10),
                            ),
                          ],
                          gradient: LinearGradient(colors: ConClrAppbarGreadiant),
                        )
                      : BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: ConClrbluelight.withOpacity(0.5),
                            blurRadius: 20,
                            offset: Offset(5, 10),
                          ),
                        ], color: ConClrDialog),
                  child: ListView(children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Con_Wid.width(10),
                            Text(
                              "Animal.ID : ${mDetails!.tagId}",
                              style: TextStyle(
                                color: fontwhiteColor,
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
                                    Text(
                                      "Farmer Code : ",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor),
                                    ),
                                    Text("${mDetails!.farmerCode}",
                                        style: ConStyle.Style_white_12_700w(
                                            fontwhiteColor)),
                                    const Expanded(child: SizedBox()),
                                    Text(
                                      "Farmer Name : ",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor),
                                    ),
                                    Text("${mDetails!.farmername}",
                                        style: ConStyle.Style_white_12_700w(
                                            fontwhiteColor)),
                                  ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Society Code :",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor),
                                  ),
                                  Text("${mDetails!.lotcode}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor)),
                                  const Expanded(child: SizedBox()),
                                  Text(
                                    "Society Name :",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 20,
                                    width: 50,
                                    child: Text("${mDetails!.lotname}",
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
                                    "Farmer Name : ",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor),
                                  ),
                                  Text("${mDetails!.farmername}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor)),
                                  const Expanded(child: SizedBox()),
                                  Con_Wid.gText(
                                    "Farmer Code : ",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor),
                                  ),
                                  Text("${mDetails!.farmer}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor)),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Con_Wid.gText(
                                  "Society Code :",
                                  style: ConStyle.Style_white_12_700w(
                                      fontwhiteColor),
                                ),
                                Text("${mDetails!.lot}",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor)),
                                const Expanded(child: SizedBox()),
                                Con_Wid.gText(
                                  "Society Name :",
                                  style: ConStyle.Style_white_12_700w(
                                      fontwhiteColor),
                                ),
                                Text("${mDetails!.lotname}",
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
                                    "assets/images/${mDetails!.speciesname.toString().toLowerCase()}${mDetails!.statusname.toString().toLowerCase() == "null" ? "" : '-' + mDetails!.statusname.toString().toLowerCase()}.webp"),
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    "${mDetails!.calvingDate == null || mDetails!.calvingDate == "" ? "Birth Date " : "Calving Date :"}   Repeat Heat ",
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                  Text(
                                    "    ${mDetails!.statusname}",
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.orange),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                " ${mDetails!.calvingDate == null || mDetails!.calvingDate == "" ? mDetails!.dOB.toString().substring(0, 10) : mDetails!.calvingDate.toString().substring(0, 10)}              0",
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                            const Divider(
                              height: 2,
                              thickness: 1,
                              color: ConClrDialog,
                            ),
                            Row(
                              children: [
                                Con_Wid.width(5),
                                const Text(
                                  "Expected Heat Date",
                                  style: TextStyle(
                                      color: fontBlackColor, fontSize: 12),
                                ),
                                const Spacer(),
                                Text(
                                  ExHeatDate == ""
                                      ? ""
                                      : "${ExHeatDate.substring(0, 10)}",
                                  style: TextStyle(
                                      color: fontBlackColor, fontSize: 12),
                                )
                              ],
                            ),
                            mDetails!.breedingStatus == "Open Bred"
                                ? Row(
                                    children: [
                                      Con_Wid.width(5),
                                      const Text(
                                        "Expected PD Date",
                                        style: TextStyle(
                                            color: fontBlackColor, fontSize: 12),
                                      ),
                                      const Spacer(),
                                      Text(
                                        ExPDDate == ""
                                            ? ""
                                            : "${ExPDDate.substring(0, 10)}",
                                        style: TextStyle(
                                            color: fontBlackColor, fontSize: 12),
                                      )
                                    ],
                                  )
                                : Container(),
                            Divider(
                              height: 2,
                              thickness: 1,
                              color: ConClrLightBack2,
                            ),
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
              Con_Wid.height(10),
              Con_Wid.fullContainer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Date_Picker(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: widget.date != "" && widget.date != null
                                  ? DateTime.parse(widget.date.toString())
                                      .add(Duration(days: 1))
                                  : mDetails!.calvingDate == null
                                      ? DateTime.parse(mDetails!.dOB)
                                      : DateTime.parse(mDetails!.calvingDate),
                              lastDate: DateTime.now())
                          .then((value) {
                        setState(() {
                          if (value == null) {
                            mStrFromdate = DateTime.now().toString();
                          } else {
                            mStrFromdate = value.toString();
                          }
                        });
                      });
                    },
                    selectionColor:
                        con_clr.ConClr2 ? ConClrborderdrop : whiteColor,
                    selectedTextColor: con_clr.ConClr2 ? BlackColor : BlackColor,
                    onDateChange: (value) {
                      setState(() {
                        mStrFromdate = value.toString();
                      });
                    },
                    buttencolor:
                        con_clr.ConClr2 ? ConClrborderdrop : ConClrDialog,
                  ),

                  Con_Wid.height(10),
                  CondropDown(
                    title: 'Select Inseminator',
                    itemList: Inseminator,
                    SelectedList: mInseminator,
                    onSelected: (List<String> value) {
                      setState(() {
                        mInseminator = value;
                      });
                    },
                  ),
                  Con_Wid.height(10),
                  Con_Wid.textFieldWithInter(
                      TextInput_Type: TextInputType.number,
                      hintText: "Enter Ticket Number",
                      controller: Ticketno,
                      text: ''),
                  //Con_Wid.paddingWithText("Select PDI Result", Conclrfontmain),
                  Con_Wid.height(10),
                  CondropDown(
                    title: 'Select PD1 Result',
                    itemList: PD1,
                    SelectedList: mPD1,
                    onSelected: (List<String> value) {
                      setState(() {
                        mPD1 = value;
                        if (mPD1.isNotEmpty) {
                          if (mPD1[0] == "EMPTY") {
                            PDcheck = true;
                          } else if (mPD1[0] == "PREGNANT") {
                            mPD2.add("PREGNANT");
                          } else {
                            PDcheck = false;
                          }
                        }
                      });
                    },
                  ),
                  Con_Wid.height(10),
                  !PDcheck
                      ? Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Con_Wid.paddingWithText(
                              //     "Select PDI Result2", Conclrfontmain),
                              CondropDown(
                                title: 'Select PD2 Result',
                                itemList: PD2,
                                SelectedList: mPD2,
                                onSelected: (List<String> value) {
                                  setState(() {
                                    mPD2 = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  //Con_Wid.paddingWithText("Inseminator", Conclrfontmain),
                  Con_Wid.height(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyCustomWidget(
                          Onchanged: () async {
                            String pd1 = "";
                            String pd2 = "";
                            if (mPD1.isNotEmpty) {
                              Con_List.M_pd1.forEach((element) {
                                if (element.name == mPD1[0].toString()) {
                                  pd1 = element.id.toString();
                                }
                              });
                            }
                            if (mPD2.isNotEmpty) {
                              Con_List.M_pd2.forEach((element) {
                                if (element.name == mPD2[0].toString()) {
                                  pd2 = element.id.toString();
                                }
                              });
                            }

                            String Insem_ticket = "";

                            var date;
                            if (mStrFromdate == null) {
                              date = new DateTime.now();
                              var formatter1 = new DateFormat('yyyy-MM-dd');
                              actual_date = formatter1.format(date);
                              var formatter = new DateFormat('dd-MM-yyyy HH:mm');
                              dates = formatter.format(date);
                            } else {
                              DateTime dateTime = DateTime.parse(mStrFromdate);
                              String formattedDate =
                                  DateFormat('dd/MM/yyyy HH:mm').format(dateTime);

                              actual_date = formattedDate;
                            }

                            var days = DateTime.parse(
                                    change_date_format(mStrFromdate.toString()))
                                .difference(DateTime.parse(change_date_format(
                                    mDetails!.heatDate == ""
                                        ? mDetails!.dOB.toString()
                                        : mDetails!.heatDate.toString())))
                                .inDays;

                            if (Ticketno.text.isEmpty) {
                              Con_Wid.Con_Show_Toast(
                                  context, "Enter Ticket Number");
                            } else if (mPD1.isEmpty) {
                              Con_Wid.Con_Show_Toast(
                                  context, "Select PD1 Result");
                            } else if (mInseminator.isEmpty) {
                              Con_Wid.Con_Show_Toast(
                                  context, "Select Inseminator");
                            } else {
                              List<Breeding_reproduction_id> Detail_insemination =
                                  [
                                Breeding_reproduction_id(
                                  TableNAme: "",
                                    SyncStatus: "1",
                                    tagId: mDetails!.tagId,
                                    parity: null,
                                    heatSeq: null,
                                    heatDate: "",
                                    remPD1: "",
                                    remPD2: mInseminator[0],
                                    pDDate: mStrFromdate,
                                    dateOfCalving: "",
                                    dateOfDry: null,
                                    dryTreatment: "",
                                    flag: null,
                                    retantionOfPlecenta: null,
                                    comments: "PD",
                                    reproductionProblemNote: "",
                                    mobileOrDesktopEntryFlg: "",
                                    totalAIDose: 0,
                                    abortionSeq: 0,
                                    vaccine: 0,
                                    colostrum: null,
                                    inseminationTicketNumber: Insem_ticket,
                                    pDTicketNumber: Ticketno.text,
                                    calvingTicketNumber: "",
                                    orderNumber: null,
                                    oTP: 0,
                                    eNTRY: "U",
                                    lat: lat,
                                    long: long,
                                    details: "M",
                                    inseminatorStaff: 0,
                                    sire: 0,
                                    pdBy: 0,
                                    service: 0,
                                    pd1: int.parse(pd1),
                                    pd2: pd2 == "" ? 0 : int.parse(pd2),
                                    sex: 0,
                                    calfSex: 0,
                                    calvingType: 0,
                                    calvingTypeOption: 0,
                                    dryReason: 0,
                                    id: Constants.Last_id_Br_reprod + 1,
                                    CI: null,
                                    Sirename: null,
                                    insertflag: null,
                                    AIDays: null,
                                    CalvingPDDays: null,
                                    AITname: null,
                                    PDname: null,
                                    PDResult: null,
                                    PDdays: days,
                                    Pregdays: null,
                                    hI: null,
                                    ServerId: "",
                                    aICost: null,
                                    createdAt: DateTime.now().toString(),
                                    createdByUser:
                                        int.parse(Constants_Usermast.user_id),
                                    lastUpdatedByUser: null,
                                    updatedAt: null,
                                    zone: mDetails!.zone)
                              ];
                              Breeding_reproduction_id rnd = Detail_insemination[
                                  math.Random()
                                      .nextInt(Detail_insemination.length)];
                              List<Map> weights_sync_datas = [];
                              weights_sync_datas.add(rnd.toJson(rnd));
                              SyncDB.insert_table(weights_sync_datas,
                                  Constants.Breeding_reproduction_id);

                              List<Breeding_PD> pd_details = [
                                Breeding_PD(
                                  visit: Ticketno.text,
                                    result: Con_List.M_pd1.where((e) =>
                                        e.name.toString() ==
                                        mPD1[0].toString()).first.id.toString(),
                                    ServerId: "",
                                    id: Constants.Last_id_Breed_PD + 1,
                                    AIT: Con_List.M_inseminator.where(
                                            (e) => e.name == mInseminator[0])
                                        .first
                                        .id
                                        .toString(),
                                    lastUpdatedByUser: 1,
                                    createdByUser: int.parse(
                                        Constants_Usermast.user_id.toString()),
                                    herd: mDetails!.herd,
                                    lot: int.parse(mDetails!.lot.toString()),
                                    farmer: mDetails!.farmer,
                                    TagId: "${mDetails!.tagId}",
                                    PDDate: "$mStrFromdate",
                                    ENTRY: 0,
                                    Lat: lat == "" ? "0.0" : lat,
                                    Long: long == "" ? "0.0" : long,
                                    createdAt: DateTime.now().toString(),
                                    updatedAt: DateTime.now().toString(),
                                    SyncStatus: "0")
                              ];
                              Breeding_PD breepd = pd_details[
                                  math.Random().nextInt(pd_details.length)];
                              List<Map> weights_sync_pd = [];
                              weights_sync_pd.add(breepd.toJson(breepd));
                              SyncDB.insert_table(
                                  weights_sync_pd, Constants.Tbl_Br_Pd);
                              switch (stateTextWithIcon) {
                                case ButtonState.idle:
                                  stateTextWithIcon = ButtonState.loading;
                                  Future.delayed(
                                    Duration(seconds: 3),
                                    () {
                                      setState(() {
                                        stateTextWithIcon = ButtonState.success;
                                        if (stateTextWithIcon ==
                                            ButtonState.success) {
                                          Future.delayed(Duration(seconds: 1),
                                              () {
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
                                                    : widget.path == "visitre"
                                                    ? Navigator.pushReplacement(context, MaterialPageRoute(
                                                  builder: (context) {
                                                    return VisitRegistrationScreen();
                                                  },
                                                ))
                                                    : null;
                                            setState(() {});
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
                              setState(
                                () {
                                  stateTextWithIcon = stateTextWithIcon;
                                },
                              );
                            }
                          },
                          Title: "Save",
                          color:
                              con_clr.ConClr2 ? Color(0xff72b4e5) : ConClrDialog,
                          stateTextWithIcon: stateTextWithIcon)
                    ],
                  )
                ],
              ))
            ],
          ),
        )),
      ),
    );
  }

  change_date_format(String date) {
    //var now = new DateTime.now();
    if (date != null && date != "null" && date != "N/A" && date != "") {
      var formatter = new DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(DateTime.parse(date));
      return formatted;
    } else {
      return "N/A";
    }
  }
}
