import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/Dashboard/Dashboard.dart';
import 'package:herdmannew/component/DataBaseHelper/Sync_Database.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../component/DataBaseHelper/Con_List.dart';
import '../../component/DataBaseHelper/Sync_Json.dart';
import '../../component/Gobal_Widgets/Con_Icons.dart';
import '../../component/Gobal_Widgets/Con_Textstyle.dart';
import '../../component/Gobal_Widgets/Constants.dart';
import '../../model/Animal_Details_id.dart';
import '../../model/Master_inseminator.dart';
import '../../model/Visit_Registration.dart';
import '../DrawerScreens/VisitRegistration/VisitRegistration.dart';

class pm_certification extends StatefulWidget {
  Visit_Registration visitmodel;

  pm_certification(this.visitmodel);

  @override
  State<pm_certification> createState() => _pm_certificationState();
}

class _pm_certificationState extends State<pm_certification> {
  final ImagePicker picker = ImagePicker();
  TextEditingController year = TextEditingController(),
      month = TextEditingController(),
      bod = TextEditingController();
  bool botton1 = true;
  bool botton2 = false;
  List<String> Species = [];
  List<String> mSelectbreed = [];
  List<String> mDoctor = [];
  String Firstimage = "";
  String Secondimage = "";
  String Therdimage = "";
  String Fourimage = "";
  String select = "Adult";
  bool botton3 = false;
  bool Selected = false;
  int Age = 0;
  bool image = false;
  List<int> ImageBytecode = [];
  String base64Image1 = '';
  String base64Image2 = '';
  String base64Image3 = '';
  String base64Image4 = '';
  String A_calf_sex = "Male";
  String year_sum = "0";
  Animal_Details_id? Mdetail;
  List<String> Selected_DeathReason = [];
  List<String> Selected_care_attention = [];
  List<String> Selected_insurence_identify = [];
  List<String> YesNoValue = [Con_Wid.Lang_Cng('Yes'), Con_Wid.Lang_Cng('No')];
  List<Map> Death_reason = [
    {"id": 0, "name": "Disease"},
    {"id": 1, "name": "Accident"},
    {"id": 2, "name": "Operation"}
  ];
  String month_sum = "0";
  String mStrFromdate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  //todo veriable from old projetct
  TextEditingController loanNoController = TextEditingController(),
      recieptNoController = TextEditingController(),
      doctorController = TextEditingController(),
      _groupNo = TextEditingController(),
      _tagId = TextEditingController(),
      _tagOnLeftEar = TextEditingController(),
      _rightEarTagRemark = TextEditingController(),
      _milkYeild = TextEditingController(),
      _nature = TextEditingController(),
      _leftEarTagRemark = TextEditingController(),
      _causeOfDeath = TextEditingController(),
      ageController = TextEditingController(),
      yearss = TextEditingController(),
      monthss = TextEditingController(),
      tailController = TextEditingController(),
      Horns = TextEditingController(),
      lHorns = TextEditingController(),
      rHorns = TextEditingController(),
      oldTagCOntroller = TextEditingController(),
      colorController = TextEditingController(),
      BodycolorController = TextEditingController(),
      othersController = TextEditingController(),
      hornController = TextEditingController(),
      illnessValue = TextEditingController(),
      specialIndication = TextEditingController(),
      generalCondition = TextEditingController(),
      visitFeeController = TextEditingController();
  int deathReason = 0;
  bool careAndAttenstionValue = false, examinValue = false;
  TextEditingController herdController = TextEditingController(),
      lotController = TextEditingController(),
      farmerController = TextEditingController(),
      District = TextEditingController();
  String dob = '';
  String lastdob = '';
  String total_age_days = '0';
  String dates = '',
      actual_date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  bool loading = false;
  bool _age_or_date_check = true;
  String animalId = '',
      dcsCode = '',
      farmerCode = '',
      farmerName = '',
      dcsName = '';
  var formatter1 = DateFormat('yyyy-MM-dd');
  DateTime selectedDate = DateTime.now();
  DateTime? _insuranceIssuedDate;
  DateTime? _treatedFromDate;
  DateTime? _treatedTodate;
  bool isExpanded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    _getRequestItems();
    setState(() {});
  }

  @override
  void dispose() {
    visitFeeController.dispose();
    _groupNo.dispose();
    tailController.dispose();
    hornController.dispose();
    othersController.dispose();
    recieptNoController.dispose();
    super.dispose();
  }

  getdata() {
    if (Con_List.M_species.isEmpty || Con_List.M_inseminator.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_species);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_staff);
    }
    mDoctor = Con_List.M_inseminator.where((e) => e.id.toString() == widget.visitmodel.masterStaff.toString()).map((e) => e.name.toString())
        .toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Con_Wid.appBar(
        title: "PM Certificate",
        Actions: [],
        onBackTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return DashBoardScreen();
            },
          ));
        },
      ),
      body: Stack(
        children: [
          IgnorePointer(
            ignoring: loading,
            child: Con_Wid.backgroundContainer(
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
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 5.0),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                      "Farmer Code :",
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
                  //     child: Row(
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Con_Wid.paddingWithText(
                  //             "Farmer Code : ", Conclrfontmain),
                  //         Con_Wid.paddingWithText(
                  //             "Farmer Name : ", Conclrfontmain),
                  //         Con_Wid.paddingWithText(
                  //             "Tag ID :     ${widget.visitmodel.animalID}",
                  //             Conclrfontmain),
                  //         Con_Wid.paddingWithText(
                  //             "Society Code : ", Conclrfontmain),
                  //         Con_Wid.paddingWithText(
                  //             "Society Name : ", Conclrfontmain),
                  //       ],
                  //     )
                  //   ],
                  // )),
                  Con_Wid.fullContainer(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Con_Wid.textFieldWithInter(
                        TextInput_Type: TextInputType.number,
                          text: "Right ear Tag ID",
                          controller: _tagId,
                          hintText: "Right ear Tag ID"),
                      Con_Wid.textFieldWithInter(
                          text: "Right ear Tag Remark",
                          controller: _rightEarTagRemark,
                          hintText: "Right ear Tag Remark"),
                      Con_Wid.textFieldWithInter(
                          TextInput_Type: TextInputType.number,
                          hintText: "Left ear Tag ID",
                          controller: _tagOnLeftEar,
                          text: "Tag on Left ear"),
                      Con_Wid.textFieldWithInter(
                          text: "Left ear Tag Remark",
                          controller: _leftEarTagRemark,
                          hintText: "Left ear Tag Remark"),
                      Con_Wid.textFieldWithInter(
                          hintText: "District",
                          controller: District,
                          text: "District"),
                      Con_Wid.textFieldWithInter(
                          text: "Taluka",
                          controller: herdController,
                          hintText: "Taluka"),
                      Con_Wid.textFieldWithInter(
                          text: "village",
                          controller: lotController,
                          hintText: "village"),
                      Con_Wid.textFieldWithInter(
                          hintText: "Farmer",
                          controller: farmerController,
                          text: "Farmer"),

                      //Con_Wid.paddingWithText("Species", Conclrfontmain),
                      CondropDown(
                        title: 'Select Species',
                        itemList:
                            Con_List.M_species.map((e) => e.name.toString())
                                .toList(),
                        SelectedList: Species,
                        onSelected: (List<String> value) {
                          setState(() {
                            Species = value;
                          });
                        },
                      ),
                      // Con_Wid.paddingWithText("Breed", Conclrfontmain),
                      CondropDown(
                        title: 'Select Breed',
                        itemList: Con_List.M_breed.where((e) => Species.isEmpty
                                ? true
                                : e.species == (Species[0] == "Cow" ? 1 : 2))
                            .map((e) => "${e.name}")
                            .toList(),
                        SelectedList: mSelectbreed,
                        onSelected: (List<String> value) {
                          setState(() {
                            mSelectbreed = value;
                          });
                        },
                      ),
                      //Con_Wid.paddingWithText("Sex", Conclrfontmain),
                      Row(
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
                          Text('Male'),
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
                          Text('Female'),
                        ],
                      ),
                      Con_Wid.textFieldWithInter(
                          text: "Body Color",
                          controller: BodycolorController,
                          hintText: "Body Color"),
                      Con_Wid.height(5),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () async {
                              setState(() {
                                ageController.clear();
                                dob = 'age';
                                _age_or_date_check = true;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color:
                                      Selected ? Colors.white : ConClrSelected,
                                  border: Border.all(
                                      color: Selected
                                          ? ConClrSelected
                                          : Colors.white,
                                      width: 1)),
                              height: 37,
                              width: 130,
                              child: Text(
                                "Age",
                                style: TextStyle(
                                    color: Selected
                                        ? ConClrSelected
                                        : Colors.white),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              ageController.text = await Con_Wid.GlbDatePicker(
                                  isdatetime: true, pcontext: context);

                              dob = 'date';
                              _age_or_date_check = false;
                              year.clear();
                              month.clear();
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color:
                                      Selected ? ConClrSelected : Colors.white,
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
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      controller: year,
                                      hintText: "Year"),
                                  Con_Wid.textFieldWithInter(
                                      color1: ConsfontBlackColor,
                                      Onchanged: (value1) {},
                                      TextInput_Type: TextInputType.number,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      controller: month,
                                      hintText: "Month"),
                                ])
                          : Con_Wid.textFieldWithInter(
                              color1: ConsfontBlackColor,
                              width: MediaQuery.of(context).size.width / 2.5,
                              controller: bod,
                              hintText: "Date Of Birth"),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       Con_Wid.textFieldWithIntersmall(age, "Age"),
                      //       Con_Wid.textFieldWithIntersmall(
                      //           birthdate, "Birth Date"),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       Con_Wid.textFieldWithIntersmall(year, "Year"),
                      //       Con_Wid.textFieldWithIntersmall(month, "month"),
                      //     ],
                      //   ),
                      // ),
                      Con_Wid.textFieldWithInter(
                          text: "Horns",
                          controller: hornController,
                          hintText: "Horns"),
                      Con_Wid.textFieldWithInter(
                          text: "Horns Right",
                          controller: rHorns,
                          hintText: "Horns Right"),
                      Con_Wid.textFieldWithInter(
                          text: "Horns Left",
                          controller: lHorns,
                          hintText: "Horns Left"),

                      Con_Wid.textFieldWithInter(
                          text: "Tail & Colour",
                          controller: tailController,
                          hintText: "Tail & Colour"),
                      Con_Wid.textFieldWithInter(
                          TextInput_Type: TextInputType.number,
                          text: "Loan Number",
                          controller: loanNoController,
                          hintText: "Enter loan number"),
                      Con_Wid.textFieldWithInter(
                          TextInput_Type: TextInputType.number,
                          hintText: "Group / Proposal S.No.",
                          controller: _groupNo,
                          text: "Group / Proposal S.No."),
                      Con_Wid.textFieldWithInter(
                          TextInput_Type: TextInputType.number,
                          text: "Reciept Number",
                          controller: recieptNoController,
                          hintText: "Enter Reciept Number"),
                      Con_Wid.textFieldWithInter(
                          TextInput_Type: TextInputType.number,
                          text: "Visit Free",
                          controller: visitFeeController,
                          hintText: "Enter visit free"),
                      CondropDown(
                        title: 'Select Doctor',
                        itemList:
                            Con_List.M_inseminator.map((e) => e.name.toString())
                                .toList(),
                        SelectedList: mDoctor,
                        onSelected: (List<String> value) {
                          setState(() {
                            mDoctor = value;
                          });
                        },
                      ),
                      Con_Wid.height(10),
                      Con_Wid.paddingWithText(
                          "Died Date :- $actual_date", Conclrfontmain,
                          context: context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Today",
                            context: context,
                            ontap: () {
                              setState(() {
                                selectedDate = DateTime.now();
                                var formatter = DateFormat('dd-MM-yyyy');
                                dates = formatter.format(selectedDate);
                                var formatter1 = DateFormat('yyyy-MM-dd');
                                actual_date = formatter1.format(selectedDate);
                                botton2 = false;
                                botton3 = false;
                                botton1 = true;
                              });
                            },
                            Color: botton1 ? ConClrbluelight : ConClrLightBack,
                          ),
                          Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Yesterday",
                            context: context,
                            ontap: () {
                              setState(() {
                                DateTime pastDay =
                                    DateTime.now().subtract(Duration(days: 1));
                                selectedDate = pastDay;
                                var formatter = DateFormat('dd-MM-yyyy');
                                dates = formatter.format(pastDay);
                                var formatter1 = DateFormat('yyyy-MM-dd');
                                actual_date = formatter1.format(selectedDate);
                                botton3 = false;
                                botton1 = false;
                                botton2 = true;
                              });
                            },
                            Color: botton2 ? ConClrbluelight : ConClrLightBack,
                          ),
                          Con_Wid.selectionContainer(
                            height: 44,
                            width: 97,
                            text: "Calendar",
                            context: context,
                            ontap: () async {
                             String s = await Con_Wid.GlbDatePicker(
                                  isdatetime: true, pcontext: context);
                              selectedDate = DateTime.parse(s);
                              setState(() {
                                var formatter = DateFormat('dd-MM-yyyy');
                                dates = formatter.format(selectedDate);
                                var formatter1 = DateFormat('yyyy-MM-dd');
                                actual_date = formatter1.format(selectedDate);
                                botton1 = false;
                                botton2 = false;
                                botton3 = true;
                              });
                            },
                            Color: botton3 ? ConClrbluelight : ConClrLightBack,
                          ),
                        ],
                      ),
                      Con_Wid.height(16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Con_Wid.MainButton(
                                width: 160,
                                height: 36,
                                fontSize: 11,
                                pStrBtnName: 'Insurance Issue Date',
                                OnTap: () async {
                                  var temp = await Con_Wid.GlbDatePicker(
                                      isdatetime: true, pcontext: context);
                                  _insuranceIssuedDate =
                                      DateTime.parse(temp.toString());
                                  setState(() {});
                                }),
                            Con_Wid.width(16),
                            if (_insuranceIssuedDate != null)
                              Text(formatter1.format(_insuranceIssuedDate!)),
                          ],
                        ),
                      ),
                      Con_Wid.height(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Con_Wid.MainButton(
                                width: 160,
                                height: 36,
                                fontSize: 11,
                                pStrBtnName: 'Treated Form Date',
                                OnTap: () async {
                                  var temp = await Con_Wid.GlbDatePicker(
                                      isdatetime: true, pcontext: context);
                                  _treatedFromDate =
                                      DateTime.parse(temp.toString());
                                  setState(() {});
                                }),
                            Con_Wid.width(16),
                            if (_treatedFromDate != null)
                              Text(formatter1.format(_treatedFromDate!)),
                          ],
                        ),
                      ),
                      Con_Wid.height(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Con_Wid.MainButton(
                                width: 160,
                                height: 36,
                                fontSize: 11,
                                pStrBtnName: 'Treated To Date',
                                OnTap: () async {
                                  var temp = await Con_Wid.GlbDatePicker(
                                      isdatetime: true, pcontext: context);
                                  _treatedTodate =
                                      DateTime.parse(temp.toString());
                                  setState(() {});
                                }),
                            Con_Wid.width(16),
                            if (_treatedTodate != null)
                              Text(formatter1.format(_treatedTodate!)),
                          ],
                        ),
                      ),
                      Con_Wid.height(10),
                      Con_Wid.textFieldWithInter(
                          text: "Special identification mark",
                          controller: specialIndication,
                          hintText: "Special identification"),
                      Con_Wid.textFieldWithInter(
                          text: "Others",
                          controller: othersController,
                          hintText: "Others"),
                      Con_Wid.textFieldWithInter(
                          TextInput_Type: TextInputType.number,
                          text: "Milk Yield",
                          controller: _milkYeild,
                          hintText: "Milk Production (liter/day)"),
                      Con_Wid.textFieldWithInter(
                          TextInput_Type: TextInputType.number,
                          text: "Value prior to illness Rs",
                          controller: illnessValue,
                          hintText: "Value prior to illness Rs"),
                      Con_Wid.textFieldWithInter(
                          hintText: "Cause of death",
                          controller: _causeOfDeath,
                          text: "Cause of death"),

                      // Con_Wid.paddingWithText("Death Reason", Conclrfontmain),
                      CondropDown(
                        title: 'Death Reason',
                        itemList: Death_reason.map((e) => e['name'].toString())
                            .toList(),
                        SelectedList: Selected_DeathReason,
                        onSelected: (List<String> value) {
                          setState(() {
                            Selected_DeathReason = value;
                            deathReason = Death_reason.where((e) =>
                                e['name'].toString() ==
                                Selected_DeathReason[0].toString()).first['id'];
                          });
                        },
                      ),
                      Con_Wid.textFieldWithInter(
                          text: "Nature",
                          controller: _nature,
                          hintText: "Nature"),
                      Con_Wid.height(10),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Con_Wid.popinsfont(
                            "Did the animal have every care and attention ?",
                            Conclrfontmain,
                            FontWeight.w300,
                            10,
                            context),
                      ),
                      CondropDown(
                        // title: 'Did the animal have every care and attention ?',
                        title: '',
                        itemList: YesNoValue,
                        SelectedList: Selected_care_attention,
                        onSelected: (List<String> value) {
                          setState(() {
                            Selected_care_attention = value;

                            if (Selected_care_attention[0] ==
                                Con_Wid.Lang_Cng("Yes")) {
                              careAndAttenstionValue = true;
                            } else {
                              careAndAttenstionValue = false;
                            }
                          });
                        },
                      ),
                      Con_Wid.height(10),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Con_Wid.popinsfont(
                            "Did you examine / verify forInsurance & do you \nidentify theanimal ?",
                            Conclrfontmain,
                            FontWeight.w300,
                            10,
                            context),
                      ),
                      CondropDown(
                        title: '',
                        // 'Did you examine / verify forInsurance & do you identify theanimal ?',
                        itemList: YesNoValue,
                        SelectedList: Selected_insurence_identify,
                        onSelected: (List<String> value) {
                          setState(() {
                            Selected_insurence_identify = value;

                            if (Selected_insurence_identify[0] ==
                                Con_Wid.Lang_Cng("Yes")) {
                              examinValue = true;
                            } else {
                              examinValue = false;
                            }
                          });
                        },
                      ),
                      Con_Wid.textFieldWithInter(
                          hintText: "General Condition of Carcass",
                          controller: generalCondition,
                          text: "General Condition of Carcass"),
                      Con_Wid.height(5),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Con_Wid.paddingWithText("Image", Conclrfontmain,
                                context: context),
                            image == false
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18.0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Con_Wid.MainButton(
                                            width: 100,
                                            height: 35,
                                            // width: 80,
                                            // height: 36,
                                            fontSize: 12,
                                            pStrBtnName: "TagId Image",
                                            OnTap: () async {
                                              showDialog(context: context,builder: (context) {
                                                return AlertDialog(actions: [
                                                  Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
                                                    TextButton(onPressed: () async {
                                                      Navigator.pop(context);
                                                      final XFile? photo =
                                                          await picker.pickImage(
                                                          source:
                                                          ImageSource.camera,
                                                          imageQuality: 7);

                                                      Firstimage = photo!.path;
                                                      ImageBytecode =
                                                          await photo.readAsBytes();
                                                      base64Image1 =
                                                          base64Encode(ImageBytecode);
                                                      setState(() {
                                                        image = true;
                                                      });
                                                    }, child: Text("Picked from camera")),
                                                    TextButton(onPressed: () async {
                                                      Navigator.pop(context);
                                                      final XFile? photo =
                                                          await picker.pickImage(
                                                          source:
                                                          ImageSource.gallery,
                                                          imageQuality: 7);

                                                      Firstimage = photo!.path;
                                                      ImageBytecode =
                                                          await photo.readAsBytes();
                                                      base64Image1 =
                                                          base64Encode(ImageBytecode);
                                                      setState(() {
                                                        image = true;
                                                      });
                                                    }, child: Text("Picked from Gallery")),
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
                            Firstimage != ""
                                ? Secondimage == ""
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 18.0),
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
                                                  showDialog(context: context,builder: (context) {
                                                    return AlertDialog(actions: [
                                                      Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
                                                        TextButton(onPressed: () async {
                                                          Navigator.pop(context);
                                                          final XFile? photo =
                                                              await picker.pickImage(
                                                              source: ImageSource
                                                                  .camera,
                                                              imageQuality: 7);

                                                          Secondimage = photo!.path;
                                                          ImageBytecode =
                                                              await photo.readAsBytes();
                                                          base64Image2 = base64Encode(
                                                              ImageBytecode);
                                                          setState(() {
                                                            image = true;
                                                          });
                                                        }, child: Text("Picked from camera")),
                                                        TextButton(onPressed: () async {
                                                          Navigator.pop(context);
                                                          final XFile? photo =
                                                              await picker.pickImage(
                                                              source: ImageSource
                                                                  .gallery,
                                                              imageQuality: 7);

                                                          Secondimage = photo!.path;
                                                          ImageBytecode =
                                                              await photo.readAsBytes();
                                                          base64Image2 = base64Encode(
                                                              ImageBytecode);
                                                          setState(() {
                                                            image = true;
                                                          });
                                                        }, child: Text("Picked from Gallery")),
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
                                        width:
                                            MediaQuery.of(context).size.width -
                                                150,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 18.0),
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Con_Wid.MainButton(
                                                width: 120,
                                                height: 35,
                                                // width: 80,
                                                // height: 36,
                                                fontSize: 12,
                                                pStrBtnName: "Sideview Image",
                                                OnTap: () async {
                                                  showDialog(context: context,builder: (context) {
                                                    return AlertDialog(actions: [
                                                      Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
                                                        TextButton(onPressed: () async {
                                                          Navigator.pop(context);
                                                          final XFile? photo =
                                                              await picker.pickImage(
                                                              source: ImageSource
                                                                  .camera,
                                                              imageQuality: 7);
                                                          Therdimage = photo!.path;
                                                          ImageBytecode =
                                                              await photo.readAsBytes();
                                                          base64Image3 = base64Encode(
                                                              ImageBytecode);
                                                          setState(() {
                                                            image = true;
                                                          });
                                                        }, child: const Text("Picked from camera")),
                                                        TextButton(onPressed: () async {
                                                          Navigator.pop(context);
                                                          final XFile? photo =
                                                              await picker.pickImage(
                                                              source: ImageSource
                                                                  .gallery,
                                                              imageQuality: 7);

                                                          Therdimage = photo!.path;
                                                          ImageBytecode =
                                                              await photo.readAsBytes();
                                                          base64Image3 = base64Encode(
                                                              ImageBytecode);
                                                          setState(() {
                                                            image = true;
                                                          });
                                                        }, child: const Text("Picked from Gallery")),
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
                                        width:
                                            MediaQuery.of(context).size.width -
                                                150,
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  150,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 18.0),
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
                                                  showDialog(context: context,builder: (context) {
                                                    return AlertDialog(actions: [
                                                      Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
                                                        TextButton(onPressed: () async {
                                                          Navigator.pop(context);
                                                          final XFile? photo =
                                                              await picker.pickImage(
                                                              source: ImageSource
                                                                  .camera,
                                                              imageQuality: 7);

                                                          Fourimage = photo!.path;
                                                          ImageBytecode =
                                                              await photo.readAsBytes();
                                                          base64Image4 = base64Encode(
                                                              ImageBytecode);
                                                          setState(() {
                                                            image = true;
                                                          });
                                                        }, child: Text("Picked from camera")),
                                                        TextButton(onPressed: () async {
                                                          Navigator.pop(context);
                                                          final XFile? photo =
                                                              await picker.pickImage(
                                                              source: ImageSource
                                                                  .gallery,
                                                              imageQuality: 7);

                                                          Fourimage = photo!.path;
                                                          ImageBytecode =
                                                              await photo.readAsBytes();
                                                          base64Image4 = base64Encode(
                                                              ImageBytecode);
                                                          setState(() {
                                                            image = true;
                                                          });
                                                        }, child: Text("Picked from Gallery")),
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
                                        width:
                                            MediaQuery.of(context).size.width -
                                                150,
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
                      Con_Wid.height(20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Con_Wid.MainButton(
                              width: 150,
                              height: 42,
                              fontSize: 16,
                              pStrBtnName: 'Submit',
                              OnTap: () {
                                if (_isValidated()) _createPMCertificate();
                              }),
                        ],
                      )
                    ],
                  ))
                ],
              ),
            )),
          ),
          loading ? Center(child: Con_Wid.Con_Loding()) : Container(),
        ],
      ),
    );
  }

  void _getRequestItems() async {
    dcsCode = widget.visitmodel.dCSCode.toString();
    farmerCode = widget.visitmodel.farmerCode;
    farmerCode = widget.visitmodel.farmerCode;
    dcsName = widget.visitmodel.dCSName;
    animalId = widget.visitmodel.animalID;
    visitFeeController.text = widget.visitmodel.visitCost.toString();
  }

  bool _isValidated() {
    if (visitFeeController.text.trim().isEmpty ||
        tailController.text.trim().isEmpty ||
        hornController.text.trim().isEmpty ||
        generalCondition.text.trim().isEmpty ||
        illnessValue.text.trim().isEmpty ||
        recieptNoController.text.isEmpty) {
      Con_Wid.Con_Show_Toast(context, "Please enter all the required fields");

      return false;
    } else if (mDoctor == null) {
      Con_Wid.Con_Show_Toast(context, "Please Select doctor");

      return false;
    }
    // else if (leftRightEar == null) {
    //   showSnackBarMessage("Please Select ear of tag");
    //   return false;
    // }
    return true;
  }

  void _createPMCertificate() async {

    var formatter1 = DateFormat('MM/dd/yyyy');
    Duration? diff;
    if (ageController.text != "") {
      dob = formatter1.format(DateTime.parse(ageController.text));
      diff = DateTime.now().difference(DateTime.parse(ageController.text));
    } else {
      double y = 0.0;
      double m = 0.0;
      if (year.text != "") {
        y = double.parse(year.text) * 365;
      }
      if (month.text != "") {
        m = double.parse(year.text) * 30;
      }
      dob = formatter1.format(
          DateTime.now().subtract(Duration(days: y.toInt() + m.toInt())));
      diff = DateTime.now().difference(
          DateTime.now().subtract(Duration(days: y.toInt() + m.toInt())));
    }
    Age = diff.inDays;
    Age = Age ~/ 365;

    final Map<String, dynamic> data = {
      "TagID": _tagId.text,
      "VisitID": widget.visitmodel.visitID.toString(),
      "ProposalNo": _groupNo.text,
      "LoanNo": loanNoController.text.toString(),
      "Date": DateFormat('MM/dd/yyyy').format(DateTime.now()).toString(),
      "AnimalDiedDate": actual_date.toString(),
      "RecieptNo": recieptNoController.text.toString(),
      "DOB": dob,
      "Identificationmark": specialIndication.text,
      "Tail": tailController.text.toString(),
      "Colour": colorController.text.toString(),
      "Horns": hornController.text.toString(),
      "RTHorns": rHorns.text.toString(),
      "LTHorns": lHorns.text.toString(),
      "Others": othersController.text.toString(),
      "Value": illnessValue.text.toString(),
      "Causeofdeath": _causeOfDeath.text,
      "DeathReason": deathReason.toString(),
      "Age": Age,
      "Care": careAndAttenstionValue.toString(),
      "Identify": examinValue.toString(),
      "Condition": generalCondition.text.toString(),
      "LastMilk": _milkYeild.text.toString(),
      "RegistrationDate": actual_date,
      "SexFlg": (A_calf_sex == "Male" ? 1 : 2).toString(),
      "herd": herdController.text,
      "lot": lotController.text,
      "farmer": farmerController.text,
      "species": widget.visitmodel.species.toString(),
      "breed": mSelectbreed.isNotEmpty?Con_List.M_breed.firstWhere(
          (element) => element.name == mSelectbreed[0]).id:"",
      "InsuranceIssueDate": _insuranceIssuedDate.toString(),
      "TreatedFromDate": _treatedFromDate.toString(),
      "TreatedToDate": _treatedTodate.toString(),
      "Nature": _nature.text.toString(),
      "LeftearTag": _tagOnLeftEar.text.toString(),
      "LeftearMark": _leftEarTagRemark.text.toString(),
      "RightearTag": _tagId.text,
      "RightearMark": _rightEarTagRemark.text.toString(),
      "District": District.text,
      "AnimalImage": base64Image1,
      "AnimalImage1": base64Image2,
      "AnimalImage2": base64Image3,
      "AnimalImage3": base64Image4,
      "BodyColour": BodycolorController.text
    };

    log(data.toString());

    List titel = [
      "TagID", 
      "VisitID", 
      "ProposalNo", 
      "LoanNo", 
      "Date",
      "AnimalDiedDate", 
      "RecieptNo", 
      "DOB", 
      "Identificationmark",
      "Tail", 
      "Colour", 
      "Horns",
      "RTHorns", 
      "LTHorns", 
      "Others", 
      "Value",
      "Causeofdeath", 
      "DeathReason",
      "Age", 
      "Care", 
      "Identify", 
      "Condition",
      "LastMilk", 
      "RegistrationDate", 
      "SexFlg", 
      "herd",
      "lot", 
      "farmer", 
      "species", 
      "breed",
      "InsuranceIssueDate",
      "TreatedFromDate",
      "TreatedToDate",
      "Nature",
      "LeftearTag",
      "LeftearMark",
      "RightearTag",
      "RightearMark",
      "District", 
      "AnimalImage", 
      "AnimalImage1",
      "AnimalImage2", 
      "AnimalImage3",
      "BodyColour"
    ];
    List temp=[];
    temp.add(data);
    showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder: (context, setState1) {
        return Material(
          color: Colors.black,
          child: Container(
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
                            titel[index]=="SexFlg"?temp[0][titel[index]]=="1"?"Male":"Female":
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
                        setState1(() {
                          setState(() {
                            loading = false;
                          });
                        });
                      }, pStrBtnName: "Edit", height: 40, width: 80, fontSize: 14),
                      Con_Wid.MainButton(OnTap: () async {
                        setState1(() {
                          setState(() {
                            loading = true;
                          });
                        });

                        data['Age'] = Constants_Usermast.id;
                        data.forEach((key, value) {
                          if (key == "TreatedFromDate" ||
                              key == "TreatedToDate" ||
                              key == "InsuranceIssueDate") if (value == "null") {
                            data[key] = null;
                          }
                        });
                        final res = await ApiCalling.createPost(AppUrl().createPMCertificate,
                            "Bearer " + Constants_Usermast.token.toString(), data);

                        if (res.statusCode == 200) {
                          if (widget.visitmodel != null) {
                            SyncDB.Visit_Complete(widget.visitmodel.visitID.toString(),
                                widget.visitmodel.animalID.toString());
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) {
                                return VisitRegistrationScreen();
                              },
                            ));
                          }
                        } else
                            {
                          setState1(() {
                            setState(() {
                              loading = false;
                            });
                          });
                          Con_Wid.Con_Show_Toast(context, "Oops, something went wrong");
                        }
                      }, pStrBtnName: "Save", height: 40, width: 80, fontSize: 14),
                    ],)
                  ],
                ),
                loading? Center(child: CircularProgressIndicator(),):Container()
              ],
            ),
          ),
        );
      },);
    },
    );
  }
}
