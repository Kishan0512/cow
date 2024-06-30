import 'package:flutter/material.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

import '../../Dashboard/Dashboard.dart';

class DatabaseExportScreen extends StatefulWidget {
  const DatabaseExportScreen({Key? key}) : super(key: key);

  @override
  State<DatabaseExportScreen> createState() => _DatabaseExportScreenState();
}

class _DatabaseExportScreenState extends State<DatabaseExportScreen> {
  @override
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
          title: "Database Export",
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
