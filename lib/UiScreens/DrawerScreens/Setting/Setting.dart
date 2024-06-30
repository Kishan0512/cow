import 'package:flutter/material.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';

import '../../../component/Gobal_Widgets/Con_Widget.dart';
import '../../Dashboard/Dashboard.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Color Backgroundcolor = Colors.white;
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
          title: "Setting",
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
          child: SingleChildScrollView(
              child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue.shade50.withOpacity(0.2),
            ),
            child: Column(
              children: [
                Con_Wid.div(),
                Row(
                  children: [
                    Con_Wid.width(10),
                    Con_Wid.popinsfont(
                        "Background color",
                        con_clr.ConClr2 ? fontwhiteColor : BlackColor,
                        FontWeight.w600,
                        15,
                        context),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (con_clr.ConClr2) {
                          con_clr.ConClr2 = false;
                        } else {
                          con_clr.ConClr2 = true;
                        }
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 36,
                        width: 76,
                        decoration: BoxDecoration(
                            color: ConClrMain,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white)),
                      ),
                    )
                  ],
                ),
                Con_Wid.div(),
                Row(
                  children: [
                    Con_Wid.width(10),
                    Con_Wid.popinsfont(
                        "Button color",
                        con_clr.ConClr2 ? fontwhiteColor : BlackColor,
                        FontWeight.w600,
                        15,
                        context),
                    Spacer(),

                  ],
                ),
                Con_Wid.div(),
                Row(
                  children: [
                    Con_Wid.width(10),
                    Con_Wid.popinsfont(
                        "Text color",
                        con_clr.ConClr2 ? fontwhiteColor : BlackColor,
                        FontWeight.w600,
                        15,
                        context),
                    Spacer(),

                  ],
                ),
                Con_Wid.div(),
                Row(
                  children: [
                    Con_Wid.width(10),
                    Con_Wid.popinsfont(
                        "Text Font color",
                        con_clr.ConClr2 ? fontwhiteColor : BlackColor,
                        FontWeight.w600,
                        15,
                        context),
                    Spacer(),

                  ],
                ),
                Con_Wid.div(),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
