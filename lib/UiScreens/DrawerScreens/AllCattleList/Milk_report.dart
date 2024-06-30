import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/AllCattleList.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

class Milk_report extends StatefulWidget {
  const Milk_report({Key? key}) : super(key: key);

  @override
  State<Milk_report> createState() => _Milk_reportState();
}

class _Milk_reportState extends State<Milk_report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Con_Wid.appBar(
        title: "Milk Report",
        Actions: [],
        onBackTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AllCattleListScreen();
            },
          ));
        },
      ),
      body: Con_Wid.backgroundContainer(
          child: Column(
        children: [
          Con_Wid.fullContainer(
              child: Column(
            children: [
              Row(
                children: [

                ],
              )
            ],
          ))
        ],
      )),
    );
  }
}
