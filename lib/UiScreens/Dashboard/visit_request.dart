// ignore_for_file: use_build_context_synchronously

import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_NetworkHelp.dart';
import 'package:herdmannew/component/DataBaseHelper/Con_List.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/tost.dart';
import 'package:herdmannew/model/Animal_Details_id.dart';
import 'package:hive/hive.dart';

import '../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../component/DataBaseHelper/Sync_Database.dart';
import '../../component/DataBaseHelper/Sync_Json.dart';
import '../../component/Gobal_Widgets/Con_Widget.dart';
import '../../model/Get_Master_Farmer.dart';
import 'Dashboard.dart';

class visit_request extends StatefulWidget {
  const visit_request({Key? key}) : super(key: key);

  @override
  State<visit_request> createState() => _visit_requestState();
}

class _visit_requestState extends State<visit_request> {
  TextEditingController mobilenumber = TextEditingController(),
      farmercode = TextEditingController(),
      farmername = TextEditingController(),
      receiptnumber = TextEditingController(),
      remark = TextEditingController();
  List<Animal_Details_id> FarmerDetail = [];
  Get_Master_Farmer? Farmer;
  List<String> selectedSociety = [];
  int pIntSelection = 0;

  //todo from old project
  int _selectedItemId = 0;
  int _selectedComplaint = 0;
  int _selectedSpecies = 0;
  int _selectedPaymentMode = 0;
  int _selectedType = 0;
  int _GlobalComplain = 0;
  bool _canSubmit = false;
  bool _selectDoctor = false;
  Map _selectedRequest = {};
  Map _selectedSortedsemen = {};
  Map selectedDoctor = {};
  List selectedComplaint = [];
  String updatenewfarmerid = "";

  // List<String> society = [];
  // List<String> SelectedSociety = [];
  bool _fetchingDetails = false;
  String newfarmerid = '';
  List doctors = [];
  String visitCost = '';
  List vehicles = [];
  String staffId = '';
  String doctorname = '';
  String lotid = '',
      herdid = '',
      Semone = 'Normal',
      zoneid = '';
  String herd_name = '',
      lot_name = '',
      owner_name = '',
      species_name = '',
      breed_name = '',
      status = '',
      lot_id_new = '';
  String labelherdnameid = "",
      labelzonenameid = "";
  TextEditingController labelsocname = TextEditingController(),
      labelherdname = TextEditingController(),
      labelzonename = TextEditingController(),
      _FarmerNameApi = TextEditingController(),
      _DSCNameApi = TextEditingController(),
      _FarmerDSCNameApi = TextEditingController(),
      _RouteNameApi = TextEditingController(),
      _ZoneNameApi = TextEditingController(),
      dscNameController = TextEditingController(),
      farmerNameController = TextEditingController();
  final List<Map> _visitTypes = [
    {
      "id": 18,
      "Name": Con_Wid.Lang_Cng("Normal Visit"),
      "Gujrathi": "નોર્મલ વિઝીટ",
    },
    {
      "id": 19,
      "Name": Con_Wid.Lang_Cng("Emergency Visit"),
      "Gujrathi": "ઈમર્જન્સી વિઝીટ",
    },
  ];

  final List<Map> _requests = [
    {
      "id": 1,
      "complaintId": null,
      "image": "Treatment.webp",
      "name": Con_Wid.Lang_Cng("Treatment"),
      "gujarathi": "સારવાર"
    },
    {
      "id": 2,
      "complaintId": 25,
      "image": "PM.webp",
      "name": Con_Wid.Lang_Cng("PM"),
      "gujarathi": "પોસ્ટમોર્ટમ"
    },
    {
      "id": 3,
      "complaintId": 24,
      "image": "SC.webp",
      "name": Con_Wid.Lang_Cng("SC"),
      "gujarathi": "લોન"
    },
    {
      "id": 4,
      "complaintId": 28,
      "image": "PDCheck.webp",
      "name": Con_Wid.Lang_Cng("PD"),
      "gujarathi": "ગર્ભાવસ્થા નિદાન"
    },
    {
      "id": 5,
      "complaintId": 13,
      "image": "Heat.webp",
      "name": Con_Wid.Lang_Cng("A.I"),
      "gujarathi": "એંઆઈ / બીજદાન"
    },
    {
      "id": 6,
      "complaintId": 26,
      "image": "Other.webp",
      "name": Con_Wid.Lang_Cng("Other"),
      "gujarathi": "અન્ય"
    },
  ];
  final List<Map> _visitComplints = [
    {
      "Sr No": 1,
      "Complaint": Con_Wid.Lang_Cng("Indigestion & Off feed"),
      "Gujrathi": "ખાતી–પીતી નથી"
    },
    {
      "Sr No": 2,
      "Complaint": Con_Wid.Lang_Cng("Fever \/ Pyrexia"),
      "Gujrathi": "તાવ"
    },
    {
      "Sr No": 3,
      "Complaint":
      Con_Wid.Lang_Cng("Mastitis \/ Blood in Milk \/ Udder affections"),
      "Gujrathi": "ગળીયો \/ બાવલાની બીમારી \/ દૂધમાં લોહી"
    },
    {
      "Sr No": 4,
      "Complaint": Con_Wid.Lang_Cng("Milkfever \/ Hypocalcaemia"),
      "Gujrathi": "સુવારોેગ \/ ઠંડી પડી જવી"
    },
    {
      "Sr No": 5,
      "Complaint": Con_Wid.Lang_Cng("Post partum sickness"),
      "Gujrathi": "વિયાણ પછી બિમાર "
    },
    {
      "Sr No": 6,
      "Complaint": Con_Wid.Lang_Cng("Dystokia"),
      "Gujrathi": "વિયાણમાં તકલીફ"
    },
    {
      "Sr No": 7,
      "Complaint": Con_Wid.Lang_Cng("Retention of Placenta"),
      "Gujrathi": "મેલી ન પડવી"
    },
    {
      "Sr No": 8,
      "Complaint": Con_Wid.Lang_Cng("Haemoglobinurea"),
      "Gujrathi": "લાલ પેશાબ"
    },
    {
      "Sr No": 9,
      "Complaint": Con_Wid.Lang_Cng("Theileriosis \/ Babesiosis"),
      "Gujrathi": "ઈતરડીનો તાવ"
    },
    {
      "Sr No": 10,
      "Complaint": Con_Wid.Lang_Cng("Bloat \/ Tympany"),
      "Gujrathi": "આફરો"
    },
    {
      "Sr No": 11,
      "Complaint": Con_Wid.Lang_Cng("Entritis"),
      "Gujrathi": "ઝાડા \/ દસ્ત \/ શેરવાનું"
    },
    {
      "Sr No": 12,
      "Complaint": Con_Wid.Lang_Cng("Abortion"),
      "Gujrathi": "તળવાઈ જવું"
    },
    {"Sr No": 13, "Complaint": Con_Wid.Lang_Cng("AI"), "Gujrathi": "બીજદાન"},
    {
      "Sr No": 14,
      "Complaint": Con_Wid.Lang_Cng("Prolaps"),
      "Gujrathi": "ગાતર કાઠવું\/ઠલવાઈ જવું\/દિલ કાઢવું"
    },
    {
      "Sr No": 15,
      "Complaint": Con_Wid.Lang_Cng("Wound"),
      "Gujrathi": "ઘા \/ વાગવું"
    },
    {
      "Sr No": 16,
      "Complaint": Con_Wid.Lang_Cng("Poisoning"),
      "Gujrathi": "ઝેરની અસર"
    },
    {
      "Sr No": 17,
      "Complaint": Con_Wid.Lang_Cng("Urolithiasis"),
      "Gujrathi": "પથરી\/પેશાબ બંધ થઈ જવો"
    },
    {
      "Sr No": 18,
      "Complaint": Con_Wid.Lang_Cng("Operational case"),
      "Gujrathi": "ઓપરેશન"
    },
    {
      "Sr No": 19,
      "Complaint": Con_Wid.Lang_Cng("Convulsion \/ Tetanus"),
      "Gujrathi": "ખેંચ \/ તાણ આવવી"
    },
    {
      "Sr No": 20,
      "Complaint": Con_Wid.Lang_Cng("Surra\/ Trypanosomiases \/"),
      "Gujrathi": "ચકરી આવવી"
    },
    {"Sr No": 21, "Complaint": Con_Wid.Lang_Cng("HS"), "Gujrathi": "ગળસુંઢો"},
    {
      "Sr No": 22,
      "Complaint": Con_Wid.Lang_Cng("FMD"),
      "Gujrathi": "ખરવા–મોવાસા"
    },
    {
      "Sr No": 23,
      "Complaint": Con_Wid.Lang_Cng("Rabies Vaccination"),
      "Gujrathi": "હડકવાની રસી"
    },
    {
      "Sr No": 24,
      "Complaint": Con_Wid.Lang_Cng("Loan Case"),
      "Gujrathi": "લોન કેશ \/ વિમો"
    },
    {
      "Sr No": 25,
      "Complaint": Con_Wid.Lang_Cng("PM \/ Death Verification"),
      "Gujrathi": "પી.એમ. \/ મરણ પ્રમાણ પત્ર"
    },
    {
      "Sr No": 26,
      "Complaint": Con_Wid.Lang_Cng("Other"),
      "Gujrathi": "અન્ય \/ ખબર નથી પડતી"
    },
    {
      "Sr No": 27,
      "Complaint": Con_Wid.Lang_Cng("Metal Detector"),
      "Gujrathi": "લોખંડની તપાસ"
    }
  ];

  final List<Map> species = [
    {"id": 1, "name": Con_Wid.Lang_Cng("Cattle"), "Gujarathi": "ગાય"},
    {"id": 2, "name": Con_Wid.Lang_Cng("Buffalo"), "Gujarathi": "ભેંસ"},
  ];

  final List<Map> sortedsemen = [
    {
      "id": 0,
      "name": Con_Wid.Lang_Cng("Normalsemen"),
      "Gujarathi": "નોર્મલ સીમેન",
      "value": false
    },
    {
      "id": 1,
      "name": Con_Wid.Lang_Cng("Sexedsortedsemen"),
      "Gujarathi": "સેકસ્ડ સોર્ટેડ સિમેન",
      "value": true
    },
  ];

  final List<Map> paymentMode = [
    {"id": 4, "name": Con_Wid.Lang_Cng("Receipt No"), "Gujarathi": "રસીદ નંબર"},
    {"id": 1, "name": Con_Wid.Lang_Cng("Cash"), "Gujarathi": "રોકડ"},
    {"id": 2, "name": Con_Wid.Lang_Cng("Online"), "Gujarathi": "ઓનલાઇન"},
    {"id": 3, "name": Con_Wid.Lang_Cng("Deduct"), "Gujarathi": "બાદ કરવું"},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initialize();
  }

  Future<void> _initialize() async {
    setState(() {
      mobilenumber.text = Constants_Usermast.mobileNumber;
      _selectedRequest = _requests[0];
      _selectedType = _visitTypes[0]['id'];
      _selectedRequest = _requests[0];
      _selectedType = 18; //Dev
      _selectedSpecies = 1; //Dev
      _selectedPaymentMode = 4;
      if (Constants_Usermast.groupId == 6) {
        _selectedRequest = _requests[4];
        _selectedItemId = _requests[4]["id"];
      }
    });
  }

  Future<bool> onBackPress() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DashBoardScreen()));
    return Future.value(false);
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "Visit / Seed Registration",
          Actions: [],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return DashBoardScreen();
              },
            ));
          },
        ),
        body: Con_Wid.backgroundContainer(
            child: Con_Wid.fullContainer(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                              value: pIntSelection,
                              groupValue: 0,
                              activeColor: ConClrMain,
                              onChanged: (index) {
                                setState(() {
                                  pIntSelection = 0;
                                });
                              }),
                          Con_Wid.gText("Mobile Number",
                              style: TextStyle(fontSize: 15)),
                          Radio(
                              value: pIntSelection,
                              activeColor: ConClrMain,
                              groupValue: 1,
                              onChanged: (index) {
                                setState(() {
                                  pIntSelection = 1;
                                });
                              }),
                          Con_Wid.gText(
                            "Farmer Code",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                      Con_Wid.height(10),
                      pIntSelection == 0
                          ? Container(
                        child: Column(
                          children: [
                            Con_Wid.height(5),
                            Con_Wid.textFieldWithInter(
                              text: 'Enter Mobile Number',
                              controller: mobilenumber,
                              TextInput_Type: TextInputType.number,
                              hintText: "Enter Mobile Number",
                              Onchanged: (p0) {
                                if (p0
                                    .toString()
                                    .isNotEmpty) {
                                  _getBreed(p0.toString());
                                  // mobilenumber.text = p0.toString();
                                }
                              },
                            )
                          ],
                        ),
                      )
                          : Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Con_Wid.paddingWithText(
                                    "Society", fontBlackColor,
                                    context: context)
                              ],
                            ),
                            CondropDown(
                              title: 'Select Society',
                              itemList: Con_List.M_Userlots.map(
                                      (e) => "${e.code}-${e.name}").toList(),
                              SelectedList: selectedSociety,
                              onSelected: (List<String> value) {
                                setState(() {
                                  selectedSociety = value;
                                  lot_name = value[0].split('-')[1];
                                  lot_id_new = Con_List.M_Userlots
                                      .firstWhere(
                                          (e) =>
                                      e.code.toString() ==
                                          value[0]
                                              .split("-")
                                              .first
                                              .toString())
                                      .id
                                      .toString();
                                });
                              },
                            ),
                            Con_Wid.textFieldWithInter(
                              text: "Enter the farmer code",
                              controller: farmercode,
                              TextInput_Type: TextInputType.number,
                              hintText: "Enter the farmer code",
                              Onchanged: (text) {
                                if (text != null) {
                                  Farmer = Con_List.M_Farmer.firstWhere(
                                          (element) =>
                                      element.code.toString() == text &&
                                          element.lot.toString() ==
                                              lot_id_new.toString());
                                  FarmerDetail = Con_List.id_Animal_Details
                                      .where((element) =>
                                  element.farmer == text.toString() &&
                                      element.lot == lot_id_new)
                                      .toList();
                                  if (Farmer != null) {
                                    farmername.text = Farmer!.name.toString();
                                    mobilenumber.text =
                                        Farmer!.mobile.toString();
                                    updatenewfarmerid = Farmer!.id.toString();
                                    setState(() {});
                                  }
                                }
                              },
                            ),
                            Con_Wid.textFieldWithInter(
                                text: "Enter Mobile Number",
                                controller: mobilenumber,
                                TextInput_Type: TextInputType.number,
                                hintText: "Enter Mobile Number"),
                            Con_Wid.textFieldWithInter(
                                text: "Farmer Name",
                                controller: farmername,
                                TextInput_Type: TextInputType.text,
                                hintText: "Farmer Name"),
                            Con_Wid.MainButton(
                                OnTap: () async {
                                  final res = await ApiCalling.createPatch(
                                      AppUrl().updatefarmermobile + "/" +
                                          updatenewfarmerid,
                                      "Bearer " +
                                          Constants_Usermast.token.toString(),
                                      {
                                        "mobile": mobilenumber.text,
                                        "farmername": farmername.text,
                                      });

                                  if (res.statusCode == 200) {
                                    var box = await Hive.openBox<
                                        Get_Master_Farmer>("Master_Farmer");
                                    var boxdata = box.get(updatenewfarmerid);
                                    boxdata!.mobile = mobilenumber.text;
                                    await box.put(updatenewfarmerid, boxdata);
                                    Sync_Json.Get_Master_Data("Master_farmer");
                                    Con_Wid.Con_Show_Toast(context,
                                        "MobileNo. Updated Successfully");
                                  } else {
                                    Con_Wid.Con_Show_Toast(context,
                                        "Something Went Wrong");
                                  }
                                },
                                pStrBtnName: "Update",
                                height: 40,
                                width: 180,
                                fontSize: 12)
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          pIntSelection == 0 ? WidFarmer : FarmerDSC,
                        ],
                      ),
                      Row(
                        children: [
                          pIntSelection == 0 ? DSCName : Container(),
                        ],
                      ),
                      Row(
                        children: [
                          pIntSelection == 0 ? Route : Container(),
                        ],
                      ),
                      Row(
                        children: [
                          pIntSelection == 0 ? Zone : Container(),
                        ],
                      ),
                      Con_Wid.height(10),
                      Container(
                          height: 250,
                          child: GridView.builder(
                            itemCount: 6,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              if (Constants_Usermast.groupId == 6) {
                                _selectedItemId = _requests[4]["id"];
                                _selectedRequest = _requests[4];
                                _selectedComplaint =
                                _requests[4]['complaintId'];

                                if (_selectedItemId == 4 ||
                                    _selectedItemId == 5) {
                                  _selectedType = _visitTypes[0]['id'];
                                  _selectedSortedsemen = sortedsemen[0];
                                }

                                if (_requests[4]['id'] == 2) {
                                  _GlobalComplain = 25;
                                }
                                if (_requests[4]['id'] == 3) {
                                  _GlobalComplain = 24;
                                }
                                if (_requests[4]['id'] == 5) {
                                  _GlobalComplain = 13;
                                }
                                if (_requests[4]['id'] == 4) {
                                  _GlobalComplain = 28;
                                }
                                if (_selectedItemId != 5) {}
                              }
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    Semone="Normal";
                                    if (Constants_Usermast.groupId == 6) {
                                      _selectedItemId = _requests[4]["id"];
                                      _selectedRequest = _requests[4];
                                      _selectedComplaint =
                                      _requests[4]['complaintId'];

                                      if (_selectedItemId == 4 ||
                                          _selectedItemId == 5) {
                                        _selectedType = _visitTypes[0]['id'];
                                        _selectedSortedsemen = sortedsemen[0];
                                        setState(() {});
                                      }

                                      if (_requests[4]['id'] == 2) {
                                        _GlobalComplain = 25;
                                      }
                                      if (_requests[4]['id'] == 3) {
                                        _GlobalComplain = 24;
                                      }
                                      if (_requests[4]['id'] == 5) {
                                        _GlobalComplain = 13;
                                      }
                                      if (_requests[4]['id'] == 4) {
                                        _GlobalComplain = 28;
                                      }
                                      if (_selectedItemId != 5) {
                                        return;
                                      }
                                    } else {
                                      _selectedItemId = _requests[index]["id"];
                                      _selectedRequest = _requests[index];
                                      if (index != 0) {
                                        _selectedComplaint =
                                        _requests[index]['complaintId'];
                                      }

                                      if (_selectedItemId == 4 ||
                                          _selectedItemId == 5) {
                                        _selectedType = _visitTypes[0]['id'];
                                        _selectedSortedsemen = sortedsemen[0];
                                        setState(() {});
                                      }

                                      if (_requests[index]['id'] == 2) {
                                        _GlobalComplain = 25;
                                      }
                                      if (_requests[index]['id'] == 3) {
                                        _GlobalComplain = 24;
                                      }
                                      if (_requests[index]['id'] == 5) {
                                        _GlobalComplain = 13;
                                      }
                                      if (_requests[index]['id'] == 4) {
                                        _GlobalComplain = 28;
                                      }
                                      if (_selectedItemId == 5) {
                                        return;
                                      }
                                    }

                                    _canSubmit = false;
                                    _selectDoctor = false;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: _selectedItemId ==
                                            _requests[index]["id"]
                                            ? Colors.transparent.withOpacity(
                                            0.2)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                            10)),
                                    height: 40,
                                    width: 96,
                                    child: Column(
                                      children: [
                                        Text(
                                          "${_requests[index]['name']}",
                                        ),
                                        Expanded(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .only(
                                                      bottomRight: Radius
                                                          .circular(10),
                                                      bottomLeft: Radius
                                                          .circular(10)),
                                                  image: _selectedItemId ==
                                                      _requests[index]["id"]
                                                      ? DecorationImage(
                                                      colorFilter: ColorFilter
                                                          .mode(
                                                          Colors.black
                                                              .withOpacity(0.2),
                                                          BlendMode.darken),
                                                      image: AssetImage(
                                                          "assets/images/${_requests[index]['image']}"))
                                                      : DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/${_requests[index]['image']}")))),
                                        ),
                                      ],
                                    )),
                              );
                            },
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Con_Wid.paddingWithText(
                              "Type of Visit", Conclrfontmain,
                              context: context),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: _visitTypes[0]['id'].toString(),
                              groupValue: _selectedType.toString(),
                              activeColor: ConClrMain,
                              onChanged: (value) {
                                setState(() {
                                  _selectedType = int.parse(value.toString());
                                  _canSubmit = false;
                                  _selectDoctor = false;
                                });
                              }),
                          Con_Wid.gText(_visitTypes[0]['Name']),
                          Radio(
                              value: _visitTypes[1]['id'].toString(),
                              activeColor: ConClrMain,
                              groupValue: _selectedType.toString(),
                              onChanged: (value) {
                                setState(() {
                                  if (_selectedItemId == 4 ||
                                      _selectedItemId == 5) {
                                    return null;
                                  }
                                  _canSubmit = false;
                                  _selectedType = int.parse(value.toString());
                                });
                              }),
                          Con_Wid.gText(_visitTypes[1]['Name'],
                              style: TextStyle(color: ConClrpending)),
                        ],
                      ),
                      Con_Wid.height(10),
                      // _selectedItemId == _requests[0]["id"]
                      //     ? CondropDown(
                      //         title: 'Select Society',
                      //         itemList:
                      //             Con_List.M_Userlots.map((e) => "${e.id}-${e.name}")
                      //                 .toList(),
                      //         SelectedList: selectedSociety,
                      //         onSelected: (List<String> value) {
                      //           setState(() {
                      //             selectedSociety = value;
                      //             lot_name = value[0].split('-')[1];
                      //           });
                      //         },
                      //       )
                      //     : Container(),
                      if (_selectedRequest == _requests[0])
                        CondropDown(
                          title: 'Select Complaint',
                          itemList: _visitComplints
                              .map((e) => e['Complaint'].toString())
                              .toList(),
                          SelectedList: [],
                          onSelected: (value) {
                            setState(() {
                              _canSubmit = false;
                              _selectDoctor = false;
                              selectedComplaint = value;
                              _selectedComplaint = _visitComplints
                                  .where((e) => e['Complaint'] == value[0])
                                  .map((e) => e['Sr No'])
                                  .first;
                              _GlobalComplain = _selectedComplaint;
                              // _selectedComplaint = _visitComplints.where((e) => )
                            });
                          },
                        ),
                      Con_Wid.height(10),
                      Row(
                        children: [
                          Con_Wid.paddingWithText(
                              "Species of Animals", Conclrfontmain,
                              context: context),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: species[0]['id'].toString(),
                            activeColor: ConClrMain,
                            groupValue: _selectedSpecies.toString(),
                            onChanged: (value) {
                              setState(() {
                                _canSubmit = false;
                                _selectDoctor = false;
                                _selectedSpecies = int.parse(value.toString());
                              });
                            },
                          ),
                          Con_Wid.gText(species[0]['name']),
                          Radio(
                              value: species[1]['id'].toString(),
                              groupValue: _selectedSpecies.toString(),
                              activeColor: ConClrMain,
                              onChanged: (value) {
                                setState(() {
                                  _canSubmit = false;
                                  _selectDoctor = false;
                                  _selectedSpecies =
                                      int.parse(value.toString());
                                });
                              }),
                          Con_Wid.gText(species[1]['name']),
                        ],
                      ),
                      if (_selectedRequest == _requests[4])
                        Column(children: [
                        Row(
                          children: [
                            Con_Wid.paddingWithText(
                                "Sire Type", Conclrfontmain,
                                context: context),
                          ],
                        ),
                        Row(children: [
                          SizedBox(width: 8),
                          Radio(value: "Normal",
                            activeColor: ConClrMain,
                            visualDensity: VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                            ),
                            groupValue: Semone,
                            onChanged: (value) {
                              setState(() {
                                Semone=value.toString();
                              });
                            },),
                          Con_Wid.gText("Normal"),
                          Radio(value: "Sorted",
                            groupValue: Semone,
                            activeColor: ConClrMain,
                            visualDensity: VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                            ),
                            onChanged: (value) {
                              setState(() {
                                Semone=value.toString();
                              });
                            },),
                          Con_Wid.gText("Sorted"),
                        ],),],),
                      Row(
                        children: [
                          Con_Wid.paddingWithText(
                            "Payment Mode",
                            context: context,
                            Conclrfontmain,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Radio(
                            value: paymentMode[0]['id'].toString(),
                            groupValue: _selectedPaymentMode.toString(),
                            activeColor: ConClrMain,
                            visualDensity: VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _canSubmit = false;
                                _selectDoctor = false;
                                _selectedPaymentMode =
                                    int.parse(value.toString());
                              });
                            },
                          ),

                          Con_Wid.gText(paymentMode[0]['name'],
                              style: TextStyle(fontSize: 12)),
                          Radio(
                              value: paymentMode[1]['id'].toString(),
                              groupValue: _selectedPaymentMode.toString(),
                              activeColor: ConClrMain,
                              visualDensity: VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _canSubmit = false;
                                  _selectDoctor = false;

                                  _selectedPaymentMode =
                                      int.parse(value.toString());
                                });
                              }),
                          Con_Wid.gText(paymentMode[1]['name'],
                              style: TextStyle(fontSize: 12)),
                          Radio(
                              value: paymentMode[2]['id'].toString(),
                              groupValue: _selectedPaymentMode.toString(),
                              activeColor: ConClrMain,
                              visualDensity: VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _canSubmit = false;
                                  _selectDoctor = false;

                                  _selectedPaymentMode =
                                      int.parse(value.toString());
                                });
                              }),
                          Con_Wid.gText(paymentMode[2]['name'],
                              style: TextStyle(fontSize: 12)),
                          Radio(
                              value: paymentMode[3]['id'].toString(),
                              groupValue: _selectedPaymentMode.toString(),
                              activeColor: ConClrMain,
                              visualDensity: VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _canSubmit = false;
                                  _selectDoctor = false;

                                  _selectedPaymentMode =
                                      int.parse(value.toString());
                                });
                              }),
                          Con_Wid.gText(paymentMode[3]['name'],
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      _selectedPaymentMode.toString() ==
                          paymentMode[0]['id'].toString()
                          ? Container(
                        child: Column(
                          children: [
                            Con_Wid.textFieldWithInter(
                                text: "Receipt Number",
                                controller: receiptnumber,
                                hintText: "Enter Receipt Number")
                          ],
                        ),
                      )
                          : Container(),
                      Container(
                        child: Column(
                          children: [
                            Con_Wid.textFieldWithInter(
                                text: "Remark",
                                controller: remark,
                                hintText: "Enter Remark")
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Con_Wid.textFieldWithInter(
                                text: "Enter Mobile Number",
                                controller: mobilenumber,
                                hintText: "Enter Mobile Number")
                          ],
                        ),
                      ),
                      if (_selectDoctor)
                        CondropDown(
                          title: 'Select Doctor',
                          itemList: doctors.map((e) => e['Name'].toString())
                              .toList(),
                          SelectedList: [
                            selectedDoctor['Name'] ?? 'Select Doctor'
                          ],
                          onSelected: (List<String> value) {
                            setState(() {
                              selectedDoctor = doctors.firstWhere(
                                      (e) =>
                                  e['Name'].toString() == value[0].toString());
                            });
                          },
                        ),
                      if (_canSubmit)
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      width: 100,
                                      child: Con_Wid.gText(
                                          "Available Doctor" + " :")),
                                  Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width - 200,
                                      child: Text(
                                        doctorname,
                                      ))
                                ],
                              ),
                              Container(
                                height: 20,
                              ),
                              Con_Wid.gText("Visit cost" + " : " + visitCost),
                            ],
                          ),
                        )
                      else
                        if (_fetchingDetails)
                          Center(
                              child: Column(
                                children: [
                                  Container(
                                    height: 30,
                                    child: CircularProgressIndicator(),
                                    width: 30,
                                  ),
                                  Con_Wid.gText("Available Doctor")
                                ],
                              )),
                      Con_Wid.MainButton(
                          OnTap: () async {
                            if (_validate() && !_fetchingDetails) {
                              _fetchingDetails = true;
                              setState(() {});
                              if (_canSubmit) {
                                await _addRequest();
                              } else {
                                if (_selectedRequest.toString() ==
                                    _requests[4].toString() ||
                                    _selectedType.toString() ==
                                        _requests[5]['id'].toString()) {
                                  if (!_selectDoctor) {
                                    await _getAitDoctors();
                                  } else {
                                    if (selectedDoctor != null) {
                                      staffId = selectedDoctor['id'].toString();
                                      await _addRequest();
                                    }
                                  }
                                } else {
                                  await _checkDoctors();
                                }
                              }
                            } else {
                              Toast.show(context,
                                  Con_Wid.Lang_Cng(
                                      "Please select all the fields"));
                            }
                            _fetchingDetails = false;
                            setState(() {});
                          },
                          pStrBtnName: "Submit",
                          height: 45,
                          width: 170,
                          fontSize: 13)
                    ],
                  ),
                ))),
      ),
    );
  }

  Widget get FarmerDSC =>
      _FarmerDSCNameApi.text.isNotEmpty
          ? Container(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30.0, bottom: 5.0),
                child: Text(
                  "Farmer Name : " + _FarmerDSCNameApi.text.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: const Color(0xFF4158B7),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      )
          : Container();

  Widget get WidFarmer =>
      _FarmerNameApi.text.isNotEmpty
          ? Container(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30.0, bottom: 5.0),
                child: Text(
                  "Farmer Name : " + _FarmerNameApi.text.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: const Color(0xFF4158B7),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      )
          : Container();

  Widget get DSCName =>
      _DSCNameApi.text.isNotEmpty
          ? Container(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30.0, bottom: 5.0),
                child: Text(
                  "Society : " + _DSCNameApi.text.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: const Color(0xFF4158B7),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      )
          : Container();

  Widget get Route =>
      _RouteNameApi.text.isNotEmpty
          ? Container(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30.0, bottom: 5.0),
                child: Text(
                  "Route : " + _RouteNameApi.text.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: const Color(0xFF4158B7),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      )
          : Container();

  Widget get Zone =>
      _ZoneNameApi.text.isNotEmpty
          ? Container(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30.0, bottom: 5.0),
                child: Text(
                  "Zonename : " + _ZoneNameApi.text.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: const Color(0xFF4158B7),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      )
          : Container();

  bool _validate() {
    if (_selectedType == 0 || _selectedComplaint == 0 || species == null) {
      return false;
    } else if(_selectedItemId == 0 && _selectedComplaint == 0){
        return false;

    } else {
      if (mobilenumber.text
          .trim()
          .length == 10) {
        return true;
      } else {
        Toast.show(context, "Please enter valid mobile number");
        return false;
      }
    }
  }

  Future _addRequest() async {
      final res = await ApiCalling.createPost(
          AppUrl().requestVisits, "Bearer " + Constants_Usermast.token, {
        "requestType": _selectedType,
        "farmer": pIntSelection == 0 ? newfarmerid : updatenewfarmerid,
        "farmerComplaint": _GlobalComplain,
        "animalTagId": mobilenumber.text,
        "staff": staffId,
        "uid": Constants_Usermast.id,
        "userid": Constants_Usermast.id,
        "species": _selectedSpecies,
        "sortedsemen": Semone =="Normal" ?"0":"1",
        "remark": remark.text
      });
      print({
        "requestType": _selectedType,
        "farmer": pIntSelection == 0 ? newfarmerid : updatenewfarmerid,
        "farmerComplaint": _GlobalComplain,
        "animalTagId": mobilenumber.text,
        "staff": staffId,
        "uid": Constants_Usermast.id,
        "userid": Constants_Usermast.id,
        "species": _selectedSpecies,
        "sortedsemen": Semone =="Normal" ?"0":"1",
        "remark": remark.text
      });
      if (res.statusCode == 200) {
        await SyncDB.SyncTable("VISITREGISTRATION", true).then((value) {
          Toast.show(context, "Request sent successfully");
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return DashBoardScreen();
            },
          ));
        });
      } else {
        Toast.show(context, "Oops something went wrong");
      }
    return true;
  }

  Future _checkDoctors() async {
    final dateTime = DateTime.now();
    final res1 = await ApiCalling.getdata(
        AppUrl().getVisitCost(
            "${dateTime.hour}:${dateTime.minute}",
            pIntSelection == 0 ? lotid.toString() : lot_id_new.toString(),
            _selectedType.toString()),
        Constants_Usermast.token);
    final res = await ApiCalling.getdata(
        AppUrl().getVisitVoAndStaff(
            "${dateTime.hour}:${dateTime.minute}",
            pIntSelection == 0 ? herdid : labelherdnameid,
            pIntSelection == 0 ? zoneid : labelzonenameid.toString()),
        Constants_Usermast.token);
    if (res1.statusCode == 200) {
      visitCost = jsonDecode(res1.body)[0]['VisitRate'];
    }
    if (res.statusCode == 200) {
      var responsedata = jsonDecode(res.body)[0];

      staffId = responsedata['vo'].toString();
      doctorname = responsedata['Name'];
      _canSubmit = true;
    } else {
      Toast.show(context, "Oops something went wrong..");
    }
    return true;
  }

  Future _getAitDoctors() async {
    var res = await ApiCalling.createPost(
        AppUrl().getDcsAitSorted, "Bearer " + Constants_Usermast.token, {
      "id": pIntSelection == 0 ? lotid.toString() : lot_id_new.toString(),
      "sorted": Semone =="Normal" ?"0":"1",
      "species": _selectedSpecies.toString()
    });

    if (res.statusCode == 200) {
      setState(() {
        List responseData = jsonDecode(res.body);
        doctors = responseData;

        _selectDoctor = true;
      });
    } else {
      Toast.show(context, "Oops something went wrong..");
    }

    return true;
  }

  void _getBreed(String mobile) async {
    final vehicleres = await ApiCalling.createPost(AppUrl().getVistiReqMobile,
        "Bearer " + Constants_Usermast.token, {"mobileno": mobile.toString()});
    if (vehicleres.statusCode == 200) {
      vehicles = json.decode(vehicleres.body);

      if (vehicles.isNotEmpty) {
        if (vehicles.length == 1) {
          if (Con_List.M_Farmer.any((element) =>
          element.id.toString() == vehicles[0]['Farmerid'].toString())) {
            _FarmerNameApi.text = vehicles[0]["farmername"] != null
                ? vehicles[0]["farmername"].toString()
                : "";
            newfarmerid = vehicles[0]["Farmerid"] != null
                ? vehicles[0]["Farmerid"].toString()
                : "";
            _DSCNameApi.text = vehicles[0]["lotname"] != null
                ? vehicles[0]["lotname"].toString()
                : "";
            _RouteNameApi.text = vehicles[0]["Herdname"] != null
                ? vehicles[0]["Herdname"].toString()
                : "";
            _ZoneNameApi.text = vehicles[0]["zonename"] != null
                ? vehicles[0]["zonename"].toString()
                : "";
            lotid = vehicles[0]["lotid"] != null
                ? vehicles[0]["lotid"].toString()
                : "";
            herdid = vehicles[0]["Herdid"] != null
                ? vehicles[0]["Herdid"].toString()
                : "";
            zoneid = vehicles[0]["zoneid"] != null
                ? vehicles[0]["zoneid"].toString()
                : "";
          }
        } else {
          clear();
        }
      } else {
        clear();
      }
    }
    setState(() {});
  }

  clear() {
    _FarmerNameApi.text = "";
    newfarmerid = "";
    _DSCNameApi.text = "";
    _RouteNameApi.text = "";
    _ZoneNameApi.text = "";
    lotid = "";
    herdid = "";
    zoneid = "";
  }
}
