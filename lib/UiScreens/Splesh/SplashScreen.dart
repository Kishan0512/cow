import 'dart:async';

import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/Dashboard/Dashboard.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../component/DataBaseHelper/SharedPref.dart';
import '../../component/DataBaseHelper/Sync_Database.dart';
import '../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../component/Gobal_Widgets/Constants.dart';
import '../Login/LoginScreen.dart';

class SpleshScreen extends StatefulWidget {
  static var popkey;
  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    SpleshScreen.popkey = scaffoldKey;
    SyncDB.SyncUserData();
    getpermition();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer(
        const Duration(seconds: 1),
        () => CheckFirstScreen(),
      );
    });
    super.initState();
    // CheckFirstScreen();
  }

  getpermition() async {
    if (Constants_Usermast.language == "English") {
      SharedPref.save_string(SrdPrefkey.language, "English");
    }
    final status = await Permission.locationAlways.request();
    final status1 = await Permission.storage.request();
    final status2 = await Permission.camera.request();
    final status3 = await Permission.notification.request();
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
        Permission.camera,
        Permission.notification,
      ].request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }
    if (status1.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }
    if (status2.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
      ].request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }
    if(status.isDenied)
      {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.locationAlways,
        ].request();
      }
    if(status3.isDenied)
      {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.notification,
        ].request();
      }

// You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
    }
  }

  CheckFirstScreen() async {
    if (Constants_Usermast.user_id.isEmpty) {
      Logincaller();
    } else {
      if (Constants_Usermast.user_name.toString().endsWith("@hap.in")) {
        AppUrl.CheckNewUrl.value = true;
        // AppUrl().BASE_URL = "https://hais.hap.in";
      } else {
        AppUrl.CheckNewUrl.value = false;
        // AppUrl().BASE_URL = "https://dudhsagar.herdman.in";
      }
      if (Constants_Usermast.groupId == 32) {
        // Navigator.pushReplacement(context, MaterialPageRoute(
        //   builder: (context) {
        //     return DailyReport();
        //   },
        // ));
      } else {
        String s = "Wait";
        await SyncDB.SyncTable(Constants.API_MASTER_DATA, true).then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return DashBoardScreen(
                onetime: s,
              );
            },
          ));
        });
      }
    }
  }

  Logincaller() {
    Constants_Usermast.BlankCaller();
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return Login();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: scaffoldKey,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/SplashImage.jpg",
              ),
              fit: BoxFit.fill),
        ),
      ),
    );
  }
}
