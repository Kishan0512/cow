import 'dart:io';
import 'dart:math';
import 'dart:math' as math;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herdmannew/UiScreens/Dashboard/Breeding.dart';
import 'package:herdmannew/UiScreens/Dashboard/Dashboard.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_NetworkHelp.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/model/Animal_Details_id.dart';
import 'package:herdmannew/model/Animal_registration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../component/DataBaseHelper/Con_List.dart';
import '../../component/DataBaseHelper/Sync_Database.dart';
import '../../component/DataBaseHelper/Sync_Json.dart';
import '../../component/Gobal_Widgets/Con_Icons.dart';
import '../../component/Gobal_Widgets/Constants.dart';
import '../../model/Visit_Registration.dart';

class New_Cattle extends StatefulWidget {
  String? manualentry;
  String? name;
  String? id;
  Visit_Registration? visitmodel;
  New_Cattle({this.manualentry,this.name,this.id,this.visitmodel});

  @override
  State<New_Cattle> createState() => _New_CattleState();
}

class _New_CattleState extends State<New_Cattle> {
  final ImagePicker picker = ImagePicker();
  int LOT = 0, FARMER = 0, SPECIES = 0, BREED = 0;
  bool Selected = false,
      Erout = false,
      Esociety = false,
      Efarmer = false,
      Ebreed = false;
  List<String> mSelectfarmer = [],
      mSelectsocity = [],
      mSelectroute = [],
      mSelectbreed = [],
      mSelectspecies = [],
      mSelectsex = [],
      sex = ["Male", "Female"];
  List BreedCOnt=['MEHSANA',
    'BANNI',
    'Murrah',
    'HF Cross',
    'HF',
    'HF x Kankrej',
    'Gir',
    'Kankrej',
    'HF IMP'];
  String lat = '',
      long = '',
      base64Image = '',
      Zone = "",
      total_age_days = "0",
      year_sum = "0",
      month_sum = "0",
      selecteSpecies = "",
      date = "Age",
      picimage = "",
      A_sex = "",
      A_farmer = "",
      A_socoety = "",
      A_rout = "",
      A_breed = "",
      A_species = "Cow",
      A_calf_sex = "Male",
      dob_value = "",
      animal_sex = "",
      status = "",
      date_value = "",
      animal_sex_flag = "",
      routecode = "",
      managestaff = "",
      extensionstaff = "",
      Societycode = "",
      farmerid = "",
      speciescode = "",
      breedcode = "",
      farmercode = "",
      lotcod = "",
      mStrFromdate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  TextEditingController Animalname = TextEditingController(),
      year = TextEditingController(),
      month = TextEditingController(),
      bod = TextEditingController();
  List image = [
    "assets/images/blur_milking_cow.webp",
    "assets/images/blur_heifer.webp",
    "assets/images/blur_calf.webp",
    "assets/images/blur_bull.webp"
  ];
  List Selectedimage = [
    "assets/images/milking_cow.webp",
    "assets/images/heifer.webp",
    "assets/images/calf.webp",
    "assets/images/bull.webp"
  ];
  List text = ["Adult", "Heifer", "Calf", "Bull"];
  int? selection;
  String select = "Adult";

  getdata() {
    if (Con_List.M_Userlots.isEmpty ||
        Con_List.M_species.isEmpty ||
        Con_List.M_Farmer.isEmpty ||
        Con_List.M_breed.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_lot);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_species);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_breed);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_farmer);
    }
    if(widget.visitmodel != null)
      {
        mSelectroute.add(Con_List.M_Userherds.where((element) => element.id.toString() == widget.visitmodel!.herd.toString()).first.code);
        mSelectroute = ["${mSelectroute[0].toString()}-${widget.visitmodel!.herdName.toString()}"];
        setState(() {
          A_rout = mSelectroute[0].toString();
          Con_List.M_Userherds.where(
                  (e) => e.code == A_rout.split('-').first).forEach((e1) {
            routecode = e1.id.toString();
            managestaff = e1.managerStaff.toString();
            extensionstaff = e1.extensionOfficerStaff.toString();
            Zone = e1.zone.toString();
          });
        });
        mSelectsocity.add(Con_List.M_Userlots.where((element) => element.id.toString() == widget.visitmodel!.lotID.toString()).first.code);
        mSelectsocity = ["${mSelectsocity[0].toString()}-${widget.visitmodel!.lotname.toString()}"];
        setState(() {
          A_socoety = mSelectsocity[0].toString();
          Con_List.M_Userlots.where(
                  (e) => e.code == A_socoety.split('-').first)
              .forEach((e1) {
            Societycode = e1.id.toString();
            lotcod = e1.code.toString();
          });
        });
        mSelectfarmer.add(Con_List.M_Farmer.where((element) => element.id.toString() == widget.visitmodel!.farmerid.toString()).first.code);
        mSelectfarmer = ["${mSelectfarmer[0].toString()}-${widget.visitmodel!.farmerName.toString()}"];
        setState(() {
          A_farmer = mSelectfarmer[0].toString();
          farmerid = widget.visitmodel!.farmerid.toString();
          farmercode = widget.visitmodel!.farmerCode.toString();
        });
        if(widget.visitmodel!.species.toString() == "1")
          {
            A_species = "Cow";
          }else{
          A_species = "Buffalo";
        }
      }
    setState(() {});
  }

  getList() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    lat = position.latitude.toString();
    long = position.longitude.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mSelectspecies.add("Cow");
    select = text[0];
    selection = 0;
    getdata();
    getList();
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
                return DashBoardScreen();
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Con_Wid.gText("Cattle Registration"),
          backgroundColor: ConClrSelected,
          leading: IconButton(
              splashRadius: 18,
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return DashBoardScreen();
                  },
                ));
              },
              icon: Own_ArrowBack),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: 800,
          color: Colors.white,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  color: ConClrSelected,
                  height: 132,
                  child: Baseline(
                    baseline: 30,
                    baselineType: TextBaseline.alphabetic,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Con_Wid.paddingWithText(
                                "Animal ID : ${widget.manualentry}",
                                Colors.white,
                                context: context),
                          ],
                        ),
                        Flexible(
                            child: Card(
                          color: Colors.white,
                          margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                          child: Container(
                              height: 100,
                              child: Center(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        selection = index;
                                        select = text[index];
                                        setState(() {});
                                      },
                                      child: Stack(children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(children: [
                                            Expanded(
                                              child: index == selection
                                                  ? Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Image.asset(
                                                        "${Selectedimage[index]}",
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )
                                                  : Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                      ),
                                                      child: Image.asset(
                                                          "${Selectedimage[index]}"),
                                                    ),
                                            ),
                                            index == selection
                                                ? Text("${text[index]}")
                                                : Text(
                                                    "${text[index]}",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                          ]),
                                        ),
                                        index == selection
                                            ? Row(
                                                children: [
                                                  Con_Wid.width(50),
                                                  Container(
                                                    width: 16,
                                                    height: 16,
                                                    child: Baseline(
                                                      baseline: 25,
                                                      baselineType: TextBaseline
                                                          .alphabetic,
                                                      child: Image.asset(
                                                          "assets/images/accept.webp"),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Positioned(child: Container()),
                                      ]),
                                    );
                                  },
                                ),
                              )),
                        )),
                      ],
                    ),
                  )),
              Con_Wid.height(10),
              Con_Wid.height(10),
              CondropDown(
                Error: Erout,
                color1: ConsfontBlackColor,
                title: 'Select Route',
                itemList: Con_List.M_Userherds.map((e) => "${e.code}-${e.Name}")
                    .toList(),
                SelectedList: mSelectroute,
                onSelected: (List<String> value) {
                  mSelectsocity.clear();
                  setState(() {
                    mSelectroute = value;
                    A_rout = value[0].toString();
                    Con_List.M_Userherds.where(
                        (e) => e.code == A_rout.split('-').first).forEach((e) {
                      routecode = e.id.toString();
                      managestaff = e.managerStaff.toString();
                      extensionstaff = e.extensionOfficerStaff.toString();
                      Zone = e.zone.toString();
                    });
                  });
                },
              ),
              CondropDown(
                Error: Esociety,
                color1: ConsfontBlackColor,
                title: 'Select Society',
                itemList: Con_List.M_Userlots.where((e) =>
                        e.herd.toString() == (routecode != "" ? routecode : ""))
                    .map((e) => "${e.code}-${e.name}")
                    .toList(),
                SelectedList: mSelectsocity,
                onSelected: (List<String> value) {
                  mSelectfarmer.clear();
                  setState(() {
                    mSelectsocity = value;
                    A_socoety = value[0].toString();
                    Con_List.M_Userlots.where(
                            (e) => e.code == A_socoety.split('-').first)
                        .forEach((e) {
                      Societycode = e.id.toString();
                      lotcod = e.code.toString();
                    });
                  });
                },
              ),
              CondropDown(
                Error: Efarmer,
                color1: ConsfontBlackColor,
                title: 'Select Farmer',
                itemList: Con_List.M_Farmer.where((e) =>
                        e.lot.toString() ==
                        (Societycode != "" ? Societycode : ""))
                    .map((e) => "${e.code}-${e.name}")
                    .toList()
                  ..sort((a, b) =>
                      a.split('-').first.compareTo(b.split('-').first)),
                SelectedList: mSelectfarmer,
                onSelected: (List<String> value) {
                  setState(() {
                    mSelectfarmer = value;
                    A_farmer = value[0].toString();
                    Con_List.M_Farmer.where(
                        (e) => "${e.code}-${e.name}" == A_farmer).forEach((e) {
                      farmerid = e.id.toString();
                      farmercode = e.code.toString();
                    });
                  });
                },
              ),
              Con_Wid.height(5),
              Container(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: "Cow",
                      groupValue: A_species,
                      onChanged: (value) {
                        setState(() {
                          A_species = value.toString();
                        });
                      },
                    ),
                    Con_Wid.gText('Cow'),
                    SizedBox(width: 10),
                    Radio(
                      value: "Buffalo",
                      groupValue: A_species,
                      onChanged: (value) {
                        setState(() {
                          A_species = value.toString();
                        });
                      },
                    ),
                    Con_Wid.gText('Buffalo'),
                  ],
                ),
              ),
              CondropDown(
                Error: Ebreed,
                color1: ConsfontBlackColor,
                title: 'Select Breed',
                itemList: Constants_Usermast.user_name.toLowerCase().startsWith("dsd") ? Con_List.M_breed.where(
                        (e) => e.species == (A_species == "Cow" ? 1 : 2) && BreedCOnt.any((element) => element.toString().toLowerCase()==e.name.toString().toLowerCase()))
                    .map((e) => "${e.name}")
                    .toList():Con_List.M_breed.where(
                        (e) => e.species == (A_species == "Cow" ? 1 : 2))
                    .map((e) => "${e.name}")
                    .toList(),
                SelectedList: mSelectbreed,
                onSelected: (List<String> value) {
                  setState(() {
                    mSelectbreed = value;
                    A_breed = value[0].toString();
                  });
                },
              ),
              select == "Calf"
                  ? Container(
                      height: 20,
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: "Male",
                            groupValue: A_calf_sex,
                            onChanged: (value) {
                              setState(() {
                                A_calf_sex = value.toString();
                              });
                            },
                          ),
                          Con_Wid.gText('Male'),
                          SizedBox(width: 10),
                          Radio(
                            value: "Female",
                            groupValue: A_calf_sex,
                            onChanged: (value) {
                              setState(() {
                                A_calf_sex = value.toString();
                              });
                            },
                          ),
                          Con_Wid.gText('Female'),
                        ],
                      ),
                    )
                  : Container(),
              Con_Wid.height(5),
              Con_Wid.textFieldWithInter(
                text: "Animal Name",
                controller: Animalname,
                hintText: "Enter Animal Name",
                color1: ConsfontBlackColor,
              ),
              Con_Wid.height(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      Selected = false;
                      date = "Age";
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Selected ? Colors.white : ConClrSelected,
                          border: Border.all(
                              color: Selected ? ConClrSelected : Colors.white,
                              width: 1)),
                      height: 37,
                      width: 130,
                      child:
                        Con_Wid.gText("Age",style: TextStyle(
                        color: Selected ? ConClrSelected : Colors.white),),


                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Selected = true;
                      date = "";
                      mStrFromdate = await Con_Wid.GlbDatePicker(
                          pcontext: context, formate: "yyyy-mm-dd");
                      bod.text = mStrFromdate;
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Selected ? ConClrSelected : Colors.white,
                          border: Border.all(
                              color: Selected ? Colors.white : ConClrSelected,
                              width: 1)),
                      height: 37,
                      width: 130,
                      child: Con_Wid.gText("Birth Date",style: TextStyle(
                          color: !Selected ? ConClrSelected : Colors.white),),
                    ),
                  )
                ],
              ),

              Con_Wid.height(5),
              date == "Age"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                          Con_Wid.textFieldWithInter(
                              color1: ConsfontBlackColor,
                              TextInput_Type: TextInputType.number,
                              Onchanged: (value1) {
                                if (value1.toString().trim() != "") {
                                  int _val = int.parse(value1.toString());
                                  if (_val <= 30) {
                                    var sum =
                                        int.parse(value1.toString()) * 365;
                                    year_sum = sum.toString();
                                    sum = sum + int.parse(month_sum);
                                    total_age_days = sum.toString();
                                    if (select == 'Calf') {
                                      if (int.parse(total_age_days) > 210) {
                                        Con_Wid.Con_Show_Toast(context,
                                            "Age should less than 210 days");
                                        year.clear();
                                        setState(() {
                                          value1 = "0";
                                          year_sum = "0";
                                          month_sum = "0";
                                          sum = 0;
                                        });
                                      }
                                    } else if (select == 'Heifer') {
                                      if (int.parse(total_age_days) < 210) {
                                        Con_Wid.Con_Show_Toast(context,
                                            "Age should greater than 210 days");
                                        year.clear();
                                        setState(() {
                                          value1 = "0";
                                          year_sum = "0";
                                          month_sum = "0";
                                          sum = 0;
                                        });
                                      }
                                    }
                                  } else {
                                    year.clear();
                                  }
                                }
                              },
                              width: MediaQuery.of(context).size.width / 2.5,
                              controller: year,
                              hintText: "Year"),
                          Con_Wid.textFieldWithInter(
                              color1: ConsfontBlackColor,
                              Onchanged: (value1) {
                                if (value1.toString().trim() != "") {
                                  int _val = int.parse(value1.toString());
                                  if (_val >= 1) {
                                    var sum = int.parse(value1.toString()) * 30;
                                    year_sum = sum.toString();
                                    sum = sum + int.parse(month_sum);
                                    total_age_days = sum.toString();
                                    if (select == 'Calf') {
                                      if (int.parse(total_age_days) > 210) {
                                        Con_Wid.Con_Show_Toast(context,
                                            "Age should less than 210 days");
                                        year.clear();
                                        setState(() {
                                          value1 = "0";
                                          year_sum = "0";
                                          month_sum = "0";
                                          sum = 0;
                                        });
                                      }
                                    }
                                  } else {
                                    month.text = '';
                                  }
                                }
                              },
                              TextInput_Type: TextInputType.number,
                              width: MediaQuery.of(context).size.width / 2.5,
                              controller: month,
                              hintText: "Month"),
                        ])
                  : Con_Wid.textFieldWithInter(
                      color1: ConsfontBlackColor,
                      width: MediaQuery.of(context).size.width / 2.5,
                      controller: bod,
                      hintText: "Date Of Birth"),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Con_Wid.width(25),
                  Con_Wid.height(10),
                  InkWell(
                    onTap: () async {
                      XFile? image;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: SizedBox(
                              height: 240,
                              child: Column(children: [
                                Container(
                                    height: 60,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                      colors: ConClrAppbarGreadiant,
                                    )),
                                    child: Stack(
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
                                              "Filter",
                                              fontwhiteColor,
                                              FontWeight.w600,
                                              15,
                                              context),
                                        )
                                      ],
                                    )),
                                Con_Wid.height(10),
                                TextButton(
                                    onPressed: () async {
                                      image = await picker.pickImage(
                                          source: ImageSource.camera);
                                      picimage = image!.path;
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Con_Wid.gText(
                                      "Take a picture",
                                      style: TextStyle(fontSize: 16),
                                    )),
                                Con_Wid.height(10),
                                TextButton(
                                    onPressed: () async {
                                      image = await picker.pickImage(
                                          source: ImageSource.gallery);
                                      picimage = image!.path;
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Text("select from gallery",
                                        style: TextStyle(fontSize: 16)))
                              ]),
                            ),
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ConClrSelected,
                        ),
                        height: 36,
                        width: 130,
                        child: Con_Wid.gText(
                          "Choose Image",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              picimage == ""
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 200,
                            width: 100,
                            child: Image.file(File("${picimage}"))),
                      ],
                    ),
              Con_Wid.height(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      if (A_breed != "") {
                        Con_List.M_breed.forEach((element) {
                          if (element.name == A_breed.split("-").last) {
                            breedcode = element.id.toString();
                          }
                        });
                      }
                      if (A_species != "") {
                        Con_List.M_species.forEach((element) {
                          if (element.name == A_species.split("-").last) {
                            speciescode = element.id.toString();
                          }
                        });
                      }

                      if (year.text.isEmpty &&
                          month.text.isEmpty &&
                          bod.text.isEmpty) {
                        Con_Wid.Con_Show_Toast(context, "Please enter age");
                      } else if (select == "") {
                        Con_Wid.Con_Show_Toast(
                            context, "Please Select Cattle Type");
                      } else if (A_rout == "") {
                        setState(() {
                          Erout = true;
                        });
                      } else if (A_socoety == "") {
                        setState(() {
                          Esociety = true;
                        });
                      } else if (A_farmer == "") {
                        setState(() {
                          Efarmer = true;
                        });
                      } else if (A_breed == "") {
                        setState(() {
                          Ebreed = true;
                        });
                      } else {
                        var now = new DateTime.now();
                        var age_formater = DateFormat('yyyy-MM-dd');
                        String age_val = now.toString();
                        if (select == "Adult" || select == 'Heifer') {
                          animal_sex_flag = '2';
                          if (date == 'Age') {
                            int YEAR = 0;
                            int MON = 0;
                            if (year.text != "0" && year.text != "") {
                              YEAR = (int.parse(year.text) * 365);
                            }
                            if (month.text != "0" && month.text != "") {
                              MON = int.parse(month.text.toString()) * 30;
                            }
                            var value = YEAR + MON;
                            date_value = DateTime.now()
                                .subtract(Duration(days: value))
                                .toString();
                          }
                          if (date == "") {
                            date_value = bod.text;
                            DateTime Today = new DateTime.now();
                            var diff_val =
                                Today.difference(DateTime.parse(bod.text))
                                    .inDays;

                            var ages = int.parse(diff_val.toString()) / 365;
                            int decimals = 1;
                            num fac = pow(10, decimals);
                            ages = (ages * fac).round() / fac;
                            var agess =
                                ages.toString().split(new RegExp(r"[.]"));
                            int month_age = int.parse(agess[1]);
                            month_age = month_age + 1;
                            year.text = agess[0].toString();
                            month.text = month_age.toString();
                          } else {
                            // date_value = '';
                          }
                          String AGE =
                              "${(year.text != "" ? year.text + " Years " : "") + (month.text != "" ? month.text + " months" : "")}";

                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Bredding_details(
                                tag: widget.manualentry,
                                route: routecode.toString(),
                                socity: Societycode.toString(),
                                owner: farmerid.toString(),
                                pagename: widget.name,
                                visitmodel: widget.visitmodel,
                                visitid: widget.id,
                                species: speciescode.toString(),
                                breed: breedcode.toString(),
                                name: Animalname.text,
                                age: AGE,
                                select_cattle: select,
                                owner_name: A_farmer.toString(),
                                socity_name: A_socoety.toString(),
                                breed_name: A_breed.toString(),
                                photo: picimage,
                                age_view: year.text +
                                    " Years " +
                                    month.text +
                                    " months",
                                zone: Zone,
                                managerStaff: managestaff,
                                extensionOfficerStaff: extensionstaff,
                                route_name: A_rout.toString(),
                                reg_date: DateTime.now.toString(),
                                dob: date_value,
                                sex_flag: animal_sex_flag,
                                species_name: A_species.toString(),
                                Farmercode: farmercode,
                                Lotcode: lotcod,
                              );
                            },
                          ));
                        } else {
                          if (select == 'Calf') {
                            animal_sex = A_calf_sex.toString();
                            status = "7";
                          } else if (select == 'Bull') {
                            status = "9";
                          }
                          if (animal_sex == 'Male') {
                            animal_sex_flag = '1';
                          } else {
                            animal_sex_flag = '2';
                          }
                          if (date == 'Age') {
                            dob_value = bod.text;
                            DateTime Today = new DateTime.now();
                            DateTime Last_days = Today.subtract(
                                new Duration(days: int.parse(total_age_days)));
                            var formatter = new DateFormat('yyyy-MM-dd');
                            String formatted = formatter.format(Last_days);
                            date_value = formatted;
                          }
                          if (date == "") {
                            date_value = bod.text;
                            DateTime Today = new DateTime.now();
                            var diff_val =
                                Today.difference(DateTime.parse(bod.text))
                                    .inDays;
                            var ages = int.parse(diff_val.toString()) / 365;
                            int decimals = 1;
                            num fac = pow(10, decimals);
                            ages = (ages * fac).round() / fac;
                            var agess =
                                ages.toString().split(new RegExp(r"[.]"));
                            int month_age = int.parse(agess[1]);
                            month_age = month_age + 1;
                            year.text = agess[0].toString();
                            month.text = month_age.toString();
                          } else {}
                          String AGE =
                              "${(year.text != "" ? year.text + " Years " : "") + (month.text != "" ? month.text + " months" : "")}";
                          List<Map<String, String>> Details = [
                            {
                              "Name": "Tag Number",
                              "value": "${widget.manualentry}"
                            },
                            {"Name": "Type of cattle", "value": "$select"},
                            {"Name": "Route", "value": "${A_rout.toString()}"},
                            {
                              "Name": "Socity",
                              "value": "${A_socoety.toString()}"
                            },
                            {
                              "Name": "Farmer",
                              "value": "${A_farmer.toString()}"
                            },
                            {
                              "Name": "Species",
                              "value": "${A_species.toString()}"
                            },
                            {"Name": "Breed", "value": "${A_breed.toString()}"},
                            {"Name": "Name", "value": "${Animalname.text}"},
                            {
                              "Name": "Age",
                              "value":
                                  "${(year.text != "" ? year.text + " Years " : "") + (month.text != "" ? month.text + " months" : "")}"
                            },
                            {"Name": "Birth Date", "value": "$date_value"},
                          ];
                          final connectivityResult =
                              await (Connectivity().checkConnectivity());
                          if (connectivityResult == ConnectivityResult.mobile ||
                              connectivityResult == ConnectivityResult.wifi) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    height: MediaQuery.of(context).size.height -
                                        260,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: ConClrMainLight),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: ConClrDialog,
                                          ),
                                          child: Stack(children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
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
                                                  fontwhiteColor,
                                                  context: context),
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
                                                  visualDensity:
                                                      const VisualDensity(
                                                          horizontal:
                                                              VisualDensity
                                                                  .minimumDensity,
                                                          vertical: VisualDensity
                                                              .minimumDensity),
                                                  title: Text(
                                                      "${Details[index]['Name']}"),
                                                  trailing: Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      width: 120,
                                                      child: Text(
                                                          "${Details[index]['value']}")),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Con_Wid.height(5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
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
                                                OnTap: () {
                                                  int age_value = int.parse(
                                                              year.text != ""
                                                                  ? year.text
                                                                  : "0") *
                                                          365 +
                                                      int.parse(month.text != ""
                                                              ? month.text
                                                              : "0") *
                                                          30;

                                                  List<Animal_Details_id>
                                                      animalDetails = [
                                                    Animal_Details_id(
                                                        tagId:
                                                            "${widget.manualentry}",
                                                        code: null,
                                                        name:
                                                            "${Animalname.text}",
                                                        dOB: "$date_value",
                                                        age: age_value,
                                                        birthWeight: null,
                                                        salvageFlag: null,
                                                        parity: 1,
                                                        aITagNo:
                                                            "${widget.manualentry}",
                                                        currentParity: null,
                                                        registrationDate:
                                                            "${DateTime.now().toString()}",
                                                        transactionDate: null,
                                                        breedingStatus: null,
                                                        heatDate: null,
                                                        heatSeq: null,
                                                        abortionSeq: null,
                                                        pDDate: null,
                                                        calvingDate: null,
                                                        dryDate: null,
                                                        milkDate: null,
                                                        lastMilk: null,
                                                        totalMilk: null,
                                                        selectFlag: null,
                                                        selectRemarks: null,
                                                        farmerCode: farmercode,
                                                        lotcode: lotcod,
                                                        selectColor: null,
                                                        disposalRemarks: null,
                                                        isSuspended: null,
                                                        syncStatus: "0",
                                                        lat: null,
                                                        long: null,
                                                        species: speciescode,
                                                        breed: breedcode,
                                                        herd: routecode,
                                                        lot: Societycode,
                                                        farmer: farmerid,
                                                        status: select,
                                                        pd1: null,
                                                        pd2: null,
                                                        sexFlg:
                                                            "${int.parse(animal_sex_flag)}",
                                                        zone: null,
                                                        disposalFlag: null,
                                                        pBFlag: null,
                                                        virtualLot: null,
                                                        farmername: A_farmer,
                                                        id: null,
                                                        lotname: A_socoety,
                                                        herdname: A_rout,
                                                        speciesname: A_species,
                                                        statusname: select,
                                                        breedname: A_breed,
                                                        Syncstatus: "0")
                                                  ];
                                                  Map Insert_animal = {
                                                    "tagId":
                                                        "${widget.manualentry}",
                                                    "code": null,
                                                    "name":
                                                        "${Animalname.text}",
                                                    "inputDate": "2023/04/11",
                                                    "birthWeight": "45",
                                                    "sensorNo": "3",
                                                    "photo": null,
                                                    "parity": "",
                                                    "registrationDate":
                                                        DateFormat('yyyy/MM/dd')
                                                            .format(
                                                                DateTime.now()),
                                                    "marketValue": "",
                                                    "staff": "348103",
                                                    "lat": lat,
                                                    "long": long,
                                                    "species":
                                                        "${speciescode.toString()}",
                                                    "breed":
                                                        "${breedcode.toString()}",
                                                    "herd": "${routecode}",
                                                    "lot": "${Societycode}",
                                                    "farmer": "${farmercode}",
                                                    "lastSire": null,
                                                    "sire": null,
                                                    "dam": null,
                                                    "paternalSire": null,
                                                    "paternalDam": null,
                                                    "sexFlg":
                                                        "${animal_sex_flag}",
                                                    "zone": "${Zone}",
                                                    "createdAt": DateFormat(
                                                            'yyyy/MM/dd')
                                                        .format(DateTime.now()),
                                                    "updatedAt": null
                                                  };
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "Do You Want To Save The Data?"),
                                                        actions: [
                                                          Con_Wid.MainButton(
                                                              Rounded: false,
                                                              OnTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              pStrBtnName: "No",
                                                              height: 40,
                                                              width: 80,
                                                              fontSize: 16),
                                                          Con_Wid.MainButton(
                                                              OnTap: () async {
                                                                Animal_Details_id
                                                                    rnd =
                                                                    animalDetails[math
                                                                            .Random()
                                                                        .nextInt(
                                                                            animalDetails.length)];
                                                                List<Map>
                                                                    weights_sync_datas1 =
                                                                    [];
                                                                weights_sync_datas1
                                                                    .add(rnd
                                                                        .toJson(
                                                                            rnd));
                                                                SyncDB.insert_table(
                                                                    weights_sync_datas1,
                                                                    Constants
                                                                        .Animal_Details_id);
                                                                var res = await ApiCalling.createPost(
                                                                    AppUrl()
                                                                        .Animal_Save,
                                                                    "Bearer ${Constants_Usermast.token}",
                                                                    Insert_animal);

                                                                if (res.statusCode ==
                                                                    200) {}
                                                                Con_Wid.Con_Show_Toast(
                                                                    context,
                                                                    "Data Saved successfuly");
                                                                Navigator
                                                                    .pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    return DashBoardScreen();
                                                                  },
                                                                ));
                                                              },
                                                              pStrBtnName:
                                                                  "Yes",
                                                              height: 40,
                                                              width: 80,
                                                              fontSize: 16),
                                                        ],
                                                      );
                                                    },
                                                  );
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
                          } else {
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
                                            OnTap: () {
                                              int age_value = int.parse(
                                                          year.text != ""
                                                              ? year.text
                                                              : "0") *
                                                      365 +
                                                  int.parse(month.text != ""
                                                          ? month.text
                                                          : "0") *
                                                      30;
                                              List<Animal_Details_id>
                                                  animalDetails = [
                                                Animal_Details_id(
                                                    tagId:
                                                        "${widget.manualentry}",
                                                    code: null,
                                                    name: "${Animalname.text}",
                                                    dOB: "$date_value",
                                                    age: age_value,
                                                    birthWeight: null,
                                                    salvageFlag: null,
                                                    parity: 1,
                                                    aITagNo:
                                                        "${widget.manualentry}",
                                                    currentParity: null,
                                                    registrationDate:
                                                        "${DateTime.now().toString()}",
                                                    transactionDate: null,
                                                    breedingStatus: null,
                                                    heatDate: null,
                                                    heatSeq: null,
                                                    abortionSeq: null,
                                                    pDDate: null,
                                                    calvingDate: null,
                                                    dryDate: null,
                                                    milkDate: null,
                                                    lastMilk: null,
                                                    totalMilk: null,
                                                    selectFlag: null,
                                                    selectRemarks: null,
                                                    farmerCode: farmercode,
                                                    lotcode: lotcod,
                                                    selectColor: null,
                                                    disposalRemarks: null,
                                                    isSuspended: null,
                                                    syncStatus: "0",
                                                    lat: null,
                                                    long: null,
                                                    species: speciescode,
                                                    breed: breedcode,
                                                    herd: routecode,
                                                    lot: Societycode,
                                                    farmer: farmerid,
                                                    status: select,
                                                    pd1: null,
                                                    pd2: null,
                                                    sexFlg:
                                                        "${int.parse(animal_sex_flag)}",
                                                    zone: null,
                                                    disposalFlag: null,
                                                    pBFlag: null,
                                                    virtualLot: null,
                                                    farmername: A_farmer,
                                                    id: null,
                                                    lotname: A_socoety,
                                                    herdname: A_rout,
                                                    speciesname: A_species,
                                                    statusname: select,
                                                    breedname: A_breed,
                                                    Syncstatus: "0")
                                              ];
                                              List<Animal_Registration>
                                                  Insert_animal = [
                                                Animal_Registration(
                                                    tagId:
                                                        "${widget.manualentry}",
                                                    code: null,
                                                    name: "${Animalname.text}",
                                                    inputDate: DateFormat(
                                                        'yyyy/MM/dd')
                                                        .format(DateTime.now()),
                                                    birthWeight: "45",
                                                    sensorNo: "3",
                                                    photo: null,
                                                    parity: "",
                                                    registrationDate:
                                                        DateFormat('yyyy/MM/dd')
                                                            .format(
                                                                DateTime.now()),
                                                    marketValue: "",
                                                    staff: "",
                                                    lat: lat,
                                                    long: long,
                                                    species:
                                                        "${speciescode.toString()}",
                                                    breed:
                                                        "${breedcode.toString()}",
                                                    herd: "${routecode}",
                                                    lot: "${Societycode}",
                                                    farmer: "${farmercode}",
                                                    lastSire: null,
                                                    sire: null,
                                                    dam: null,
                                                    paternalSire: null,
                                                    paternalDam: null,
                                                    sexFlg:
                                                        "${animal_sex_flag}",
                                                    SyncStatus: "0",
                                                    zone: "${Zone}",
                                                    createdAt: DateFormat(
                                                            'yyyy/MM/dd')
                                                        .format(DateTime.now()),
                                                    updatedAt: null)
                                              ];

                                              Animal_Details_id rnd = animalDetails[math.Random().nextInt(animalDetails.length)];
                                              List<Map> weights_sync_datas1 = [];
                                              weights_sync_datas1.add(rnd.toJson(rnd));
                                              SyncDB.insert_table(weights_sync_datas1, Constants.Animal_Details_id);

                                              Animal_Registration Animal = Insert_animal[math.Random().nextInt(Insert_animal.length)];
                                              List<Map> weights_sync_datas2 =[];
                                              weights_sync_datas2.add(Animal.toJson(Animal));
                                              SyncDB.insert_table(weights_sync_datas2, Constants.Tbl_Animal_Registration);

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
                              },
                            );
                          }
                        }
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ConClrSelected,
                      ),
                      height: 36,
                      width: 130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_right_alt_rounded,
                            size: 30,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Con_Wid.height(10)
            ]),
          ),
        ),
      ),
    );
  }
}
