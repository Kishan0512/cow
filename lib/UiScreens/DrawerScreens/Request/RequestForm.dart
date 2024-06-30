import 'package:flutter/material.dart';

import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../component/Gobal_Widgets/Con_Icons.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../../component/Gobal_Widgets/Con_Widget.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../Dashboard/Dashboard.dart';
import 'Request.dart';

class RequestForm extends StatefulWidget {
  const RequestForm({Key? key}) : super(key: key);

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  @override
  bool filterdate = false;
  String Status = "All";
  bool notshow = false;
  TextEditingController Quantity = TextEditingController();
  TextEditingController Feedname = TextEditingController();
  List<String> Species = [];
  List<dynamic> Semon = [];
  List<dynamic> Other = [];
  List<dynamic> Medicine = [];
  List<dynamic> Feed = [];
  DateTime RequestDate = DateTime.now();

  List<String> SelectedSpecies = [];
  bool loadedVisitData = false;
  List<String> Breed = [];
  List<String> SelectedBreed = [];
  List<String> Sementype = ["Normal", "Sorted"];
  var filteredUsers = [];
  List BreedCOnt = [
    'MEHSANA',
    'BANNI',
    'Murrah',
    'HF Cross',
    'HF',
    'HF x Kankrej',
    'Gir',
    'Kankrej',
    'HF IMP'
  ];
  List<String> SelectedSementype = [];
  List<String> Medicinetype = [];
  var vehicles = [];
  List<String> SelectedMedicinetype = [];
  List<String> Feedtype = [];
  List<String> SelectedFeedtype = [];
  List<String> other = [
    "AI Gun-4",
    "Sheeth-5",
    "Thawmonitor-6",
    "AI Forvceps-7",
    "Straw Cutter-8",
    "Thermose-9",
    "LN2 Container 3 Lit=10",
    "Scissor-11",
    "Cotton-12",
    "Tissue paper-13",
    "Thermometer-14",
    "PD Gloves-15",
    "Tag Numbers-16",
    "Tag Applicator-17",
    "LN2-18",
    "AI Gun with Lock-19",
    "MM Book-20",
    "AI Register-21"
  ];
  bool loading = false;
  List<String> Selectedother = [];

  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    getList();
  }

  getdata() {
    if (Con_List.M_Userherds.isEmpty ||
        Con_List.M_Userlots.isEmpty ||
        Con_List.M_species.isEmpty ||
        Con_List.M_breed.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_herd);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_lot);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_breed);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_species);
    }
  }

  getBreed() {
    Breed.clear();
    Con_List.M_breed.forEach((element) {
      if (element.species ==
          Con_List.M_species.where((e) => e.name == SelectedSpecies[0])
              .first
              .id) {
        if (Constants_Usermast.user_name.toLowerCase().startsWith("dsd")) {
          if (BreedCOnt.any((e) =>
              e.toString().toLowerCase() ==
              element.name.toString().toLowerCase())) {
            Breed.add(element.name);
          }
        } else {
          Breed.add(element.name);
        }
      }
    });
  }

  getList() {
    Con_List.M_species.forEach((element) {
      Species.add(element.name);
    });
    Con_List.M_medicineLedger.forEach((element) {
      Medicinetype.add(element.name);
      Feedtype.add("${element.name}" " - ${element.medicineCode}");
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Con_Wid.appBar(
          title: "Request Form",
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
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Con_Wid.height(10),
                    Container(
                      height: 50,
                      width: 211,
                      decoration: BoxDecoration(
                        color: con_clr.ConClr2
                            ? ConClrbluelight
                            : Color(0xFF5C99E8),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                              maxRadius: 26,
                              backgroundColor: con_clr.ConClr2
                                  ? ConClrBtn
                                  : Color(0xFFBCD5FA),
                              child: IconButton(
                                  splashRadius: 18,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (context, setState1) {
                                            return Dialog(
                                              child: Container(
                                                height: 380,
                                                decoration: BoxDecoration(
                                                  color: ConClrMainLight,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(children: [
                                                  Container(
                                                    height: 60,
                                                    width: double.infinity,
                                                    decoration: con_clr.ConClr2
                                                        ? BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                                    colors:
                                                                        ConClrAppbarGreadiant))
                                                        : BoxDecoration(
                                                            color:
                                                                ConClrDialog),
                                                    child: Stack(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Con_Wid.mIconButton(
                                                                color:
                                                                    fontwhiteColor,
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon:
                                                                    Own_Close),
                                                          ],
                                                        ),
                                                        Center(
                                                          child: Con_Wid
                                                              .popinsfont(
                                                                  "Semen",
                                                                  fontwhiteColor,
                                                                  FontWeight
                                                                      .w600,
                                                                  15,
                                                                  context),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 15, right: 15),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Con_Wid.height(5),
                                                          CondropDown(
                                                            title:
                                                                'Select Species',
                                                            itemList: Species,
                                                            SelectedList:
                                                                SelectedSpecies,
                                                            onSelected:
                                                                (List<String>
                                                                    value) {
                                                              setState1(() {
                                                                SelectedSpecies =
                                                                    value;
                                                                getBreed();
                                                              });
                                                            },
                                                          ),
                                                          // Con_Wid.paddingWithText(
                                                          //     "Select Breed",
                                                          //     Conclrfontmain),
                                                          Con_Wid.height(5),
                                                          CondropDown(
                                                            title:
                                                                'Select Breed',
                                                            itemList: Breed,
                                                            SelectedList:
                                                                SelectedBreed,
                                                            onSelected:
                                                                (List<String>
                                                                    value) {
                                                              setState1(() {
                                                                SelectedBreed =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                          // Con_Wid.paddingWithText(
                                                          //     "Semen Type",
                                                          //     Conclrfontmain),
                                                          Con_Wid.height(5),
                                                          CondropDown(
                                                            title:
                                                                'Select Semen Type',
                                                            itemList: Sementype,
                                                            SelectedList:
                                                                SelectedSementype,
                                                            onSelected:
                                                                (List<String>
                                                                    value) {
                                                              setState1(() {
                                                                SelectedSementype =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                          Con_Wid.height(5),
                                                          Con_Wid.textFieldWithInter(
                                                              text: "Quantity",
                                                              controller:
                                                                  Quantity,
                                                              hintText:
                                                                  "Enter Quantity"),
                                                          Con_Wid.height(20),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Con_Wid
                                                                  .MainButton(
                                                                      OnTap:
                                                                          () {
                                                                        Map data =
                                                                            {
                                                                          "inputDate":
                                                                              DateTime.now().toString(),
                                                                          "staffId": Constants_Usermast
                                                                              .staff
                                                                              .toString(),
                                                                          "breed": Con_List.M_breed.where((element) => element.name == SelectedBreed[0])
                                                                              .first
                                                                              .id
                                                                              .toString(),
                                                                          "bName":
                                                                              SelectedBreed[0],
                                                                          "sorted": SelectedSementype[0] == "Sorted"
                                                                              ? "0"
                                                                              : "1",
                                                                          "quantity":
                                                                              Quantity.text,
                                                                          "remark":
                                                                              "Remarks",
                                                                          "requestStatus":
                                                                              "R",
                                                                          "species":
                                                                              SelectedSpecies[0],
                                                                        };
                                                                        Semon.add(
                                                                            data);
                                                                        SelectedBreed =
                                                                            [];
                                                                        SelectedSementype =
                                                                            [];
                                                                        SelectedSpecies =
                                                                            [];
                                                                        Quantity
                                                                            .clear();
                                                                        Navigator.pop(
                                                                            context);
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      pStrBtnName:
                                                                          "Save",
                                                                      height:
                                                                          45,
                                                                      width:
                                                                          180,
                                                                      fontSize:
                                                                          16)
                                                            ],
                                                          )
                                                        ]),
                                                  )
                                                ]),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ))),
                          Con_Wid.div(),
                          Con_Wid.paddingWithText(
                              "Semen", context: context, fontwhiteColor)
                        ],
                      ),
                    ),
                    Semon.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height:
                                    80 * double.parse(Semon.length.toString()),
                                width: MediaQuery.of(context).size.width - 50,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: Semon.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.all(4),
                                      padding:
                                          EdgeInsets.only(right: 5, left: 5),
                                      height: 71,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.blue),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  'Species :${Semon[index]['species']}',
                                                  style: TextStyle(
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                            ),
                                            IconButton(
                                                splashRadius: 20,
                                                splashColor: Colors.white,
                                                onPressed: () {
                                                  setState(() {
                                                    Semon.removeAt(index);
                                                  });
                                                },
                                                icon: Own_delete)
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Breed : ${Semon[index]['bName']}"),
                                            Text(
                                                "Quantity : ${Semon[index]['quantity']}"),
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
                    Con_Wid.div(),
                    Container(
                      height: 50,
                      width: 211,
                      decoration: BoxDecoration(
                        color: con_clr.ConClr2
                            ? ConClrbluelight
                            : Color(0xFF5C99E8),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                              maxRadius: 26,
                              backgroundColor: con_clr.ConClr2
                                  ? ConClrBtn
                                  : Color(0xFFBCD5FA),
                              child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (context, setState1) {
                                            return Dialog(
                                              child: Container(
                                                height: 250,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: ConClrMainLight),
                                                child: Column(children: [
                                                  Container(
                                                    height: 60,
                                                    width: double.infinity,
                                                    decoration: con_clr.ConClr2
                                                        ? BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                                    colors:
                                                                        ConClrAppbarGreadiant))
                                                        : BoxDecoration(
                                                            color:
                                                                ConClrDialog),
                                                    child: Stack(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Con_Wid.mIconButton(
                                                                color:
                                                                    fontwhiteColor,
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon:
                                                                    Own_Close),
                                                          ],
                                                        ),
                                                        Center(
                                                          child: Con_Wid
                                                              .popinsfont(
                                                                  "Other",
                                                                  fontwhiteColor,
                                                                  FontWeight
                                                                      .w600,
                                                                  15,
                                                                  context),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 15, right: 15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // Con_Wid.paddingWithText(
                                                        //     "Item",
                                                        //     Conclrfontmain),
                                                        Con_Wid.height(5),
                                                        CondropDown(
                                                          title: 'Select Item',
                                                          itemList: other,
                                                          SelectedList:
                                                              Selectedother,
                                                          onSelected:
                                                              (List<String>
                                                                  value) {
                                                            setState1(() {});
                                                          },
                                                        ),
                                                        Con_Wid.height(5),
                                                        Con_Wid.textFieldWithInter(
                                                            TextInput_Type:
                                                                TextInputType
                                                                    .numberWithOptions(),
                                                            text: "Quantity",
                                                            controller:
                                                                Quantity,
                                                            hintText:
                                                                " Enter Quantity"),
                                                        Con_Wid.height(20),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Con_Wid.MainButton(
                                                                OnTap: () {
                                                                  String
                                                                      Itemcode =
                                                                      Selectedother[
                                                                          0];
                                                                  Map data = {
                                                                    "item":
                                                                        Selectedother[
                                                                            0],
                                                                    "requestType": Itemcode.substring(
                                                                        Itemcode.indexOf("-") +
                                                                            1,
                                                                        Itemcode
                                                                            .length),
                                                                    "inputDate":
                                                                        DateTime.now()
                                                                            .toString(),
                                                                    "staffId":
                                                                        Constants_Usermast
                                                                            .staff,
                                                                    "itemCode": int.parse(Itemcode.substring(
                                                                        Itemcode.indexOf("-") +
                                                                            1,
                                                                        Itemcode
                                                                            .length)),
                                                                    "quantity":
                                                                        Quantity
                                                                            .text,
                                                                    "remark":
                                                                        'Remarks',
                                                                    "requestStatus":
                                                                        "R"
                                                                  };
                                                                  Other.add(
                                                                      data);
                                                                  Selectedother =
                                                                      [];
                                                                  Quantity
                                                                      .clear();
                                                                  Navigator.pop(
                                                                      context);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                pStrBtnName:
                                                                    "Save",
                                                                height: 45,
                                                                width: 180,
                                                                fontSize: 16)
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ))),
                          Con_Wid.div(),
                          Con_Wid.paddingWithText(
                              "Other", context: context, fontwhiteColor)
                        ],
                      ),
                    ),
                    Other.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height:
                                    80 * double.parse(Other.length.toString()),
                                width: MediaQuery.of(context).size.width - 50,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: Other.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.all(4),
                                      padding:
                                          EdgeInsets.only(right: 5, left: 5),
                                      height: 71,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.blue),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  '${Other[index]['item']}',
                                                  style: TextStyle(
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                            ),
                                            IconButton(
                                                splashRadius: 20,
                                                splashColor: Colors.white,
                                                onPressed: () {
                                                  setState(() {
                                                    Other.removeAt(index);
                                                  });
                                                },
                                                icon: Own_delete)
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Quantity : ${Other[index]['quantity']}"),
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
                    Con_Wid.div(),
                    Container(
                      height: 50,
                      width: 211,
                      decoration: BoxDecoration(
                        color: con_clr.ConClr2
                            ? ConClrbluelight
                            : Color(0xFF5C99E8),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                              maxRadius: 26,
                              backgroundColor: con_clr.ConClr2
                                  ? ConClrBtn
                                  : Color(0xFFBCD5FA),
                              child: IconButton(
                                  splashRadius: 18,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (context, setState1) {
                                              return Dialog(
                                                child: Container(
                                                  height: 250,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: ConClrMainLight),
                                                  child: Column(children: [
                                                    Container(
                                                        height: 60,
                                                        width: double.infinity,
                                                        decoration: con_clr
                                                                .ConClr2
                                                            ? BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                        colors:
                                                                            ConClrAppbarGreadiant))
                                                            : BoxDecoration(
                                                                color:
                                                                    ConClrDialog),
                                                        child: Stack(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Con_Wid
                                                                    .mIconButton(
                                                                        color:
                                                                            fontwhiteColor,
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        icon:
                                                                            Own_Close),
                                                              ],
                                                            ),
                                                            Center(
                                                              child: Con_Wid
                                                                  .popinsfont(
                                                                      "Medicine",
                                                                      fontwhiteColor,
                                                                      FontWeight
                                                                          .w600,
                                                                      15,
                                                                      context),
                                                            )
                                                          ],
                                                        )),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 15, right: 15),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            // Con_Wid.paddingWithText(
                                                            //     "Medicine Type",
                                                            //     Conclrfontmain),
                                                            Con_Wid.height(5),
                                                            CondropDown(
                                                              title:
                                                                  'Select Medicine Type',
                                                              itemList:
                                                                  Medicinetype,
                                                              SelectedList:
                                                                  SelectedMedicinetype,
                                                              onSelected:
                                                                  (List<String>
                                                                      value) {
                                                                setState1(
                                                                    () {});
                                                              },
                                                            ),
                                                            Con_Wid.height(5),
                                                            Con_Wid.textFieldWithInter(
                                                                text:
                                                                    "Quantity",
                                                                controller:
                                                                    Quantity,
                                                                hintText:
                                                                    "Enter Quantity"),
                                                            Con_Wid.height(20),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Con_Wid
                                                                    .MainButton(
                                                                        OnTap:
                                                                            () {
                                                                          String Medicinetype = Con_List.M_medicineLedger.where((element) => element.name == SelectedMedicinetype[0])
                                                                              .first
                                                                              .id
                                                                              .toString();
                                                                          Map data =
                                                                              {
                                                                            "Name":
                                                                                SelectedMedicinetype[0],
                                                                            "inputDate":
                                                                                DateTime.now().toString(),
                                                                            "staffId":
                                                                                Constants_Usermast.staff,
                                                                            "medicine":
                                                                                Medicinetype,
                                                                            "quantity":
                                                                                Quantity.text,
                                                                            "remark":
                                                                                'None',
                                                                            "requestStatus":
                                                                                "R"
                                                                          };
                                                                          Medicine.add(
                                                                              data);
                                                                          SelectedMedicinetype =
                                                                              [];
                                                                          Quantity
                                                                              .clear();
                                                                          Navigator.pop(
                                                                              context);
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        pStrBtnName:
                                                                            "Save",
                                                                        height:
                                                                            45,
                                                                        width:
                                                                            180,
                                                                        fontSize:
                                                                            16)
                                                              ],
                                                            )
                                                          ]),
                                                    )
                                                  ]),
                                                ),
                                              );
                                            },
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ))),
                          Con_Wid.div(),
                          Con_Wid.paddingWithText(
                              "Medicine", context: context, fontwhiteColor)
                        ],
                      ),
                    ),
                    Medicine.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 80 *
                                    double.parse(Medicine.length.toString()),
                                width: MediaQuery.of(context).size.width - 50,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: Medicine.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.all(4),
                                      padding:
                                          EdgeInsets.only(right: 5, left: 5),
                                      height: 71,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.blue),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  '${Medicine[index]['Name']}',
                                                  style: TextStyle(
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                            ),
                                            IconButton(
                                                splashRadius: 20,
                                                splashColor: Colors.white,
                                                onPressed: () {
                                                  setState(() {
                                                    Medicine.removeAt(index);
                                                  });
                                                },
                                                icon: Own_delete)
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Quantity : ${Medicine[index]['quantity']}"),
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
                    Con_Wid.div(),
                    Container(
                      height: 50,
                      width: 211,
                      decoration: BoxDecoration(
                        color: con_clr.ConClr2
                            ? ConClrbluelight
                            : Color(0xFF5C99E8),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                              maxRadius: 26,
                              backgroundColor: con_clr.ConClr2
                                  ? ConClrBtn
                                  : Color(0xFFBCD5FA),
                              child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (context, setState1) {
                                            return Dialog(
                                              child: Container(
                                                height: 300,
                                                decoration: BoxDecoration(
                                                  color: ConClrMainLight,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(children: [
                                                  Container(
                                                    height: 60,
                                                    width: double.infinity,
                                                    decoration: con_clr.ConClr2
                                                        ? BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                                    colors:
                                                                        ConClrAppbarGreadiant))
                                                        : BoxDecoration(
                                                            color:
                                                                ConClrDialog),
                                                    child: Stack(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Con_Wid.mIconButton(
                                                                color:
                                                                    fontwhiteColor,
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon:
                                                                    Own_Close),
                                                          ],
                                                        ),
                                                        Center(
                                                          child: Con_Wid
                                                              .popinsfont(
                                                                  "Feed",
                                                                  fontwhiteColor,
                                                                  FontWeight
                                                                      .w600,
                                                                  15,
                                                                  context),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 15, right: 15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // Con_Wid.paddingWithText(
                                                        //     "Feed type",
                                                        //     Conclrfontmain),
                                                        Con_Wid.height(5),
                                                        CondropDown(
                                                          title:
                                                              'Select Feed type',
                                                          itemList: Feedtype,
                                                          SelectedList:
                                                              SelectedFeedtype,
                                                          onSelected:
                                                              (List<String>
                                                                  value) {
                                                            setState1(() {});
                                                          },
                                                        ),
                                                        Con_Wid.height(5),
                                                        Con_Wid.textFieldWithInter(
                                                            text: "Feed Name",
                                                            controller:
                                                                Feedname,
                                                            hintText:
                                                                "Enter Feed Name"),
                                                        Con_Wid.height(5),
                                                        Con_Wid
                                                            .textFieldWithInter(
                                                                text:
                                                                    "Quantity",
                                                                controller:
                                                                    Quantity,
                                                                hintText:
                                                                    "Quantity"),
                                                        Con_Wid.height(20),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Con_Wid.MainButton(
                                                                OnTap: () {
                                                                  String
                                                                      mednumber =
                                                                      SelectedFeedtype[
                                                                          0];
                                                                  Map data = {
                                                                    'Fname':
                                                                        Feedname
                                                                            .text,
                                                                    "name":
                                                                        SelectedFeedtype[
                                                                            0],
                                                                    "inputDate":
                                                                        DateTime.now()
                                                                            .toString(),
                                                                    "staffId":
                                                                        Constants_Usermast
                                                                            .staff,
                                                                    "feed": int.parse(mednumber.substring(
                                                                        mednumber.indexOf("-") +
                                                                            2,
                                                                        mednumber
                                                                            .length)),
                                                                    "quantity":
                                                                        Quantity
                                                                            .text,
                                                                    "remark":
                                                                        'Remarks',
                                                                    "requestStatus":
                                                                        "R"
                                                                  };
                                                                  Feed.add(
                                                                      data);
                                                                  SelectedFeedtype =
                                                                      [];
                                                                  Quantity
                                                                      .clear();
                                                                  Feedname
                                                                      .clear();
                                                                  Navigator.pop(
                                                                      context);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                pStrBtnName:
                                                                    "Save",
                                                                height: 45,
                                                                width: 180,
                                                                fontSize: 16)
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ))),
                          Con_Wid.div(),
                          Con_Wid.paddingWithText(
                              "Feed", context: context, fontwhiteColor)
                        ],
                      ),
                    ),
                    Feed.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height:
                                    80 * double.parse(Feed.length.toString()),
                                width: MediaQuery.of(context).size.width - 50,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: Feed.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.all(4),
                                      padding:
                                          EdgeInsets.only(right: 5, left: 5),
                                      height: 71,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.blue),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  '${Feed[index]['name']}',
                                                  style: TextStyle(
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                            ),
                                            IconButton(
                                                splashRadius: 20,
                                                splashColor: Colors.white,
                                                onPressed: () {
                                                  setState(() {
                                                    Feed.removeAt(index);
                                                  });
                                                },
                                                icon: Own_delete)
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Quantity : ${Feed[index]['quantity']}"),
                                            Text(
                                                "Feed Name : ${Feed[index]['Fname']}"),
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
                    Con_Wid.div(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Con_Wid.selectionContainer(
                                text: "RESET",
                                context: context,
                                ontap: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return DashBoardScreen();
                                    },
                                  ));
                                },
                                Color: con_clr.ConClr2
                                    ? ConClrLightBack
                                    : whiteColor,
                                textcolor:
                                    con_clr.ConClr2 ? whiteColor : ConClrDialog,
                                height: 40,
                                width: double.infinity)),
                        Con_Wid.div(),
                        Expanded(
                            child: Con_Wid.selectionContainer(
                                text: "SUBMIT",
                                context: context,
                                ontap: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  for (int i = 0; i < Semon.length; i++) {
                                    Semon[i].remove('species');
                                    Semon[i].remove('bName');
                                    await _updatesemen(Semon[i]);
                                  }
                                  for (int i = 0; i < Other.length; i++) {
                                    Other[i].remove('item');

                                    await _updateData(Other[i]);
                                  }
                                  for (int i = 0; i < Medicine.length; i++) {
                                    Medicine[i].remove('Name');

                                    await _updatemedicine(Medicine[i]);
                                  }
                                  for (int i = 0; i < Feed.length; i++) {
                                    Feed[i].remove('name');
                                    Feed[i].remove('Fname');
                                    await _updateFeed(Feed[i]);
                                  }
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return RequestScreen();
                                    },
                                  ));
                                  Con_Wid.Con_Show_Toast(
                                      context, "Request send Successfully");
                                },
                                Color: con_clr.ConClr2
                                    ? ConClrbluelight
                                    : ConClrDialog,
                                height: 40,
                                width: double.infinity)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container()
          ],
        ));
  }

  _updatesemen(Map Data) async {
    final res = await ApiCalling.createPost(AppUrl().requestfirstsemen,
        "Bearer " + Constants_Usermast.token.toString(), Data);

  }

  _updatemedicine(Map Data) async {
    final res = await ApiCalling.createPost(AppUrl().requestsecondmedicine,
        "Bearer " + Constants_Usermast.token.toString(), Data);
  }

  _updateFeed(Map Data) async {
    final res = await ApiCalling.createPost(AppUrl().requestthirdseed,
        "Bearer " + Constants_Usermast.token.toString(), Data);
  }

  _updateData(Map Data) async {
    final res = await ApiCalling.createPost(AppUrl().requestItemsRequest,
        "Bearer " + Constants_Usermast.token.toString(), Data);
  }
}
