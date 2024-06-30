import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/CattleStatusTimeline.dart';
import 'package:herdmannew/component/DataBaseHelper/Con_List.dart';
import 'package:herdmannew/component/DataBaseHelper/Sync_Json.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Icons.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Textstyle.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/component/Gobal_Widgets/Constants.dart';
import 'package:herdmannew/component/Gobal_Widgets/MyCustomWidget.dart';
import 'package:herdmannew/model/Animal_Details_id.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../Model_local/Bredding_Calving.dart';
import '../../../Model_local/rep_problem_val_model.dart';
import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../../component/DataBaseHelper/Sync_Database.dart';
import '../../../component/Gobal_Widgets/ButtonState.dart';
import '../../../component/Gobal_Widgets/DatePicker.dart';
import '../../../model/Breeding_reproduction_id.dart';
import '../Action/Action.dart';
import '../Alarm/Alarm.dart';
import '../VisitRegistration/VisitRegistration.dart';

class CalvingDetails extends StatefulWidget {
  String? index;
  String? vistid;
  String? path;

  CalvingDetails({this.index, this.vistid, this.path});

  @override
  State<CalvingDetails> createState() => _CalvingDetailsState();
}

class _CalvingDetailsState extends State<CalvingDetails> {
  ButtonState stateTextWithIcon = ButtonState.idle;
  Color consts = Colors.green.shade800;
  Color Mainlight200 = Colors.green.shade200;
  Color Mainlight300 = Colors.green.shade300;
  Color Mainlight500 = Colors.green.shade500;
  final ImagePicker picker = ImagePicker();
  TextEditingController ticketnumber = TextEditingController(),
      calfid = TextEditingController(),
      calfid2 = TextEditingController(),
      colostrum = TextEditingController(),
      comment = TextEditingController(),
      reproductiveproblem = TextEditingController();
  String mStrFromdate = DateFormat('MM/dd/yyyy HH:mm').format(DateTime.now()),
      calf_sex_id = "2",
      calf_sex_id1 = "1",
      Firstimage = "",
      Secondimage = "",
      dates = "",
      actual_date2 = "",
      lat = "",
      long = "",
      TapToExpandIt = "Breeding details",
      c_type = "1";
  String ExHeatDate = "";
  String ExPDDate = "";
  bool twin = false,
      FirstImg = false,
      SecondImg = false,
      done = false,
      isExpanded = true;
  List<String> reproHistory = ["null"];
  List<String> reproproblem = [];
  List<String> ticket = [];
  List<dynamic> menual = [
    {
      "Name": "Abortion",
      "id": 1,
    },
    {
      "Name": "Still birth",
      "id": 2,
    },
    {
      "Name": "Normal",
      "id": 3,
    },
    {
      "Name": "Prolapse",
      "id": 4,
    }
  ];
  Animal_Details_id? Mdetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.vistid.toString() == "null") {
      ticketnumber.text = "100";
    } else {
      ticketnumber.text = widget.vistid.toString();
    }
    cheakconnectivity();
    getdata();
    getList();
    if ('${Mdetail!.breedingStatus}' == 'Open Bred' ||
        '${Mdetail!.breedingStatus}' == 'Heifer Bred') {
      ExHeatDate = DateTime.parse(Mdetail!.heatDate.toString())
          .add(Duration(days: 21))
          .toString();
      ExPDDate = DateTime.parse(Mdetail!.heatDate.toString())
          .add(Duration(days: 90))
          .toString();
    }
    if ('${Mdetail!.breedingStatus}' == 'Open Unbred') {
      ExHeatDate = DateTime.parse(Mdetail!.calvingDate.toString())
          .add(Duration(days: 60))
          .toString();
    }
    if ('${Mdetail!.breedingStatus}' == 'Pregnant' &&
        '${Mdetail!.speciesname}' == 'Cow') {
      ExHeatDate = DateTime.parse(Mdetail!.heatDate.toString())
          .add(Duration(days: 270))
          .toString();
    }
    if ('${Mdetail!.breedingStatus}' == 'Pregnant' &&
        '${Mdetail!.speciesname}' == 'Buffalo') {
      ExHeatDate = DateTime.parse(Mdetail!.heatDate.toString())
          .add(Duration(days: 310))
          .toString();
    }
  }

  cheakconnectivity() {}

  getdata() async {
    if (Con_List.id_reproduction.isEmpty ||
        Con_List.M_reproductveProblem.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Breeding_reproduction_id);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_reproductiveProblem);
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    lat = position.latitude.toString();
    long = position.longitude.toString();
    setState(() {});
  }

  getdata1() async {
    var box = await Hive.openBox<Breeding_Calving>("Breeding_Calving");
    try {
      Constants.Last_id_Calving = int.parse(box.keys.last.toString());
    } catch (e) {
      print(e);
      Constants.Last_id_Calving = 0;
    }
  }

  getList() {
    Mdetail = Con_List.id_Animal_Details
        .firstWhere((element) => element.tagId == widget.index.toString());
    ticketnumber.text = "100";
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
        appBar: AppBar(
          leading: Con_Wid.mIconButton(
              onPressed: () {
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
              icon: Own_ArrowBack,
              color: Colors.black),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Mainlight200,
          title: Con_Wid.gText(
            "Calving Details",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
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
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 5.0),
                  height: isExpanded ? 70 : 188,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(milliseconds: 1200),
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                  ),
                  child: ListView(children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Con_Wid.width(10),
                            Text(
                              "Animal.ID : ${Mdetail!.tagId}",
                              style: const TextStyle(
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
                                      "Farmer Name : ",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor),
                                    ),
                                    Text("${Mdetail!.farmername}",
                                        style: ConStyle.Style_white_12_700w(
                                            fontwhiteColor)),
                                    const Expanded(child: SizedBox()),
                                    Text(
                                      "Farmer Code : ",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor),
                                    ),
                                    Text("${Mdetail!.farmer}",
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
                                  Text("${Mdetail!.lot}",
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
                                    child: Text("${Mdetail!.lotname}",
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
                                  Text(
                                    "Farmer Name : ",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor),
                                  ),
                                  Text("${Mdetail!.farmername}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor)),
                                  const Expanded(child: SizedBox()),
                                  Text(
                                    "Farmer Code : ",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor),
                                  ),
                                  Text("${Mdetail!.farmer}",
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
                                Text("${Mdetail!.lot}",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor)),
                                const Expanded(child: SizedBox()),
                                Text(
                                  "Society Name :",
                                  style: ConStyle.Style_white_12_700w(
                                      fontwhiteColor),
                                ),
                                Text("${Mdetail!.lotname}",
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
                                    "assets/images/${Mdetail!.speciesname.toString().toLowerCase()}${Mdetail!.statusname.toString().toLowerCase() == "null" ? "" : '-' + Mdetail!.statusname.toString().toLowerCase()}.webp"),
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    "${Mdetail!.calvingDate == null ? "Birth Date " : "Calving Date :"}   Repeat Heat ",
                                    style: const TextStyle(
                                        fontSize: 13, color: fontwhiteColor),
                                  ),
                                  Text(
                                    "    ${Mdetail!.statusname}",
                                    style: const TextStyle(
                                        fontSize: 13, color: fontwhiteColor),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                " ${Mdetail!.calvingDate == null ? Mdetail!.dOB.toString().substring(0, 10) : Mdetail!.calvingDate.toString().substring(0, 10)}              0",
                                style: const TextStyle(
                                    fontSize: 10, color: fontwhiteColor),
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
                                const Text(
                                  "Expected Heat Date",
                                  style: TextStyle(
                                      color: fontwhiteColor, fontSize: 12),
                                ),
                                const Spacer(),
                                Text(
                                  ExHeatDate == ""
                                      ? ""
                                      : "${ExHeatDate.substring(0, 10)}",
                                  style: const TextStyle(
                                      color: fontwhiteColor, fontSize: 12),
                                )
                              ],
                            ),
                            Mdetail!.breedingStatus == "Open Bred"
                                ? Row(
                                    children: [
                                      Con_Wid.width(5),
                                      const Text(
                                        "Expected PD Date",
                                        style: TextStyle(
                                            color: fontwhiteColor, fontSize: 12),
                                      ),
                                      const Spacer(),
                                      Text(
                                        ExPDDate == ""
                                            ? ""
                                            : ExPDDate.substring(0, 10),
                                        style: const TextStyle(
                                            color: fontwhiteColor, fontSize: 12),
                                      )
                                    ],
                                  )
                                : Container(),
                            const Divider(
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
              Con_Wid.height(5),
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Date_Picker(
                      selectionColor: Mainlight200,
                      selectedTextColor: Colors.white,
                      onDateChange: (value) {
                        setState(() {
                          mStrFromdate = value.toString();
                        });
                      },
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: Mdetail!.calvingDate == null
                                    ? DateTime.parse(Mdetail!.dOB)
                                    : DateTime.parse(Mdetail!.calvingDate),
                                lastDate: DateTime.now())
                            .then((value) {
                          setState(() {
                            if (value == null) {
                              mStrFromdate = value.toString();
                            } else {
                              mStrFromdate = value.toString();
                            }
                          });
                        });
                      },
                      buttencolor: Mainlight200,
                    ),
                    Con_Wid.height(10),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Con_Wid.textFieldWithInter(
                              color1: consts,
                              text: "Ticket Number",
                              controller: ticketnumber,
                              hintText: "Enter Ticket Number"),
                          Con_Wid.height(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Con_Wid.paddingWithText(
                                  "Calving Type", Colors.green.shade900,
                                  context: context),
                              Con_Wid.width(6),
                              Expanded(
                                child: Choice_Chip(
                                  ButtonName: const ["Normal", "Abnormal"],
                                  StrDefault: 'Normal',
                                  onSelected: (value) {
                                    setState(() {
                                      if (value == 'Normal') {
                                        c_type = '1';
                                      } else {
                                        c_type = '2';
                                      }
                                    });
                                  },
                                  BackClr: Colors.white,
                                  RoundClr: Mainlight200,
                                  SelectedBackClr: Mainlight200,
                                  SelectedRoundClr: Mainlight500,
                                ),
                              ),
                            ],
                          ),
                          Con_Wid.height(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Con_Wid.paddingWithText(
                                  "Single or Twin", Colors.green.shade900,
                                  context: context),
                              Con_Wid.width(2),
                              Expanded(
                                child: Choice_Chip(
                                  ButtonName: const ["Single", "Twin"],
                                  StrDefault: 'Single',
                                  onSelected: (value) {
                                    setState(() {
                                      if (value == 'Single') {
                                        twin = false;
                                      } else {
                                        twin = true;
                                      }
                                    });
                                  },
                                  BackClr: Colors.white,
                                  RoundClr: Mainlight200,
                                  SelectedBackClr: Mainlight200,
                                  SelectedRoundClr: Mainlight500,
                                ),
                              ),
                            ],
                          ),
                          Con_Wid.height(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Con_Wid.paddingWithText(
                                  "Calf Sex 1",
                                  context: context,
                                  Colors.green.shade900),
                              Con_Wid.width(36),
                              Expanded(
                                child: Choice_Chip(
                                  ButtonName: const ["Female", "Male"],
                                  StrDefault: 'Female',
                                  onSelected: (value) {
                                    setState(() {
                                      if (value == 'Male') {
                                        calf_sex_id = '1';
                                      } else {
                                        calf_sex_id = '2';
                                      }
                                    });
                                  },
                                  BackClr: Colors.white,
                                  RoundClr: Mainlight200,
                                  SelectedBackClr: Mainlight200,
                                  SelectedRoundClr: Mainlight500,
                                ),
                              ),
                            ],
                          ),
                          Con_Wid.height(5),
                          Con_Wid.textFieldWithInter(
                              color1: consts,
                              text: "Calf ID 1",
                              controller: calfid,
                              hintText: "Enter Calf id",
                              TextInput_Type: TextInputType.number),
                          Con_Wid.height(5),
                          Con_Wid.paddingWithText(
                              "Calf Image 1",
                              context: context,
                              Colors.green.shade900),
                          Con_Wid.height(5),
                          FirstImg == false
                              ? Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  alignment: Alignment.centerLeft,
                                  child: Con_Wid.selectionContainer(
                                    width: 80,
                                    height: 35,
                                    text: "Add +",
                                    context: context,
                                    textcolor: Colors.white,
                                    ontap: () async {
                                      final XFile? image = await picker.pickImage(
                                          source: ImageSource.camera);
                                      setState(() {
                                        Firstimage = image!.path;
                                        FirstImg = true;
                                      });
                                    },
                                    Color: consts,
                                  ),
                                )
                              : Container(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width - 200,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image:
                                              FileImage(File(Firstimage)))),
                                  child: Baseline(
                                    baseline: 25,
                                    baselineType: TextBaseline.alphabetic,
                                    child: Container(
                                        height: 30,
                                        width: MediaQuery.of(context).size.width -
                                            200,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 32,
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    FirstImg = false;
                                                    Firstimage = "";
                                                  });
                                                },
                                                icon: Own_Close,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        )),
                                  )),
                          twin == true
                              ? Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Con_Wid.height(5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Con_Wid.paddingWithText(
                                            "Calf Sex 2",
                                            context: context,
                                            Colors.green.shade900),
                                        Expanded(
                                          child: Choice_Chip(
                                            ButtonName: const ["Male", "Female"],
                                            StrDefault: 'Female',
                                            onSelected: (value) {
                                              setState(() {
                                                if (value == 'Male') {
                                                  calf_sex_id1 = '1';
                                                } else {
                                                  calf_sex_id1 = '2';
                                                }
                                              });
                                            },
                                            BackClr: Colors.white,
                                            RoundClr: Mainlight200,
                                            SelectedBackClr: Mainlight200,
                                            SelectedRoundClr: Mainlight500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Con_Wid.height(5),
                                    Con_Wid.textFieldWithInter(
                                        color1: consts,
                                        text: "Calf ID 2",
                                        controller: calfid2,
                                        hintText: "Enter Calf id",
                                        TextInput_Type: TextInputType.number),
                                    Con_Wid.height(5),
                                    Container(
                                      padding: const EdgeInsets.only(left: 25),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Calf Image 2",
                                        style: ConStyle.Style_white_13s_700w(
                                            Colors.green.shade900),
                                      ),
                                    ),
                                    Con_Wid.height(5),
                                    SecondImg == false
                                        ? Container(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            alignment: Alignment.centerLeft,
                                            child: Con_Wid.selectionContainer(
                                              width: 80,
                                              height: 35,
                                              text: "Add +",
                                              context: context,
                                              textcolor: Colors.white,
                                              ontap: () async {
                                                final XFile? image =
                                                    await picker.pickImage(
                                                        source: ImageSource
                                                            .camera);
                                                setState(() {
                                                  Secondimage = image!.path;
                                                  SecondImg = true;
                                                });
                                              },
                                              Color: consts,
                                            ),
                                          )
                                        : Container(
                                            height: 300,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                200,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: FileImage(File(
                                                        Secondimage)))),
                                            child: Baseline(
                                              baseline: 25,
                                              baselineType:
                                                  TextBaseline.alphabetic,
                                              child: SizedBox(
                                                  height: 30,
                                                  width:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                          200,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      SizedBox(
                                                        width: 32,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              SecondImg =
                                                                  false;
                                                              Secondimage =
                                                                  "";
                                                            });
                                                          },
                                                          icon: Own_Close,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            )),
                                  ])
                              : Container(),
                          Con_Wid.textFieldWithInter(
                              text: "Colostum",
                              color1: consts,
                              controller: colostrum,
                              hintText: "Enter Colostum"),
                          Con_Wid.height(5),
                          Con_Wid.textFieldWithInter(
                              text: "Comments",
                              color1: consts,
                              controller: comment,
                              hintText: "Enter Comments"),
                          Con_Wid.height(5),
                          CondropDown(
                            color1: consts,
                            title: 'Reproduction Problem',
                            itemList: Con_List.M_reproductveProblem.isEmpty ? menual.map((e) => e['Name'].toString()).toList():Con_List.M_reproductveProblem.map((e) => e.name).toList(),
                            SelectedList: reproproblem,
                            onSelected: (List<String> value) {
                              setState(() {
                                reproproblem = value;
                                reproductiveproblem.text =
                                    reproproblem[0].toString();
                              });
                            },
                          ),
                          Con_Wid.height(5),
                          CondropDown(
                            color1: consts,
                            title: 'Problem History',
                            itemList: reproHistory,
                            SelectedList: [],
                            onSelected: (List<String> value) {
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    Con_Wid.height(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyCustomWidget(
                            Onchanged: () async {
                              if (calfid == null) {
                                calfid.text = "";
                              }
                              if (AppUrl.CheckNewUrl.value == false) {
                                if ((calf_sex_id == '2' || calf_sex_id1 == '2') &&
                                    (Firstimage == "" || Secondimage == "") &&
                                    calfid.text.isEmpty) {
                                  return showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                      builder: (context, setState1) {
                                        return AlertDialog(
                                          actions: [
                                             Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Constants_Usermast.user_name.contains("dsd")?const Text(
                                                """મહાશય, માફ કરશો ! બચ્ચાનો કડી નંબર લખો અને કડી સાથેનો બચ્ચાનો ફોટો લઈને અપલોડ કરો જેથી માહિતી સેવ થશે અને તમને સાદા બીજદાનના વિયાણ માટે રૂ પ૦/– અને સેકસ્ડ સીમેનના વિયાણ માટે રૂ ૧૦૦/– નું ઇન્સેન્ટીવ મળશે. જો આપને ઈન્સુન્ટીન ન લેવુ હોયતો સ્કીપ બટન દબાવો.""",
                                                style:  TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400),
                                              ):const Text( """Sir, I'm sorry! Write the link number of the cub and upload the photo of the cub with the link so that the information will be saved and you will get an incentive of Rs.50/- on normal inseminations and incentive of Rs.100/- on sorted of insemination. If you don't want to take Insuntin, press the skip button.""",
                                        style:  TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                              )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Con_Wid.selectionContainer(
                                                  height: 33,
                                                  width: 97,
                                                  text: "Skip",
                                                  context: context,
                                                  ontap: () {
                                                    Navigator.pop(context);
                                                    CallSave();
                                                  },
                                                  Color: ConClrLightBack,
                                                ),
                                                Con_Wid.selectionContainer(
                                                  height: 33,
                                                  width: 97,
                                                  text: "Yes",
                                                  context: context,
                                                  ontap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  Color: ConClrLightBack,
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  CallSave();
                                }
                              } else {
                                CallSave();
                              }
                            },
                            Title: "save",
                            color: consts,
                            stateTextWithIcon: stateTextWithIcon),
                      ],
                    ),
                    Con_Wid.height(10),
                  ])),
            ],
          )),
        ),
      ),
    );
  }

  CallSave() async {
    if (calfid.text.isNotEmpty) {
      if (await validateTagId(calfid.text)) {
        FocusScope.of(context).requestFocus(FocusNode());
      } else {
        Con_Wid.Con_Show_Toast(context, "Enter Valid TagID");
        return;
      }
    }
    FocusScope.of(context).requestFocus(FocusNode());
    var date;
    if (mStrFromdate == null) {
      date = DateTime.now();
      var formatter = DateFormat('dd-MM-yyyy');
      mStrFromdate = formatter.format(date);
    }

    //checking for same date or not
    DateTime today_date = DateTime.now();

    var days = DateTime.parse(change_date_format(today_date.toString()))
        .difference(DateTime.parse(change_date_format(
            Mdetail!.heatDate.toString() == "N/A"
                ? today_date.toString()
                : Mdetail!.heatDate.toString())))
        .inDays;
    days = 200;
    if (days < 180) {
      Con_Wid.Con_Show_Toast(
          context, "Calving should not less than 180 days from heat date");
    } else if (ticketnumber.text.isEmpty) {
      Con_Wid.Con_Show_Toast(context, "Enter Ticket Number");
    } else {
      for (int i = 0; i < reproHistory.length; i++) {
        List<rep_problem_val_model> testClients = [
          rep_problem_val_model(
              TagId: widget.index!,
              Date: mStrFromdate,
              Comments: reproHistory[i].toString(),
              details: null,
              reproductiveProblem: 0,
              reproduction: null,
              id: null,
              createdAt: DateTime.now().toString(),
              updatedAt: null,
              lastUpdatedByUser: null,
              createdByUser: null)
        ];
        rep_problem_val_model rnd =
            testClients[math.Random().nextInt(testClients.length)];
        rnd.Comments = "Calving";
        //todo pending insert table
        // SyncDB.insert_table(rnd as List, Constants.Tbl_Breeding_reproductiveProblemHistory);
      }
      if (('${Mdetail!.breedingStatus}' != 'Pregnant')) {
        try {
          var box = await Hive.openBox<Breeding_reproduction_id>(
              "Breeding_reproduction_id");
          final myobject = box.get(Mdetail!.id.toString());
          if (myobject != null) {
            myobject.comments = "PD";
            myobject.SyncStatus = '0';
            myobject.eNTRY = "U";
            myobject.dateOfDry = "";
            myobject.pd1 = "3";
            myobject.pDDate = actual_date2;
            myobject.pDTicketNumber = "101";
            myobject.remPD2 = "1";
            myobject.pd2 = "3" != null ? int.parse("3") : null;
            await box.put(widget.index, myobject);
          }
        } catch (e) {
          print("erore in update_Breeding_reproduction_id $e");
        }
      }
      try {
        var box = await Hive.openBox<Breeding_reproduction_id>(
            "Breeding_reproduction_id");
        final myobject = box.get(Mdetail!.id.toString());

        if (myobject != null) {
          myobject.SyncStatus = '1';
          myobject.eNTRY = "1";
          myobject.dateOfDry = "";
          myobject.dateOfCalving = mStrFromdate.toString();
          myobject.calvingTicketNumber = ticketnumber.text;
          myobject.calfSex = calf_sex_id.toString();
          myobject.colostrum = colostrum.text.toString();
          myobject.reproductionProblemNote = reproductiveproblem.text;
          myobject.inseminatorStaff = Constants_Usermast.staff.toString();
          myobject.comments = comment.text;
          await box.put(widget.index, myobject);
        }
      } catch (e) {
        print("erore in update_Breeding_reproduction_id $e");
      }
      List<Breeding_Calving> Detail_dryoff = [
        Breeding_Calving(
          visit: widget.vistid??"0",
            id: Constants.Last_id_Calving + 1,
            updatedAt: "",
            lastUpdatedByUser: int.parse(Constants_Usermast.user_id.toString()),
            createdByUser: int.parse(Constants_Usermast.user_id.toString()),
            createdAt: DateTime.now().toString(),
            details: "",
            ENTRY: "1",
            farmer: Mdetail!.farmer,
            herd: Mdetail!.herd,
            Lat: lat == "" ? "0.0" : lat,
            Long: long == "" ? "0.0" : long,
            lot: Mdetail!.lot,
            OrderNumber: 0,
            OTP: 0,
            TagId: widget.index.toString(),
            staff: int.parse(Constants_Usermast.staff),
            Calf2ID: twin ? calfid2.text : "",
            Calf2Sex: twin ? int.parse(calf_sex_id1) : 0,
            CalfID: calfid.text,
            CalfSex:   int.parse(calf_sex_id),
            CalvingDate: mStrFromdate,
            CalvingTicketNumber: int.parse(ticketnumber.text),
            CalvingType: int.parse(c_type),
            calvingTypeOption: int.parse(c_type),
            Comments: comment.text,
            image1: Firstimage.toString(),
            image2: twin ? Secondimage.toString() : "",
            ReproductionProblemNote: reproductiveproblem.text,
            Sex: Mdetail!.sexFlg,
            SyncStatus: "0",
            ServerId: ""),
      ];
      log(Detail_dryoff.toString());
      Breeding_Calving rnd =
          Detail_dryoff[math.Random().nextInt(Detail_dryoff.length)];
      List<Map> weights_sync_datas = [];
      weights_sync_datas.add(rnd.toJson(rnd));
      SyncDB.insert_table(weights_sync_datas, Constants.Tbl_Breeding_Calving);
      if (twin == false) {
        Map twin1 = {
          "damid": widget.index.toString(),
          "tagId": calfid.text.toString(),
          "sireid": "0",
          "sex": calf_sex_id.toString(),
          "calvingDate": mStrFromdate.toString(),
          "image": ""
        };
        final twinresponse = await ApiCalling.createPost(
            AppUrl().saveClavigDetailsimage,
            "Bearer " + Constants_Usermast.token.toString(),
            twin1);
      }

      if (twin) {
        Map twin2 = {
          "damid": widget.index.toString(),
          "tagId": calfid2.text.toString(),
          "sireid": "1",
          "sex": calf_sex_id1.toString(),
          "calvingDate": mStrFromdate.toString(),
          "image": ""
        };
        final twinresponse_2 = await ApiCalling.createPost(
            AppUrl().saveClavigDetailsimage,
            "Bearer " + Constants_Usermast.token.toString(),
            twin2);
      }
      if (widget.vistid != null) {
        SyncDB.Visit_Complete(
            widget.vistid!.toString(), widget.index!.toString());
      }

      switch (stateTextWithIcon) {
        case ButtonState.idle:
          stateTextWithIcon = ButtonState.loading;
          Future.delayed(
            Duration(seconds: 3),
            () {
              setState(() {
                stateTextWithIcon = ButtonState.success;
                if (stateTextWithIcon == ButtonState.success) {
                  Future.delayed(Duration(seconds: 1), () {
                    done = true;
                    back();
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
  }

  change_date_format(String date) {
    //var now = new DateTime.now();
    if (date != "null" && date != "N/A" && date != "") {
      var formatter = DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(DateTime.parse(date));
      return formatted;
    } else {
      return "N/A";
    }
  }

  back() {
    if (done == true) {
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
    }
  }

  Future<bool> validateTagId(String text) async {
    if (Constants_Usermast.QRCode == "false") {
      return true;
    }
    if (text.length == 12 && text != "000000000000") {
      String tag = text;

      int sum = 0;

      for (int i = 0; i < tag.length; i++) {
        int multipliedValue = (tag.length - i - 1) * int.tryParse(tag[i])!;
        if (multipliedValue >= 0) sum += multipliedValue;
      }

      double value = (sum / 9).toDouble();

      int y = int.tryParse(value.toString().split('.')[1][0])!;

      if (y == int.tryParse(tag[11])!) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
