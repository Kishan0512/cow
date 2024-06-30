import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/component/Gobal_Widgets/MyCustomWidget.dart';
import 'package:hive/hive.dart';

import '../../../Model_local/Breeding_Abortion.dart';
import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Database.dart';
import '../../../component/Gobal_Widgets/ButtonState.dart';
import '../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../component/Gobal_Widgets/Con_Textstyle.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../../component/Gobal_Widgets/DatePicker.dart';
import '../../../model/Animal_Details_id.dart';
import '../../../model/Breeding_reproduction_id.dart';
import '../Action/Action.dart';
import '../Alarm/Alarm.dart';
import '../VisitRegistration/VisitRegistration.dart';
import 'CattleStatusTimeline.dart';

class Abortion_Details extends StatefulWidget {
  String? index;
  String? date;
  String? path;
  String? visit;

  Abortion_Details({this.path,this.index, this.date,this.visit});

  @override
  State<Abortion_Details> createState() => _Abortion_DetailsState();
}

class _Abortion_DetailsState extends State<Abortion_Details> {
  ButtonState stateTextWithIcon = ButtonState.idle;
  bool isExpanded = true;
  Animal_Details_id? mDetails;
  String lat = '', long = '';
  String mStrFromdate = DateTime.now().toString();
  List<String> mInseminator = [], inseminator = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mDetails = Con_List.id_Animal_Details
        .firstWhere((element) => element.tagId == widget.index.toString());
    getdata();
  }

  getdata() async {

    var box = await Hive.openBox<Breeding_Abortion>("Breeding_Abortion");
    try {
      Constants.Last_id_abor = int.parse(box.keys.last.toString());
    } catch (e) {
      print(e);
      Constants.Last_id_abor = 0;
    }

    var box1 = await Hive.openBox<Breeding_reproduction_id>(
        "Breeding_reproduction_id");
    try {
      Constants.Last_id_Br_reprod = int.parse(box1.keys.last.toString());
    } catch (e) {
      Constants.Last_id_Br_reprod = 0;
    }

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
      desiredAccuracy: LocationAccuracy.medium,
    );

    lat = position.latitude.toString();
    long = position.longitude.toString();


    setState(() {});
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
          title: "Abortion Details",
          Actions: [],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return cattlestatustimeline(index: widget.index!);
              },
            ));
          },
        ),
        body: Con_Wid.backgroundContainer(
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
                height: isExpanded ? 70 : 147,
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
                                    "Farmer Name",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor),
                                  ),
                                  Text("  ${mDetails!.farmername}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor)),
                                  const Expanded(child: SizedBox()),
                                  Text(
                                    "Farmer Code",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor),
                                  ),
                                  Text("  ${mDetails!.farmer}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor)),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Society Code",
                                  style: ConStyle.Style_white_12_700w(
                                      fontwhiteColor),
                                ),
                                Text("  ${mDetails!.lot}",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor)),
                                const Expanded(child: SizedBox()),
                                Text(
                                  "Society Name",
                                  style: ConStyle.Style_white_12_700w(
                                      fontwhiteColor),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 20,
                                  width: 50,
                                  child: Text("  ${mDetails!.lotname}",
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
                                Text("${mDetails!.farmername}",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor)),
                                const Expanded(child: SizedBox()),
                                Text(
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
                              Text(
                                "Society Code :",
                                style:
                                    ConStyle.Style_white_12_700w(fontwhiteColor),
                              ),
                              Text("${mDetails!.lot}",
                                  style: ConStyle.Style_white_12_700w(
                                      fontwhiteColor)),
                              const Expanded(child: SizedBox()),
                              Text(
                                "Society Name :",
                                style:
                                    ConStyle.Style_white_12_700w(fontwhiteColor),
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
                                  "${mDetails!.calvingDate == null ? "Birth Date " : "Calving Date :"}   Repeat Heat ",
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
                              " ${mDetails!.calvingDate == null ? mDetails!.dOB.toString().substring(0, 10) : mDetails!.calvingDate.toString().substring(0, 10)}              0",
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.white),
                            ),
                          ),
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
            Con_Wid.fullContainer(
                child: Column(
              children: [
                Date_Picker(
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: widget.date != ""
                                ? DateTime.parse(widget.date.toString())
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
                  selectionColor: con_clr.ConClr2 ? ConClrborderdrop : whiteColor,
                  selectedTextColor: con_clr.ConClr2 ? BlackColor : BlackColor,
                  onDateChange: (value) {
                    setState(() {
                      mStrFromdate = value.toString();
                    });
                  },
                  buttencolor: con_clr.ConClr2 ? ConClrborderdrop : ConClrDialog,
                ),
                Con_Wid.height(20),
                CondropDown(
                  title: 'Select Inseminator',
                  itemList: Con_List.M_inseminator.where((e) =>
                          e.id.toString() == Constants_Usermast.staff.toString())
                      .map((e) => e.name.toString())
                      .toList(),
                  SelectedList: mInseminator,
                  onSelected: (List<String> value) {
                    setState(() {
                      mInseminator.contains(value);
                      mInseminator = value;
                    });
                  },
                ),
                Con_Wid.height(100),
                MyCustomWidget(
                    Onchanged: () async {
                      int dateDiff = DateTime.parse(mStrFromdate)
                          .difference(DateTime.parse(widget.date.toString() != "" && widget.date.toString() != "null"
                              ? widget.date.toString()
                              : mDetails!.calvingDate == null
                                  ? mDetails!.dOB
                                  : mDetails!.calvingDate))
                          .inDays;

                      if (dateDiff > 0) {
                        String dateString1 = mDetails!.calvingDate == null ||
                                mDetails!.calvingDate == ""
                            ? mDetails!.dOB
                            : mDetails!.calvingDate;

                        DateTime dateTime1 = DateTime.parse(dateString1);
                        DateTime dateTime2 = DateTime.parse(mStrFromdate);
                        Duration difference = dateTime2.difference(dateTime1);

                        List<Breeding_Abortion> abor = [
                          Breeding_Abortion(
                              SyncStatus: "0",
                              ServerId: "",
                              id: Constants.Last_id_abor,
                              TagId: widget.index,
                              AbortionDate: mStrFromdate,
                              AbortionSeq: 1,
                              OrderNumber: 0,
                              OTP: null,
                              ENTRY: 1,
                              Lat: lat == "" ? "0.0" : lat,
                              Long: long == "" ? "0.0" : long,
                              details: "",
                              createdAt: DateTime.now().toString(),
                              updatedAt: DateTime.now().toString(),
                              lastUpdatedByUser: Constants_Usermast.id,
                              createdByUser: int.parse(Constants_Usermast.id),
                              herd: int.parse(mDetails!.herd.toString()),
                              lot: int.parse(mDetails!.lot.toString()),
                              farmer: int.parse(mDetails!.farmer.toString()), visit:widget.visit??"0",)
                        ];

                        List<Breeding_reproduction_id> Inseminat = [
                          Breeding_reproduction_id(
                            TableNAme: "",
                              ServerId: "",
                              aICost: null,
                              createdAt: DateTime.now(),
                              createdByUser:
                                  int.parse(Constants_Usermast.user_id),
                              hI: null,
                              lastUpdatedByUser: "0",
                              updatedAt: "0",
                              zone: mDetails!.zone,
                              tagId: "${mDetails!.tagId}",
                              parity: 0,
                              heatSeq: 0,
                              heatDate: null,
                              remPD1: null,
                              remPD2: null,
                              pDDate: "$mStrFromdate",
                              dateOfCalving: null,
                              dateOfDry: null,
                              dryTreatment: "fdfgdgdg",
                              flag: null,
                              retantionOfPlecenta: null,
                              comments: "321321",
                              reproductionProblemNote: "3216516",
                              mobileOrDesktopEntryFlg: null,
                              totalAIDose: 0,
                              abortionSeq: null,
                              vaccine: null,
                              colostrum: null,
                              inseminationTicketNumber: 0,
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
                              sire: null,
                              pdBy: null,
                              pd1: null,
                              pd2: 4,
                              sex: "1",
                              calfSex: mDetails!.sexFlg,
                              calvingType: null,
                              calvingTypeOption: null,
                              dryReason: null,
                              id: Constants.Last_id_Br_reprod + 1,
                              SyncStatus: "1",
                              CI: null,
                              Sirename: null,
                              insertflag: null,
                              AIDays: 0,
                              CalvingPDDays: null,
                              AITname: mInseminator[0],
                              PDname: null,
                              PDResult: null,
                              PDdays: int.parse(difference.inDays.toString()),
                              Pregdays: null,
                              service: null)
                        ];

                        Breeding_Abortion rnd =
                            abor[math.Random().nextInt(abor.length)];
                        List<Map> weights_sync_datas = [];
                        weights_sync_datas.add(rnd.toJson(rnd));
                        SyncDB.insert_table(
                            weights_sync_datas, Constants.Tbl_Br_Ab);

                        Breeding_reproduction_id reporoduc =
                            Inseminat[math.Random().nextInt(Inseminat.length)];
                        List<Map> weights_sync_reprodu = [];
                        weights_sync_reprodu.add(reporoduc.toJson(reporoduc));
                        SyncDB.insert_table(weights_sync_reprodu,
                            Constants.Breeding_reproduction_id);
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
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                        builder: (context) {
                                          return cattlestatustimeline(
                                              index: widget.index!);
                                        },
                                      ));
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
                      } else {
                        Con_Wid.Con_Show_Toast(
                            context, "Entry not available for this date");
                      }

                      setState(
                        () {
                          stateTextWithIcon = stateTextWithIcon;
                        },
                      );
                    },
                    Title: "Save",
                    color: ConClrDialog,
                    stateTextWithIcon: stateTextWithIcon)
              ],
            ))
          ],
        )),
      ),
    );
  }
}
