import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../component/Gobal_Widgets/Con_Textstyle.dart';
import '../../../component/Gobal_Widgets/Con_Widget.dart';
import '../../../component/Gobal_Widgets/Constants.dart';

class Add_abort_details extends StatefulWidget {
  const Add_abort_details({Key? key}) : super(key: key);

  @override
  State<Add_abort_details> createState() => _Add_abort_detailsState();
}

class _Add_abort_detailsState extends State<Add_abort_details> {
  String mStrFromdate = "";
  bool botton1 = true;
  bool botton2 = false;
  bool botton3 = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() {
    if (Con_List.M_status.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_status);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Con_Wid.appBar(
        title: "PD Details",
        Actions: [],
        onBackTap: () {},
      ),
      body: Con_Wid.backgroundContainer(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Con_Wid.fullContainer(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                      "Farmer Name : ",
                      style: ConStyle.style_theme_16s_500w(),
                    ),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Society Code :-",
                        style: ConStyle.style_theme_16s_500w(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Society Name :-",
                        style: ConStyle.style_theme_16s_500w(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Animal.ID :-",
                        style: ConStyle.style_theme_16s_500w(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Last Calv Date :-",
                        style: ConStyle.style_theme_16s_500w(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "No of A.l :-",
                        style: ConStyle.style_theme_16s_500w(),
                      ),
                    ],
                  )
                ],
              ),
            )),
            Con_Wid.fullContainer(
                child: Column(
              children: [
                Con_Wid.paddingWithText(
                    "PD Date : ${mStrFromdate}", Conclrfontmain,
                    context: context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Con_Wid.selectionContainer(
                      height: 44,
                      width: 97,
                      text: "Today",
                      context: context,
                      ontap: () {
                        mStrFromdate =
                            DateFormat('dd-MM-yyyy').format(DateTime.now());

                        setState(() {
                          botton2 = false;
                          botton3 = false;
                          botton1 = true;
                        });
                      },
                      Color: botton1 ? ConClrbluelight : ConClrLightBack,
                    ),
                    Con_Wid.selectionContainer(
                      height: 44,
                      width: 97,
                      text: "Yesterday",
                      context: context,
                      ontap: () {
                        mStrFromdate = DateFormat('dd-MM-yyyy')
                            .format(DateTime.now().subtract(Duration(days: 1)));
                        setState(() {
                          botton3 = false;
                          botton1 = false;
                          botton2 = true;
                        });
                      },
                      Color: botton2 ? ConClrbluelight : ConClrLightBack,
                    ),
                    Con_Wid.selectionContainer(
                      height: 44,
                      width: 97,
                      text: "Calendar",
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
                      Color: botton3 ? ConClrbluelight : ConClrLightBack,
                    ),
                  ],
                ),
                Con_Wid.MainButton(
                    OnTap: () {},
                    pStrBtnName: "Save",
                    height: 45,
                    width: 170,
                    fontSize: 10)
              ],
            ))
          ],
        ),
      )),
    );
  }
}
