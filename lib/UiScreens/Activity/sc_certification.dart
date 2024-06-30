import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/Dashboard/Dashboard.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_ApiUrl.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../component/DataBaseHelper/Con_List.dart';
import '../../component/DataBaseHelper/Sync_Database.dart';
import '../../component/DataBaseHelper/Sync_Json.dart';
import '../../component/Gobal_Widgets/Con_Icons.dart';
import '../../component/Gobal_Widgets/Con_Textstyle.dart';
import '../../component/Gobal_Widgets/Constants.dart';
import '../../model/Animal_Details_id.dart';
import '../../model/Visit_Registration.dart';
import '../DrawerScreens/VisitRegistration/VisitRegistration.dart';

class sccertification extends StatefulWidget {
  Visit_Registration visitmodel;

  sccertification({required this.visitmodel});

  @override
  State<sccertification> createState() => _sccertificationState();
}

class _sccertificationState extends State<sccertification> {
  List<int> ImageBytecode = [];
  bool Selected = false;
  bool _age_or_date_check = true;
  TextEditingController year = TextEditingController(),
      month = TextEditingController(),
      bod = TextEditingController();
  bool loadingforai = false;
  List<int> ImageBytecode1 = [];
  List<int> ImageBytecode2 = [];
  List<int> ImageBytecode3 = [];
  final ImagePicker picker = ImagePicker();
  bool isExpanded = false;
  bool image = false;
  String dob = '';
  String total_age_days = '0';
  late XFile? photo;
  TextEditingController Certificate = TextEditingController(),
      Reciept = TextEditingController(),
      AnimalOwneName = TextEditingController(),
      Village = TextEditingController(),
      Taluka = TextEditingController(),
      Distinct = TextEditingController(),
      Colour = TextEditingController(),
      Horns = TextEditingController(),
      Right = TextEditingController(),
      Left = TextEditingController(),
      Naturalidentificationmark = TextEditingController(),
      Tail = TextEditingController(),
      LactaionNo = TextEditingController(),
      TagId = TextEditingController(),
      ageController = TextEditingController(),
      yearss = TextEditingController(),
      monthss = TextEditingController(),
      LtEarTag = TextEditingController(),
      OldTag = TextEditingController(),
      RtEarTag = TextEditingController(),
      Description = TextEditingController(),
      LastMilk = TextEditingController(),
      Value = TextEditingController(),
      SpecialIdentificationMark = TextEditingController(),
      BankSerch = TextEditingController(),
      Branch = TextEditingController(),
      InsuranceBranch = TextEditingController(),
      PurchaseFarmer = TextEditingController(),
      PurchaseVillage = TextEditingController(),
      PurchaseTaluka = TextEditingController(),
      PurchaseDistict = TextEditingController(),
      PurchaseState = TextEditingController(),
      Remarkforunfit = TextEditingController();
  List<String> mStrspecies = [];
  Animal_Details_id? Mdetail;
  String species = "";
  List<String> mStrbreed = [];
  String breed = "";
  String base64Image1 = "";
  String base64Image2 = "";
  String base64Image3 = "";
  String base64Image4 = "";
  String bankID = "";
  String insorID = "";
  List insem_list_bank = [];
  List insem_list_insor = [];
  List<String> Bank = [];
  List<String> Insur = [];
  String Firstimage = "";
  String Secondimage = "";
  String Therdimage = "";
  String Fourimage = "";
  String mStrFromdate = "",
      mStrFromDuedate = "",
      mStrFromHsdate = "",
      mStrFromFmddate = "",
      mStrFromTheliorsdate = "",
      mStrFromCalvindate = "",
      mStrFromDiagnosis = "",
      mStrFromAnimalfit = "",
      mStrFromCalvintype = "",
      mStrFromCalfsex = "",
      mStrstatus = "";
  bool botton1 = false,
      botton2 = false,
      botton3 = false,
      botton4 = false,
      botton5 = false,
      botton6 = false,
      botton7 = false,
      botton8 = false,
      botton9 = false,
      botton10 = false,
      botton11 = false,
      botton12 = false,
      botton13 = false,
      botton14 = false,
      botton15 = false,
      botton16 = false,
      botton17 = false,
      botton18 = false,
      botton19 = false,
      botton20 = false,
      botton21 = false,
      botton22 = false,
      botton23 = false,
      botton24 = false,
      botton25 = false,
      botton26 = false,
      botton27 = false,
      botton29 = false,
      botton30 = false,
      loading = false,
      botton28 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Certificate.text = widget.visitmodel.visitID.toString();
    getdata();
    getList();
    getBankandInsorance();
    setState(() {});
  }

  getdata() {
    if (Con_List.M_species.isEmpty ||
        Con_List.M_inseminator.isEmpty ||
        Con_List.M_breed.isEmpty ||
        Con_List.M_systemAffected.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_species);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_staff);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_breed);
      Sync_Json.Get_Master_Data(Constants.Tbl_Health_systemAffected);
    }
    setState(() {});
  }

  getBankandInsorance() async {
    var response =
    await ApiCalling.getdata(AppUrl().getBankApi, Constants_Usermast.token);
    if (response.statusCode == 200) {
      insem_list_bank = jsonDecode(response.body);

      setState(() {});
    }
    var res = await ApiCalling.getdata(
        AppUrl().getInsuranceApi, Constants_Usermast.token);
    if (res.statusCode == 200) {
      insem_list_insor = jsonDecode(res.body);
      setState(() {});
    }
  }

  getList() {
    // Mdetail = Con_List.id_Animal_Details
    //     .firstWhere((element) => element.tagId == widget.visitId.toString());

    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Con_Wid.appBar(
        title: "SC certification",
        Actions: [],
        onBackTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return DashBoardScreen();
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
                  child: AnimatedContainer(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0,
                    ),
                    padding: const EdgeInsets.only(
                        right: 10, left: 10, top: 5.0),
                    height: isExpanded ? 70 : 70,
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(milliseconds: 1200),
                    decoration: BoxDecoration(color: ConClrDialog),
                    child: ListView(children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Con_Wid.width(10),
                              Text(
                                "Animal.ID : ${widget.visitmodel.animalID}",
                                style: TextStyle(
                                  color: fontwhiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
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
                                      Text("${widget.visitmodel.animalID}",
                                          style: ConStyle.Style_white_12_700w(
                                              fontwhiteColor)),
                                      const Expanded(child: SizedBox()),
                                      Text(
                                        "Farmer Code : ",
                                        style: ConStyle.Style_white_12_700w(
                                            fontwhiteColor),
                                      ),
                                      Text("${widget.visitmodel.animalID}",
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
                                    Text("${widget.visitmodel.animalID}",
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
                                      child: Text(
                                          "${widget.visitmodel.animalID}",
                                          style: ConStyle.Style_white_12_700w(
                                              fontwhiteColor)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            secondChild: Column(children: [
                              Con_Wid.height(5),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Farmer Name : ",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor),
                                    ),
                                    Text("${widget.visitmodel.farmerName}",
                                        style: ConStyle.Style_white_12_700w(
                                            fontwhiteColor)),
                                    const Expanded(child: SizedBox()),
                                    Text(
                                      "DCS Name :",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor),
                                    ),
                                    Text("${widget.visitmodel.dCSName}",
                                        style: ConStyle.Style_white_12_700w(
                                            fontwhiteColor)),
                                  ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Farmer Code : ",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor),
                                  ),
                                  Text("${widget.visitmodel.farmerCode}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor)),
                                  const Expanded(child: SizedBox()),
                                  Text(
                                    "DCS Code : ",
                                    style: ConStyle.Style_white_12_700w(
                                        fontwhiteColor),
                                  ),
                                  Text("${widget.visitmodel.dCSCode}",
                                      style: ConStyle.Style_white_12_700w(
                                          fontwhiteColor)),
                                ],
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
                // Con_Wid.fullContainer(
                //     child: Column(
                //   children: [
                //     Row(
                //       children: [
                //         Con_Wid.paddingWithText("Farmer Code:", Conclrfontmain)
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Con_Wid.paddingWithText("Farmer Name:", Conclrfontmain)
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Con_Wid.paddingWithText(" Tag ID:", Conclrfontmain)
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Con_Wid.paddingWithText("Society Code:", Conclrfontmain)
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Con_Wid.paddingWithText("Society Name:", Conclrfontmain)
                //       ],
                //     ),
                //   ],
                // )),
                Con_Wid.fullContainer(
                    child: Column(children: [
                      Con_Wid.textFieldWithInter(readonly: true,
                        TextInput_Type: TextInputType.number,
                          text: "Certificate No",
                          controller: Certificate,
                          hintText: "Visit ID"),
                      Con_Wid.textFieldWithInter(
                          TextInput_Type: TextInputType.number,
                          text: "Reciept Number",
                          controller: Reciept,
                          hintText: "Enter Reciept Number"),
                      Con_Wid.textFieldWithInter(
                          text: "Animal Farmer Name",
                          controller: AnimalOwneName,
                          hintText: "Animal Farmer name "),
                      Con_Wid.textFieldWithInter(
                          text: "Village",
                          controller: Village,
                          hintText: "Enter Village"),
                      Con_Wid.textFieldWithInter(
                          text: "Taluka",
                          controller: Taluka,
                          hintText: "Enter Taluka"),
                      Con_Wid.textFieldWithInter(
                          text: "Distinct",
                          controller: Distinct,
                          hintText: "Enter Distinct"),
                      // Con_Wid.paddingWithText("Species", Conclrfontmain),
                      CondropDown(
                        title: 'Select Species',
                        itemList: Con_List.M_species.map((e) => e.name)
                            .toList(),
                        SelectedList: mStrspecies,
                        onSelected: (List<String> value) {
                          setState(() {
                            species = Con_List.M_species
                                .firstWhere(
                                    (e) =>
                                e.name.toString() == value[0].toString())
                                .id
                                .toString();
                          });
                        },
                      ),
                      // Con_Wid.paddingWithText("Breed", Conclrfontmain),
                      CondropDown(
                        title: 'Select Breed',
                        itemList: Con_List.M_breed.where(
                                (element) =>
                            element.species.toString() == species)
                            .map((e) => e.name.toString())
                            .toList(),
                        SelectedList: mStrbreed,
                        onSelected: (List<String> value) {
                          setState(() {
                            breed = Con_List.M_breed
                                .firstWhere(
                                    (e) =>
                                e.name.toString() == value[0].toString())
                                .id
                                .toString();
                          });
                        },
                      ),
                      Con_Wid.textFieldWithInter(
                          text: "Color",
                          controller: Colour,
                          hintText: "Enter Color"),
                      Con_Wid.height(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () async {
                              setState(() {
                                ageController.text = "";
                                dob = 'age';
                                _age_or_date_check = true;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Selected
                                      ? Colors.white
                                      : ConClrSelected,
                                  border: Border.all(
                                      color: Selected ? ConClrSelected : Colors
                                          .white,
                                      width: 1)),
                              height: 37,
                              width: 130,
                              child: Text(
                                "Age",
                                style: TextStyle(
                                    color: Selected ? ConClrSelected : Colors
                                        .white),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              dob = 'date';
                              _age_or_date_check = false;
                              year.text = "";
                              month.text = "";
                              ageController.text = await Con_Wid.GlbDatePicker(
                                  isdatetime: true, pcontext: context);
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Selected ? ConClrSelected : Colors
                                      .white,
                                  border: Border.all(
                                      color: Selected
                                          ? Colors.white
                                          : ConClrSelected,
                                      width: 1)),
                              height: 37,
                              width: 130,
                              child: Text("Birth Date",
                                  style: TextStyle(
                                      color: Selected
                                          ? Colors.white
                                          : ConClrSelected)),
                            ),
                          )
                        ],
                      ),
                      Con_Wid.height(5),
                      dob == "age"
                          ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Con_Wid.textFieldWithInter(
                                color1: ConsfontBlackColor,
                                TextInput_Type: TextInputType.number,
                                Onchanged: (value1) {},
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2.5,
                                controller: year,
                                hintText: "Year"),
                            Con_Wid.textFieldWithInter(
                                color1: ConsfontBlackColor,
                                Onchanged: (value1) {},
                                TextInput_Type: TextInputType.number,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2.5,
                                controller: month,
                                hintText: "Month"),
                          ])
                          : Con_Wid.textFieldWithInter(
                          color1: ConsfontBlackColor,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 2.5,
                          controller: ageController,
                          hintText: "Date Of Birth"),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Con_Wid.paddingWithText(
                      //         "Birth Date :${mStrFromdate}", Conclrfontmain,
                      //         context: context),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Con_Wid.selectionContainer(
                      //       height: 44,
                      //       width: 97,
                      //       text: "Today",
                      //       context: context,
                      //       ontap: () {
                      //         mStrFromdate =
                      //             DateFormat('MM/dd/yyyy').format(DateTime.now());
                      //         setState(() {
                      //           botton2 = false;
                      //           botton3 = false;
                      //           botton1 = true;
                      //         });
                      //       },
                      //       Color: botton1 ? ConClrbluelight : ConClrLightBack,
                      //     ),
                      //     Con_Wid.selectionContainer(
                      //       height: 44,
                      //       width: 97,
                      //       text: "Yesterday",
                      //       context: context,
                      //       ontap: () {
                      //         DateFormat('MM/dd/yyyy')
                      //             .format(DateTime.now().subtract(Duration(days: 1)));
                      //         setState(() {
                      //           botton3 = false;
                      //           botton1 = false;
                      //           botton2 = true;
                      //         });
                      //       },
                      //       Color: botton2 ? ConClrbluelight : ConClrLightBack,
                      //     ),
                      //     Con_Wid.selectionContainer(
                      //       height: 44,
                      //       width: 97,
                      //       text: "Calendar",
                      //       context: context,
                      //       ontap: () async {
                      //         mStrFromdate =
                      //             await Con_Wid.GlbDatePicker(pcontext: context);
                      //         setState(() {
                      //           botton1 = false;
                      //           botton2 = false;
                      //           botton3 = true;
                      //         });
                      //       },
                      //       Color: botton3 ? ConClrbluelight : ConClrLightBack,
                      //     ),
                      //   ],
                      // ),
                      Con_Wid.textFieldWithInter(
                          text: "Horns", controller: Horns, hintText: "Horns"),
                      Con_Wid.textFieldWithInter(
                          text: "Right", controller: Right, hintText: "Right"),
                      Con_Wid.textFieldWithInter(
                          text: "Left", controller: Left, hintText: "Left"),
                      Con_Wid.textFieldWithInter(
                          text: "Natural identification mark",
                          controller: Naturalidentificationmark,
                          hintText: "Natural Identification"),
                      Con_Wid.textFieldWithInter(
                          text: "Tail", controller: Tail, hintText: "Tail"),
                      Con_Wid.textFieldWithInter(
                          TextInput_Type: TextInputType.number,
                          text: "Lactaion No",
                          controller: LactaionNo,
                          hintText: "Lactaion No"),
                      Con_Wid.textFieldWithInter(
                          TextInput_Type: TextInputType.number,
                          text: "Insurance RightEar Tag",
                          controller: TagId,
                          hintText: "Insurance RightEar Tag"),
                      // Con_Wid.textFieldWithInter(
                      //     text: "Lt Ear Tag",
                      //     controller: LtEarTag,
                      //     hintText: "Lt Ear Tag"),
                      Con_Wid.textFieldWithInter(
                          TextInput_Type: TextInputType.number,
                          text: "Insurance LeftEar Tag",
                          controller: OldTag,
                          hintText: "Insurance LeftEar Tag"),
                      // Con_Wid.textFieldWithInter(
                      //     text: "Rt Ear Tag",
                      //     controller: RtEarTag,
                      //     hintText: "Rt Ear Tag"),
                      Con_Wid.textFieldWithInter(
                          text: "Description",
                          controller: Description,
                          hintText: "Description"),
                      Con_Wid.height(10),
                      Con_Wid.paddingWithText(
                          "Status", context: context, Conclrfontmain),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Milking",
                            context: context,
                            ontap: () {
                              setState(() {
                                botton27 = true;
                                botton28 = false;
                              });
                            },
                            Color: botton27 ? ConClrbluelight : ConClrLightBack,
                          ),
                          Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Pregnancy",
                            context: context,
                            ontap: () {
                              setState(() {
                                botton27 = false;
                                botton28 = true;
                              });
                            },
                            Color: botton28 ? ConClrbluelight : ConClrLightBack,
                          ),
                        ],
                      ),
                      botton27
                          ? Container(
                        child: Column(children: [
                          Con_Wid.height(10),
                          Container(width: double.infinity,height: 2,color: Colors.blue),
                          Con_Wid.height(10),
                          Con_Wid.paddingWithText(
                              "Calving Date :${mStrFromCalvindate}",
                              context: context,
                              Conclrfontmain),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Con_Wid.selectionContainer(
                                height: 44,
                                width: 97,
                                text: "Today",
                                context: context,
                                ontap: () {
                                  mStrFromCalvindate = DateFormat('MM/dd/yyyy')
                                      .format(DateTime.now());
                                  setState(() {
                                    botton5 = false;
                                    botton6 = false;
                                    botton4 = true;
                                  });
                                },
                                Color:
                                botton4 ? ConClrbluelight : ConClrLightBack,
                              ),
                              Con_Wid.selectionContainer(
                                height: 44,
                                width: 97,
                                text: "Yesterday",
                                context: context,
                                ontap: () {
                                  mStrFromCalvindate = DateFormat('MM/dd/yyyy')
                                      .format(DateTime.now()
                                      .subtract(Duration(days: 1)));
                                  setState(() {
                                    botton6 = false;
                                    botton4 = false;
                                    botton5 = true;
                                  });
                                },
                                Color:
                                botton5 ? ConClrbluelight : ConClrLightBack,
                              ),
                              Con_Wid.selectionContainer(
                                height: 44,
                                width: 97,
                                text: "Calendar",
                                context: context,
                                ontap: () async {
                                  mStrFromCalvindate =
                                  await Con_Wid.GlbDatePicker(
                                      pcontext: context);
                                  setState(() {
                                    botton4 = false;
                                    botton5 = false;
                                    botton6 = true;
                                  });
                                },
                                Color:
                                botton6 ? ConClrbluelight : ConClrLightBack,
                              ),
                            ],
                          ),
                          Con_Wid.height(10),
                          Container(width: double.infinity,height: 2,color: Colors.blue),
                          Con_Wid.height(10),
                          Con_Wid.paddingWithText(
                              "Calving Type", context: context, Conclrfontmain),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Con_Wid.selectionContainer(
                                height: 44,
                                width: 97,
                                text: "None",
                                context: context,
                                ontap: () {
                                  mStrFromCalvintype = "";
                                  mStrFromCalvintype = "None";
                                  setState(() {
                                    botton8 = false;
                                    botton9 = false;
                                    botton7 = true;
                                  });
                                },
                                Color:
                                botton7 ? ConClrbluelight : ConClrLightBack,
                              ),
                              Con_Wid.selectionContainer(
                                height: 44,
                                width: 97,
                                text: "yes",
                                context: context,
                                ontap: () {
                                  mStrFromCalvintype = "";
                                  mStrFromCalvintype = "yes";
                                  setState(() {
                                    botton9 = false;
                                    botton7 = false;
                                    botton8 = true;
                                  });
                                },
                                Color:
                                botton8 ? ConClrbluelight : ConClrLightBack,
                              ),
                              Con_Wid.selectionContainer(
                                height: 44,
                                width: 97,
                                text: "no",
                                context: context,
                                ontap: () {
                                  mStrFromCalvintype = "";
                                  mStrFromCalvintype = "no";
                                  setState(() {
                                    botton7 = false;
                                    botton8 = false;
                                    botton9 = true;
                                  });
                                },
                                Color:
                                botton9 ? ConClrbluelight : ConClrLightBack,
                              ),
                            ],
                          ),
                          Con_Wid.height(10),
                          Container(width: double.infinity,height: 2,color: Colors.blue),
                          Con_Wid.height(10),
                          Con_Wid.paddingWithText(
                              "Calf Sex", context: context, Conclrfontmain),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Con_Wid.selectionContainer(
                                height: 44,
                                width: 110,
                                text: "Male",
                                context: context,
                                ontap: () {
                                  mStrFromCalfsex = "";
                                  mStrFromCalfsex = "Male";
                                  setState(() {
                                    botton11 = false;
                                    botton10 = true;
                                  });
                                },
                                Color:
                                botton10 ? ConClrbluelight : ConClrLightBack,
                              ),
                              Con_Wid.selectionContainer(
                                height: 44,
                                width: 110,
                                text: "Female",
                                context: context,
                                ontap: () {
                                  mStrFromCalfsex = "";
                                  mStrFromCalfsex = "Female";
                                  setState(() {
                                    botton10 = false;
                                    botton11 = true;
                                  });
                                },
                                Color:
                                botton11 ? ConClrbluelight : ConClrLightBack,
                              ),
                            ],
                          ),
                        ]),
                      )
                          : Container(
                        child: Column(
                          children: [
                            Con_Wid.height(10),
                            Container(width: double.infinity,height: 2,color: Colors.blue),
                            Con_Wid.height(10),
                            Con_Wid.paddingWithText(
                                "Due Date:${mStrFromDuedate}",
                                context: context,
                                Conclrfontmain),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Con_Wid.selectionContainer(
                                  height: 44,
                                  width: 110,
                                  text: "Today",
                                  context: context,
                                  ontap: () {
                                    mStrFromDuedate = DateFormat('MM/dd/yyyy')
                                        .format(DateTime.now());
                                    setState(() {
                                      botton13 = false;
                                      botton12 = true;
                                    });
                                  },
                                  Color: botton12
                                      ? ConClrbluelight
                                      : ConClrLightBack,
                                ),
                                Con_Wid.selectionContainer(
                                  height: 44,
                                  width: 110,
                                  text: "Calendar",
                                  context: context,
                                  ontap: () async {
                                    mStrFromDuedate =
                                    await Con_Wid.GlbDatePicker(
                                        pcontext: context);
                                    setState(() {
                                      botton12 = false;
                                      botton13 = true;
                                    });
                                  },
                                  Color: botton13
                                      ? ConClrbluelight
                                      : ConClrLightBack,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Con_Wid.textFieldWithInter(
                          TextInput_Type: TextInputType.number,
                          text: "Last Milk",
                          controller: LastMilk,
                          hintText: "Last Milk"),
                      Con_Wid.textFieldWithInter(
                          TextInput_Type: TextInputType.number,
                          text: "Value", controller: Value, hintText: "Value"),
                      Con_Wid.textFieldWithInter(
                          text: "Special Identification Mark",
                          controller: SpecialIdentificationMark,
                          hintText: "Special Indication"),
                      //Con_Wid.paddingWithText("Bank", Conclrfontmain),
                      CondropDown(
                        title: 'Select Bank',
                        itemList: insem_list_bank
                            .map((e) => e['BankName'].toString())
                            .toList(),
                        SelectedList: Bank,
                        onSelected: (List<String> value) {
                          setState(() {
                            Bank = value;
                            if (Bank.isNotEmpty) {
                              insem_list_bank.forEach((e) {
                                if (e['BankName'] == Bank[0]) {
                                  bankID = e['ID'].toString();
                                }
                              });
                            }
                          });
                        },
                      ),
                      Con_Wid.textFieldWithInter(
                          text: "Branch",
                          controller: Branch,
                          hintText: "Branch"),
                      // Con_Wid.paddingWithText("Insurance", Conclrfontmain),
                      CondropDown(
                        title: 'Select Insurance',
                        itemList:
                        insem_list_insor.map((e) => e['Name'].toString())
                            .toList(),
                        SelectedList: Insur,
                        onSelected: (List<String> value) {
                          setState(() {
                            Insur = value;
                            if (Insur.isNotEmpty) {
                              insem_list_insor.forEach((e) {
                                if (e['Name'] == Insur[0]) {
                                  insorID = e['id'].toString();
                                }
                              });
                            }
                          });
                        },
                      ),
                      Con_Wid.textFieldWithInter(
                          hintText: "Insurance Branch",
                          controller: InsuranceBranch,
                          text: "Insurance Branch"),
                      Con_Wid.textFieldWithInter(
                          text: "Purchase Farmer",
                          controller: PurchaseFarmer,
                          hintText: "Purchase Farmer"),
                      Con_Wid.textFieldWithInter(
                          text: "Purchase Village",
                          controller: PurchaseVillage,
                          hintText: "Purchase Village"),
                      Con_Wid.textFieldWithInter(
                          text: "Purchase Taluka",
                          controller: PurchaseTaluka,
                          hintText: "Purchase Taluka"),
                      Con_Wid.textFieldWithInter(
                          text: "Purchase Distict",
                          controller: PurchaseDistict,
                          hintText: "Purchase Distict"),
                      Con_Wid.textFieldWithInter(
                          text: "Purchase State",
                          controller: PurchaseState,
                          hintText: "Purchase State"),
                      Con_Wid.height(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Con_Wid.paddingWithText(
                              "HS Date :${mStrFromHsdate}",
                              context: context,
                              Conclrfontmain),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Today",
                            context: context,
                            ontap: () {
                              mStrFromHsdate = DateFormat('MM/dd/yyyy').format(DateTime.now());

                              setState(() {
                                botton20 = false;
                                botton19 = false;
                                botton18 = true;
                              });
                            },
                            Color: botton18 ? ConClrbluelight : ConClrLightBack,
                          ),
                          Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Yesterday",
                            context: context,
                            ontap: () {
                              mStrFromHsdate = DateFormat('MM/dd/yyyy')
                                  .format(
                                  DateTime.now().subtract(Duration(days: 1)));
                              setState(() {
                                botton20 = false;
                                botton18 = false;
                                botton19 = true;
                              });
                            },
                            Color: botton19 ? ConClrbluelight : ConClrLightBack,
                          ),
                          Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Calendar",
                            context: context,
                            ontap: () async {
                              mStrFromHsdate =
                              await Con_Wid.GlbDatePicker(pcontext: context);
                              setState(() {
                                botton18 = false;
                                botton19 = false;
                                botton20 = true;
                              });
                            },
                            Color: botton20 ? ConClrbluelight : ConClrLightBack,
                          ),
                        ],
                      ),
                      Con_Wid.height(10),
                      Container(width: double.infinity,height: 2,color: Colors.blue),
                      Con_Wid.height(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Con_Wid.paddingWithText(
                              "Fmd Date :${mStrFromFmddate}",
                              context: context,
                              Conclrfontmain),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Today",
                            context: context,
                            ontap: () {
                              mStrFromFmddate =
                                  DateFormat('MM/dd/yyyy').format(
                                      DateTime.now());
                              setState(() {
                                botton23 = false;
                                botton22 = false;
                                botton21 = true;
                              });
                            },
                            Color: botton21 ? ConClrbluelight : ConClrLightBack,
                          ),
                          Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Yesterday",
                            context: context,
                            ontap: () {
                              mStrFromFmddate = DateFormat('MM/dd/yyyy')
                                  .format(
                                  DateTime.now().subtract(Duration(days: 1)));
                              setState(() {
                                botton23 = false;
                                botton21 = false;
                                botton22 = true;
                              });
                            },
                            Color: botton22 ? ConClrbluelight : ConClrLightBack,
                          ),
                          Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Calendar",
                            context: context,
                            ontap: () async {
                              mStrFromFmddate =
                              await Con_Wid.GlbDatePicker(pcontext: context);
                              setState(() {
                                botton21 = false;
                                botton22 = false;
                                botton23 = true;
                              });
                            },
                            Color: botton23 ? ConClrbluelight : ConClrLightBack,
                          ),
                        ],
                      ),
                      Con_Wid.height(10),
                      Container(width: double.infinity,height: 2,color: Colors.blue),
                      Con_Wid.height(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Con_Wid.paddingWithText(
                              "Theliors Date :${mStrFromTheliorsdate}",
                              context: context,
                              Conclrfontmain),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Today",
                            context: context,
                            ontap: () {
                              mStrFromTheliorsdate =
                                  DateFormat('MM/dd/yyyy').format(
                                      DateTime.now());
                              setState(() {
                                botton26 = false;
                                botton25 = false;
                                botton24 = true;
                              });
                            },
                            Color: botton24 ? ConClrbluelight : ConClrLightBack,
                          ),
                          Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Yesterday",
                            context: context,
                            ontap: () {
                              mStrFromTheliorsdate = DateFormat('MM/dd/yyyy')
                                  .format(
                                  DateTime.now().subtract(Duration(days: 1)));
                              setState(() {
                                botton24 = false;
                                botton26 = false;
                                botton25 = true;
                              });
                            },
                            Color: botton25 ? ConClrbluelight : ConClrLightBack,
                          ),
                          Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Calendar",
                            context: context,
                            ontap: () async {
                              mStrFromTheliorsdate =
                              await Con_Wid.GlbDatePicker(pcontext: context);
                              setState(() {
                                botton24 = false;
                                botton25 = false;
                                botton26 = true;
                              });
                            },
                            Color: botton26 ? ConClrbluelight : ConClrLightBack,
                          ),
                        ],
                      ),
                      Con_Wid.height(10),
                      Container(width: double.infinity,height: 2,color: Colors.blue),
                      Con_Wid.height(10),
                      // Con_Wid.paddingWithText(
                      //     "Diagnosis", context: context, Conclrfontmain),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Con_Wid.selectionContainer(
                      //       height: 44,
                      //       width: 110,
                      //       text: "yes",
                      //       context: context,
                      //       ontap: () {
                      //         mStrFromDiagnosis = "";
                      //         mStrFromDiagnosis = "yes";
                      //         setState(() {
                      //           botton15 = false;
                      //           botton14 = true;
                      //         });
                      //       },
                      //       Color: botton14 ? ConClrbluelight : ConClrLightBack,
                      //     ),
                      //     Con_Wid.selectionContainer(
                      //       height: 44,
                      //       width: 110,
                      //       text: "NO",
                      //       context: context,
                      //       ontap: () {
                      //         mStrFromDiagnosis = "";
                      //         mStrFromDiagnosis = "No";
                      //         setState(() {
                      //           botton14 = false;
                      //           botton15 = true;
                      //         });
                      //       },
                      //       Color: botton15 ? ConClrbluelight : ConClrLightBack,
                      //     ),
                      //   ],
                      // ),
                      Con_Wid.paddingWithText(
                          "Animal Fit / UnFit", context: context,
                          Conclrfontmain),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Con_Wid.selectionContainer(
                            height: 44,
                            width: 110,
                            text: "yes",
                            context: context,
                            ontap: () {
                              mStrFromAnimalfit = "";
                              mStrFromAnimalfit = "Yes";
                              setState(() {
                                botton17 = false;
                                botton16 = true;
                              });
                            },
                            Color: botton16 ? ConClrbluelight : ConClrLightBack,
                          ),
                          Con_Wid.selectionContainer(
                            height: 44,
                            width: 110,
                            text: "No",
                            context: context,
                            ontap: () {
                              mStrFromAnimalfit = "";
                              mStrFromAnimalfit = "No";
                              setState(() {
                                botton16 = false;
                                botton17 = true;
                              });
                            },
                            Color: botton17 ? ConClrbluelight : ConClrLightBack,
                          ),
                        ],
                      ),
                      botton17
                          ? Con_Wid.textFieldWithInter(
                          controller: Remarkforunfit,
                          hintText: "Remark for unfit")
                          : Container(),
                      Con_Wid.height(10),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Con_Wid.paddingWithText("Image", Conclrfontmain,
                                context: context),
                            image == false
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Con_Wid.MainButton(
                                      width: 100,
                                      height: 35,
                                      fontSize: 12,
                                      pStrBtnName: "Tag ID Image",
                                      OnTap: () async {
                                        showDialog(
                                          context: context, builder: (context) {
                                          return AlertDialog(actions: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center, children: [
                                              TextButton(onPressed: () async {
                                                Navigator.pop(context);
                                                final XFile? photo =
                                                await picker.pickImage(
                                                    source:
                                                    ImageSource.camera,
                                                    imageQuality: 10);

                                                Firstimage = photo!.path;
                                                ImageBytecode =
                                                await photo.readAsBytes();
                                                base64Image1 =
                                                    base64Encode(ImageBytecode);
                                                setState(() {
                                                  image = true;
                                                });
                                              },
                                                  child: const Text(
                                                      "Picked from camera")),
                                              TextButton(onPressed: () async {
                                                Navigator.pop(context);
                                                final XFile? photo =
                                                await picker.pickImage(
                                                    source:
                                                    ImageSource.gallery,
                                                    imageQuality: 10);

                                                Firstimage = photo!.path;
                                                ImageBytecode =
                                                await photo.readAsBytes();
                                                base64Image1 =
                                                    base64Encode(ImageBytecode);
                                                setState(() {
                                                  image = true;
                                                });
                                              },
                                                  child: const Text(
                                                      "Picked from Gallery")),
                                            ],)

                                          ],);
                                        },);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Container(
                                  height: 300,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width - 150,
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
                                        width:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width - 150,
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
                            Firstimage != ""
                                ? Secondimage == ""
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Con_Wid.MainButton(
                                      width: 120,
                                      height: 35,
                                      // width: 80,
                                      // height: 36,
                                      fontSize: 12,
                                      pStrBtnName: "FrontView Image",
                                      OnTap: () async {
                                        showDialog(
                                          context: context, builder: (context) {
                                          return AlertDialog(actions: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center, children: [
                                              TextButton(onPressed: () async {
                                                Navigator.pop(context);
                                                final XFile? photo =
                                                await picker.pickImage(
                                                    source: ImageSource
                                                        .camera,
                                                    imageQuality: 10);

                                                Secondimage = photo!.path;
                                                ImageBytecode =
                                                await photo.readAsBytes();
                                                base64Image2 = base64Encode(
                                                    ImageBytecode);
                                                setState(() {
                                                  image = true;
                                                });
                                              },
                                                  child: const Text("Picked from camera")),
                                              TextButton(onPressed: () async {
                                                Navigator.pop(context);
                                                final XFile? photo =
                                                await picker.pickImage(
                                                    source: ImageSource
                                                        .gallery,
                                                    imageQuality: 10);

                                                Secondimage = photo!.path;
                                                ImageBytecode =
                                                await photo.readAsBytes();
                                                base64Image2 = base64Encode(
                                                    ImageBytecode);
                                                setState(() {
                                                  image = true;
                                                });
                                              },
                                                  child: const Text(
                                                      "Picked from Gallery")),
                                            ],)

                                          ],);
                                        },);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Container()
                                : Container(),
                            Secondimage != ""
                                ? Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Container(
                                  height: 300,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width - 150,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: FileImage(
                                              File("${Secondimage}")))),
                                  child: Baseline(
                                    baseline: 25,
                                    baselineType: TextBaseline.alphabetic,
                                    child: Container(
                                        height: 30,
                                        width:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width - 150,
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
                                                    Secondimage = "";
                                                  });
                                                },
                                                icon: Own_Close,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        )),
                                  )),
                            )
                                : Container(),
                            Secondimage != ""
                                ? Therdimage == ""
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Con_Wid.MainButton(
                                      width: 120,
                                      height: 35,
                                      // width: 80,
                                      // height: 36,
                                      fontSize: 12,
                                      pStrBtnName: "SideView Image",
                                      OnTap: () async {
                                        showDialog(
                                          context: context, builder: (context) {
                                          return AlertDialog(actions: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center, children: [
                                              TextButton(onPressed: () async {
                                                Navigator.pop(context);
                                                final XFile? photo =
                                                await picker.pickImage(
                                                    source: ImageSource
                                                        .camera,
                                                    imageQuality: 10);

                                                Therdimage = photo!.path;
                                                ImageBytecode =
                                                await photo.readAsBytes();
                                                base64Image3 = base64Encode(
                                                    ImageBytecode);
                                                setState(() {
                                                  image = true;
                                                });
                                              },
                                                  child: Text(
                                                      "Picked from camera")),
                                              TextButton(onPressed: () async {
                                                Navigator.pop(context);
                                                final XFile? photo =
                                                await picker.pickImage(
                                                    source: ImageSource
                                                        .gallery,
                                                    imageQuality: 10);

                                                Therdimage = photo!.path;
                                                ImageBytecode =
                                                await photo.readAsBytes();
                                                base64Image3 = base64Encode(
                                                    ImageBytecode);
                                                setState(() {
                                                  image = true;
                                                });
                                              },
                                                  child: Text(
                                                      "Picked from Gallery")),
                                            ],)

                                          ],);
                                        },);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Container()
                                : Container(),
                            Therdimage != ""
                                ? Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Container(
                                  height: 300,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width - 150,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: FileImage(
                                              File("${Therdimage}")))),
                                  child: Baseline(
                                    baseline: 25,
                                    baselineType: TextBaseline.alphabetic,
                                    child: Container(
                                        height: 30,
                                        width:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width - 150,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 32,
                                              child: IconButton(
                                                splashRadius: 18,
                                                onPressed: () {
                                                  setState(() {
                                                    Therdimage = "";
                                                  });
                                                },
                                                icon: Own_Close,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        )),
                                  )),
                            )
                                : Container(),
                            Therdimage != ""
                                ? Fourimage == ""
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Con_Wid.MainButton(
                                      width: 120,
                                      height: 35,
                                      // width: 80,
                                      // height: 36,
                                      fontSize: 12,
                                      pStrBtnName: "BackView Image",
                                      OnTap: () async {
                                        showDialog(
                                          context: context, builder: (context) {
                                          return AlertDialog(actions: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center, children: [
                                              TextButton(onPressed: () async {
                                                Navigator.pop(context);
                                                final XFile? photo =
                                                await picker.pickImage(
                                                    source: ImageSource
                                                        .camera,
                                                    imageQuality: 10);

                                                Fourimage = photo!.path;
                                                ImageBytecode =
                                                await photo.readAsBytes();
                                                base64Image4 = base64Encode(
                                                    ImageBytecode);
                                                setState(() {
                                                  image = true;
                                                });
                                              },
                                                  child: Text(
                                                      "Picked from camera")),
                                              TextButton(onPressed: () async {
                                                Navigator.pop(context);
                                                final XFile? photo =
                                                await picker.pickImage(
                                                    source: ImageSource
                                                        .gallery,
                                                    imageQuality: 10);

                                                Fourimage = photo!.path;
                                                ImageBytecode =
                                                await photo.readAsBytes();
                                                base64Image4 = base64Encode(
                                                    ImageBytecode);
                                                setState(() {
                                                  image = true;
                                                });
                                              },
                                                  child: Text(
                                                      "Picked from Gallery")),
                                            ],)

                                          ],);
                                        },);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Container()
                                : Container(),
                            Fourimage != ""
                                ? Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Container(
                                  height: 300,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width - 150,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: FileImage(
                                              File("${Fourimage}")))),
                                  child: Baseline(
                                    baseline: 25,
                                    baselineType: TextBaseline.alphabetic,
                                    child: Container(
                                        height: 30,
                                        width:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width - 150,
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
                                                    Fourimage = "";
                                                  });
                                                },
                                                icon: Own_Close,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        )),
                                  )),
                            )
                                : Container(),
                          ]),

                      Con_Wid.height(15),
                      Con_Wid.MainButton(
                          OnTap: () {
                            if (isValidated()) {
                              _createSCCertificate();
                            }
                          },
                          pStrBtnName: "Submit",
                          height: 45,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 3,
                          fontSize: 14)
                    ]))
              ],
            ),
          )),
    );
  }

  bool isValidated() {
    if (Reciept.text
        .trim()
        .isEmpty ||
        // taluka.text.trim().isEmpty ||
        Horns.text
            .trim()
            .isEmpty ||
        Colour.text
            .trim()
            .isEmpty ||
        // generalCondition.text.trim().isEmpty ||
        Naturalidentificationmark.text
            .trim()
            .isEmpty) {
      Con_Wid.Con_Show_Toast(context, "Please enter all the required fields");

      return false;
    }
    return true;
  }

  void _createSCCertificate() async {
    setState(() {
      loading = true;
    });
    var formatter1 = DateFormat('MM/dd/yyyy');

    if (ageController.text != "") {
      dob = formatter1.format(DateTime.parse(ageController.text));
    } else {
      double y = 0.0;
      double m = 0.0;
      if (year.text != "") {
        y = double.parse(year.text) * 365;
      }
      if (month.text != "") {
        m = double.parse(month.text) * 30;
      }
      dob = formatter1.format(
          DateTime.now().subtract(Duration(days: y.toInt() + m.toInt())));
    }
    Map<String, dynamic> data = {
      "RegistrationDate":
      DateFormat('MM/dd/yyyy').format(DateTime.now()).toString(),
      "VisitID": widget.visitmodel.visitID,
      "Village": Village.text.toString(),
      "PurchaseDistrict": PurchaseDistict.text,
      "Date": DateFormat('MM/dd/yyyy').format(DateTime.now()).toString(),
      "CertificateNo": "0",
      "lot": Taluka.text,
      "farmer": AnimalOwneName.text,
      "species": species,
      "Colour": Colour.text,
      "CalfSex": botton27
          ? mStrFromCalfsex == "Male"
          ? "1"
          : "2"
          : null,
      "Diagnosis": PurchaseState.text,
      "breed": breed,
      "DOB": dob,
      "LactationNo": LactaionNo.text.trimLeft().trim(),
      "ProposalNo": mStrFromAnimalfit.toString() == "Yes" ? "1" : "2",
      "vaccinatedagainstHS": mStrFromHsdate ==
          DateFormat('MM/dd/yyyy').format(DateTime.now()).toString()
          ? ""
          : mStrFromHsdate,
      "vaccinatedagainstFMD": mStrFromFmddate ==
          DateFormat('MM/dd/yyyy').format(DateTime.now()).toString()
          ? ""
          : mStrFromFmddate,
      "vaccinatedagainstTheileriosis": mStrFromTheliorsdate ==
          DateFormat('MM/dd/yyyy').format(DateTime.now()).toString()
          ? ""
          : mStrFromTheliorsdate,
      "CalvingDate": botton27 ? mStrFromCalvindate : null,
      "ExpCalvingDate": botton27 ? null : mStrFromDuedate,
      "Horns": Horns.text,
      "RTHorns": Right.text,
      "LTHorns": Left.text,
      "Specialmark": SpecialIdentificationMark.text,
      "Identificationmark": Naturalidentificationmark.text,
      "Tail": Tail.text,
      "LeftearTag": LtEarTag.text,
      "OldTag": OldTag.text,
      "LeftearMark": LtEarTag.text,
      "RightearTag": RtEarTag.text,
      "Description": Description.text,
      "LoanNo": mStrFromAnimalfit.toString() == "Yes" ? "1" : "2",
      "RecieptNo": Reciept.text,
      "LastMilk": LastMilk.text,
      "Value": Value.text,
      "Bank": Bank.isNotEmpty ? int.parse(bankID.toString()) : 0,
      "BankBranch": Branch.text,
      "Insurance": Insur.isNotEmpty ? int.parse(insorID.toString()) : 0,
      "InsuranceBranch": InsuranceBranch.text,
      "PurchaseSource": PurchaseVillage.text,
      "PurchaseVillage": Remarkforunfit.text,
      "PurchaseTaluka": PurchaseTaluka.text,
      "Purchasefarmer": PurchaseFarmer.text,
      "type": Distinct.text,
      "InsuranceIssueDate":
      DateFormat('MM/dd/yyyy').format(DateTime.now()).toString(),
      "VOname": Constants_Usermast.staff,
      "StartLat": "13.4",
      "StartLong": "13.4",
      "SyncStatus": 2,
      "updatedAt": DateFormat('MM/dd/yyyy').format(DateTime.now()).toString(),
      "lastUpdatedByUser": Constants_Usermast.user_id,
      "createdByUser": Constants_Usermast.user_id,
      "AnimalImage": base64Image1.trim(),
      "AnimalImage1": base64Image2.trim(),
      "AnimalImage2": base64Image3.trim(),
      "AnimalImage3": base64Image4.trim(),
      "createdAt": DateFormat('MM/dd/yyyy').format(DateTime.now()).toString(),
      "TagID": TagId.text,
      "herd": Distinct.text
    };
    List titel = [
      "RegistrationDate",
    "VisitID",
    "Village",
    "PurchaseDistrict",
    "Date",
    "CertificateNo",
    "lot",
    "farmer",
    "species",
    "Colour",
    "CalfSex",
    "Diagnosis",
    "breed",
    "DOB",
    "LactationNo",
    "ProposalNo",
    "vaccinatedagainstHS",
    "vaccinatedagainstFMD",
    "vaccinatedagainstTheileriosis",
    "CalvingDate",
    "ExpCalvingDate",
    "Horns",
    "RTHorns",
    "LTHorns",
    "Specialmark",
    "Identificationmark",
    "Tail",
    "LeftearTag",
    "OldTag",
    "LeftearMark",
    "RightearTag",
    "Description",
    "LoanNo",
    "RecieptNo",
    "LastMilk",
    "Value",
    "Bank",
    "BankBranch",
    "Insurance",
    "InsuranceBranch",
    "PurchaseSource",
    "PurchaseVillage",
    "PurchaseTaluka",
    "Purchasefarmer",
    "type",
    "InsuranceIssueDate",
    "VOname",
    "StartLat",
    "StartLong",
    "SyncStatus",
    "updatedAt",
    "lastUpdatedByUser",
    "createdByUser",
    "AnimalImage",
    "AnimalImage1",
    "AnimalImage2",
    "AnimalImage3",
    "createdAt",
    "TagID",
    "herd"
    ];
    List temp=[];
    temp.add(data);
    showDialog(context: context, builder: (context) {
    return Material(
      color: Colors.black,
      child: StatefulBuilder(
        builder: (context,setState1) {
          return Container(
            height: double.infinity,
            width: double.infinity,
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(itemCount: titel.length,itemBuilder: (context, index) {

                    return ListTile(title: Text(titel[index]),trailing: Text(
                        titel[index]=="CalfSex"?temp[0][titel[index]]=="1"?"Male":"Female":
                        titel[index]=="species"?temp[0][titel[index]]=="1"?"Cow":"Buffalo":
                        titel[index]=="breed"?temp[0][titel[index]].toString().isNotEmpty?Con_List.M_breed.where((element) => element.id.toString()==temp[0][titel[index]].toString()).first.name.toString():"":
                        titel[index]=="AnimalImage"?temp[0][titel[index]]!=""?"yes":"no":
                        titel[index]=="AnimalImage1"?temp[0][titel[index]]!=""?"yes":"no":
                        titel[index]=="AnimalImage2"?temp[0][titel[index]]!=""?"yes":"no":
                        titel[index]=="AnimalImage3"?temp[0][titel[index]]!=""?"yes":"no":temp[0][titel[index]].toString()
                    ),);
                    },),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                    Con_Wid.MainButton(OnTap: () {
                      Navigator.pop(context);
                    }, pStrBtnName: "Edit", height: 40, width: 80, fontSize: 14),
                    Con_Wid.MainButton(OnTap: () async {
                      setState1(() {
                        setState(() {
                          loadingforai = true;
                        });
                      });
                      log(data.toString());
                      final res = await ApiCalling.createPost(AppUrl().createSCCertificate,
                          "Bearer " + Constants_Usermast.token, data);

                      if (res.statusCode == 200) {
                        if (widget.visitmodel.visitID != null) {
                          SyncDB.Visit_Complete(
                              widget.visitmodel.visitID!.toString(), TagId.text);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return VisitRegistrationScreen();
                            },
                          ));
                        }
                      }else{
                        setState1(() {
                          setState(() {
                            loadingforai = false;
                          });
                        });
                        Con_Wid.Con_Show_Toast(context, "Opps something went wrong");
                      }
                    }, pStrBtnName: "Save", height: 40, width: 80, fontSize: 14),
                  ],)
                ],
              ),
              loadingforai ? Center(child: CircularProgressIndicator(),):Container()
            ],
          ),
          );
        }
      ),
    );
    },
    );

  }
}
