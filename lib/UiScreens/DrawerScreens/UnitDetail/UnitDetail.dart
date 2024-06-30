import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/UnitDetail/AddVehicleDetails.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:intl/intl.dart';

import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../Dashboard/Dashboard.dart';
import 'UpdateVehicleDetails.dart';

class UnitDetailScreen extends StatefulWidget {
  const UnitDetailScreen({Key? key}) : super(key: key);

  @override
  State<UnitDetailScreen> createState() => _UnitDetailScreenState();
}

class _UnitDetailScreenState extends State<UnitDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getVehicle();
  }

  String date = DateTime.now().toString().substring(0, 10);
  bool loading = false;
  List<dynamic> vehicles = [];
  int count = 0;
  bool istap = false;
  bool istap2 = false;

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
            title: "Unit Detail",
            Actions: [
              IconButton(
                  splashRadius: 20,
                  onPressed: () => showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now())
                          .then((value) {
                        setState(() {
                          date = value.toString().substring(0, 10);

                          loading = false;
                          _getVehicle();
                        });
                      }),
                  icon: Icon(Icons.date_range))
            ],
            onBackTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return DashBoardScreen();
                },
              ));
            },
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            color: whiteColor1,
            padding: const EdgeInsets.all(6),
            child: loading
                ? vehicles.isEmpty
                    ? Center(
                        child: Image(
                            height: 150,
                            width: 150,
                            image:
                                AssetImage("assets/images/No-Data-Found.webp")),
                      )
                    : ListView.builder(
                        itemCount: vehicles.length,
                        itemBuilder: (context, index) {
                          return Card(
                              margin: const EdgeInsets.only(
                                  left: 5, right: 5, top: 10),
                              color: whiteColor,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset(
                                                fit: BoxFit.fill,
                                                width: 150,
                                                "assets/images/Rectangle 199.png",
                                                color: (vehicles[index]
                                                                    ['EndUnit']
                                                                .toString() ==
                                                            "null" ||
                                                        vehicles[index][
                                                                    'EndDatetime']
                                                                .toString() ==
                                                            "null")
                                                    ? Colors.red
                                                    : Colors.green,
                                              ),
                                              (vehicles[index]['EndUnit']
                                                              .toString() ==
                                                          "null" ||
                                                      vehicles[index][
                                                                  'EndDatetime']
                                                              .toString() ==
                                                          "null")
                                                  ? Text(
                                                      "Pending",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  : const Text("Completed",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                            ],
                                          ),
                                          Spacer(),
                                          (vehicles[index]['EndUnit']
                                                          .toString() ==
                                                      "null" ||
                                                  vehicles[index]['EndDatetime']
                                                          .toString() ==
                                                      "null")
                                              ? Con_Wid.mIconButton(
                                                  onPressed: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return upadtevehicledetails(
                                                            vehicles[index]);
                                                      },
                                                    ));
                                                  },
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Colors.green,
                                                  ))
                                              : Container(),
                                          (vehicles[index]['EndUnit']
                                                          .toString() ==
                                                      "null" ||
                                                  vehicles[index]['EndDatetime']
                                                          .toString() ==
                                                      "null")
                                              ? Con_Wid.mIconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                          child: Container(
                                                            height: 170,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                color: con_clr
                                                                    .ConClr2
                                                                    ? ConClrMainLight
                                                                    : whiteColor),
                                                            child: Column(
                                                                children: [
                                                                  Container(
                                                                    height: 60,
                                                                    width: double
                                                                        .infinity,
                                                                    decoration: con_clr
                                                                        .ConClr2
                                                                        ? const BoxDecoration(
                                                                        gradient:
                                                                        LinearGradient(
                                                                          colors:
                                                                          ConClrAppbarGreadiant,
                                                                        ))
                                                                        : const BoxDecoration(
                                                                        color:
                                                                        ConClrDialog),
                                                                    child: Center(
                                                                      child: Con_Wid.popinsfont(
                                                                          "Delete Detail ?",
                                                                          fontwhiteColor,
                                                                          FontWeight
                                                                              .w600,
                                                                          15,
                                                                          context),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                        15,
                                                                        right:
                                                                        15),
                                                                    child: Column(
                                                                      children: [
                                                                        Con_Wid
                                                                            .height(
                                                                            15),
                                                                        Con_Wid.paddingWithText(
                                                                            "Do you want to delete this Detail ?",
                                                                            Conclrfontmain,
                                                                            context:
                                                                            context),
                                                                        Con_Wid
                                                                            .height(
                                                                            10),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                          children: [
                                                                            Con_Wid.MainButton(
                                                                                OnTap: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                pStrBtnName: "No",
                                                                                height: 35,
                                                                                width: 90,
                                                                                fontSize: 16),
                                                                            Con_Wid.width(
                                                                                5),
                                                                            Con_Wid.MainButton(
                                                                                OnTap: () {
                                                                                  _onVehicleDelete(
                                                                                      vehicles[index]['ID']
                                                                                          .toString());
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                pStrBtnName: "yes",
                                                                                height: 35,
                                                                                width: 90,
                                                                                fontSize: 16)
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ]),
                                                          ),
                                                        );
                                                      },
                                                    );

                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ))
                                              : Container(),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            getHeadingText(
                                                Head: "Regular Vehicle : ",
                                                body: vehicles[index]
                                                        ['RegularVehicleNo']
                                                    .toString()),
                                            getHeadingText(
                                                Head: "Vehicle number : ",
                                                body: vehicles[index]['VNo'] ??
                                                    vehicles[index]
                                                        ['ReplaceVehicleNo']),
                                            getHeadingText(
                                                Head: "Total Unit : ",
                                                body: vehicles[index]
                                                        ['TotalUnit']
                                                    .toString()),
                                            getHeadingText(
                                                Head: "Starting Time : ",
                                                body: DateFormat(
                                                        'dd-MM-yyyy hh:mm:ss aa')
                                                    .format(DateTime.parse(
                                                        vehicles[index][
                                                                'StartDatetime']
                                                            .toString()))),
                                            getHeadingText(
                                                Head: "Ending Time : ",
                                                body: vehicles[index]
                                                            ['EndDatetime'] ==
                                                        null
                                                    ? ""
                                                    : DateFormat(
                                                            'dd-MM-yyyy hh:mm:ss aa')
                                                        .format(DateTime.parse(
                                                            vehicles[index][
                                                                    'EndDatetime']
                                                                .toString()))),
                                            getHeadingText(
                                                Head: "Driver : ",
                                                body: vehicles[index]
                                                        ['DName'] ??
                                                    vehicles[index]
                                                        ['DriverNickName'] ??
                                                    ""),
                                            Row(
                                              children: [
                                                getHeadingText(
                                                    Head: "Start Unit : ",
                                                    body: vehicles[index]
                                                            ['StartUnit']
                                                        .toString()),
                                                Spacer(),
                                                getHeadingText(
                                                    Head: "End Unit : ",
                                                    body: vehicles[index]
                                                                    ['EndUnit']
                                                                .toString() !=
                                                            "null"
                                                        ? vehicles[index]
                                                                ['EndUnit']
                                                            .toString()
                                                        : ""),
                                              ],
                                            ),
                                            getHeadingText(
                                                Head: "Total Hour Travel : ",
                                                body: vehicles[index]
                                                        ['TotalTravelHr']
                                                    .toString()),
                                            getHeadingText(
                                                Head: "Registration : ",
                                                body: DateFormat(
                                                        'dd-MM-yyyy hh:mm:ss aa')
                                                    .format(DateTime.parse(
                                                        vehicles[index][
                                                                'RegistrationDate']
                                                            .toString()))),
                                          ],
                                        ),
                                      ),
                                    ]),
                              ));
                        },
                      )
                : Center(child: CircularProgressIndicator()),
          ),
          bottomNavigationBar: Container(
            color: Colors.transparent,
            padding: EdgeInsets.only(left: 50, right: 50, bottom: 10),
            child: Con_Wid.MainButton(
                isborder: true,
                OnTap: () {
                  if (count == 0) {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return AddVehicleDetails();
                      },
                    ));
                  } else {
                    Con_Wid.Con_Show_Toast(
                        context, "Please Complete All Pending Details");
                  }
                },
                pStrBtnName: "Add Details",
                fontSize: 16,
                height: 45,
                width: 150),
          )),
    );
  }

  _getVehicle() async {
    setState(() {
      loading = false;
    });
    final vehicleres = await ApiCalling.getdata(
      AppUrl().vehicleUnitDetails,
      Constants_Usermast.token.toString(),
    );
    if (vehicleres.statusCode == 200) {
      vehicles = json.decode(vehicleres.body);
      count =
          vehicles.where((element) => element['EndDatetime'] == null).length;
      vehicles.removeWhere((element) =>
          element['StartDatetime'].toString().substring(0, 10) != date);
    }
    loading = true;
    setState(() {});
  }

  _onVehicleDelete(id) async {
    final vehicleres = await ApiCalling.createPost(
        '${AppUrl().vehicleUnitDetailsDelete}/$id',
        "Bearer " + Constants_Usermast.token.toString(),
        null);
    await _getVehicle();
  }

  getHeadingText({required String Head, required String body}) {
    return Text.rich(TextSpan(children: [
      TextSpan(text: Head, style: TextStyle(color: Colors.black26)),
      TextSpan(text: body)
    ]));
  }
}
