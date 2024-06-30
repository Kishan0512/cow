import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../Dashboard/Dashboard.dart';

class ProjectCampScreen extends StatefulWidget {
  const ProjectCampScreen({Key? key}) : super(key: key);

  @override
  State<ProjectCampScreen> createState() => _ProjectCampScreenState();
}

class _ProjectCampScreenState extends State<ProjectCampScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    var res;
    res = await ApiCalling.createPost(
        AppUrl().getCampData, Constants_Usermast.token.toString(), res);
    if (res.statusCode == 200) {
      List<Map> formList =
          (jsonDecode(res.body) as List).map((e) => e as Map).toList();
      // AppUrl.GlbLanguageData = formList;
    }
  }

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
        appBar: Con_Wid.appBar(
          title: "Project Camp",
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
          child: Container(),
        ),
      ),
    );
  }
}

class Language {}
