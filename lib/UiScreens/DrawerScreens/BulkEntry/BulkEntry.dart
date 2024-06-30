import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/Dashboard/Dashboard.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

import '../../../component/Gobal_Widgets/Con_Color.dart';
import 'De-Worming/De-Worming.dart';
import 'MilkEntry/MilkEntry.dart';
import 'Vaccination/Vaccination.dart';

class BulkEntryScreen extends StatefulWidget {
  const BulkEntryScreen({Key? key}) : super(key: key);

  @override
  State<BulkEntryScreen> createState() => _BulkEntryScreenState();
}

class _BulkEntryScreenState extends State<BulkEntryScreen> {
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
            title: 'Bulk Entry',
            Actions: [],
            onBackTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return DashBoardScreen();
                },
              ));
            }),
        body: Con_Wid.backgroundContainer(
          child: Column(
            children: [
              Container(
                color: con_clr.ConClr2 ? Colors.white : whiteColor1,
                child: Container(
                  height: 325,
                  margin: const EdgeInsets.all(7),
                  padding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
                  decoration: con_clr.ConClr2
                      ? BoxDecoration(
                          color: ConClrLightBack2,
                          border: Border.all(width: 5, color: Colors.white),
                        )
                      : BoxDecoration(color: ConClrLightBack2),
                  child: Column(
                    children: [
                      Con_Wid.showTypesDetailContainer(
                          "Select type of bulk entry", context),
                      Con_Wid.div(),
                      containerWithTxt(() {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return MilkEntry();
                          },
                        ));
                      }, 10, 10, "Milk Entry", 5, FontWeight.w500),
                      Con_Wid.div(),
                      containerWithTxt(() {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return DeWorming();
                          },
                        ));
                        // Get.toNamed("/DeWorming");
                      }, 10, 10, "De-worming", 5, FontWeight.w500),
                      Con_Wid.div(),
                      containerWithTxt(() {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Vaccination();
                          },
                        ));
                        //Get.toNamed("/Vaccination");
                      }, 10, 10, "Vaccination", 5, FontWeight.w500),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  containerWithTxt(dynamic onTap, double margin, double radius, String text,
      double borderWidth, FontWeight fontWeight) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: 170,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / margin),
        decoration: BoxDecoration(
          color: con_clr.ConClr2 ? ConClrBlueDark : Color(0xff579ee5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Con_Wid.popinsfont(
            text, Colors.white, FontWeight.w600, 14, context),
      ),
    );
  }
}
