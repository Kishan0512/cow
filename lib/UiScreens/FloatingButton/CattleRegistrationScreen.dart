import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/Dashboard/Dashboard.dart';
import 'package:herdmannew/UiScreens/Dashboard/cattle_manual.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/profile.dart';
import 'package:herdmannew/UiScreens/FloatingButton/QRcode_Scan.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Icons.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

import '../../component/DataBaseHelper/Con_List.dart';
import '../../component/DataBaseHelper/Sync_Json.dart';
import '../../component/Gobal_Widgets/Constants.dart';
import '../Dashboard/cattle_add.dart';

class CattleRegistrationScreen extends StatefulWidget {
  CattleRegistrationScreen();

  @override
  State<CattleRegistrationScreen> createState() =>
      _CattleRegistrationScreenState();
}

class _CattleRegistrationScreenState extends State<CattleRegistrationScreen> {
  TextEditingController manualentry = TextEditingController();
  String _result = "";
  bool Mobileregistration_perm = false;
  List<int> mFrature = [];
  List permisstion = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    get();
    setState(() {});
  }

  getdata() {
    if (Con_List.M_Userherds.isEmpty ||
        Con_List.M_species.isEmpty ||
        Con_List.M_feature.isEmpty ||
        Con_List.M_userFeatureAccessDetail.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_herd);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_species);
      Sync_Json.Get_Master_Data(Constants.Tbl_RoleAuthAndLogs_feature);
      Sync_Json.Get_Master_Data(
          Constants.Tbl_RoleAuthAndLogs_featureuseraccesstxn);
    }
  }

  get() {
    Con_List.M_feature.forEach((e) {
      mFrature.add(e.id);
    });
    for (int i = 0; i < Con_List.M_userFeatureAccessDetail.length; i++) {
      for (int j = 0; j < mFrature.length; j++) {
        if (Con_List.M_userFeatureAccessDetail[i].feature.toInt() ==
            mFrature[j].toInt()) {
          permisstion.add(
              Con_List.M_userFeatureAccessDetail[i].combinedPermissionValue);
        }
        if (permisstion.length > 0) {
          Mobileregistration_perm = true;
          setState(() {});
        }
      }
    }
  }

  Future<bool> onBackPress() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DashBoardScreen()));

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "Cattle Registration",
          Actions: [],
          onBackTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => DashBoardScreen()));
          },
        ),
        body: Con_Wid.backgroundContainer(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
            children: [
              tagText("Scan QR Code or RF-ID for already registered", 10),
              Con_Wid.height(25.0),
              button(() {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return QRcode_Scan(Mobileregistration_perm);
                  },
                ));
              }, [
                const Color(0XFF4E7AB7),
                const Color(0XFF4E7AB7),
              ], 48, 40, 4, "QR Code Scan", FontWeight.w600, 15),
              Con_Wid.height(25.0),
              button(
                  () {},
                  [
                    const Color(0XFF4E7AB7),
                    const Color(0XFF4E7AB7),
                  ],
                  48,
                  40,
                  4,
                  "RF-ID Scan",
                  FontWeight.w600,
                  15),
              Con_Wid.height(25.0),
              tagText("Enter the TAG-No Manually", 13),
              Con_Wid.height(12.0),
              Con_Wid.MainButton(
                  OnTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: SizedBox(
                            height: 250,
                            child: Column(children: [
                              Container(
                                  height: 80,
                                  width: double.infinity,
                                  decoration: con_clr.ConClr2
                                      ? BoxDecoration(
                                          gradient: LinearGradient(
                                          colors: ConClrAppbarGreadiant,
                                        ))
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
                                            "Enter Tag-No of \nCattle Manually",
                                            fontwhiteColor,
                                            FontWeight.w600,
                                            13,
                                            context),
                                      )
                                    ],
                                  )),
                              Con_Wid.height(10),
                              Con_Wid.textFieldWithInter(
                                  TextInput_Type: TextInputType.number,
                                  text: "",
                                  controller: manualentry,
                                  hintText: "Tag No"),
                              Con_Wid.height(10),
                              Con_Wid.MainButton(
                                  OnTap: () async {
                                    bool flagWarranty = false;
                                    if (await validateTagId(manualentry.text)) {
                                      {
                                        setState(() {
                                          manualentry.text.isEmpty
                                              ? flagWarranty = true
                                              : flagWarranty = false;
                                        });
                                        if (manualentry.text.isEmpty) {
                                          Con_Wid.Con_Show_Toast(
                                              context, "Enter TagId");
                                        } else {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop('dialog');
                                          //getSWData();
                                          _result = manualentry.text;
                                          check_db();
                                        }
                                      }
                                    } else {
                                      Con_Wid.Con_Show_Toast(
                                          context, "Enter valid Tagid");
                                    }
                                  },
                                  pStrBtnName: "Continue",
                                  height: 45,
                                  width: 170,
                                  fontSize: 14)
                            ]),
                          ),
                        );
                      },
                    );
                  },
                  pStrBtnName: "Manual Entry",
                  height: 45,
                  width: 175,
                  fontSize: 15,
                  isborder: true)
            ],
          ),
        ),
      ),
    );
  }

  InkWell button(dynamic onTap, List<Color> color, double radius, double height,
      double borderWidth, String text, FontWeight fontWeight, double fontSize) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height * (MediaQuery.of(context).size.width) / 100,
        width: double.infinity,
        decoration: con_clr.ConClr2
            ? BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: color),
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(
                  width: borderWidth,
                  color: Colors.white,
                ),
              )
            : BoxDecoration(
                color: ConClrSelectedLightBack2,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: borderWidth,
                  color: Colors.white,
                )),
        child: Con_Wid.gText(
          text,
          style: TextStyle(
              fontSize:
                  fontSize * (MediaQuery.of(context).size.width / 3) / 100,
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontWeight: fontWeight),
        ),
      ),
    );
  }

  tagText(String text, double fontSize) {
    return Center(
      child: Con_Wid.gText(text,
          style: TextStyle(
              fontSize:
                  fontSize * (MediaQuery.of(context).size.width / 3) / 100,
              color: con_clr.ConClr2 ? Colors.white : BlackColor,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500)),
    );
  }

  Future check_db() async {
    String Tag = "";
    for (int i = 0; i < Con_List.id_Animal_Details.length; i++) {
      if (Con_List.id_Animal_Details[i].tagId
          .toString()
          .contains(_result.toString())) {
        Tag = Con_List.id_Animal_Details[i].tagId.toString();
      }
    }
    if (Tag != "") {
      int index = int.parse(Tag.toString());
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return profile(index.toString());
        },
      ));
    }
    else {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return manual_entry(manualentry:manualentry.text);
          },
        ));
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
                          Navigator.pushReplacement(context, MaterialPageRoute(
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
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return New_Cattle(
                                manualentry: manualentry.text,
                              );
                            },
                          ));
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

  Future<bool> validateTagId(String text) async {
    if (Constants_Usermast.QRCode == "false") {
      return true;
    }
    if (text.length == 12 && text != "000000000000") {
      String tag = text;

      int sum = 0;

      for (int i = 0; i < tag.length; i++) {
        int multipliedValue = (tag.length - i - 1) * int.tryParse(tag[i])!;
        if (multipliedValue >= 0) sum += multipliedValue;
      }

      double value = (sum / 9).toDouble();

      int y = int.tryParse(value.toString().split('.')[1][0])!;

      if (y == int.tryParse(tag[11])!) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
