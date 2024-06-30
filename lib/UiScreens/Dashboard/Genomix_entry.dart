import 'dart:io';

import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/profile.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_NetworkHelp.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../component/DataBaseHelper/Con_List.dart';
import '../../component/DataBaseHelper/Sync_Json.dart';
import '../../component/Gobal_Widgets/Con_Icons.dart';
import '../../component/Gobal_Widgets/Con_Textstyle.dart';
import '../../component/Gobal_Widgets/Constants.dart';
import '../../model/Animal_Details_id.dart';

class Genomix_entry extends StatefulWidget {
  int index;
  Genomix_entry(this.index);
  @override
  State<Genomix_entry> createState() => _Genomix_entryState();
}

class _Genomix_entryState extends State<Genomix_entry> {
  final ImagePicker picker = ImagePicker();
  String Firstimage = "";
  Animal_Details_id? Mdetail;
  String mStrFromdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  bool botton1 = true;
  bool botton2 = false;
  bool botton3 = false;
  TextEditingController rearlegset = TextEditingController(),
      udderattahm = TextEditingController(),
      conditionscore = TextEditingController(),
      legrearview = TextEditingController(),
      centralligament = TextEditingController(),
      fronttearplacement = TextEditingController(),
      reartearplacement = TextEditingController(),
      rumpwith = TextEditingController(),
      rearudderwidth = TextEditingController(),
      rearudderhight = TextEditingController(),
      teatlength = TextEditingController(),
      girth = TextEditingController(),
      bodydepth = TextEditingController(),
      bodylength = TextEditingController(),
      stature = TextEditingController(),
      rumpangle = TextEditingController(),
      udderdepth = TextEditingController(),
      angularity = TextEditingController(),
      teatthickness = TextEditingController(),
      skinthickness = TextEditingController(),
      taillenghtbeyond = TextEditingController(),
      footangle = TextEditingController();
  String base64Image1 = "";
  String base64Image2 = "";
  String base64Image3 = "";
  String base64Image4 = "";

  bool one = false,
      two = false,
      three = false,
      four = false,
      five = false,
      six = false,
      seven = false,
      eigth = false,
      nine = false,
      ten = false,
      eleven = false,
      twele = false,
      therteen = false,
      forteen = false,
      fifteen = false,
      sixteen = false,
      seventeen = false,
      eieteen = false,
      nienteen = false,
      twenty = false,
      twentyone = false,
      twentytwo = false;
  List<String> mrearset1 = [
    "assets/images/rearleg1.webp",
    "assets/images/rearleg2.webp",
    "assets/images/rearleg3.webp",
    "assets/images/rearleg4.webp"
  ];
  List<String> MFootangle2 = [
    "assets/images/Footangle1.webp",
    "assets/images/Footangle2.webp",
    "assets/images/Footangle3.webp",
  ];
  List<String> MForeUdder3 = [
    "assets/images/ForeUdde1.webp",
    "assets/images/ForeUdde2.webp",
    "assets/images/ForeUdde3.webp",
    "assets/images/ForeUdde4.webp",
  ];
  List<String> Mrearlegview5 = [
    "assets/images/RearLegsrearview1.webp",
    "assets/images/RearLegsrearview2.webp",
    "assets/images/RearLegsrearview3.webp",
    "assets/images/RearLegsrearview4.webp",
  ];
  List<String> MCentral_Ligament6 = [
    "assets/images/Central Ligament1.webp",
    "assets/images/Central Ligament2.webp",
    "assets/images/Central Ligament3.webp",
    "assets/images/Central Ligament4.webp",
  ];
  List<String> MFront_Teat_Placement_7 = [
    "assets/images/FrontTeatPlacement1.webp",
    "assets/images/FrontTeatPlacement2.webp",
    "assets/images/FrontTeatPlacement3.webp",
    "assets/images/FrontTeatPlacement4.webp",
  ];
  List<String> MRear_Teat_Placement_8 = [
    "assets/images/RearTeatPlacement1.webp",
    "assets/images/RearTeatPlacement2.webp",
    "assets/images/RearTeatPlacement3.webp",
    "assets/images/RearTeatPlacement4.webp",
  ];
  List<String> MRump_with9 = [
    "assets/images/Rumpwith1.webp",
    "assets/images/Rumpwith2.webp",
  ];
  List<String> MStature_16 = [
    "assets/images/Stature1.webp",
    "assets/images/Stature2.webp",
  ];
  List<String> MAngularity_19 = [
    "assets/images/Angularity1.webp",
    "assets/images/Angularity2.webp",
  ];
  List<String> MSkin_Thickness21 = [
    "assets/images/SkinThickness1.jpg",
    "assets/images/SkinThickness2.webp",
  ];
  List<String> MTail_Length22 = [
    "assets/images/TailLength1.webp",
    "assets/images/TailLength2.webp",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    getdata();
  }

  getdata() {
    if (Con_List.M_status.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_status);
    }
  }

  get() {
    Mdetail = Con_List.id_Animal_Details
        .firstWhere((element) => element.tagId == widget.index.toString());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Con_Wid.appBar(
        title: Con_Wid.Lang_Cng("Genomix Entry"),
        Actions: [],
        onBackTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return profile(widget.index.toString());
            },
          ));
        },
      ),
      body: Con_Wid.backgroundContainer(
          child: SingleChildScrollView(
        child: Column(
          children: [
            con_clr.ConClr2
                ? Con_Wid.fullContainer(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Society Code :-",
                            style:
                                ConStyle.Style_white_10s_500w(fontBlackColor),
                          ),
                          Text("  ${Mdetail!.lot}",
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis),
                          Expanded(child: Container()),
                          Text(
                            "Society Name :-",
                            style:
                                ConStyle.Style_white_10s_500w(fontBlackColor),
                          ),
                          Text("  ${Mdetail!.name}",
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis)
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Farmer Name : ",
                              style:
                                  ConStyle.Style_white_10s_500w(fontBlackColor),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              width: 200,
                              child: widget.index == null
                                  ? Text("")
                                  : Text("  ${Mdetail!.farmername}",
                                      style: TextStyle(fontSize: 12),
                                      overflow: TextOverflow.ellipsis),
                            )
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Animal.ID :-",
                            style:
                                ConStyle.Style_white_10s_500w(fontBlackColor),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 20,
                            width: 200,
                            child: widget.index == null
                                ? Text("")
                                : Text("  ${Mdetail!.tagId}",
                                    style: TextStyle(fontSize: 12),
                                    overflow: TextOverflow.ellipsis),
                          )
                        ],
                      )
                    ],
                  ))
                : Con_Wid.fullContainer1(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Society Code :-",
                            style:
                                ConStyle.Style_white_10s_500w(fontwhiteColor),
                          ),
                          Text("  ${Mdetail!.lot}",
                              style: TextStyle(
                                  fontSize: 12, color: fontwhiteColor),
                              overflow: TextOverflow.ellipsis),
                          Expanded(child: Container()),
                          Text(
                            "Society Name :-",
                            style:
                                ConStyle.Style_white_10s_500w(fontwhiteColor),
                          ),
                          Text("  ${Mdetail!.name}",
                              style: TextStyle(
                                  fontSize: 12, color: fontwhiteColor),
                              overflow: TextOverflow.ellipsis)
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Farmer Name : ",
                              style:
                                  ConStyle.Style_white_10s_500w(fontwhiteColor),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              width: 200,
                              child: widget.index == null
                                  ? Text("")
                                  : Text("  ${Mdetail!.farmername}",
                                      style: TextStyle(
                                          fontSize: 12, color: fontwhiteColor),
                                      overflow: TextOverflow.ellipsis),
                            )
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Animal.ID :-",
                            style:
                                ConStyle.Style_white_10s_500w(fontwhiteColor),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 20,
                            width: 200,
                            child: widget.index == null
                                ? Text("")
                                : Text("  ${Mdetail!.tagId}",
                                    style: TextStyle(
                                        fontSize: 12, color: fontwhiteColor),
                                    overflow: TextOverflow.ellipsis),
                          )
                        ],
                      )
                    ],
                  )),
            Con_Wid.fullContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Con_Wid.selectionContainer(
                      height: 44,
                      width: 97,
                      text: "Today",
                      context: context,
                      ontap: () {
                        mStrFromdate = DateFormat('MM/dd/yyyy HH:mm')
                            .format(DateTime.now());
                        setState(() {
                          botton2 = false;
                          botton3 = false;
                          botton1 = true;
                        });
                      },
                      Color: botton1
                          ? con_clr.ConClr2
                              ? ConClrbluelight
                              : ConClrDialog
                          : con_clr.ConClr2
                              ? ConClrLightBack
                              : whiteColor,
                      textcolor: botton1
                          ? whiteColor
                          : con_clr.ConClr2
                              ? whiteColor
                              : ConClrDialog,
                    ),
                    Con_Wid.selectionContainer(
                      height: 44,
                      width: 97,
                      text: "Yesterday",
                      context: context,
                      ontap: () {
                        mStrFromdate = DateFormat('MM/dd/yyyy HH:mm')
                            .format(DateTime.now().subtract(Duration(days: 1)));
                        setState(() {
                          botton3 = false;
                          botton1 = false;
                          botton2 = true;
                        });
                      },
                      Color: botton2
                          ? con_clr.ConClr2
                              ? ConClrbluelight
                              : ConClrDialog
                          : con_clr.ConClr2
                              ? ConClrLightBack
                              : whiteColor,
                      textcolor: botton2
                          ? whiteColor
                          : con_clr.ConClr2
                              ? whiteColor
                              : ConClrDialog,
                    ),
                    Con_Wid.selectionContainer(
                      height: 44,
                      width: 97,
                      text: "Calender",
                      context: context,
                      ontap: () async {
                        mStrFromdate =
                            await Con_Wid.GlbDatePicker(pcontext: context);
                        setState(() {
                          botton1 = false;
                          botton2 = false;
                          botton3 = true;
                        });
                      },
                      Color: botton3
                          ? con_clr.ConClr2
                              ? ConClrbluelight
                              : ConClrDialog
                          : con_clr.ConClr2
                              ? ConClrLightBack
                              : whiteColor,
                      textcolor: botton3
                          ? whiteColor
                          : con_clr.ConClr2
                              ? whiteColor
                              : ConClrDialog,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: rearlegset,
                        hintText: "Enter Rear Leg Set",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            one = !one;
                          });
                        },
                        icon: one
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                one ? drop(mrearset1) : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: footangle,
                        hintText: "Enter Foot Angle",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            two = !two;
                          });
                        },
                        icon: two
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                two ? drop(MFootangle2) : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: udderattahm,
                        hintText: "Enter Fore Udder Attahmnent",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            three = !three;
                          });
                        },
                        icon: three
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                three ? drop(MForeUdder3) : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: conditionscore,
                        hintText: "Enter Body Condition Score",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            four = !four;
                          });
                        },
                        icon: four
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                four ? drop(["assets/images/General1.webp"]) : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: legrearview,
                        hintText: "Enter Rear Legs Rear View",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            five = !five;
                          });
                        },
                        icon: five
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                five ? drop(Mrearlegview5) : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: centralligament,
                        hintText: "Enter Central Ligament",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            six = !six;
                          });
                        },
                        icon: six
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                six ? drop(MCentral_Ligament6) : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: fronttearplacement,
                        hintText: "Enter Front Tear Placement",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            seven = !seven;
                          });
                        },
                        icon: seven
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                seven ? drop(MFront_Teat_Placement_7) : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: reartearplacement,
                        hintText: "Enter Rear Tear Placement",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            eigth = !eigth;
                          });
                        },
                        icon: eigth
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                eigth ? drop(MRear_Teat_Placement_8) : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: rumpwith,
                        hintText: "Enter Rumo with"),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            nine = !nine;
                          });
                        },
                        icon: nine
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                nine ? drop(MRump_with9) : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: rearudderhight,
                        hintText: "Enter Rear Udder Hight",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            ten = !ten;
                          });
                        },
                        icon: ten
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                ten
                    ? drop(["assets/images/RearUdderHight1.webp"])
                    : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: rearudderwidth,
                        hintText: "Enter Rear Udder Width",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            eleven = !eleven;
                          });
                        },
                        icon: eleven
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                eleven
                    ? drop(["assets/images/RearUdderwidth1.webp"])
                    : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: teatlength,
                        hintText: "Enter Teat Length",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            twele = !twele;
                          });
                        },
                        icon: twele
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                twele ? drop(["assets/images/Teatlength1.webp"]) : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: girth,
                        hintText: "Enter Girth"),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            therteen = !therteen;
                          });
                        },
                        icon: therteen
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                therteen ? drop(["assets/images/GirthCM1.webp"]) : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: bodydepth,
                        hintText: "Enter Body Depth",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            forteen = !forteen;
                          });
                        },
                        icon: forteen
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                forteen
                    ? drop(["assets/images/BodyDepthCM1.webp"])
                    : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: bodylength,
                        hintText: "Enter Body Length",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            fifteen = !fifteen;
                          });
                        },
                        icon: fifteen
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                fifteen
                    ? drop(["assets/images/BodyLengthCM1.webp"])
                    : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: stature,
                        hintText: "Enter ststure"),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            sixteen = !sixteen;
                          });
                        },
                        icon: sixteen
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                sixteen ? drop(MStature_16) : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: rumpangle,
                        hintText: "Enter Rump angle",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            seventeen = !seventeen;
                          });
                        },
                        icon: seventeen
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                seventeen
                    ? drop(["assets/images/RumpAngle1.webp"])
                    : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: udderdepth,
                        hintText: "Enter Udder Depth",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            eieteen = !eieteen;
                          });
                        },
                        icon: eieteen
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                eieteen
                    ? drop(["assets/images/UdderDepth1.webp"])
                    : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: angularity,
                        hintText: "Enter Angularity",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            nienteen = !nienteen;
                          });
                        },
                        icon: nienteen
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                nienteen ? drop(MAngularity_19) : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: teatthickness,
                        hintText: "Enter Teat Thickness",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            twenty = !twenty;
                          });
                        },
                        icon: twenty
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                twenty
                    ? drop(["assets/images/TeatThickness1.webp"])
                    : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: skinthickness,
                        hintText: "Enter Skin Thickness",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            twentyone = !twentyone;
                          });
                        },
                        icon: twentyone
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                twentyone ? drop(MSkin_Thickness21) : Container(),
                Row(
                  children: [
                    Con_Wid.textFieldWithInter(
                        width: MediaQuery.of(context).size.width - 100,
                        controller: taillenghtbeyond,
                        hintText: "Enter Tail Length Point",
                        TextInput_Type: TextInputType.number),
                    Con_Wid.mIconButton(
                        onPressed: () {
                          setState(() {
                            twentytwo = !twentytwo;
                          });
                        },
                        icon: twentytwo
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up)),
                  ],
                ),
                twentytwo ? drop(MTail_Length22) : Container(),
                Con_Wid.paddingWithText("Camera Image", ConClrBlueDark,
                    context: context),
                Con_Wid.height(5),
                Row(
                  children: [
                    Con_Wid.width(25),
                    Con_Wid.MainButton(
                        OnTap: () async {
                          final XFile? photo = await picker.pickImage(
                              source: ImageSource.camera);
                          setState(() {
                            Firstimage = photo!.path;
                          });
                        },
                        pStrBtnName: "Add+",
                        height: 35,
                        width: 90,
                        fontSize: 15),
                  ],
                ),
                Firstimage == ""
                    ? Container()
                    : Center(
                        child: Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width - 150,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(File("${Firstimage}")))),
                            child: Baseline(
                              baseline: 35,
                              baselineType: TextBaseline.alphabetic,
                              child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width - 150,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 40,
                                        child: IconButton(
                                          splashRadius: 18,
                                          onPressed: () {
                                            setState(() {
                                              Firstimage = "";
                                            });
                                          },
                                          icon: Own_Close,
                                          iconSize: 35,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )),
                            )),
                      ),
                Con_Wid.height(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Con_Wid.MainButton(
                        OnTap: () async {
                          try {
                            final res = await ApiCalling.createPost(
                                AppUrl().genomixdetail,
                                "Bearer " + Constants_Usermast.token.toString(),
                                {
                                  "Idno": widget.index.toString(),
                                  "Date": mStrFromdate,
                                  "Status": 1,
                                  "Parity": Mdetail!.parity.toString() == "null"
                                      ? "0"
                                      : int.tryParse("${Mdetail!.parity}"),
                                  "Image1": base64Image1,
                                  "Image2": base64Image2,
                                  "Image3": base64Image3,
                                  "Image4": base64Image4,
                                  "Rear_Leg_Set": int.parse(rearlegset.text),
                                  "Foot_angle": int.parse(footangle.text),
                                  "Fore_Udder_Attahmnent":
                                      udderattahm.text.toString(),
                                  "Body_Condition_Score":
                                      conditionscore.text.toString(),
                                  "Rear_Legs_rear_view":
                                      legrearview.text.toString(),
                                  "Central_Ligament":
                                      centralligament.text.toString(),
                                  "Front_Teat_Placement":
                                      fronttearplacement.text.toString(),
                                  "Rear_Teat_Placement":
                                      reartearplacement.text.toString(),
                                  "Rump_with": rumpwith.text.toString(),
                                  "Rear_Udder_Hight":
                                      rearudderhight.text.toString(),
                                  "Rear_Udder_width":
                                      rearudderwidth.text.toString(),
                                  "Teat_length": teatlength.text.toString(),
                                  "Girth": girth.text.toString(),
                                  "Body_Depth": bodydepth.text.toString(),
                                  "Body_Length": bodylength.text.toString(),
                                  "Stature": stature.text.toString(),
                                  "Rump_Angle": rumpangle.text.toString(),
                                  "Udder_Depth": udderdepth.text.toString(),
                                  "Angularity": angularity.text.toString(),
                                  "Teat_Thickness":
                                      teatthickness.text.toString(),
                                  "Skin_Thickness":
                                      skinthickness.text.toString(),
                                  "Tail_Length_Beyond_point_of_Hock":
                                      taillenghtbeyond.text.toString()

                                  //"receipt": _reciptController.text // add this for receipt number
                                });
                          } catch (e) {
                          }
                        },
                        pStrBtnName: "Save",
                        height: 40,
                        width: 150,
                        fontSize: 16),
                  ],
                )
              ],
            )),
          ],
        ),
      )),
    );
  }

  Widget drop(List<String> Images) {
    return Container(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: Images.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Image.asset(
                    "${Images[index]}",
                    width: 110,
                  ),
                ),
              ),
            ]);
          }),
    );
  }
}
