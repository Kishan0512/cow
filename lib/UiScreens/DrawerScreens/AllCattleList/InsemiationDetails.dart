import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/Alarm/Alarm.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/CattleStatusTimeline.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Icons.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Textstyle.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/component/Gobal_Widgets/DatePicker.dart';
import 'package:herdmannew/model/Animal_Details_id.dart';
import 'package:herdmannew/model/Visit_Registration.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../Model_local/Breeding_insemination.dart';
import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Api.dart';
import '../../../component/DataBaseHelper/Sync_Database.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/ButtonState.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../../component/Gobal_Widgets/MyCustomWidget.dart';
import '../../../model/Breeding_reproduction_id.dart';
import '../../../model/Master_sire.dart';
import '../../Dashboard/Api_Done_Dialog.dart';
import '../Action/Action.dart';
import '../VisitRegistration/VisitRegistration.dart';

class Insemiationdetails extends StatefulWidget {
  String? path;
  String? index;
  String? VisitID;
  String? date;

  Insemiationdetails({this.path, this.index, this.VisitID, this.date});

  @override
  State<Insemiationdetails> createState() => _InsemiationdetailsState();
}

class _InsemiationdetailsState extends State<Insemiationdetails> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final ImagePicker picker = ImagePicker();
  Color Textcolor = Colors.indigo.shade400;
  Color buttencolor = Color(0xFF8C8CEA);
  ButtonState stateTextWithIcon = ButtonState.idle;
  Color buttencolor1 = Color(0xB38C8CEA);
  Color buttencolor2 = Color(0xB3B2B2E8);
  Color datecolor = Colors.black;
  String TapToExpandIt = "Breeding details";
  bool isExpanded = true;
  String Dateheat = "";
  int sirecode= 0;
  bool sSemon = false;
  TextEditingController visitnumber = TextEditingController(),
      noofdose = TextEditingController(),
      batchnumber = TextEditingController();
  String mStrFromdate = DateTime.now().toString();
  bool botton1 = true;
  bool botton2 = false;
  bool botton3 = false;
  List<String> inseminator = [],
      mInseminator = [],
      inseminatortype = [],
      mInseminatortype = [],
      sire = [],
      sire1 = [],
      sirenormal = [],
      mSire = [];
  List CheckList = [], CheckList1 = [];
  bool image = false;
  String Firstimage = "";
  List<int> ImageBytecode = [];
  String ExHeatDate = "";
  String ExPDDate = "";
  Animal_Details_id? Mdetail;
  late Duration difference;
  String lat = '', long = '', base64Image = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.VisitID.toString() == "null") {
      visitnumber.text = "100";
    } else {
      visitnumber.text = widget.VisitID.toString();
    }

    mInseminatortype = ["A.I"];
    noofdose.text = "1";
    batchnumber.text = "None";
    getdata();
    getList();
    getlastid();
    continuousFunction();
    setState(() {});
  }

  Future getlastid([String? HeatDate]) async {
    var box =
    await Hive.openBox<Breeding_insemination>("Breeding_insemination");
    try {
      Constants.Last_id_AI = int.parse(box.keys.last.toString());
    } catch (e) {
      print(e);
      Constants.Last_id_AI = 0;
    }
    var box1 = await Hive.openBox<Breeding_reproduction_id>(
        "Breeding_reproduction_id");
    try {
      Constants.Last_id_Br_reprod = int.parse(box1.keys.last.toString());
    } catch (e) {
      Constants.Last_id_Br_reprod = 0;
    }
    CheckList1 = box1.values
        .toList()
        .where((el) => el.tagId.toString() == Mdetail!.tagId.toString())
        .map((e) =>
    (e.heatDate.toString().isNotEmpty
        ? e.heatDate.substring(0, 10)
        : "") ==
        mStrFromdate.toString().substring(0, 10) ||
        (e.pDDate.toString().isNotEmpty ? e.pDDate.substring(0, 10) : "") ==
            mStrFromdate.toString().substring(0, 10))
        .toList();
    CheckList = List.filled(CheckList1.length, false);
  }

  getdata() {
    if (Con_List.M_inseminator.isEmpty ||
        Con_List.M_Service.isEmpty ||
        Con_List.M_sire.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_staff);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_service);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_sire);
    }
    setState(() {});
  }

  getList() async {
    Mdetail = Con_List.id_Animal_Details
        .firstWhere((element) => element.tagId == widget.index.toString());

    Con_List.M_inseminator.forEach((element) {
      inseminator.add(element.name);
    });
    Con_List.M_Service.forEach((element) {
      inseminatortype.add(element.name);
    });
    Con_List.M_sire.forEach((element) {
      if((element.birthWeight.toString().contains("-") || element.birthWeight.toString()=="0") && (element.minStrawStock.toString().contains("-") || element.minStrawStock.toString()=="0")) {
      }else{
        Con_List.M_breed.forEach((e) {
          if (e.species.toString() == Mdetail!.species.toString()) {
            String mStrbreed = e.id.toString();
            if (element.breed.toString() == mStrbreed) {
              if (!sire.contains(element.name.toString()) &&
                  element.minStrawStock.toString() != "0" && element.naturalOrAIBirth.toString() == "1") {
                sire.add(element.name.toString());
              }
              if (!sire1.contains(element.name.toString()) &&
                  element.birthWeight.toString() != "0") {
                sire1.add(element.name.toString());
              }
              if (!sirenormal.contains(element.name.toString()) &&
                  element.minStrawStock.toString() != "0" && element.naturalOrAIBirth.toString() == "0") {
                sirenormal.add(element.name.toString());
              }
            }
          }
        });
      }
    });
    if (Con_List.M_inseminator.where(
            (e) => e.id.toString() == Constants_Usermast.staff.toString())
        .isNotEmpty) {
      mInseminator.add(Con_List.M_inseminator.where(
              (e) => e.id.toString() == Constants_Usermast.staff.toString())
          .first
          .name
          .toString());
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    lat = position.latitude.toString();
    long = position.longitude.toString();

    // mInseminator.add(Con_List.M_inseminator.where((e) => e.id.toString()==Constants_Usermast.staff.toString()).first.name.toString());
    setState(() {});
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    continuousFunction();
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
          elevation: 3,
          backgroundColor: Color(0xFFC9C9F7),
          title: Con_Wid.gText(
            "Insemination Details",
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
                    padding:
                    const EdgeInsets.only(right: 10, left: 10, top: 5.0),
                    height: isExpanded ? 70 : 188,
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(milliseconds: 1200),
                    decoration: BoxDecoration(
                      color: Color(0xFFC9C9F7),
                    ),
                    child: ListView(children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Con_Wid.width(10),
                              Text(
                                "Animal.ID : ${Mdetail!.tagId}",
                                style: TextStyle(
                                  color: fontBlackColor,
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
                                            fontBlackColor),
                                      ),
                                      Text("${Mdetail!.farmername}",
                                          style: ConStyle.Style_white_12_700w(
                                              fontBlackColor)),
                                      const Expanded(child: SizedBox()),
                                      Text(
                                        "Farmer Code : ",
                                        style: ConStyle.Style_white_12_700w(
                                            fontBlackColor),
                                      ),
                                      Text("${Mdetail!.farmer}",
                                          style: ConStyle.Style_white_12_700w(
                                              fontBlackColor)),
                                    ]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Society Code :",
                                      style: ConStyle.Style_white_12_700w(
                                          fontBlackColor),
                                    ),
                                    Text("${Mdetail!.lot}",
                                        style: ConStyle.Style_white_12_700w(
                                            fontBlackColor)),
                                    const Expanded(child: SizedBox()),
                                    Text(
                                      "Society Name :",
                                      style: ConStyle.Style_white_12_700w(
                                          fontBlackColor),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: 20,
                                      width: 50,
                                      child: Text("${Mdetail!.lotname}",
                                          style: ConStyle.Style_white_12_700w(
                                              fontBlackColor)),
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
                                color: Color(0xFF8C8CEA),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Farmer Name : ",
                                      style: ConStyle.Style_white_12_700w(
                                          fontBlackColor),
                                    ),
                                    Text("${Mdetail!.farmername}",
                                        style: ConStyle.Style_white_12_700w(
                                            fontBlackColor)),
                                    const Expanded(child: SizedBox()),
                                    Text(
                                      "Farmer Code : ",
                                      style: ConStyle.Style_white_12_700w(
                                          fontBlackColor),
                                    ),
                                    Text("${Mdetail!.farmer}",
                                        style: ConStyle.Style_white_12_700w(
                                            fontBlackColor)),
                                  ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Society Code :",
                                    style: ConStyle.Style_white_12_700w(
                                        fontBlackColor),
                                  ),
                                  Text("${Mdetail!.lot}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontBlackColor)),
                                  const Expanded(child: SizedBox()),
                                  Text(
                                    "Society Name :",
                                    style: ConStyle.Style_white_12_700w(
                                        fontBlackColor),
                                  ),
                                  Text("${Mdetail!.lotname}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontBlackColor))
                                ],
                              ),
                              Con_Wid.height(5),
                              const Divider(
                                height: 2,
                                thickness: 1,
                                color: Color(0xFF8C8CEA),
                              ),
                              ListTile(
                                leading: CircleAvatar(
                                  foregroundImage: AssetImage(
                                      "assets/images/${Mdetail!.speciesname.toString().toLowerCase()}${Mdetail!.statusname.toString().toLowerCase() == "null" ? "" : '-' + Mdetail!.statusname.toString().toLowerCase()}.webp"),
                                ),
                                title: Row(
                                  children: [
                                    Text(
                                      "${Mdetail!.calvingDate == null || Mdetail!.calvingDate == "" ? "Birth Date " : "Calving Date :"}   Repeat Heat ",
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.black),
                                    ),
                                    Text(
                                      "    ${Mdetail!.statusname}",
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.orange),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  " ${Mdetail!.calvingDate == null || Mdetail!.calvingDate == "" ? Mdetail!.dOB.toString().substring(0, 10) : Mdetail!.calvingDate.toString()}              0",
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.black),
                                ),
                              ),
                              const Divider(
                                height: 2,
                                thickness: 1,
                                color: Color(0xFF8C8CEA),
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
                              Mdetail!.breedingStatus == "Open Bred"
                                  ? Row(
                                children: [
                                  Con_Wid.width(5),
                                  const Text(
                                    "Expected PD Date",
                                    style: TextStyle(
                                        color: fontBlackColor,
                                        fontSize: 12),
                                  ),
                                  const Spacer(),
                                  Text(
                                    ExPDDate == ""
                                        ? ""
                                        : "${ExPDDate.substring(0, 10)}",
                                    style: TextStyle(
                                        color: fontBlackColor,
                                        fontSize: 12),
                                  )
                                ],
                              )
                                  : Container(),
                              const Divider(
                                height: 2,
                                thickness: 1,
                                color: Color(0xFF8C8CEA),
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
                Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Column(children: [
                      Con_Wid.height(8),
                      Date_Picker(
                        onDateChange: (value) {
                          setState(() {
                            mStrFromdate = value.toString();
                          });
                        },
                        selectionColor: buttencolor,
                        selectedTextColor: Colors.white,
                        onPressed: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: widget.date == "" ||
                                  widget.date == null ||
                                  widget.date == "null"
                                  ? Mdetail!.calvingDate == null ||
                                  Mdetail!.calvingDate == ""
                                  ? DateTime.parse(
                                  Mdetail!.dOB.toString())
                                  : DateTime.parse(Mdetail!.calvingDate)
                                  : DateTime.parse(widget.date.toString())
                                  .add(Duration(days: 1)),
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
                        buttencolor: buttencolor,
                      ),
                      Con_Wid.height(10),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Con_Wid.paddingWithText("Inseminator", Textcolor),

                            CondropDown(
                              color1: Textcolor,
                              title: 'Select Inseminator',
                              itemList: inseminator,
                              SelectedList: mInseminator,
                              onSelected: (List<String> value) {
                                setState(() {
                                  mInseminator.contains(value);
                                  mInseminator = value;
                                });
                              },
                            ),
                            Con_Wid.height(5),
                            Con_Wid.textFieldWithInter(
                                color1: Textcolor,
                                text: "Visit Number",
                                controller: visitnumber,
                                hintText: "Enter Visit Number"),
                            // Con_Wid.paddingWithText(
                            //     "Select Inseminator Type", Textcolor),

                            CondropDown(
                              color1: Textcolor,
                              title: 'Select Type',
                              itemList: inseminatortype,
                              SelectedList: mInseminatortype,
                              onSelected: (List<String> value) {
                                setState(() {
                                  mInseminatortype.contains(value);
                                  mInseminatortype = value;
                                  sirecode =  Con_List.M_Service.where(
                                          (e) => e.name == mInseminatortype[0])
                                      .first
                                      .id;
                                  print(sirecode);
                                });
                              },
                            ),
                            (sirecode == 3 || sirecode ==2)? Container(): Row(children: [
                              Con_Wid.paddingWithText("sorted semon", Textcolor,
                                  context: context),
                              Checkbox(
                                value: sSemon,
                                onChanged: (value) {
                                  sSemon = value!;
                                  setState(() {});
                                },
                              ),
                            ]),
                            (sirecode == 3 || sirecode ==2)? Container(): image == false
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 18.0),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Con_Wid.selectionContainer(
                                      width: 100,
                                      height: 35,
                                      text: "Add Image",
                                      context: context,
                                      textcolor: Colors.white,
                                      ontap: () async {
                                        final XFile? photo =
                                        await picker.pickImage(imageQuality: 10,
                                          source: ImageSource.camera,
                                        );

                                        Firstimage = photo!.path;
                                        ImageBytecode =
                                        await photo.readAsBytes();
                                        base64Image =
                                            base64Encode(ImageBytecode);
                                        setState(() {
                                          image = true;
                                        });
                                      },
                                      Color: buttencolor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Container(
                                  height: 300,
                                  width:
                                  MediaQuery.of(context).size.width -
                                      150,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: FileImage(
                                              File("${Firstimage}")))),
                                  child: Baseline(
                                    baseline: 25,
                                    baselineType: TextBaseline.alphabetic,
                                    child: Container(
                                        height: 30,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width -
                                            150,
                                        child: Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 32,
                                              child: IconButton(
                                                splashRadius: 18,
                                                onPressed: () {
                                                  setState(() {
                                                    image = false;
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
                            ),
                            //Con_Wid.paddingWithText("Sire", Textcolor),

                            Con_Wid.height(5),
                            (sirecode == 3)? Container(): CondropDown(
                              color1: Textcolor,
                              title: 'Select Sire',
                              itemList: sirecode == 2? sirenormal : sSemon ? sire1:sire,
                              SelectedList: mSire,
                              onSelected: (List<String> value) {
                                setState(() {
                                  mSire = value;
                                });
                              },
                            ),
                            Con_Wid.height(5),
                            (sirecode == 3 || sirecode ==2)? Container():  Con_Wid.textFieldWithInter(
                                Onchanged: (p0) {

                                  setState(() {
                                    if(int.parse(p0.toString())<=2 && int.parse(p0.toString())!=0)
                                    {}
                                    else{
                                      Con_Wid.Con_Show_Toast(context,
                                          'Maximum dose allowed is 2');
                                      noofdose.clear();
                                    }
                                  });
                                },
                                color1: Textcolor,
                                text: "No of Dose",
                                controller: noofdose,
                                hintText: "Enter No of Dose"),
                            Con_Wid.height(5),
                            (sirecode == 3 || sirecode ==2)? Container(): Con_Wid.textFieldWithInter(
                                color1: Textcolor,
                                text: "Batch Number",
                                controller: batchnumber,
                                hintText: "Enter Batch Number"),
                            Con_Wid.height(5),
                            Con_Wid.height(5),
                          ],
                        ),
                      ),
                      Con_Wid.height(5),
                      MyCustomWidget(
                          stateTextWithIcon: stateTextWithIcon,
                          Onchanged: () async {
                            var days;
                            days = 5;
                            if (sirecode == 3) {
                                getapicall();
                              }
                             else if(sirecode == 2)
                               {
                                 if (mSire.isEmpty) {
                                   Con_Wid.Con_Show_Toast(
                                       context, 'Select Sire');
                                 }else{
                                   getapicall();
                                 }
                               }
                               else {
                              if (mSire.isEmpty) {
                                Con_Wid.Con_Show_Toast(
                                    context, 'Select Sire');
                              }else if (noofdose.text == "") {
                                Con_Wid.Con_Show_Toast(
                                    context, 'Enter No of dose');
                              } else if (mInseminator.isEmpty)
                                {
                                  Con_Wid.Con_Show_Toast(
                                      context, 'Select Insinuator');
                                }else if(batchnumber.text =="")
                                  {
                                    Con_Wid.Con_Show_Toast(
                                        context, 'Enter Batch no');
                                  } else if (sSemon) {
                                if (Firstimage == "") {
                                  Con_Wid.Con_Show_Toast(
                                      context, 'Please select image');
                                  return;
                                }
                                //show_dialog();
                              }else if (listEquals(mInseminatortype, [])){
                                Con_Wid.Con_Show_Toast(
                                    context, 'Select Insemination Type');
                              }else{
                                getapicall();
                              }
                            }


                          },
                          Title: "Save",
                          color: buttencolor),
                      Con_Wid.height(10),
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
getapicall(){

  String dateString1 = Mdetail!.calvingDate == null ||
      Mdetail!.calvingDate == ""
      ? Mdetail!.dOB
      : Mdetail!.calvingDate;

  // DateTime inputDateTime =
  //     DateFormat('dd/MM/yyyy HH:mm')
  //         .parse(mStrFromdate);
  String formattedDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.parse(mStrFromdate));
  Dateheat = formattedDate;
  DateTime dateTime1 = DateTime.parse(dateString1);
  DateTime dateTime2 = DateTime.parse(formattedDate);
  difference = dateTime2.difference(dateTime1);
  List<Breeding_insemination> Detail_insemination = [
    Breeding_insemination(
      id: Constants.Last_id_AI + 1,
      TagId: "${Mdetail!.tagId}",
      HeatDate: "$mStrFromdate",
      InseminationTicketNumber:
      int.parse(visitnumber.text.toString()),
      AIT: Con_List.M_inseminator.where(
              (e) => e.name == mInseminator[0])
          .first
          .id
          .toString(),
      ENTRY: 2,
      sire: mSire.isEmpty ? 0 :int.parse(Con_List.M_sire.where(
              (e) => e.name == mSire[0])
          .first
          .id
          .toString()),
      service: Con_List.M_Service.where(
              (e) => e.name == mInseminatortype[0])
          .first
          .id
          .toString(),
      createdAt: DateTime.now().toString(),
      StrawImage: base64Image,
      BatchNo: (sirecode == 3 || sirecode == 2)? "": batchnumber.text,
      createdByUser: int.parse(
          Constants_Usermast.user_id.toString()),
      herd: int.parse(Mdetail!.herd.toString()),
      lot: int.parse(Mdetail!.lot.toString()),
      farmer: int.parse(Mdetail!.farmer.toString()),
      SortedSemon: sSemon == true ? 1 : 0,
      AICost: 0,
      TotalAIDose: int.parse(noofdose.text),
      Lat: lat == "" ? "0.0" : lat,
      Long: long == "" ? "0.0" : long,
      SyncStatus: "0",
      ServerId: "", Visit: visitnumber.text,
    )
  ];
  log(Detail_insemination.map((e) => Breeding_insemination.toJson1(e)).toList().toString());
  List<Breeding_reproduction_id> Inseminat = [
    Breeding_reproduction_id(
        TableNAme: "",
        ServerId: "",
        aICost: null,
        createdAt: DateTime.now().toString(),
        createdByUser:
        int.parse(Constants_Usermast.user_id),
        hI: null,
        lastUpdatedByUser: "0",
        updatedAt: "0",
        zone: Mdetail!.zone,
        tagId: "${Mdetail!.tagId}",
        parity: int.parse(Mdetail!.currentParity.toString()=="null"?"0":Mdetail!.currentParity.toString()),
        heatSeq: 0,
        heatDate: "$mStrFromdate",
        remPD1: null,
        remPD2: null,
        pDDate: null,
        dateOfCalving: null,
        dateOfDry: null,
        dryTreatment: "fdfgdgdg",
        flag: null,
        retantionOfPlecenta: null,
        comments: "321321",
        reproductionProblemNote: "3216516",
        mobileOrDesktopEntryFlg: null,
        totalAIDose: int.parse(noofdose.text),
        abortionSeq: null,
        vaccine: null,
        colostrum: null,
        inseminationTicketNumber: visitnumber.text,
        pDTicketNumber: null,
        calvingTicketNumber: "12344",
        orderNumber: null,
        oTP: null,
        eNTRY: "U",
        lat: lat == "" ? "0.0" : lat,
        long: long == "" ? "0.0" : long,
        details: "02",
        inseminatorStaff: int.parse(
            Con_List.M_inseminator.where(
                    (e) => e.name == mInseminator[0])
                .first
                .id
                .toString()),
        sire:mSire.isEmpty? 0: int.parse(Con_List.M_sire.where(
                (e) => e.name == mSire[0])
            .first
            .id
            .toString()),
        pdBy: null,
        pd1: null,
        pd2: "1",
        sex: "1",
        calfSex: Mdetail!.sexFlg,
        calvingType: null,
        calvingTypeOption: null,
        dryReason: null,
        id: Constants.Last_id_Br_reprod + 1,
        SyncStatus: "1",
        CI: null,
        Sirename: mSire.isEmpty? "Unknown":mSire[0],
        insertflag: null,
        AIDays:
        int.parse(difference.inDays.toString()),
        CalvingPDDays: null,
        AITname: mInseminator[0].toString(),
        PDname: null,
        PDResult: null,
        PDdays: null,
        Pregdays: null,
        service: null)
  ];
  getlastid(mStrFromdate).then((value) async {
    bool Comparistion = listEquals(CheckList1, CheckList);

    if (Comparistion) {
      Breeding_insemination rnd = Detail_insemination[
      math.Random()
          .nextInt(Detail_insemination.length)];
      List<Map> weights_sync_datas = [];
      weights_sync_datas.add(rnd.toJson(rnd));
      SyncDB.insert_table(weights_sync_datas,
          Constants.Tbl_Br_insemination);
      Breeding_reproduction_id reporoduc = Inseminat[
      math.Random().nextInt(Inseminat.length)];
      List<Map> weights_sync_reprodu = [];
      weights_sync_reprodu
          .add(reporoduc.toJson(reporoduc));
      SyncDB.insert_table(weights_sync_reprodu,
          Constants.Breeding_reproduction_id);
      var box = await Hive.openBox<Master_sire>(
          "Master_sire");
      if (sSemon == true) {
        final boxdata = box.get(Con_List.M_sire.where(
                (e) => e.name == mSire[0])
            .first
            .id
            .toString());

        boxdata!.birthWeight = int.parse(
            boxdata.birthWeight.toString()) -
            int.parse(noofdose.text);
        boxdata.Syncstatus = "0";
        boxdata.Selected = "1";
        await box.put(
            Con_List.M_sire.where(
                    (e) => e.name == mSire[0])
                .first
                .id
                .toString(),
            boxdata);
      } else {
        final boxdata = box.get(Con_List.M_sire.where(
                (e) => e.name == (mSire.isEmpty ? "Unknown" : mSire[0]))
            .first
            .id
            .toString());

        boxdata!.minStrawStock = int.parse(
            boxdata.minStrawStock.toString()) -
            int.parse(noofdose.text);
        boxdata.Syncstatus = "0";
        boxdata.Selected = "0";
        await box.put(
            Con_List.M_sire.where(
                    (e) => e.name == (mSire.isEmpty ? "Unknown" : mSire[0]))
                .first
                .id
                .toString(),
            boxdata);
      }
      await SyncDB.SyncTable("sireStock", true);
      switch (stateTextWithIcon) {
        case ButtonState.idle:
          final connectivityResult =
          await (Connectivity()
              .checkConnectivity());
          if (connectivityResult ==
              ConnectivityResult.mobile ||
              connectivityResult ==
                  ConnectivityResult.wifi) {
            stateTextWithIcon = ButtonState.loading;
            Future.delayed(
              Duration(seconds: 10),
                  () {
                setState(() {
                  stateTextWithIcon =
                      ButtonState.success;
                  if (stateTextWithIcon ==
                      ButtonState.success) {
                    Future.delayed(
                        Duration(seconds: 1), () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(
                        builder: (context) {
                          return Api_Dailog(
                              Sync_Api
                                  .MstrResponsecode,
                              Sync_Api.MstrResponse,
                              widget.index!
                                  .toString(),
                              Mdetail!.farmerCode,
                              Mdetail!.farmername,
                              Mdetail!.lotcode,
                              Mdetail!.lotname,
                              "Insemination",
                              widget.path!,
                              widget.VisitID);
                        },
                      ));

                      setState(() {});
                    });
                  }
                });
              },
            );
          } else {
            setState(() {
              if(widget.VisitID != "") {
                SyncDB.Visit_Complete(widget.VisitID!,widget.index!);
              }
              stateTextWithIcon = ButtonState.success;

              Con_Wid.Nointernet(
                  id: widget.index.toString(),
                  context: context);
            });
          }

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
    } else {
      Con_Wid.Con_Show_Toast(
          context, "You Can't Save Same Day AI");
      Navigator.pop(context);
    }
  });
}
  void updateHiveValue(String key, dynamic newValue) async {
    final box = await Hive.openBox<Visit_Registration>("VISITREGISTRATION");
    final oldValue = box.get('${widget.VisitID.toString()}');
    if (oldValue != null) {
      //final updatedValue = {...oldValue, 'updatedField': newValue};
      // await box.put(key, updatedValue);
    }
    await box.close();
  }

  void continuousFunction() {
    Timer.periodic(Duration(microseconds: 500), (timer) {
      Sync_Api.MstrResponse;
      Sync_Api.MstrResponsecode;
      setState(() {});
    });
  }
}
