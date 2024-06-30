import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/Action/Action.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/Alarm/Alarm.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/AllCattleList.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/BulkEntry/BulkEntry.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/CustomReport/CustomReport.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/DisposalEntry/DisposalEntry.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/FarmerRegistration/FarmerRegistration.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/ProjectCamp/ProjectCamp.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/Report/Report.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/Request/Request.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/SireStocks/SireStocks.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/SyncReport/SyncReport.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/UnitDetail/UnitDetail.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/UnitEntryReport/UnitReport.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/VisitRegistration/VisitRegistration.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/updatefarmer/updatefarmer.dart';
import 'package:herdmannew/UiScreens/Login/LoginScreen.dart';
import 'package:herdmannew/component/DataBaseHelper/SharedPref.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/component/Gobal_Widgets/Constants.dart';
import 'package:hive/hive.dart';

import '../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../component/DataBaseHelper/Con_List.dart';
import '../component/Gobal_Widgets/Con_Icons.dart';
import '../component/Gobal_Widgets/Con_Usermast.dart';
import '../main.dart';
import 'Dashboard/Dashboard.dart';
import 'DrawerScreens/Chengepassword/ChangePassword.dart';
import 'DrawerScreens/EVM Medicine/EvmMedicine.dart';
import 'DrawerScreens/Mpptest/Mpptest.dart';
import 'DrawerScreens/Notification/Notification.dart';
import 'DrawerScreens/Setting/Setting.dart';
import 'FloatingButton/CattleRegistrationScreen.dart';

class DrawerWidget {
  static Drawer drawer(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.40,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
      ),
      backgroundColor: con_clr.ConClr2 ? ConClrLightBack : ConClrSelected,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: DrawerHeader(
                margin: EdgeInsets.only(right: 20, bottom: 1),
                padding: EdgeInsets.only(left: 25, top: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                  color:
                      con_clr.ConClr2 ? ConClrBlueDark : Colors.blue.shade300,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Con_Wid.gText(
                      "Welcome",
                      style: TextStyle(
                        color: con_clr.ConClr2 ? fontwhiteColor : whiteColor,
                        fontSize: 14,
                        fontFamily: 'Gardenia',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "${Constants_Usermast.user_name}",
                      style: TextStyle(
                        color: con_clr.ConClr2 ? whiteColor : whiteColor,
                        fontSize:
                            20 * (MediaQuery.of(context).size.width / 3) / 100,
                        fontFamily: 'Gardenia',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Draweritem.FinalDraweritem.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: SizedBox(
                        child: Image.asset(color: Colors.white,
                            "assets/images/${Draweritem.FinalDraweritem[index]["image"]}"),
                        height: 20,
                        width: 20,
                      ),
                      title: Row(children: [
                        const SizedBox(width:
                          10,),
                        Transform.translate(
                          offset: const Offset(-20, 2),
                          child: Con_Wid.gText(
                            Draweritem.FinalDraweritem[index]["name"],
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 12 *
                                  (MediaQuery.of(context).size.width / 3) /
                                  100,
                              fontStyle: FontStyle.normal,
                              fontFamily: "Gardenia",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ]),
                      onTap: () {
                        navPage(
                            Draweritem.FinalDraweritem[index]["name"], context);
                      },
                    ),
                    Con_Wid.gLineDivider(),
                  ],
                );
              },
            ),
          ),
          Con_Wid.height(20)
        ],
      ),
    );
  }

  static navPage(item, context) async {
    switch (item.toString().trim().trimLeft().trimRight()) {
      case "Add/Update Cattle Data":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return CattleRegistrationScreen();
          },
        ));
        break;
      case "Download Data":
        // Navigator.pushReplacement(context, MaterialPageRoute(
        //   builder: (context) {
        //     return const DownloadDataScreen();
        //   },
        // ));
        break;
      case "Update Farmer":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const updatefarmer();
          },
        ));
        break;
        case "Farmer Registration":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const FarmerRegis();
          },
        ));
        break;
      case "All Cattle List":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return AllCattleListScreen();
          },
        ));
        break;
      case "Sire Stocks":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return SireStockScreen();
          },
        ));
        break;
      case "MPP Test":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return mpptest();
          },
        ));
        break;
      case "Bulk Entry":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return BulkEntryScreen();
          },
        ));
        break;
      case "Action":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return ActionScreen();
          },
        ));
        break;
      case "Alarm":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return AlarmScreen();
          },
        ));
        break;
      case "EVM Medicine":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return EVMMedicine();
          },
        ));
        break;
      case "Custom Report":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return CustomReportScreen();
          },
        ));
        break;
      case "Report":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return ReportScreen();
          },
        ));
        break;
      case "Disposal Entry":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return DisposalEntryScreen();
          },
        ));
        break;
      case "Sync Report":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return SyncReportScreen();
          },
        ));
        break;
      case "Visit Registration":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return VisitRegistrationScreen();
          },
        ));
        break;
      case "Project Camp":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return ProjectCampScreen();
          },
        ));
        break;
      case "Unit Details":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return UnitDetailScreen();
          },
        ));
        break;
      case "Unit Entry Report":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return UnitReport();
          },
        ));
        break;
      case "Request":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return RequestScreen();
          },
        ));
        break;
      case "Notification":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Notificationpage();
          },
        ));
        break;
      case "Setting":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Setting();
          },
        ));
        break;
      case "Language":
        Show_language(context: context);
        break;
      case "Change Password":
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return ChangePassword();
          },
        ));
        break;
      case "Logout":
        AppUrl.CheckNewUrl.value = false;

        if (Con_List.mListPanding.isEmpty) {
          dbclear().then((value) {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return Login();
              },
            ));
          });
        } else {
          Con_Wid.Sync_Dialog(context: context);
        }
        break;
      case "Version":
        String appVersion = '2022.8.18';
        Con_Wid.gText("$appVersion");
        break;
    }
  }

  static Future<void> dbclear() async {
    await Hive.deleteFromDisk();
    await SharedPref.clear();
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  static Show_language({required BuildContext context}) async {
    String pStringLanguage = Constants_Usermast.language.toString().isEmpty
        ? "English"
        : Constants_Usermast.language;
    List Language = [
      "English",
      "Gujrathi",
      "hindi",
      "Punjabi",
      "Russian",
      "Kannada",
      "Marathi",
      "Tamil"
    ];
    restartDialog({required BuildContext context}) {
      return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
          title: Con_Wid.gText('You wont to change language.'),
          // content: Text('Result is $_result'),
          actions: [
            TextButton(
                onPressed: () {
                  // SystemNavigator.pop(); // Close the current app
                  runApp(MyApp());
                  Navigator.pop(context);// Restart the app
                },
                child: const Text('Confirm'))
          ],
        ),
      );
    }

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState1) {
            return Dialog(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ConClrMainLight),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: con_clr.ConClr2
                          ? const BoxDecoration(
                              gradient:
                                  LinearGradient(colors: ConClrAppbarGreadiant))
                          : BoxDecoration(color: ConClrDialog),
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
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return DashBoardScreen();
                                      },
                                    ));
                                  },
                                  icon: Own_Close,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        Center(
                          child: Con_Wid.paddingWithText(
                              "Language", fontwhiteColor,
                              context: context),
                        )
                      ]),
                    ),
                    Expanded(
                      child: Column(children: [
                        Expanded(
                            child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return RadioListTile(
                                    visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    value: "${Language[index]}",
                                    activeColor: Color(0xff06809F),
                                    groupValue: pStringLanguage,
                                    title: Text("${Language[index]}"),
                                    onChanged: (value) {
                                      pStringLanguage = value.toString();
                                      SharedPref.save_string(
                                          SrdPrefkey.language, pStringLanguage);
                                      Constants_Usermast.language =
                                          pStringLanguage.toString();
                                      Navigator.pop(context);
                                      setState1(() {});
                                      restartDialog(context: context);
                                    },
                                  );
                                },
                                itemCount: Language.length))
                      ]),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
