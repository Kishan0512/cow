// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'dart:math' as math;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herdmannew/UiScreens/Dashboard/Api_Done_Dialog.dart';
import 'package:herdmannew/UiScreens/Dashboard/Dashboard.dart';
import 'package:herdmannew/UiScreens/Dashboard/cattle_add.dart';
import 'package:herdmannew/component/DataBaseHelper/Sync_Api.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../component/DataBaseHelper/Con_List.dart';
import '../../component/DataBaseHelper/Sync_Database.dart';
import '../../component/DataBaseHelper/Sync_Json.dart';
import '../../component/Gobal_Widgets/Con_Color.dart';
import '../../component/Gobal_Widgets/Con_Icons.dart';
import '../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../component/Gobal_Widgets/Constants.dart';
import '../../model/Animal_Details_id.dart';
import '../../model/Animal_registration.dart';
import '../../model/Breeding_reproduction_id.dart';
import '../../model/Milk_production_id.dart';
import '../../model/Visit_Registration.dart';

class Bredding_details extends StatefulWidget {
  String? tag;
  String? pagename;
  String? visitid;
  String? route;
  String? socity;
  String? owner;
  String? species;
  String? breed;
  String? zone;
  String? name;
  String? age;
  String? select_cattle;
  String? sex_flag;
  String? dob;
  String? reg_date;
  String? route_name;
  String? socity_name;
  String? owner_name;
  String? species_name;
  String? breed_name;
  String? photo;
  String? age_view;
  String? managerStaff;
  String? extensionOfficerStaff;
  String? Farmercode;
  String? Lotcode;
  Visit_Registration? visitmodel;

  Bredding_details({
    this.visitmodel,
    this.tag,
    this.route,
    this.socity,
    this.owner,
    this.species,
    this.breed,
    this.zone,
    this.name,
    this.age,
    this.select_cattle,
    this.sex_flag,
    this.dob,
    this.reg_date,
    this.route_name,
    this.socity_name,
    this.owner_name,
    this.pagename,
    this.visitid,
    this.species_name,
    this.breed_name,
    this.photo,
    this.age_view,
    this.managerStaff,
    this.extensionOfficerStaff,
    this.Farmercode,
    this.Lotcode,
  });

  @override
  State<Bredding_details> createState() => _Bredding_detailsState();
}

class _Bredding_detailsState extends State<Bredding_details> {
  String mStrFromdate = DateFormat('yyyy-dd-MM').format(DateTime.now());
  TextEditingController NoofCalving = TextEditingController(),
      milkday = TextEditingController(),
      milkKG = TextEditingController(),
      enterday = TextEditingController(),
      noofdose = TextEditingController(),
      heatsequence = TextEditingController();
  List<String> worm = [];
  bool  milk1 =false;
  String mor = "",
      pass = "",
      pass1 = "",
      pass2 = "",
      pass3 = "",
      pass4 = "",
      pass5 = "",
      lac_total = "",
      Sire = "",
      lat = '',
      long = '',
      CAlF = "",
      Inseme = "",
      pd1 = "",
      pd2 = "",
      NAme = "",
      milk_heat_date = "",
      calving_or_dry_days = "",
      calving_or_dry_date = "",
      prag_heat_date = "",
      milk_parm_val = "",
      prag_milk_val = "",
      calf_sex_id = "",
      pragn_or_ai_days = "",
      dry_parm_val = "",
      calving_date = "",
      milk_sire = "",
      milk_insem = "",
      milking_calf_sex = "",
      pragn_or_ai_date = "",
      prag_sire = "",
      prag_insem = "",
      ai_sire_id = "",
      ai_insem_id = "",
      prag_sire_id = "",
      clavinfID = "1",
      prag_insem_id = "",
      parity = "",
      status = '10',
      milking_sire_id = "",
      milking_insem_id = "",
      pragnent_or_ai_diff = "",
      c_type = "",
      calving = "",
      Heat = "",
      RCalvingdate = "",
      pregnantday = "",
      RHeatdate = "",
      RPDdate = "",
      RDrydate = "",
      RCalvingdate1 = "",
      RHeatdate1 = "",
      RPDdate1 = "",
      RDrydate1 = "",
      milk_yield_type = "Today_milk";
  String FirstSelected = "None";
  String SecondSelected = "";
  String ThridSelected = "Normal";
  String FourSelected = "Avg Milk";
  String FiveSelected = "None";
  String SixSelected = "Pregnant Days";
  List<String> sire = ["Unknown"],
      sire1 = [],
      inseminator = [],
      inseminator1 = [],
      mSire = [],
      mSire1 = [],
      mInseminator1 = [],
      calfsex = [],
      mCalfsex = [],
      mInseminator = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    getlist();
    mSire = ["Unknown"];
    mInseminator = ["Unknown"];
    mCalfsex = ["Unknown"];
  }

  getdata() async {
    if (Con_List.M_sire.isEmpty ||
        Con_List.M_inseminator.isEmpty ||
        Con_List.M_calvingType.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_sire);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_staff);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_calvingType);
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    lat = position.latitude.toString();
    long = position.longitude.toString();
    var box = await Hive.openBox<Breeding_reproduction_id>(
        "Breeding_reproduction_id");
    try {
      Constants.Last_id_rep = int.parse(box.keys.last.toString());
    } catch (e) {
      Constants.Last_id_rep = 0;
    }
    var box1 = await Hive.openBox<Breeding_reproduction_id>(
        "Breeding_reproduction_id");
    try {
      Constants.Last_id_Br_reprod = int.parse(box1.keys.last.toString());
    } catch (e) {
      Constants.Last_id_Br_reprod = 0;
    }
    setState(() {});
  }

  getlist() async {
    Con_List.M_inseminator.forEach((e) {
      inseminator.add(e.name);
    });
    Con_List.M_calvingType.forEach((e) {
      calfsex.add(e.name);
    });
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    lat = position.latitude.toString();
    long = position.longitude.toString();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(
          () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return New_Cattle(manualentry: widget.tag);
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "Breeding",
          Actions: [],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return New_Cattle(manualentry: widget.tag);
              },
            ));
          },
        ),
        body: Con_Wid.backgroundContainer(
            child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Con_Wid.fullContainer(
                  child: widget.select_cattle == "Heifer"
                      ? Container()
                      : Con_Wid.textFieldWithInter(
                          Onchanged: (p0) {
                            setState(() {
                              int val = int.parse(p0.toString());

                              if (val <= 20) {
                                pass = "";
                              } else {
                                pass = "No of Calving should be less then 20";
                              }
                            });
                          },
                          eRror: pass,
                          TextInput_Type: TextInputType.number,
                          text: "NO of Calving",
                          controller: NoofCalving,
                          hintText: "Enter NO of Calving")),
            ),
            Row(children: [
              Checkbox(value: milk1, onChanged: (value) {
                setState(() {
                  milk1=value!;

                });

              },),
              Text("Milk Yield Competition")
            ],),
            widget.select_cattle == "Heifer"
                ? Container()
                : Con_Wid.fullContainer(
                    child: Con_Wid.fullContainer(
                        child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Con_Wid.gText("Cattle Type",
                          style:
                              TextStyle(fontSize: 18, color: Conclrfontmain)),
                      Con_Wid.height(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Con_Wid.selectionContainer(
                              height: 35,
                              width: 97,
                              text: "None",
                              ontap: () {
                                setState(() {
                                  FirstSelected = "None";
                                });
                              },
                              context: context,
                              Color: FirstSelected == "None"
                                  ? con_clr.ConClr2
                                      ? ConClrbluelight
                                      : ConClrDialog
                                  : con_clr.ConClr2
                                      ? ConClrLightBack
                                      : whiteColor,
                              textcolor: FirstSelected == "None"
                                  ? whiteColor
                                  : con_clr.ConClr2
                                      ? whiteColor
                                      : ConClrDialog),
                          Con_Wid.selectionContainer(
                              height: 35,
                              width: 97,
                              text: "Milking",
                              context: context,
                              ontap: () {
                                setState(() {
                                  FirstSelected = "Milking";
                                  SecondSelected = "Days in milk";
                                });
                              },
                              Color: FirstSelected == "Milking"
                                  ? con_clr.ConClr2
                                      ? ConClrbluelight
                                      : ConClrDialog
                                  : con_clr.ConClr2
                                      ? ConClrLightBack
                                      : whiteColor,
                              textcolor: FirstSelected == "Milking"
                                  ? whiteColor
                                  : con_clr.ConClr2
                                      ? whiteColor
                                      : ConClrDialog),
                          Con_Wid.selectionContainer(
                              height: 35,
                              width: 97,
                              text: "Dry",
                              context: context,
                              ontap: () {
                                setState(() {
                                  FirstSelected = "Dry";
                                  SecondSelected = "Dry Days";
                                  milkKG.text = "0";
                                });
                              },
                              Color: FirstSelected == "Dry"
                                  ? con_clr.ConClr2
                                      ? ConClrbluelight
                                      : ConClrDialog
                                  : con_clr.ConClr2
                                      ? ConClrLightBack
                                      : whiteColor,
                              textcolor: FirstSelected == "Dry"
                                  ? whiteColor
                                  : con_clr.ConClr2
                                      ? whiteColor
                                      : ConClrDialog),
                        ],
                      ),
                      Con_Wid.height(5),
                      FirstSelected == "Milking" || FirstSelected == "Dry"
                          ? Container(
                              child: Column(children: [
                                Container(
                                  height: 2,
                                  color: Colors.grey,
                                ),
                                Con_Wid.height(5),
                                FirstSelected == "Dry"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                            Radio(
                                              value: "Dry Days",
                                              groupValue: SecondSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  milkday.text = "";
                                                  SecondSelected =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text("Dry Days"),
                                            Radio(
                                              value: "Last Dry Date",
                                              groupValue: SecondSelected,
                                              onChanged: (value) async {
                                                mStrFromdate =
                                                    await Con_Wid.GlbDatePicker(
                                                        pcontext: context,
                                                        formate: "11");
                                                milkday.text = mStrFromdate
                                                    .toString()
                                                    .substring(0, 10);
                                                setState(() {
                                                  var date = DateTime.now();
                                                  Duration diff =
                                                      date.difference(
                                                          DateTime.parse(
                                                              mStrFromdate));
                                                  SecondSelected =
                                                      value.toString();
                                                  if (int.parse(diff.inDays
                                                          .toString()) >
                                                      120) {
                                                    pass3 =
                                                        "enter Days between 1 to 120";
                                                  } else {
                                                    pass3 = "";
                                                  }
                                                });
                                              },
                                            ),
                                            Text("Last Dry Date"),
                                          ])
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                            Radio(
                                              value: "Days in milk",
                                              groupValue: SecondSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  milkday.text = "";
                                                  SecondSelected =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          Con_Wid.gText("Days in milk"),
                                            Radio(
                                              value: "Last Calving Date",
                                              groupValue: SecondSelected,
                                              onChanged: (value) async {
                                                mStrFromdate =
                                                    await Con_Wid.GlbDatePicker(
                                                        pcontext: context,
                                                        formate: "11");
                                                milkday.text = mStrFromdate
                                                    .toString()
                                                    .substring(0, 10);
                                                setState(() {
                                                  var date = DateTime.now();
                                                  Duration diff =
                                                      date.difference(
                                                          DateTime.parse(
                                                              mStrFromdate));
                                                  SecondSelected =
                                                      value.toString();
                                                  if (int.parse(diff.inDays
                                                          .toString()) >
                                                      300) {
                                                    pass3 =
                                                        "enter Days between 1 to 300";
                                                  } else {
                                                    pass3 = "";
                                                  }
                                                });
                                              },
                                            ),
                                          Con_Wid.gText("Last Calving Date"),
                                          ]),
                                Con_Wid.height(10),
                                FirstSelected == "Dry"
                                    ? Con_Wid.textFieldWithInter(
                                        TextInput_Type: TextInputType.number,
                                        controller: milkday,
                                        hintText: "Enter  Days",
                                        eRror: pass3,
                                        Onchanged: (p0) {
                                          setState(() {
                                            int val = int.parse(p0.toString());
                                            if (val <= 120) {
                                              pass3 = "";
                                            } else {
                                              pass3 =
                                                  "enter day between 1 to 120";
                                            }
                                          });
                                        },
                                      )
                                    : Con_Wid.textFieldWithInter(
                                        eRror: pass3,
                                        Onchanged: (p0) {
                                          setState(() {
                                            int val = int.parse(p0.toString());

                                            if (val <= 500) {
                                              pass3 = "";
                                            } else {
                                              pass3 =
                                                  "enter day between 1 to 500";
                                            }
                                          });
                                        },
                                        TextInput_Type: TextInputType.number,
                                        controller: milkday,
                                        hintText: "Enter Days In milk"),
                                CondropDown(
                                  title: 'Select Sire',
                                  itemList: sire,
                                  SelectedList: mSire,
                                  onSelected: (List<String> value) {
                                    setState(() {
                                      mSire = value;
                                    });
                                  },
                                ),
                                CondropDown(
                                  title: 'Select Inseminator',
                                  itemList: inseminator,
                                  SelectedList: mInseminator,
                                  onSelected: (List<String> value) {
                                    setState(() {
                                      mInseminator = value;
                                    });
                                  },
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Radio(
                                        value: "Normal",
                                        groupValue: ThridSelected,
                                        onChanged: (value) {
                                          setState(() {
                                            ThridSelected = value.toString();
                                            clavinfID = "1";
                                          });
                                        },
                                      ),
                                      Con_Wid.gText("Normal"),
                                      Radio(
                                        value: "Abnormal",
                                        groupValue: ThridSelected,
                                        onChanged: (value) {
                                          setState(() {
                                            ThridSelected = value.toString();
                                            clavinfID = "2";
                                          });
                                        },
                                      ),
                                      Con_Wid.gText("Abnormal"),
                                    ]),
                                Con_Wid.height(5),
                                CondropDown(
                                  title: 'Select Calf Sex',
                                  itemList: Con_List.M_calvingTypeOption.where(
                                          (element) =>
                                              element.calvingType.toString() ==
                                              clavinfID)
                                      .map((e) => "${e.name}")
                                      .toList(),
                                  SelectedList: mCalfsex,
                                  onSelected: (List<String> value) {
                                    setState(() {
                                      mCalfsex = value;
                                    });
                                  },
                                ),
                                FirstSelected == "Dry"
                                    ? Container()
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Con_Wid.selectionContainer(
                                                height: 35,
                                                width: 97,
                                                text: "Today Milk",
                                                context: context,
                                                ontap: () {
                                                  setState(() {
                                                    FourSelected = "Today Milk";
                                                  });
                                                },
                                                Color: FourSelected ==
                                                            "Today Milk" ||
                                                        FourSelected ==
                                                            "Total Milk"
                                                    ? con_clr.ConClr2
                                                        ? ConClrbluelight
                                                        : ConClrDialog
                                                    : con_clr.ConClr2
                                                        ? ConClrLightBack
                                                        : whiteColor,
                                                textcolor: FourSelected ==
                                                            "Today Milk" ||
                                                        FourSelected ==
                                                            "Total Milk"
                                                    ? whiteColor
                                                    : con_clr.ConClr2
                                                        ? whiteColor
                                                        : ConClrDialog),
                                            Con_Wid.selectionContainer(
                                                height: 35,
                                                width: 97,
                                                text: "Total Milk",
                                                context: context,
                                                ontap: () {
                                                  setState(() {
                                                    FourSelected = "Today Milk";
                                                  });
                                                },
                                                Color: FourSelected ==
                                                            "Today Milk" ||
                                                        FourSelected ==
                                                            "Total Milk"
                                                    ? con_clr.ConClr2
                                                        ? ConClrbluelight
                                                        : ConClrDialog
                                                    : con_clr.ConClr2
                                                        ? ConClrLightBack
                                                        : whiteColor,
                                                textcolor: FourSelected ==
                                                            "Today Milk" ||
                                                        FourSelected ==
                                                            "Total Milk"
                                                    ? whiteColor
                                                    : con_clr.ConClr2
                                                        ? whiteColor
                                                        : ConClrDialog),
                                            Con_Wid.selectionContainer(
                                                height: 35,
                                                width: 97,
                                                text: "Avg Milk",
                                                context: context,
                                                ontap: () {
                                                  setState(() {
                                                    FourSelected = "Avg Milk";
                                                  });
                                                },
                                                Color:
                                                    FourSelected == "Avg Milk"
                                                        ? con_clr.ConClr2
                                                            ? ConClrbluelight
                                                            : ConClrDialog
                                                        : con_clr.ConClr2
                                                            ? ConClrLightBack
                                                            : whiteColor,
                                                textcolor:
                                                    FourSelected == "Avg Milk"
                                                        ? whiteColor
                                                        : con_clr.ConClr2
                                                            ? whiteColor
                                                            : ConClrDialog),
                                          ],
                                        ),
                                      ),
                                FirstSelected == "Dry"
                                    ? Container()
                                    : FourSelected == "Avg Milk"
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: Con_Wid.textFieldWithInter(
                                              TextInput_Type:
                                                  TextInputType.number,
                                              controller: milkKG,
                                              hintText: "Enter Milk in kg",
                                              eRror: pass4,
                                              Onchanged: (p0) {
                                                setState(() {
                                                  int val =
                                                      int.parse(p0.toString());

                                                  if (val <= 50) {
                                                    pass4 = "";
                                                  } else {
                                                    pass4 =
                                                        "enter average milk between 1 to 50";
                                                  }
                                                });
                                              },
                                            ))
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: Con_Wid.textFieldWithInter(
                                              TextInput_Type:
                                                  TextInputType.number,
                                              controller: milkKG,
                                              hintText: "Enter Milk in kg",
                                              eRror: pass4,
                                              Onchanged: (p0) {
                                                setState(() {
                                                  int val =
                                                      int.parse(p0.toString());

                                                  if (val <= 15000) {
                                                    pass4 = "";
                                                  } else {
                                                    pass4 =
                                                        "enter total milk between 1 to 15000";
                                                  }
                                                });
                                              },
                                            ))
                              ]),
                            )
                          : Container(),
                    ],
                  ))),
            Con_Wid.fullContainer(
                child: Column(
              children: [
                Con_Wid.paddingWithText(
                    "Breeding Status",
                    context: context,
                    Conclrfontmain,
                    pIntPadding: 1),
                Con_Wid.height(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Con_Wid.selectionContainer(
                        height: 35,
                        width: 97,
                        text: "None",
                        context: context,
                        ontap: () {
                          setState(() {
                            FiveSelected = "None";
                          });
                        },
                        Color: FiveSelected == "None"
                            ? con_clr.ConClr2
                                ? ConClrbluelight
                                : ConClrDialog
                            : con_clr.ConClr2
                                ? ConClrLightBack
                                : whiteColor,
                        textcolor: FiveSelected == "None"
                            ? whiteColor
                            : con_clr.ConClr2
                                ? whiteColor
                                : ConClrDialog),
                    Con_Wid.selectionContainer(
                        height: 35,
                        width: 97,
                        text: "Pregnant",
                        context: context,
                        ontap: () {
                          setState(() {
                            FiveSelected = "Pregnant";
                            SixSelected = "Pregnant Days";
                          });
                        },
                        Color: FiveSelected == "Pregnant"
                            ? con_clr.ConClr2
                                ? ConClrbluelight
                                : ConClrDialog
                            : con_clr.ConClr2
                                ? ConClrLightBack
                                : whiteColor,
                        textcolor: FiveSelected == "Pregnant"
                            ? whiteColor
                            : con_clr.ConClr2
                                ? whiteColor
                                : ConClrDialog),
                    Con_Wid.selectionContainer(
                        height: 35,
                        width: 97,
                        text: "A.I",
                        context: context,
                        ontap: () {
                          setState(() {
                            FiveSelected = "A.I";
                            SixSelected = "A.I Days";
                          });
                        },
                        Color: FiveSelected == "A.I"
                            ? con_clr.ConClr2
                                ? ConClrbluelight
                                : ConClrDialog
                            : con_clr.ConClr2
                                ? ConClrLightBack
                                : whiteColor,
                        textcolor: FiveSelected == "A.I"
                            ? whiteColor
                            : con_clr.ConClr2
                                ? whiteColor
                                : ConClrDialog),
                  ],
                ),
                Con_Wid.height(10),
                FiveSelected == "None"
                    ? Container()
                    : Column(children: [
                        Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        Con_Wid.height(10),
                        FiveSelected == "A.I"
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Radio(
                                      value: "A.I Days",
                                      groupValue: SixSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          enterday.text = "";
                                          SixSelected = value.toString();
                                        });
                                      },
                                    ),
                                    Text("A.I Days"),
                                    Radio(
                                      value: "A.I Date",
                                      groupValue: SixSelected,
                                      onChanged: (value) async {
                                        mStrFromdate =
                                            await Con_Wid.GlbDatePicker(
                                                pcontext: context,
                                                formate: "11");
                                        enterday.text = mStrFromdate
                                            .toString()
                                            .substring(0, 10);
                                        setState(() {
                                          SixSelected = value.toString();
                                        });
                                      },
                                    ),
                                    Text("A.I Date"),
                                  ])
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Radio(
                                      value: "Pregnant Days",
                                      groupValue: SixSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          enterday.text = "";
                                          SixSelected = value.toString();
                                        });
                                      },
                                    ),
                                    Text("Pregnant Days"),
                                    Radio(
                                      value: "Pregnant Date",
                                      groupValue: SixSelected,
                                      onChanged: (value) async {
                                        mStrFromdate =
                                            await Con_Wid.GlbDatePicker(
                                                pcontext: context,
                                                formate: "11");
                                        enterday.text = mStrFromdate
                                            .toString()
                                            .substring(0, 10);
                                        setState(() {
                                          SixSelected = value.toString();
                                        });
                                      },
                                    ),
                                    Text("Pregnant Date"),
                                  ]),
                        FiveSelected == "Pregnant"
                            ? SixSelected == "Pregnant Days"
                                ? Con_Wid.textFieldWithInter(
                                    TextInput_Type: TextInputType.number,
                                    controller: enterday,
                                    hintText: "Enter Days",
                                    eRror: pass5,
                                    Onchanged: (p0) {
                                      setState(() {
                                        int val = int.parse(p0.toString());

                                        if (val <= 300) {
                                          pass5 = "";
                                        } else {
                                          pass5 = "enter Day between 1 to 300";
                                        }
                                      });
                                    },
                                  )
                                : Con_Wid.textFieldWithInter(
                                    TextInput_Type: TextInputType.number,
                                    controller: enterday,
                                    hintText: "Enter Days")
                            : SixSelected == "A.I Days"
                                ? Con_Wid.textFieldWithInter(
                                    TextInput_Type: TextInputType.number,
                                    controller: enterday,
                                    hintText: "Enter Days",
                                    eRror: pass5,
                                    Onchanged: (p0) {
                                      setState(() {
                                        int val = int.parse(p0.toString());

                                        if (val <= 300) {
                                          pass5 = "";
                                        } else {
                                          pass5 = "enter Days between 1 to 300";
                                        }
                                      });
                                    },
                                  )
                                : Con_Wid.textFieldWithInter(
                                    TextInput_Type: TextInputType.number,
                                    controller: enterday,
                                    hintText: "Enter Days"),
                        CondropDown(
                          title: 'Select sire',
                          itemList: sire,
                          SelectedList: mSire1,
                          onSelected: (List<String> value) {
                            setState(() {
                              mSire1 = value;
                            });
                          },
                        ),
                        CondropDown(
                          title: 'Select Insemination',
                          itemList: inseminator,
                          SelectedList: mInseminator1,
                          onSelected: (List<String> value) {
                            setState(() {
                              mInseminator1 = value;
                            });
                          },
                        ),
                        Con_Wid.textFieldWithInter(
                            Onchanged: (p0) {
                              setState(() {
                                int val = int.parse(p0.toString());

                                if (val == 1 || val == 2) {
                                  pass1 = "";
                                } else {
                                  pass1 = "No of Dose between 1 or 2";
                                }
                              });
                            },
                            eRror: pass1,
                            TextInput_Type: TextInputType.numberWithOptions(),
                            controller: noofdose,
                            hintText: "Enter No of Dose"),
                        Con_Wid.textFieldWithInter(
                            eRror: pass2,
                            Onchanged: (p0) {
                              setState(() {
                                int val = int.parse(p0.toString());

                                if (val > 1 || val < 30) {
                                  pass2 = "";
                                } else {
                                  pass2 = "No of Heat Squence between 1 or 30";
                                }
                              });
                            },
                            TextInput_Type: TextInputType.numberWithOptions(),
                            controller: heatsequence,
                            hintText: "Enter Heate Sequence"),
                        Con_Wid.height(10),
                      ]),
                Con_Wid.MainButton(
                    OnTap: () {
                      if (widget.select_cattle == "Adult") {
                        if (NoofCalving.text == "") {
                          Con_Wid.Con_Show_Toast(
                              context, "Enter No Of Calving");
                        } else if(widget.select_cattle=="Adult" && FirstSelected=="None"){
                          Con_Wid.Con_Show_Toast(
                              context, "Please Enter Cattle Type");
                        } else {
                          validation();
                        }
                      } else {
                        validation();
                      }
                    },
                    pStrBtnName: "Save",
                    height: 42,
                    width: 150,
                    fontSize: 16),
                Con_Wid.height(10),
              ],
            )),
          ]),
        )),
      ),
    );
  }

  void validation() {
    setState(() {
      if (mSire.isNotEmpty) {
        Con_List.M_sire.forEach((element) {
          if (element.name == mSire[0]) {
            Sire = element.id.toString();
          }
        });
      }
      if (mInseminator.isNotEmpty) {
        Con_List.M_inseminator.forEach((element) {
          if (element.name == mInseminator[0]) {
            Inseme = element.id.toString();
          }
        });
      }
      if (mCalfsex.isNotEmpty) {
        Con_List.M_calvingType.forEach((element) {
          if (element.name == mCalfsex[0]) {
            CAlF = element.id.toString();
          }
        });
      }
      if (FirstSelected == 'None') {
        milkday.text = '0';
        milk_sire = '0';
        milk_insem = '0';
        mCalfsex.add("");
        ThridSelected = '-';
      } else if (FirstSelected == 'Milking') {
        pd1 = "3";
        pd2 = "3";

        //milking sire
        if (mSire.isEmpty) {
          if ('${widget.species}' == "1") {
            milk_sire = "999999C";
          } else {
            milk_sire = "999998B";
          }
        } else {
          milk_sire = mSire[0];
        }

        //milking inseminator
        if (mInseminator.isEmpty) {
          milk_insem = "9999999";
        } else {
          milk_insem = mInseminator[0];
        }
        //calf sex
        if (mCalfsex.isEmpty) {
          Con_Wid.Con_Show_Toast(context, "select calf sex");
        } else {
          milking_calf_sex = mCalfsex[0];
        }


        if (ThridSelected == "Abnormal") {
          c_type = "2";
        } else {
          c_type = "1";
        }

        //total milk or average milk
        if (FourSelected == "Today_milk") {
          if (double.parse(milkKG.text) > 0) {
            mor = milkKG.text;
            if (int.parse(milkday.text) > 0) {
              var milks_ltr = double.parse(milkKG.text);
              int decimals = 2;
              num fac = pow(10, decimals);
              milks_ltr = (milks_ltr).round() / fac;
              lac_total = milks_ltr.toString();
            } else {
              lac_total = mor;
            }
          }
        } else if (FourSelected == "Average_milk") {
          if (double.parse(milkKG.text) > 0) {
            mor = milkKG.text;
            if (int.parse(milkday.text) > 0) {
              var milks_ltr =
                  double.parse(milkKG.text) * double.parse(milkday.text);
              int decimals = 2;
              num fac = pow(10, decimals);
              milks_ltr = (milks_ltr * fac).round() / fac;
              lac_total = milks_ltr.toString();
            } else {
              lac_total = mor;
            }
          }
        } else {
          if (milkKG.text.length > 0) {
            if (SecondSelected == "Last Calving Date") {
              Duration di = DateTime.now()
                  .difference(DateTime.parse(milkday.text.toString()));
              if (di.inDays > 0) {
                var milks_ltr = double.parse(milkKG.text) /
                    double.parse(di.inDays.toString());
                double multiplier = .5;
                int x = (multiplier * milks_ltr).toInt();
                int decimals = 2;
                num fac = pow(10, decimals);
                milks_ltr = (milks_ltr * fac).round() / fac;
                mor = milks_ltr.toString();
              }
            } else {
              if (int.parse(milkday.text) > 0) {
                var milks_ltr =
                    double.parse(milkKG.text) / double.parse(milkday.text);
                double multiplier = .5;
                int x = (multiplier * milks_ltr).toInt();
                int decimals = 2;
                num fac = pow(10, decimals);
                milks_ltr = (milks_ltr * fac).round() / fac;
                mor = milks_ltr.toString();
              } else {
                var morn = double.parse(milkKG.text);
                int decimals = 2;
                num fac = pow(10, decimals);
                morn = (morn * fac).round() / fac;
                mor = morn.toString();
              }
            }
          }
          lac_total = milkKG.text;
        }
      }

      //dry button clicked
      else if (FirstSelected == 'Dry') {
        pd1 = "3";
        pd2 = "3";
        // milking_in_ltr.text.isEmpty || int.parse(milking_in_ltr.text) > 50 ? _validate_milk_details = true : _validate_milk_details = false;
        //milking sire
        if (mSire.isEmpty) {
          if ('${widget.species}' == "1") {
            milk_sire = "999999C";
          } else {
            milk_sire = "999998B";
          }
        } else {
          milk_sire = mSire[0];
        }

        //milking inseminator
        if (mInseminator.isEmpty) {
          milk_insem = "9999999";
        } else {
          milk_insem = mInseminator[0];
        }
        //calf sex
        milking_calf_sex = mCalfsex[0];
        if (SecondSelected == 'Dyas in milk' || SecondSelected == "Dry Days") {
          // milkday.text.isEmpty ||
          //         int.parse(milkday.text) > 500 ||
          //         int.parse(milkday.text) < 1
          //     ? Con_Wid.Con_Show_Toast(
          //         context, "Invalid Days. please enter days from 1 to 500")
          //     : null;

          calving_or_dry_days = milkday.text;
          DateTime Today = new DateTime.now();
          DateTime Last_days =
              Today.subtract(new Duration(days: int.parse(milkday.text)));
          calving_or_dry_date = Last_days.toString();

          // DateTime Last_dayss=Last_days.subtract(new Duration(days: int.parse(milk_parm_val)));
          if (Con_List.M_paramter.where(
                  (et) => et.breed == int.parse(widget.breed.toString()))
              .isNotEmpty) {
            dry_parm_val = Con_List.M_paramter.where(
                    (et) => et.breed == int.parse(widget.breed.toString()))
                .first
                .lactationLength
                .toString();
          }
          if (Con_List.M_paramter.where(
                  (et) => et.breed == int.parse(widget.breed.toString()))
              .isNotEmpty) {
            dry_parm_val = Con_List.M_paramter.where(
                    (et) => et.breed == int.parse(widget.breed.toString()))
                .first
                .conCalv
                .toString();
          }
          DateTime cal_next_dayss = Last_days.subtract(new Duration(
              days: dry_parm_val == "" ? 0 : int.parse(dry_parm_val) - 1));
          calving_date = cal_next_dayss.toString();
          DateTime next_dayss = cal_next_dayss.subtract(new Duration(
              days: milk_parm_val == "" ? 0 : int.parse(milk_parm_val) - 1));
          milk_heat_date = next_dayss.toString();
        } else {
          Duration di = DateTime.now()
              .difference(DateTime.parse(milkday.text.toString()));

          DateTime cal_next_dayss =
              DateTime.now().subtract(Duration(days: di.inDays));
          calving_date = cal_next_dayss.toString();
          DateTime next_dayss = cal_next_dayss;
          milk_heat_date = next_dayss.toString();
        }
        if (ThridSelected == "Abnormal") {
          c_type = "2";
        } else {
          c_type = "1";
        }

        //total milk or average milk

        if (milk_yield_type == "Average_milk") {
          if (milkKG.text.length > 0) {
            mor = milkKG.text;
            if (int.parse(calving_or_dry_days) > 0) {
              var milks_ltr =
                  double.parse(milkKG.text) * double.parse(calving_or_dry_days);
              int decimals = 2;
              num fac = pow(10, decimals);
              milks_ltr = (milks_ltr * fac).round() / fac;
              lac_total = milks_ltr.toString();
            } else {
              lac_total = mor;
            }
          }
        } else if (milk_yield_type == "Today_milk") {
          if (int.parse(milkKG.text) > 0) {
            if (int.parse(calving_or_dry_days) > 0) {
              var milks_ltr =
                  double.parse(milkKG.text) / double.parse(calving_or_dry_days);
              int decimals = 2;
              num fac = pow(10, decimals);
              milks_ltr = (milks_ltr * fac).round() / fac;
              mor = milkKG.toString();
            } else {
              var morn = double.parse(milkKG.text);
              int decimals = 2;
              num fac = pow(10, decimals);
              morn = (morn * fac).round() / fac;
              mor = morn.toString();
            }
          }
          lac_total = milkKG.text;
        }
      }

      if (FiveSelected == "None") {
        enterday.text = '0';
        noofdose.text = '0';
        mSire1.add("0");
        mInseminator1.add("0");
        heatsequence.text = '0';
      } else if (FiveSelected == 'Pregnant') {
        pd1 = "3";
        pd2 = "3";

        //prag sire
        if (mSire1.isEmpty) {
          if ('${widget.species}' == "1") {
            prag_sire = "999999C";
          } else {
            prag_sire = "999998B";
          }
        } else {
          prag_sire = mSire1[0];
        }

        //prag inseminator
        if (mInseminator1.isEmpty) {
          prag_insem = "9999999";
        } else {
          prag_insem = mInseminator1[0];
        }

        if (SixSelected == 'Pregnant Days' || SixSelected == 'A.I Days') {
          pragn_or_ai_days = enterday.text;
          DateTime Today = new DateTime.now();
          DateTime Last_days =
              Today.subtract(new Duration(days: int.parse(enterday.text)));
          prag_heat_date = Last_days.toString();
          DateTime next_dayss =
              Last_days.subtract(new Duration(days: int.parse(enterday.text)));
          pragn_or_ai_date = next_dayss.toString();
        } else {
          pragn_or_ai_days = pragnent_or_ai_diff;
          prag_heat_date = enterday.text;
          DateTime next_dayss = DateTime.tryParse(pragn_or_ai_date)!
              .subtract(new Duration(days: int.parse(prag_milk_val)));
          pragn_or_ai_date = next_dayss.toString();
        }
      } else if (FiveSelected == 'A.I') {
        pd1 = "";
        pd2 = "";
        //prag sire
        if (mSire1.isEmpty) {
          if ('${widget.species}' == "1") {
            prag_sire = "999999C";
          } else {
            prag_sire = "999998B";
          }
        } else {
          prag_sire = mSire1[0];
        }

        //prag inseminator
        if (mInseminator1.isEmpty) {
          prag_insem = "9999999";
        } else {
          prag_insem = mInseminator1[0];
        }
        if (SixSelected == 'Pregnant days') {
          pragn_or_ai_days = enterday.text;
          DateTime Today = new DateTime.now();
          DateTime Last_days =
              Today.subtract(new Duration(days: int.parse(enterday.text)));
          prag_heat_date = Last_days.toString();
        } else {
          pragn_or_ai_days = pragnent_or_ai_diff;
          prag_heat_date = enterday.text;
        }
      }

      /*no_calving.text.isEmpty ||
          int.parse(no_calving.text) > 25
          ? _validate_no_calving = true
          : _validate_no_calving = false;*/
    });
    if (noofdose.text == "" ||
        heatsequence.text == "" ||
        enterday.text == "" ||
        milkKG == "" ||
        milkday.text == "") {
      parity = '1';
      Con_Wid.Con_Show_Toast(context, "Invalid Entry");
    } else {
      //parity start
      if (FirstSelected == 'None') {
        parity = NoofCalving.text;
      } else {
        parity = NoofCalving.text;
      }

      if (NoofCalving.text.isEmpty) {
        parity = '0';
      }
      //parity ends

      //status starts
      if (FiveSelected == 'Pregnant' && FirstSelected == 'Milking') {
        status = '5';
        NAme = "Pregnant Milking";
      } else if (FiveSelected == 'A.I' && FirstSelected == 'Milking') {
        pragn_or_ai_date = "null";
        NAme = "null";
      } else if (FiveSelected == 'A.I' && FirstSelected == 'Dry') {
        pragn_or_ai_date = "null";
      } else if (FiveSelected == 'A.I') {
        pragn_or_ai_date = "null";
      } else if (FiveSelected == 'Pregnant' && FirstSelected == 'Dry') {
        status = '3';
        NAme = "Pregnant Dry";
      } else if (FiveSelected == '-' && FiveSelected == 'None') {
        status = '6';
      } else if (FirstSelected == 'Milking') {
        status = '4';
        NAme = "Milking";
      } else if (FirstSelected == 'Dry') {
        status = '2';
        NAme = "Dry";
      } else if (FiveSelected == 'Pregnant') {
        status = '1';
        NAme = "Pregnant";
      }
      List<Map<String, String>> Details = [
        {"Name": "Animal ID", "value": "${widget.tag}"},
        {"Name": "Type of cattle", "value": "${widget.select_cattle}"},
        {"Name": "Route", "value": "${widget.route_name}"},
        {"Name": "Socity", "value": "${widget.socity_name}"},
        {"Name": "Farmer", "value": "${widget.owner_name}"},
        {"Name": "Species", "value": "${widget.species_name}"},
        {"Name": "Breed", "value": "${widget.breed_name}"},
        {"Name": "Name", "value": "${widget.name}"},
        {"Name": "DOB", "value": "${widget.dob.toString().substring(0, 10)}"},
        {"Name": "Age", "value": "${widget.age}"},
        {"Name": "DOB", "value": "${widget.dob}"},
        {"Name": "No of Calving", "value": "${NoofCalving.text}"},
        {"Name": "Milking/Dry Days", "value": "${milkday.text}"},
        {"Name": "Calving Type", "value": "${ThridSelected}"},
        {"Name": "Total/Average Milk", "value": "${milkKG.text}"},
        {"Name": "PD checking Date/Days", "value": "${enterday.text}"},
        {"Name": "Sire", "value": "$prag_sire"},
        {"Name": "Inseminator", "value": "$prag_insem"},
        {"Name": "No of Dose", "value": "${noofdose.text}"},
        {"Name": "Heat Sequence", "value": "${heatsequence.text}"},
        {"Name": "status ", "value": "${status}"},
        {"Name": "sexflag ", "value": "${widget.sex_flag}"},
        {"Name": "statusname ", "value": "${NAme}"},
      ];

      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height - 260,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ConClrWhite50),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(color: ConClrDialog),
                    child: Stack(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            child: IconButton(
                                splashRadius: 18,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Own_Close,
                                color: Colors.white),
                          )
                        ],
                      ),
                      Center(
                        child: Con_Wid.paddingWithText(
                            "  Confirm Cattle \nRegistration Data",
                            context: context,
                            fontwhiteColor),
                      )
                    ]),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: Details.length * 60.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: Details.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity),
                            title: Text("${Details[index]['Name']}"),
                            trailing: Container(
                                alignment: Alignment.centerRight,
                                width: 130,
                                child: Text("${Details[index]['value']}")),
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Con_Wid.MainButton(
                          OnTap: () {
                            Navigator.pop(context);
                          },
                          pStrBtnName: "Edit",
                          height: 40,
                          width: 80,
                          fontSize: 16),
                      Con_Wid.MainButton(
                          OnTap: () async {
                            String cal_drydates = "",
                                c_type = ThridSelected == "Normal" ? "0" : "1",
                                sex = "";
                            AllDate(milkday.text, enterday.text);

                            if (cal_drydates != null || cal_drydates != "") {
                              c_type = c_type;
                              sex = "${widget.sex_flag}";
                            }

                            List<Milk_production_id> prods = [
                              Milk_production_id(
                                  tagId: "${widget.tag}",
                                  date: "${widget.reg_date}",
                                  parity: NoofCalving.text != ""
                                      ? int.parse(NoofCalving.text)
                                      : 0,
                                  morningYield: milkKG.text,
                                  eveningYield: null,
                                  nightYield: null,
                                  midnightYield: null,
                                  fat: null,
                                  snf: null,
                                  lactose: null,
                                  protein: null,
                                  fatC: null,
                                  snfC: null,
                                  lactoseC: null,
                                  proteinC: null,
                                  cumulativeMilkTotal: null,
                                  lactationMilkTotal: milkKG.text,
                                  daysCount: calving_or_dry_days != ""
                                      ? int.parse(calving_or_dry_days)
                                      : 0,
                                  officialMilk: null,
                                  lat: null,
                                  long: null,
                                  dayMilkTotal: milkKG.text,
                                  details: "02",
                                  id: null,
                                  herd: null,
                                  lot: null,
                                  farmer: widget.owner,
                                  boxno: null,
                                  bottleno: null,
                                  staff: null,
                                  SyncStatus: "1",
                                  clientID: null,
                                  serverID: null)
                            ];
                            List<Breeding_reproduction_id> milk_prod = [
                              Breeding_reproduction_id(
                                TableNAme: "MILK",
                                aICost: null,
                                createdAt: DateTime.now().toString(),
                                createdByUser:
                                    int.parse(Constants_Usermast.user_id),
                                hI: null,
                                lastUpdatedByUser:
                                    int.parse(Constants_Usermast.user_id),
                                updatedAt: DateTime.now().toString(),
                                zone: int.parse(widget.zone.toString() == ""
                                    ? "0"
                                    : widget.zone.toString()),
                                CI: '',
                                AIDays: '',
                                AITname: '',
                                CalvingPDDays: '',
                                insertflag: '',
                                PDdays: '',
                                PDname: '',
                                PDResult: '',
                                Pregdays: pregnantday,
                                Sirename: mSire1.isEmpty
                                    ? "Unknown"
                                    : mSire1[0].toString(),
                                tagId: "${widget.tag}",
                                parity: int.parse(parity),
                                heatSeq: int.parse(heatsequence.text),
                                heatDate: "${RHeatdate.toString()}",
                                remPD1: 1,
                                remPD2: 1,
                                pDDate: "${RPDdate.toString()}",
                                dateOfCalving: "${RCalvingdate.toString()}",
                                dateOfDry: "${RDrydate.toString()}",
                                dryTreatment: "DryTreatment Text",
                                flag: "Flag Text",
                                retantionOfPlecenta: 1,
                                comments: "Comments Text",
                                reproductionProblemNote:
                                    "ReproductionProblemNote Text",
                                mobileOrDesktopEntryFlg: "M",
                                totalAIDose: int.parse(noofdose.text),
                                abortionSeq: 0,
                                vaccine: 0,
                                colostrum: 1,
                                inseminationTicketNumber: null,
                                pDTicketNumber: null,
                                calvingTicketNumber: null,
                                orderNumber: null,
                                oTP: null,
                                eNTRY: "I",
                                lat: lat == "" ? 0.0 : double.parse(lat),
                                long: long == "" ? 0.0 : double.parse(long),
                                details: 02,
                                inseminatorStaff:
                                    Inseme != "" ? int.parse(Inseme) : 0,
                                sire: Sire != "" ? int.parse(Sire) : 0,
                                pdBy: 1,
                                service: 1,
                                pd1: parseIntIfZeroSendNull(pd1),
                                pd2: parseIntIfZeroSendNull(pd2),
                                sex: int.parse(sex),
                                calfSex: CAlF != "" ? int.parse(CAlF) : 0,
                                calvingType: int.parse(c_type),
                                calvingTypeOption:
                                    ThridSelected == "Normal" ? 1 : 2,
                                dryReason: null,
                                id: Constants.Last_id_rep + 1,
                                SyncStatus: "0",
                                ServerId: '',
                              )
                            ];
                            List<Breeding_reproduction_id> repod = [
                              Breeding_reproduction_id(
                                 TableNAme: "Repoduction",
                                aICost: null,
                                createdAt: DateTime.now().toString(),
                                createdByUser:
                                    int.parse(Constants_Usermast.user_id),
                                hI: null,
                                lastUpdatedByUser:
                                    int.parse(Constants_Usermast.user_id),
                                updatedAt: DateTime.now().toString(),
                                zone: int.parse(widget.zone.toString() == ""
                                    ? "0"
                                    : widget.zone.toString()),
                                tagId: "${widget.tag}",
                                parity: int.parse(parity),
                                heatSeq: int.parse(heatsequence.text),
                                heatDate: "${RHeatdate1.toString()}",
                                remPD1: 1,
                                remPD2: 1,
                                pDDate: "${RPDdate1.toString()}",
                                dateOfCalving: "${RCalvingdate1.toString()}",
                                dateOfDry: "${RDrydate1.toString()}",
                                dryTreatment: "DryTreatment Text",
                                flag: "Flag Text",
                                retantionOfPlecenta: 1,
                                comments: "Comments Text",
                                reproductionProblemNote:
                                    "ReproductionProblemNote Text",
                                mobileOrDesktopEntryFlg: "M",
                                totalAIDose: int.parse(noofdose.text),
                                abortionSeq: 0,
                                vaccine: null,
                                colostrum: 1,
                                inseminationTicketNumber: null,
                                pDTicketNumber: null,
                                calvingTicketNumber: null,
                                orderNumber: null,
                                oTP: null,
                                eNTRY: "I",
                                lat: lat == "" ? 0.0 : double.parse(lat),
                                long: long == "" ? 0.0 : double.parse(long),
                                details: 02,
                                inseminatorStaff:
                                    Inseme != "" ? int.parse(Inseme) : 0,
                                sire: Sire != "" ? int.parse(Sire) : 0,
                                pdBy: 1,
                                service: 1,
                                pd1: parseIntIfZeroSendNull(pd1),
                                pd2: parseIntIfZeroSendNull(pd2),
                                sex: int.parse(widget.sex_flag.toString()),
                                calfSex: CAlF != "" ? int.parse(CAlF) : 0,
                                calvingType: int.parse(c_type),
                                calvingTypeOption:
                                    ThridSelected == "Normal" ? 1 : 2,
                                dryReason: 0,
                                id: Constants.Last_id_rep + 2,
                                SyncStatus: "0",
                                CI: '',
                                AIDays: '',
                                AITname: '',
                                CalvingPDDays: '',
                                insertflag: '',
                                PDdays: '',
                                PDname: '',
                                PDResult: '',
                                Pregdays: pregnantday,
                                Sirename: mSire1.isEmpty
                                    ? "Unknown"
                                    : mSire1[0].toString(),
                                ServerId: '',
                              )
                            ];
                            List<Animal_Details_id> animalDetails = [
                              Animal_Details_id(
                                  tagId: "${widget.tag}",
                                  code: null,
                                  name: "${widget.name}",
                                  dOB: "${widget.dob}",
                                  age: "${widget.age}",
                                  birthWeight: null,
                                  salvageFlag: null,
                                  parity: int.parse(parity),
                                  aITagNo: "",
                                  currentParity: 0,
                                  registrationDate: "${widget.reg_date}",
                                  transactionDate: null,
                                  breedingStatus: "",
                                  heatSeq: "${heatsequence.text}",
                                  heatDate:
                                      RHeatdate1 == "" ? RHeatdate : RHeatdate1,
                                  abortionSeq: null,
                                  pDDate: RPDdate1 == "" ? RPDdate : RPDdate1,
                                  calvingDate: RCalvingdate1 == ""
                                      ? RCalvingdate
                                      : RCalvingdate1,
                                  dryDate:
                                      RDrydate1 == "" ? RDrydate : RDrydate1,
                                  milkDate: null,
                                  lastMilk: null,
                                  totalMilk: null,
                                  selectFlag: null,
                                  farmerCode: widget.Farmercode,
                                  lotcode: widget.Lotcode,
                                  selectRemarks: null,
                                  selectColor: null,
                                  disposalRemarks: null,
                                  isSuspended: null,
                                  syncStatus: "0",
                                  lat: lat == "" ? 0.0 : double.parse(lat),
                                  long: long == "" ? 0.0 : double.parse(long),
                                  species: widget.species,
                                  breed: widget.breed,
                                  herd: widget.socity,
                                  lot: widget.route,
                                  farmer: widget.owner,
                                  status: status,
                                  pd1: null,
                                  pd2: null,
                                  sexFlg: int.parse("${widget.sex_flag}"),
                                  zone: int.parse(
                                      "${widget.zone.toString() == "" ? "0" : widget.zone}"),
                                  disposalFlag: null,
                                  pBFlag: null,
                                  virtualLot: null,
                                  farmername: "${widget.owner_name}",
                                  id: int.parse(widget.tag.toString()),
                                  lotname: "${widget.route_name}",
                                  herdname: "${widget.socity_name}",
                                  speciesname: "${widget.species_name}",
                                  statusname: NAme,
                                  breedname: "${widget.breed_name}",
                                  Syncstatus: "0")
                            ];
                            List<Animal_Registration>
                            Insert_animal = [
                              Animal_Registration(
                            tagId: "${widget.tag}",
                            code: milk1 == true?"1":"0",
                            name: "${widget.name}",
                            inputDate: "${widget.dob}",
                            birthWeight: "45",
                            sensorNo: "3",
                            photo: null,
                            parity: "$parity",
                            registrationDate: DateFormat(
                                'yyyy/MM/dd')
                                .format(DateTime.now()),
                            marketValue: "",
                            staff: "${widget.extensionOfficerStaff}",
                            lat: lat,
                            long: long,
                            species: "${widget.species}",
                            breed: "${widget.breed}",
                            herd: "${widget.route}",
                            lot: "${widget.socity}",
                            farmer: widget.owner,
                            lastSire: null,
                            sire: null,
                            dam: null,
                            paternalSire: null,
                            paternalDam: null,
                            sexFlg: "${widget.sex_flag}",
                            zone: "${widget.zone}",
                            createdAt: DateFormat(
                                'yyyy/MM/dd')
                                .format(DateTime.now()),
                            updatedAt: null, SyncStatus: "0")
                            ];
                            Map Online_Animal = {
                              "tagId": "${widget.tag}",
                              "code": milk1 == true?"1":"0",
                              "name": "${widget.name}",
                              "inputDate": "${widget.dob}",
                              "birthWeight": "45",
                              "sensorNo": "3",
                              "photo": null,
                              "parity": "$parity",
                              "registrationDate": DateFormat('yyyy/MM/dd').format(DateTime.now()),
                              "marketValue": "",
                              "staff": "${widget.extensionOfficerStaff}",
                              "lat": lat,
                              "long": long,
                              "species": "${widget.species}",
                              "breed": "${widget.breed}",
                              "herd": "${widget.route}",
                              "lot": "${widget.socity}",
                              "farmer": widget.owner,
                              "lastSire": null,
                              "sire": null,
                              "dam": null,
                              "paternalSire": null,
                              "paternalDam": null,
                              "sexFlg": "${widget.sex_flag}",
                              "zone": "${widget.zone}",
                              "createdAt": DateFormat('yyyy/MM/dd').format(DateTime.now()),
                              "updatedAt": null
                            };
                            //todo milk production id
                            Milk_production_id get =
                                prods[math.Random().nextInt(prods.length)];
                            List<Map> weights_sync_prods = [];
                            weights_sync_prods.add(get.toJson(get));

                            //todo bredding reproduction id
                            Breeding_reproduction_id reporoduc =
                                repod[math.Random().nextInt(repod.length)];
                            List<Map> weights_sync_reprodu = [];
                            weights_sync_reprodu
                                .add(reporoduc.toJson(reporoduc));

                            //todo bredding reproduction with milking id
                            Breeding_reproduction_id milk = milk_prod[
                                math.Random().nextInt(milk_prod.length)];
                            List<Map> weights_sync_milkprodu = [];
                            weights_sync_milkprodu.add(milk.toJson(milk));

                            //todo animal details id
                            Animal_Details_id rnd = animalDetails[
                                math.Random().nextInt(animalDetails.length)];
                            List<Map> weights_sync_datas1 = [];
                            weights_sync_datas1.add(rnd.toJson(rnd));

                            SyncDB.insert_table(weights_sync_datas1,
                                Constants.Animal_Details_id);
                            final connectivityResult =
                            await (Connectivity().checkConnectivity());
                            if (connectivityResult == ConnectivityResult.mobile ||
                                connectivityResult == ConnectivityResult.wifi)

                            {
                            var res = await ApiCalling.createPost(
                                AppUrl().Animal_Save,
                                "Bearer ${Constants_Usermast.token}", Online_Animal);

                            var decodedData = jsonDecode(res.body);

                            var lastUpdatedByUser =
                                decodedData['data']['lastUpdatedByUser'];

                            if (res.statusCode == 200) {
                              if (FirstSelected == "Milking") {

                                await SyncDB.insert_table(
                                    weights_sync_milkprodu,
                                    Constants.Breeding_reproduction_id);
                              }
                              if (FirstSelected == "Dry") {
                                await SyncDB.insert_table(
                                    weights_sync_milkprodu,
                                    Constants.Breeding_reproduction_id);
                              }
                              if (FiveSelected == "Pregnant") {
                                await SyncDB.insert_table(weights_sync_reprodu,
                                    Constants.Breeding_reproduction_id);
                              }
                              if (FiveSelected == "A.I") {
                                await SyncDB.insert_table(weights_sync_reprodu,
                                    Constants.Breeding_reproduction_id);
                              }
                              if (FirstSelected == "None" &&
                                  FiveSelected == "None") {
                                Sync_Api.refreh(widget.tag.toString());
                              }

                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return Api_Dailog1(
                                    rescode:res.statusCode.toString(),
                                    code:decodedData['data']['lastUpdatedByUser'].toString(),
                                    tag:widget.tag!,
                                    farmer:widget.Farmercode!,
                                    farmername:widget.owner_name!,
                                    society:widget.socity!,
                                    societyname:widget.socity_name!,
                                    name:"Animal Registration",
                                    path:widget.pagename!=null?widget.pagename:"Activity",
                                    visitmodel: widget.visitmodel,
                                    visitcode:widget.visitid);
                              }));
                            } else {}}
                            else{
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                return AlertDialog(
                                  content: const Text(
                                      "You are offline, if this animal is already register then it is delete automatic from local"),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Con_Wid.MainButton(
                                            OnTap: () {
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return DashBoardScreen();
                                                    },
                                                  ));
                                            },
                                            pStrBtnName: "Cancel",
                                            height: 40,
                                            width: 80,
                                            fontSize: 16),
                                        Con_Wid.MainButton(
                                            OnTap: () async {
                                              Animal_Registration Animal = Insert_animal[
                                              math.Random().nextInt(Insert_animal.length)];
                                              List<Map> weights_sync_datas3 = [];
                                              weights_sync_datas3.add(Animal.toJson(Animal));

                                              SyncDB.insert_table(weights_sync_datas3, Constants.Tbl_Animal_Registration);

                                              if (FirstSelected == "Milking") {
                                                await SyncDB.insert_table(
                                                    weights_sync_milkprodu,
                                                    Constants.Breeding_reproduction_id);
                                              }
                                              if (FirstSelected == "Dry") {
                                                await SyncDB.insert_table(
                                                    weights_sync_milkprodu,
                                                    Constants.Breeding_reproduction_id);
                                              }
                                              if (FiveSelected == "Pregnant") {
                                                await SyncDB.insert_table(weights_sync_reprodu,
                                                    Constants.Breeding_reproduction_id);
                                              }
                                              if (FiveSelected == "A.I") {
                                                await SyncDB.insert_table(weights_sync_reprodu,
                                                    Constants.Breeding_reproduction_id);
                                              }
                                              if (FirstSelected == "None" &&
                                                  FiveSelected == "None") {
                                                Sync_Api.refreh(widget.tag.toString());
                                              }

                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                                return DashBoardScreen();
                                              },));
                                            },
                                            pStrBtnName: "Ok",
                                            height: 40,
                                            width: 80,
                                            fontSize: 16)
                                      ],
                                    )
                                  ],
                                );
                              });
                            }
                          },
                          pStrBtnName: "Save",
                          height: 40,
                          width: 80,
                          fontSize: 16),
                    ],
                  ),
                  Con_Wid.height(5)
                ],
              ),
            ),
          );
        },
      );
    }
  }

  int? parseIntIfZeroSendNull(value) {
    if (value != 'null' &&
        value != '' &&
        value != '0' &&
        value != 0 &&
        value != null) {
      return int.parse(value);
    } else {
      return null;
    }
  }

  AllDate(String cattle, String breeding) {
    if (SecondSelected == "Days in milk") {
      RCalvingdate =
          DateTime.now().subtract(Duration(days: int.parse(cattle))).toString();
      RHeatdate = DateTime.parse(RCalvingdate.toString())
          .subtract(Duration(days: 300))
          .toString();
      RPDdate = DateTime.parse(RHeatdate).add(Duration(days: 90)).toString();
      RDrydate = "";
    }
    if (SecondSelected == "Last Calving Date") {
      RCalvingdate = cattle;
      RHeatdate = DateTime.parse(RCalvingdate.toString())
          .subtract(Duration(days: 300))
          .toString();
      RPDdate = DateTime.parse(RHeatdate).add(Duration(days: 90)).toString();
      RDrydate = "";
    }
    if (SecondSelected == "Dry Days") {
      RDrydate =
          DateTime.now().subtract(Duration(days: int.parse(cattle))).toString();
      RCalvingdate = DateTime.parse(RDrydate.toString())
          .subtract(Duration(days: 300))
          .toString();
      RHeatdate = DateTime.parse(RCalvingdate.toString())
          .subtract(Duration(days: 300))
          .toString();
      RPDdate = DateTime.parse(RHeatdate).add(Duration(days: 90)).toString();
    }
    if (SecondSelected == "Last Dry Date") {
      RDrydate = cattle;
      RCalvingdate = DateTime.parse(RDrydate.toString())
          .subtract(Duration(days: 300))
          .toString();
      RHeatdate = DateTime.parse(RDrydate.toString())
          .subtract(Duration(days: 300))
          .toString();
      RPDdate = DateTime.parse(RHeatdate).add(Duration(days: 90)).toString();
    }
    if (SixSelected == "Pregnant Days") {
      RPDdate1 = DateTime.now()
          .subtract(Duration(days: int.parse(breeding)))
          .toString();
      RCalvingdate1 = "";
      RHeatdate1 = DateTime.parse(RPDdate1.toString())
          .subtract(Duration(days: 90))
          .toString();
      RDrydate1 = "";
      pregnantday = breeding;
    }
    if (SixSelected == "Pregnant Date") {
      RPDdate1 = breeding;
      RDrydate1 = "";
      RCalvingdate1 = "";
      RHeatdate1 = DateTime.parse(RPDdate1.toString())
          .subtract(Duration(days: 90))
          .toString();
      pregnantday = DateTime.now()
          .difference(DateTime.parse(breeding.toString()))
          .inDays
          .toString();
    }
    if (SixSelected == "A.I Days") {
      RHeatdate1 = DateTime.now()
          .subtract(Duration(days: int.parse(breeding)))
          .toString();
      RPDdate1 = "";
      RDrydate1 = "";
      RCalvingdate1 = "";
    }
    if (SixSelected == "A.I Date") {
      RHeatdate1 = breeding;
      RPDdate1 = "";
      RDrydate1 = "";
      RCalvingdate1 = "";
    }
  }
}
