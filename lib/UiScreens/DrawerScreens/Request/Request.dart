import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/Request/requestformpopup.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_ApiUrl.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_NetworkHelp.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:intl/intl.dart';

import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Con_Icons.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../Dashboard/Dashboard.dart';
import 'RequestForm.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  bool filterdate = false;
  String Status = "All";
  bool notshow = false;
  TextEditingController Quantity = TextEditingController();
  TextEditingController Feedname = TextEditingController();
  List<String> Species = [];
  DateTime RequestDate = DateTime.now();

  List<String> SelectedSpecies = [];
  int _itemCount = 0;
  bool loadedVisitData = false;
  List<String> Breed = [];
  List<String> SelectedBreed = [];
  List<String> Sementype = ["Normal", "Sorted"];
  var filteredUsers = [];
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
  List<String> Selectedother = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    getList();
    _getBreed("");
  }

  getBreed() {
    Breed.clear();
    Con_List.M_breed.forEach((element) {
      if (element.species ==
          Con_List.M_species.where((e) => e.name == SelectedSpecies[0])
              .first
              .id) {
        Breed.add(element.name);
      }
    });
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
    String appVersion = DateFormat('dd-MM-yyyy').format(RequestDate);
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
          appBar: Con_Wid.appBar(
            title: "Request",
            Actions: [
              Con_Wid.mIconButton(
                  iconSize: 30,
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
                                    borderRadius: BorderRadius.circular(10),
                                    color: con_clr.ConClr2
                                        ? fontwhiteColor
                                        : whiteColor),
                                child: Column(children: [
                                  Container(
                                    height: 60,
                                    width: double.infinity,
                                    decoration: con_clr.ConClr2
                                        ? BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: ConClrAppbarGreadiant))
                                        : BoxDecoration(color: ConClrDialog),
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
                                              "Select Status",
                                              fontwhiteColor,
                                              FontWeight.w600,
                                              15,
                                              context),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: "All",
                                        groupValue: Status,
                                        onChanged: (value) {
                                          setState1(() {
                                            Status = value.toString();
                                          });
                                        },
                                      ),
                                      Con_Wid.paddingWithText(
                                          "All", Conclrfontmain,
                                          context: context)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: "Dispatched",
                                        groupValue: Status,
                                        onChanged: (value) {
                                          setState1(() {
                                            Status = value.toString();
                                          });
                                        },
                                      ),
                                      Con_Wid.paddingWithText(
                                          "Dispatched", Conclrfontmain,
                                          context: context)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: "Received",
                                        groupValue: Status,
                                        onChanged: (value) {
                                          setState1(() {
                                            Status = value.toString();
                                          });
                                        },
                                      ),
                                      Con_Wid.paddingWithText(
                                          "Received",
                                          context: context,
                                          Conclrfontmain)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: "Approved",
                                        groupValue: Status,
                                        onChanged: (value) {
                                          setState1(() {
                                            Status = value.toString();
                                          });
                                        },
                                      ),
                                      Con_Wid.paddingWithText(
                                          "Approved", Conclrfontmain,
                                          context: context)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: "On the Way",
                                        groupValue: Status,
                                        onChanged: (value) {
                                          setState1(() {
                                            Status = value.toString();
                                          });
                                        },
                                      ),
                                      Con_Wid.paddingWithText(
                                          "On the Way",
                                          context: context,
                                          Conclrfontmain)
                                    ],
                                  )
                                ]),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  icon: Own_tune),
              Con_Wid.width(5),
              Con_Wid.mIconButton(
                  iconSize: 30, onPressed: () {
                _getBreed("");
                setState(() {});
              }, icon: Own_Refresh),
            ],
            onBackTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return DashBoardScreen();
                },
              ));
            },
          ),
          floatingActionButton:
              Constants_Usermast.groupId != 22 &&
                      Constants_Usermast.groupId != 22
                  ? (notshow == true)
                      ? Container()
                      : Con_Wid.floatingButtontimeline(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              return RequestForm();
                            },));
                            // showDialog(
                            //   context: context,
                            //   builder: (context) {
                            //     return Dialog(
                            //       child: Container(
                            //         decoration: BoxDecoration(
                            //           color: con_clr.ConClr2
                            //               ? ConClrMainLight
                            //               : whiteColor1,
                            //         ),
                            //         height: 400,
                            //         padding: EdgeInsets.all(10),
                            //         width:
                            //             MediaQuery.of(context).size.width / 2,
                            //         child: SingleChildScrollView(
                            //           child: Column(
                            //             children: [
                            //               Con_Wid.height(10),
                            //               Container(
                            //                 height: 50,
                            //                 width: 211,
                            //                 decoration: BoxDecoration(
                            //                   color: con_clr.ConClr2
                            //                       ? ConClrbluelight
                            //                       : Color(0xFF5C99E8),
                            //                   borderRadius:
                            //                       BorderRadius.circular(40),
                            //                 ),
                            //                 child: Row(
                            //                   children: [
                            //                     CircleAvatar(
                            //                         maxRadius: 26,
                            //                         backgroundColor:
                            //                             con_clr.ConClr2
                            //                                 ? ConClrBtn
                            //                                 : Color(0xFFBCD5FA),
                            //                         child: IconButton(
                            //                             splashRadius: 18,
                            //                             onPressed: () {
                            //                               showDialog(
                            //                                 context: context,
                            //                                 builder: (context) {
                            //                                   return StatefulBuilder(
                            //                                     builder: (context,
                            //                                         setState1) {
                            //                                       return Dialog(
                            //                                         child:
                            //                                             Container(
                            //                                           height:
                            //                                               380,
                            //                                           decoration:
                            //                                               BoxDecoration(
                            //                                             color:
                            //                                                 ConClrMainLight,
                            //                                             borderRadius:
                            //                                                 BorderRadius.circular(10),
                            //                                           ),
                            //                                           child: Column(
                            //                                               children: [
                            //                                                 Container(
                            //                                                   height: 60,
                            //                                                   width: double.infinity,
                            //                                                   decoration: con_clr.ConClr2 ? BoxDecoration(gradient: LinearGradient(colors: ConClrAppbarGreadiant)) : BoxDecoration(color: ConClrDialog),
                            //                                                   child: Stack(
                            //                                                     children: [
                            //                                                       Row(
                            //                                                         mainAxisAlignment: MainAxisAlignment.end,
                            //                                                         children: [
                            //                                                           Con_Wid.mIconButton(
                            //                                                               color: fontwhiteColor,
                            //                                                               onPressed: () {
                            //                                                                 Navigator.pop(context);
                            //                                                               },
                            //                                                               icon: Own_Close),
                            //                                                         ],
                            //                                                       ),
                            //                                                       Center(
                            //                                                         child: Con_Wid.popinsfont("Semen", fontwhiteColor, FontWeight.w600, 15, context),
                            //                                                       )
                            //                                                     ],
                            //                                                   ),
                            //                                                 ),
                            //                                                 Container(
                            //                                                   padding: EdgeInsets.only(left: 15, right: 15),
                            //                                                   child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            //                                                     Con_Wid.height(5),
                            //                                                     CondropDown(
                            //                                                       title: 'Select Species',
                            //                                                       itemList: Species,
                            //                                                       SelectedList: SelectedSpecies,
                            //                                                       onSelected: (List<String> value) {
                            //                                                         setState1(() {
                            //                                                           SelectedSpecies = value;
                            //                                                           getBreed();
                            //                                                         });
                            //                                                       },
                            //                                                     ),
                            //                                                     // Con_Wid.paddingWithText(
                            //                                                     //     "Select Breed",
                            //                                                     //     Conclrfontmain),
                            //                                                     Con_Wid.height(5),
                            //                                                     CondropDown(
                            //                                                       title: 'Select Breed',
                            //                                                       itemList: Breed,
                            //                                                       SelectedList: SelectedBreed,
                            //                                                       onSelected: (List<String> value) {
                            //                                                         setState1(() {
                            //                                                           SelectedBreed = value;
                            //                                                         });
                            //                                                       },
                            //                                                     ),
                            //                                                     // Con_Wid.paddingWithText(
                            //                                                     //     "Semen Type",
                            //                                                     //     Conclrfontmain),
                            //                                                     Con_Wid.height(5),
                            //                                                     CondropDown(
                            //                                                       title: 'Select Semen Type',
                            //                                                       itemList: Sementype,
                            //                                                       SelectedList: SelectedSementype,
                            //                                                       onSelected: (List<String> value) {
                            //                                                         setState1(() {
                            //                                                           SelectedSementype=value;
                            //                                                         });
                            //                                                       },
                            //                                                     ),
                            //                                                     Con_Wid.height(5),
                            //                                                     Con_Wid.textFieldWithInter(text: "Quantity", controller: Quantity, hintText: "Enter Quantity"),
                            //                                                     Con_Wid.height(20),
                            //                                                     Row(
                            //                                                       mainAxisAlignment: MainAxisAlignment.center,
                            //                                                       children: [
                            //                                                         Con_Wid.MainButton(
                            //                                                             OnTap: () {
                            //                                                               String Species = SelectedSpecies[0];
                            //                                                               String Breed = SelectedBreed[0];
                            //                                                               String Breed_id = Con_List.M_breed.where((element) => element.name == SelectedBreed[0]).first.id.toString();
                            //                                                               String Sementype = SelectedSementype[0] == "Sorted" ? "0" : "1";
                            //                                                               String quantity = Quantity.text;
                            //                                                               _updatesemen(Species, Breed, Breed_id, Sementype, quantity);
                            //                                                               Navigator.pop(context);
                            //                                                             },
                            //                                                             pStrBtnName: "Save",
                            //                                                             height: 45,
                            //                                                             width: 180,
                            //                                                             fontSize: 16)
                            //                                                       ],
                            //                                                     )
                            //                                                   ]),
                            //                                                 )
                            //                                               ]),
                            //                                         ),
                            //                                       );
                            //                                     },
                            //                                   );
                            //                                 },
                            //                               );
                            //                             },
                            //                             icon: Icon(
                            //                               Icons.add,
                            //                               color: Colors.black,
                            //                             ))),
                            //                     Con_Wid.div(),
                            //                     Con_Wid.paddingWithText(
                            //                         "Semen",
                            //                         context: context,
                            //                         fontwhiteColor)
                            //                   ],
                            //                 ),
                            //               ),
                            //               Con_Wid.div(),
                            //               Container(
                            //                 height: 50,
                            //                 width: 211,
                            //                 decoration: BoxDecoration(
                            //                   color: con_clr.ConClr2
                            //                       ? ConClrbluelight
                            //                       : Color(0xFF5C99E8),
                            //                   borderRadius:
                            //                   BorderRadius.circular(40),
                            //                 ),
                            //                 child: Row(
                            //                   children: [
                            //                     CircleAvatar(
                            //                         maxRadius: 26,
                            //                         backgroundColor:
                            //                         con_clr.ConClr2
                            //                             ? ConClrBtn
                            //                             : Color(0xFFBCD5FA),
                            //                         child: IconButton(
                            //                             onPressed: () {
                            //                               showDialog(
                            //                                 context: context,
                            //                                 builder: (context) {
                            //                                   return StatefulBuilder(
                            //                                     builder: (context,
                            //                                         setState1) {
                            //                                       return Dialog(
                            //                                         child:
                            //                                         Container(
                            //                                           height:
                            //                                           250,
                            //                                           decoration: BoxDecoration(
                            //                                               borderRadius: BorderRadius.circular(
                            //                                                   10),
                            //                                               color:
                            //                                               ConClrMainLight),
                            //                                           child: Column(
                            //                                               children: [
                            //                                                 Container(
                            //                                                   height: 60,
                            //                                                   width: double.infinity,
                            //                                                   decoration: con_clr.ConClr2 ? BoxDecoration(gradient: LinearGradient(colors: ConClrAppbarGreadiant)) : BoxDecoration(color: ConClrDialog),
                            //                                                   child: Stack(
                            //                                                     children: [
                            //                                                       Row(
                            //                                                         mainAxisAlignment: MainAxisAlignment.end,
                            //                                                         children: [
                            //                                                           Con_Wid.mIconButton(
                            //                                                               color: fontwhiteColor,
                            //                                                               onPressed: () {
                            //                                                                 Navigator.pop(context);
                            //                                                               },
                            //                                                               icon: Own_Close),
                            //                                                         ],
                            //                                                       ),
                            //                                                       Center(
                            //                                                         child: Con_Wid.popinsfont("Other", fontwhiteColor, FontWeight.w600, 15, context),
                            //                                                       )
                            //                                                     ],
                            //                                                   ),
                            //                                                 ),
                            //                                                 Container(
                            //                                                   padding: EdgeInsets.only(left: 15, right: 15),
                            //                                                   child: Column(
                            //                                                     crossAxisAlignment: CrossAxisAlignment.start,
                            //                                                     children: [
                            //                                                       // Con_Wid.paddingWithText(
                            //                                                       //     "Item",
                            //                                                       //     Conclrfontmain),
                            //                                                       Con_Wid.height(5),
                            //                                                       CondropDown(
                            //                                                         title: 'Select Item',
                            //                                                         itemList: other,
                            //                                                         SelectedList: Selectedother,
                            //                                                         onSelected: (List<String> value) {
                            //                                                           setState1(() {});
                            //                                                         },
                            //                                                       ),
                            //                                                       Con_Wid.height(5),
                            //                                                       Con_Wid.textFieldWithInter(TextInput_Type: TextInputType.numberWithOptions(),text: "Quantity", controller: Quantity, hintText: " Enter Quantity"),
                            //                                                       Con_Wid.height(20),
                            //                                                       Row(
                            //                                                         mainAxisAlignment: MainAxisAlignment.center,
                            //                                                         children: [
                            //                                                           Con_Wid.MainButton(
                            //                                                               OnTap: () {
                            //                                                                 String Itemcode = Selectedother[0];
                            //                                                                 _updateData(Itemcode.substring(Itemcode.indexOf("-") + 1, Itemcode.length), Quantity.text);
                            //                                                               },
                            //                                                               pStrBtnName: "Save",
                            //                                                               height: 45,
                            //                                                               width: 180,
                            //                                                               fontSize: 16)
                            //                                                         ],
                            //                                                       )
                            //                                                     ],
                            //                                                   ),
                            //                                                 )
                            //                                               ]),
                            //                                         ),
                            //                                       );
                            //                                     },
                            //                                   );
                            //                                 },
                            //                               );
                            //                             },
                            //                             icon: Icon(
                            //                               Icons.add,
                            //                               color: Colors.black,
                            //                             ))),
                            //                     Con_Wid.div(),
                            //                     Con_Wid.paddingWithText(
                            //                         "Other",
                            //                         context: context,
                            //                         fontwhiteColor)
                            //                   ],
                            //                 ),
                            //               ),
                            //               Con_Wid.div(),
                            //               Container(
                            //                 height: 50,
                            //                 width: 211,
                            //                 decoration: BoxDecoration(
                            //                   color: con_clr.ConClr2
                            //                       ? ConClrbluelight
                            //                       : Color(0xFF5C99E8),
                            //                   borderRadius:
                            //                       BorderRadius.circular(40),
                            //                 ),
                            //                 child: Row(
                            //                   children: [
                            //                     CircleAvatar(
                            //                         maxRadius: 26,
                            //                         backgroundColor:
                            //                             con_clr.ConClr2
                            //                                 ? ConClrBtn
                            //                                 : Color(0xFFBCD5FA),
                            //                         child: IconButton(
                            //                             splashRadius: 18,
                            //                             onPressed: () {
                            //                               showDialog(
                            //                                   context: context,
                            //                                   builder:
                            //                                       (context) {
                            //                                     return StatefulBuilder(
                            //                                       builder: (context,
                            //                                           setState1) {
                            //                                         return Dialog(
                            //                                           child:
                            //                                               Container(
                            //                                             height:
                            //                                                 250,
                            //                                             decoration: BoxDecoration(
                            //                                                 borderRadius:
                            //                                                     BorderRadius.circular(10),
                            //                                                 color: ConClrMainLight),
                            //                                             child: Column(
                            //                                                 children: [
                            //                                                   Container(
                            //                                                       height: 60,
                            //                                                       width: double.infinity,
                            //                                                       decoration: con_clr.ConClr2 ? BoxDecoration(gradient: LinearGradient(colors: ConClrAppbarGreadiant)) : BoxDecoration(color: ConClrDialog),
                            //                                                       child: Stack(
                            //                                                         children: [
                            //                                                           Row(
                            //                                                             mainAxisAlignment: MainAxisAlignment.end,
                            //                                                             children: [
                            //                                                               Con_Wid.mIconButton(
                            //                                                                   color: fontwhiteColor,
                            //                                                                   onPressed: () {
                            //                                                                     Navigator.pop(context);
                            //                                                                   },
                            //                                                                   icon: Own_Close),
                            //                                                             ],
                            //                                                           ),
                            //                                                           Center(
                            //                                                             child: Con_Wid.popinsfont("Medicine", fontwhiteColor, FontWeight.w600, 15, context),
                            //                                                           )
                            //                                                         ],
                            //                                                       )),
                            //                                                   Container(
                            //                                                     padding: EdgeInsets.only(left: 15, right: 15),
                            //                                                     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            //                                                       // Con_Wid.paddingWithText(
                            //                                                       //     "Medicine Type",
                            //                                                       //     Conclrfontmain),
                            //                                                       Con_Wid.height(5),
                            //                                                       CondropDown(
                            //                                                         title: 'Select Medicine Type',
                            //                                                         itemList: Medicinetype,
                            //                                                         SelectedList: SelectedMedicinetype,
                            //                                                         onSelected: (List<String> value) {
                            //                                                           setState1(() {});
                            //                                                         },
                            //                                                       ),
                            //                                                       Con_Wid.height(5),
                            //                                                       Con_Wid.textFieldWithInter(text: "Quantity", controller: Quantity, hintText: "Enter Quantity"),
                            //                                                       Con_Wid.height(20),
                            //                                                       Row(
                            //                                                         mainAxisAlignment: MainAxisAlignment.center,
                            //                                                         children: [
                            //                                                           Con_Wid.MainButton(
                            //                                                               OnTap: () {
                            //                                                                 String Medicinetype = Con_List.M_medicineLedger.where((element) => element.name == SelectedMedicinetype[0]).first.id.toString();
                            //                                                                 _updatemedicine(Medicinetype, Quantity.text);
                            //                                                                 Navigator.pop(context);
                            //                                                               },
                            //                                                               pStrBtnName: "Save",
                            //                                                               height: 45,
                            //                                                               width: 180,
                            //                                                               fontSize: 16)
                            //                                                         ],
                            //                                                       )
                            //                                                     ]),
                            //                                                   )
                            //                                                 ]),
                            //                                           ),
                            //                                         );
                            //                                       },
                            //                                     );
                            //                                   });
                            //                             },
                            //                             icon: Icon(
                            //                               Icons.add,
                            //                               color: Colors.black,
                            //                             ))),
                            //                     Con_Wid.div(),
                            //                     Con_Wid.paddingWithText(
                            //                         "Medicine",
                            //                         context: context,
                            //                         fontwhiteColor)
                            //                   ],
                            //                 ),
                            //               ),
                            //               Con_Wid.div(),
                            //               Container(
                            //                 height: 50,
                            //                 width: 211,
                            //                 decoration: BoxDecoration(
                            //                   color: con_clr.ConClr2
                            //                       ? ConClrbluelight
                            //                       : Color(0xFF5C99E8),
                            //                   borderRadius:
                            //                       BorderRadius.circular(40),
                            //                 ),
                            //                 child: Row(
                            //                   children: [
                            //                     CircleAvatar(
                            //                         maxRadius: 26,
                            //                         backgroundColor:
                            //                             con_clr.ConClr2
                            //                                 ? ConClrBtn
                            //                                 : Color(0xFFBCD5FA),
                            //                         child: IconButton(
                            //                             onPressed: () {
                            //                               showDialog(
                            //                                 context: context,
                            //                                 builder: (context) {
                            //                                   return StatefulBuilder(
                            //                                     builder: (context,
                            //                                         setState1) {
                            //                                       return Dialog(
                            //                                         child:
                            //                                             Container(
                            //                                           height:
                            //                                               300,
                            //                                           decoration:
                            //                                               BoxDecoration(
                            //                                             color:
                            //                                                 ConClrMainLight,
                            //                                             borderRadius:
                            //                                                 BorderRadius.circular(10),
                            //                                           ),
                            //                                           child: Column(
                            //                                               children: [
                            //                                                 Container(
                            //                                                   height: 60,
                            //                                                   width: double.infinity,
                            //                                                   decoration: con_clr.ConClr2 ? BoxDecoration(gradient: LinearGradient(colors: ConClrAppbarGreadiant)) : BoxDecoration(color: ConClrDialog),
                            //                                                   child: Stack(
                            //                                                     children: [
                            //                                                       Row(
                            //                                                         mainAxisAlignment: MainAxisAlignment.end,
                            //                                                         children: [
                            //                                                           Con_Wid.mIconButton(
                            //                                                               color: fontwhiteColor,
                            //                                                               onPressed: () {
                            //                                                                 Navigator.pop(context);
                            //                                                               },
                            //                                                               icon: Own_Close),
                            //                                                         ],
                            //                                                       ),
                            //                                                       Center(
                            //                                                         child: Con_Wid.popinsfont("Feed", fontwhiteColor, FontWeight.w600, 15, context),
                            //                                                       )
                            //                                                     ],
                            //                                                   ),
                            //                                                 ),
                            //                                                 Container(
                            //                                                   padding: EdgeInsets.only(left: 15, right: 15),
                            //                                                   child: Column(
                            //                                                     crossAxisAlignment: CrossAxisAlignment.start,
                            //                                                     children: [
                            //                                                       // Con_Wid.paddingWithText(
                            //                                                       //     "Feed type",
                            //                                                       //     Conclrfontmain),
                            //                                                       Con_Wid.height(5),
                            //                                                       CondropDown(
                            //                                                         title: 'Select Feed type',
                            //                                                         itemList: Feedtype,
                            //                                                         SelectedList: SelectedFeedtype,
                            //                                                         onSelected: (List<String> value) {
                            //                                                           setState1(() {});
                            //                                                         },
                            //                                                       ),
                            //                                                       Con_Wid.height(5),
                            //                                                       Con_Wid.textFieldWithInter(text: "Feed Name", controller: Feedname, hintText: "Enter Feed Name"),
                            //                                                       Con_Wid.height(5),
                            //                                                       Con_Wid.textFieldWithInter(text: "Quantity", controller: Quantity, hintText: "Quantity"),
                            //                                                       Con_Wid.height(20),
                            //                                                       Row(
                            //                                                         mainAxisAlignment: MainAxisAlignment.center,
                            //                                                         children: [
                            //                                                           Con_Wid.MainButton(
                            //                                                               OnTap: () {
                            //                                                                 String mednumber = SelectedFeedtype[0];
                            //                                                                 _updateFeed(mednumber.substring(mednumber.indexOf("-") + 2, mednumber.length), Quantity.text);
                            //                                                                 Navigator.pop(context);
                            //                                                               },
                            //                                                               pStrBtnName: "Save",
                            //                                                               height: 45,
                            //                                                               width: 180,
                            //                                                               fontSize: 16)
                            //                                                         ],
                            //                                                       )
                            //                                                     ],
                            //                                                   ),
                            //                                                 )
                            //                                               ]),
                            //                                         ),
                            //                                       );
                            //                                     },
                            //                                   );
                            //                                 },
                            //                               );
                            //                             },
                            //                             icon: Icon(
                            //                               Icons.add,
                            //                               color: Colors.black,
                            //                             ))),
                            //                     Con_Wid.div(),
                            //                     Con_Wid.paddingWithText(
                            //                         "Feed",
                            //                         context: context,
                            //                         fontwhiteColor)
                            //                   ],
                            //                 ),
                            //               ),
                            //
                            //
                            //               Con_Wid.div(),
                            //               Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.center,
                            //                 children: [
                            //                   Expanded(
                            //                       child: Con_Wid
                            //                           .selectionContainer(
                            //                               text: "RESET",
                            //                               context: context,
                            //                               ontap: () {
                            //                                 Navigator.pop(
                            //                                     context);
                            //                               },
                            //                               Color: con_clr.ConClr2
                            //                                   ? ConClrLightBack
                            //                                   : whiteColor,
                            //                               textcolor: con_clr
                            //                                       .ConClr2
                            //                                   ? whiteColor
                            //                                   : ConClrDialog,
                            //                               height: 40,
                            //                               width:
                            //                                   double.infinity)),
                            //                   Con_Wid.div(),
                            //                   Expanded(
                            //                       child: Con_Wid
                            //                           .selectionContainer(
                            //                               text: "SUBMIT",
                            //                               context: context,
                            //                               ontap: () {
                            //                                 Navigator.pop(
                            //                                     context);
                            //                               },
                            //                               Color: con_clr.ConClr2
                            //                                   ? ConClrbluelight
                            //                                   : ConClrDialog,
                            //                               height: 40,
                            //                               width:
                            //                                   double.infinity)),
                            //                 ],
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // );
                            // dbhelper.GenerateDB();
                            // Get.toNamed("/CattleRegistrationScreen");
                          },
                          height: 65,
                          width: 65)
                  : Container(),
          body: loadedVisitData
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: whiteColor1,
                  child: SingleChildScrollView(
                    child: filteredUsers.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: filteredUsers != null
                                ? filteredUsers.length
                                : 0,
                            itemBuilder: (BuildContext ctxt, int index) {
                              filteredUsers.sort((a, b) => b['Request ID'].compareTo(a['Request ID']),);
                              // filteredUsers.sort((a, b) => b['Date'].toString().compareTo(a['Date'].toString()),);

                              Color cardColor;
                              Color fontColor = Colors.black;

                              if (filteredUsers[index]['Status'] ==
                                  "Alert First") {
                                cardColor = Colors.green;
                              } else if (filteredUsers[index]['Status'] ==
                                  "Alert Stop") {
                                notshow = true;
                                cardColor = Colors.red.shade900;
                                fontColor = Colors.black;
                              } else if (filteredUsers[index]['Status'] ==
                                  "Alert Last") {
                                cardColor = Colors.red.shade200;
                                fontColor = Colors.black;
                              } else if (filteredUsers[index]['Status'] ==
                                  "On the Way") {
                                cardColor = Color.fromARGB(255, 153, 153, 153);
                                fontColor = Colors.black;
                              } else if (filteredUsers[index]['Status'] ==
                                  "Received") {
                                cardColor = Color.fromARGB(255, 68, 114, 196);
                                fontColor = Colors.black;
                              } else if (filteredUsers[index]['Status'] ==
                                  "Requested") {
                                cardColor = Color(0xFFD5AD03);
                                fontColor = Colors.black;
                              } else if (filteredUsers[index]['Status'] ==
                                  "Approved") {
                                cardColor = Color.fromARGB(255, 112, 173, 71);
                                fontColor = Colors.black;
                              } else if (filteredUsers[index]['Status'] ==
                                  "Rejected") {
                                cardColor = Color.fromARGB(255, 255, 0, 0);
                                fontColor = Colors.black;
                              } else if (filteredUsers[index]['Status'] ==
                                  "Dispatched") {
                                cardColor = Color.fromARGB(255, 204, 255, 255);
                                fontColor = Colors.black;
                              } else {
                                cardColor = Colors.green;
                              }
                              String dates = appVersion;
                              var formatter = new DateFormat('dd-MM-yyyy');
                              dates = formatter.format(
                                  DateTime.parse(filteredUsers[index]['Date']));

                              String datesbill = appVersion;
                              var formatterbill = new DateFormat('dd-MM-yyyy');
                              datesbill =
                                  filteredUsers[index]['Bill Date'] != null
                                      ? formatterbill.format(DateTime.parse(
                                          filteredUsers[index]['Bill Date']))
                                      : "";

                              return GestureDetector(
                                onTap: () async {
                                  if (filteredUsers[index]['Status'] ==
                                      "Alert First") {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => RequestForm()),
                                    // );
                                  } else if (filteredUsers[index]['Status'] ==
                                      "Alert Stop") {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           RequestFormNoties()),
                                    // );
                                  } else if (filteredUsers[index]['Status'] ==
                                      "Alert Last") {
                                    // Navigator.push(
                                    //   context,
                                    //   CupertinoPageRoute(
                                    //       builder: (context) => RequestForm()),
                                    // );
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                request_form_popup(
                                                  notshow,
                                                    filteredUsers[index]
                                                            ['Request ID']
                                                        .toString(),
                                                    filteredUsers[index]
                                                            ['Status']
                                                        .toString())));
                                  }
                                  // await showDialog(
                                  //     barrierDismissible: false,
                                  //     context: context,
                                  //     builder: (context) => request_form_popup());
                                },
                                child: Card(
                                  margin: EdgeInsets.only(
                                      left: 5, right: 5, top: 10),
                                  borderOnForeground: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: whiteColor,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Stack(
                                              children: [
                                                Image.asset(
                                                  fit: BoxFit.fill,
                                                  width: 150,
                                                  height: 25,
                                                  "assets/images/Rectangle 199.png",
                                                  color: cardColor,
                                                ),
                                                Positioned(
                                                  top: 3,
                                                  bottom: 3,
                                                  left: 3,
                                                  right: 3,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          "${filteredUsers[index]['Status']}",
                                                          style: TextStyle(
                                                              color: whiteColor,
                                                              fontSize: 12))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Con_Wid.height(10),
                                        filteredUsers[index]['AIT Name'] != null
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Text(
                                                          Con_Wid.Lang_Cng(
                                                                  "AIT Name") +
                                                              " : " +
                                                              '${filteredUsers[index]['AIT Name'].toString()}',
                                                          style: new TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 14.5,
                                                              color: fontColor),
                                                          textAlign:
                                                              TextAlign.left),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              filteredUsers[index]['Request ID']
                                                          .toString()
                                                          .trim() !=
                                                      "999999999"
                                                  ? Expanded(
                                                      child: Text(
                                                          Con_Wid.Lang_Cng(
                                                                  "Request ID") +
                                                              " : " +
                                                              '${filteredUsers[index]['Request ID']}',
                                                          style: new TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 13.5,
                                                              color: fontColor),
                                                          textAlign:
                                                              TextAlign.left),
                                                    )
                                                  : Container(),
                                              filteredUsers[index]['Request ID']
                                                          .toString()
                                                          .trim() !=
                                                      "999999999"
                                                  ? Expanded(
                                                      child: new Text(
                                                          Con_Wid.Lang_Cng(
                                                                  "Req Date") +
                                                              " : " +
                                                              '${dates.toString()}',
                                                          style: new TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 13.5,
                                                              color: fontColor),
                                                          textAlign:
                                                              TextAlign.left),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              filteredUsers[index]['Request ID']
                                                          .toString()
                                                          .trim() !=
                                                      "999999999"
                                                  ? Expanded(
                                                      child: Text(
                                                          Con_Wid.Lang_Cng(
                                                                  "Challan No") +
                                                              " : " +
                                                              '${filteredUsers[index]['Challan No']}',
                                                          style: new TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 13.5,
                                                              color: fontColor),
                                                          textAlign:
                                                              TextAlign.left),
                                                    )
                                                  : Container(),
                                              filteredUsers[index]['Request ID']
                                                          .toString()
                                                          .trim() !=
                                                      "999999999"
                                                  ? new Expanded(
                                                      child: new Text(
                                                          Con_Wid.Lang_Cng(
                                                                  "Bill Date") +
                                                              " : " +
                                                              '${datesbill.toString()}',
                                                          style: new TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 13.5,
                                                              color: fontColor),
                                                          textAlign:
                                                              TextAlign.left),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              filteredUsers[index]['Request ID']
                                                          .toString()
                                                          .trim() !=
                                                      "999999999"
                                                  ? new Expanded(
                                                      child: new Text(
                                                          Con_Wid.Lang_Cng(
                                                                  "Status") +
                                                              ' : ${filteredUsers[index]['Status']}',
                                                          style: new TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 13.5,
                                                              color: fontColor),
                                                          textAlign:
                                                              TextAlign.left),
                                                    )
                                                  : Container(),
                                              filteredUsers[index]['Request ID']
                                                          .toString()
                                                          .trim() !=
                                                      "999999999"
                                                  ? new Expanded(
                                                      child: new Text(
                                                          Con_Wid.Lang_Cng(
                                                                  "DCS Name") +
                                                              " : " +
                                                              '${filteredUsers[index]['DCS Name']}',
                                                          style: new TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 13.5,
                                                              color: fontColor),
                                                          textAlign:
                                                              TextAlign.left),
                                                    )
                                                  : new Expanded(
                                                      child: new Text(
                                                          filteredUsers[index]
                                                                  ['DCS Name']
                                                              .toString()
                                                              .trimLeft(),
                                                          style: new TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 14.5,
                                                              color: fontColor),
                                                          textAlign:
                                                              TextAlign.left),
                                                    ),
                                            ],
                                          ),
                                        ),
                                        Con_Wid.height(10),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })
                        : Container(
                            //displaying reports as tables ends
                            margin: EdgeInsets.only(top: 200.0, bottom: 30),
                            // height: 50.0,
                            //width: 150.0,
                            decoration: new BoxDecoration(
                                border:
                                    new Border.all(color: Colors.transparent),
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(30.0),
                                    topRight: const Radius.circular(30.0),
                                    bottomLeft: const Radius.circular(30.0),
                                    bottomRight: const Radius.circular(30.0))),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  _getBreed("");
                                },
                                child: Image(
                                    height: 150,
                                    width: 150,
                                    image: AssetImage(
                                        "assets/images/No-Data-Found.webp")),
                              ),
                            ),
                          ),
                  ),
                )
              : Center(child: CircularProgressIndicator())),
    );
  }

  _updatesemen(String Species, String Breed, String Breed_id, String Sementype,
      String quantity) async {
    final res = await ApiCalling.createPost(AppUrl().requestfirstsemen,
        "Bearer " + Constants_Usermast.token.toString(), {
      "inputDate": DateTime.now().toString(),
      "staffId": Constants_Usermast.staff.toString(),
      "breed": Breed_id,
      "sorted": Sementype,
      "quantity": quantity,
      "remark": "Remarks",
      "requestStatus": "R"
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return RequestScreen();
    },));
  }

  _updatemedicine(String Medicineid, String quantity) async {
    final res = await ApiCalling.createPost(AppUrl().requestsecondmedicine,
        "Bearer " + Constants_Usermast.token.toString(), {
      "inputDate": DateTime.now().toString(),
      "staffId": Constants_Usermast.staff,
      "medicine": Medicineid,
      "quantity": quantity,
      "remark": 'None',
      "requestStatus": "R"
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return RequestScreen();
    },));
  }

  _updateFeed(String Medicineid, String quantity) async {
    final res = await ApiCalling.createPost(AppUrl().requestthirdseed,
        "Bearer " + Constants_Usermast.token.toString(), {
      "inputDate": DateTime.now().toString(),
      "staffId": Constants_Usermast.staff,
      "feed": int.parse(Medicineid),
      "quantity": quantity,
      "remark": 'Remarks',
      "requestStatus": "R"
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return RequestScreen();
    },));
  }

  _updateData(String othrid, String quantity) async {
    final res = await ApiCalling.createPost(AppUrl().requestItemsRequest,
        "Bearer " + Constants_Usermast.token.toString(), {
      "requestType": othrid,
      "inputDate": DateTime.now().toString(),
      "staffId": Constants_Usermast.staff,
      "itemCode": int.parse(othrid),
      "quantity": quantity,
      "remark": 'Remarks',
      "requestStatus": "R"
    });

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return RequestScreen();
    },));
  }

  void _getBreed(String pStrStatus) async {
    String Value = "0";
    if (Constants_Usermast.groupId == 22) {
      Value = "1";
    } else if (Constants_Usermast.groupId == 32) {
      Value = "3";
    } else if (Constants_Usermast.groupId == 6) {
      Value = "2";
    }

    final vehicleres = await ApiCalling.createPost(
        AppUrl().getaitsemen, "Bearer " + Constants_Usermast.token.toString(), {
        "staffId": Constants_Usermast.groupId == 6 ? Constants_Usermast.staff:Constants_Usermast.user_id.toString(),
        "id": Value.toString()
    });
    if (vehicleres.body.isEmpty) {
      loadedVisitData = true;
      setState(() {});
      return;
    }
    if (vehicleres.statusCode == 200) {
      vehicles = json.decode(vehicleres.body);
      filteredUsers = vehicles;
      _itemCount = vehicles.length;

      if (pStrStatus.isNotEmpty) {
        filteredUsers = vehicles
            .where((i) => i["Status"] == pStrStatus.toString())
            .toList();
      }
      if (RequestDate != null) {
        var formatter = new DateFormat('dd-MM-yyyy');
        String dates = formatter.format(DateTime.parse(RequestDate.toString()));
        if (filterdate) {
          var formatter1 = new DateFormat('dd-MM-yyyy');
          filteredUsers = vehicles
              .where((i) =>
                  (i['Bill Date'] != null ||
                          i['Bill Date'] != "" ||
                          i['Bill Date'] != "Null"
                      ? formatter1.format(DateTime.parse(i['Bill Date']))
                      : dates.toString()) ==
                  dates.toString())
              .toList();
        }
      }
      int count =
          vehicles.where((i) => i["Status"] == "Alert Stop").toList().length;

      if (count > 0) {
        setState(() {
          notshow = true;
        });
      }
    }
    loadedVisitData = true;
    setState(() {});
  }
}
