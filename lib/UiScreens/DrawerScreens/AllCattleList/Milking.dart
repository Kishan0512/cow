import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/Bluetooth_connection.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/CattleStatusTimeline.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/Milk_report.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_NetworkHelp.dart';
import 'package:herdmannew/component/DataBaseHelper/Con_List.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/DataBaseHelper/Sync_Database.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/ButtonState.dart';
import '../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../component/Gobal_Widgets/Con_Icons.dart';
import '../../../component/Gobal_Widgets/Con_Textstyle.dart';
import '../../../component/Gobal_Widgets/Con_Toast.dart';
import '../../../component/Gobal_Widgets/Con_Widget.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../../component/Gobal_Widgets/MyCustomWidget.dart';
import '../../../model/Animal_Details_id.dart';
import '../../../model/Milk_production_id.dart';

class Milking extends StatefulWidget {
  String index;

  Milking(this.index);

  @override
  State<Milking> createState() => _MilkingState();
}

class _MilkingState extends State<Milking> {
  ButtonState stateTextWithIcon = ButtonState.idle;
  late StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  bool _isBluetoothConnected = false;
  TextEditingController MilkEntry = TextEditingController();
  var e1 = TextEditingController();
  TextEditingController t1 = TextEditingController();
  TextEditingController Bottleno = TextEditingController();
  TextEditingController Boxno = TextEditingController();
  late int TagIndex;
  String parity = "";
  String TotalMilk = "0";
  Animal_Details_id? noteList;
  var t1_sum = 0.0;
  var m1_sum = 0.0;
  var e1_sum = 0.0;
  String dates = "",
      actual_date = DateTime.now().toString(),
      lat = "",
      long = "",
      _dataBuffer = '',
      strDate = "",
      dateDifference = "",
      deviceid = "",
      weight = "",
      Lastmilk = "",
      Lactation_Total = "",
      dateTime = "",
      latitude = "",
      longitude = "",
      CountIdno = "";
  DateTime selectedDate = DateTime.now();
  var datess = new DateTime.now();
  Animal_Details_id? Mdetail;
  bool Milkdetail = false;
  List<Milk_production_id> Milkproduction = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata1();
    GetPermission().then((value){
      getConnected();
      getLoc();
      for (int i = 0; i < Con_List.id_Milk_production.length; i++) {
        if (Con_List.id_Milk_production[i].tagId.toString() ==
            Mdetail!.tagId.toString()) {
          TagIndex = i;
          Milkdetail = true;
        }
      }
    });

  }
 Future GetPermission() async {
    final status1 = await Permission.bluetoothScan.request();
    final status2 = await Permission.bluetoothConnect.request();
    if(status1.isDenied || status2.isDenied)
    {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ].request();
    }

  }

  void getData(address) async {
    try {
      BluetoothConnection connection =
      await BluetoothConnection.toAddress(address);
      _isBluetoothConnected = true;

      CustomToast.show(context, "Connected to the device");
      connection.input?.listen((Uint8List data) {
        final asciidata = ascii.decode(data);
        _dataBuffer = _dataBuffer + asciidata;

        if (ascii.decode(data).contains('}}')) {
          final navigationData = jsonDecode(_dataBuffer);
          _dataBuffer = '';
          setState(() {
            deviceid = navigationData['device']['deviceid'];
            weight = navigationData['reading']['weight'];
            MilkEntry.text = weight;
            dateTime = navigationData['reading']['datetime'];
            latitude = navigationData['reading']['lat'];
            longitude = navigationData['reading']['lng'];
          });
          //connection.finish(); // Closing connection
        }
      }).onDone(() {
        CustomToast.show(context, "Disconnected by remote request");
      });
    } catch (exception) {
      CustomToast.show(context, "Cannot connect, exception occured");
    }
  }

  void getConnected() {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
          if (r.device.isBonded) {
            //  Toast.show("bonded", context,duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            setState(() {});
            getData(r.device.address);
          }
        });
  }

  Future getLoc() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    lat = position.latitude.toString();
    long = position.longitude.toString();
    var box = await Hive.openBox<Milk_production_id>("Milk_production_id");
    try {
      Constants.Last_id_milk = int.parse(box.keys.last.toString());
    } catch (e) {
      print(e);
      Constants.Last_id_milk = 0;
    }
  }

  Future<void> _onPressHere(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Bluetooth_connection()),
    );
    if (result != null) {
      getData(result.bluetoothAddress);
    }
  }

  getdata1() {
    Milkproduction = Con_List.id_Milk_production
        .where((e) => e.tagId == widget.index.toString())
        .toList();

    Mdetail = Con_List.id_Animal_Details
        .firstWhere((element) => element.tagId == widget.index.toString());
    List<Animal_Details_id> noteListFuture = [];
    noteListFuture.add(Mdetail!);
    if (noteListFuture.isNotEmpty) {
      this.noteList = noteListFuture[0];
      if (noteListFuture.length < 0) {
        return;
      } else if (noteListFuture.length == 0) {
        return;
      }

      TotalMilk = Mdetail!.totalMilk.toString();
      TotalMilk = TotalMilk.replaceAll("(", "");
      TotalMilk = TotalMilk.replaceAll(")", "");
      setState(() {});
      CountIdno = Milkproduction.length.toString();
      CountIdno = CountIdno.replaceAll("(", "");
      CountIdno = CountIdno.replaceAll(")", "");

      if (Milkproduction.isNotEmpty) {
        strDate = Milkproduction[0].date;
        strDate = strDate.replaceAll("(", "");
        strDate = strDate.replaceAll(")", "");

        Lastmilk = Milkproduction[0].dayMilkTotal.toString();
        Lastmilk = Lastmilk.replaceAll("(", "");
        Lastmilk = Lastmilk.replaceAll(")", "");
      }
      parity = Mdetail!.parity.toString();
      parity = parity.replaceAll("(", "");
      parity = parity.replaceAll(")", "");

      DateTime today_date = DateTime.now();
      if (Con_Wid.change_date_format(strDate) ==
          Con_Wid.change_date_format(today_date.toString())) {
        var noteMapList = Con_List.id_Milk_production
            .where(
                (e) => e.tagId == widget.index.toString() && e.date == strDate)
            .toList();
        List<Map> formList = [];
        formList.add(noteMapList as Map);
        List<Map> noteListFuture1 = formList;
        if (noteListFuture1.isNotEmpty) {
          if (noteListFuture1[0]["MorningYield"].toString() != "null") {
            MilkEntry.text = noteListFuture1[0]["MorningYield"].toString();
            m1_sum =
                double.parse(noteListFuture1[0]["MorningYield"].toString());
          }
          if (noteListFuture1[0]["EveningYield"].toString() != "null") {
            e1.text = noteListFuture1[0]["EveningYield"].toString();
            e1_sum =
                double.parse(noteListFuture1[0]["EveningYield"].toString());
          }
          t1.text = noteListFuture1[0]["DayMilkTotal"].toString();
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(
              () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return cattlestatustimeline(index: widget.index);
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "Official Milk Record",
          Actions: [
            Con_Wid.mIconButton(
              onPressed: () {
                _onPressHere(context);
              },
              icon: _isBluetoothConnected
                  ? Icon(Icons.bluetooth_connected)
                  : Icon(Icons.bluetooth),
            ),
            Con_Wid.mIconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Milk_report();
                    },
                  ));
                },
                icon: Own_menu)
          ],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return cattlestatustimeline(index: widget.index);
              },
            ));
          },
        ),
        body: Con_Wid.backgroundContainer(
          child: SingleChildScrollView(
            child: Column(children: [
              con_clr.ConClr2
                  ? Con_Wid.fullContainer(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Farmer Name :",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 40,
                                width: 200,
                                child: Con_Wid.paddingWithText(
                                    "${Mdetail!.farmername}", Conclrfontmain,
                                    pIntPadding: 5, context: context),
                              )
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Society Code : ",
                              style: ConStyle.style_theme_16s_500w(),
                            ),
                            Con_Wid.paddingWithText(
                                "${Mdetail!.lot}", Conclrfontmain,
                                pIntPadding: 5, context: context)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Society Name : ",
                              style: ConStyle.style_theme_16s_500w(),
                            ),
                            Con_Wid.paddingWithText(
                                "${Mdetail!.lotname}", Conclrfontmain,
                                pIntPadding: 5, context: context)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Animal.ID : ",
                              style: ConStyle.style_theme_16s_500w(),
                            ),
                            Con_Wid.paddingWithText(
                                "${Mdetail!.tagId}", Conclrfontmain,
                                pIntPadding: 5, context: context)
                          ],
                        )
                      ],
                    ),
                  ))
                  : Con_Wid.fullContainer1(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Farmer Name :",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 40,
                                width: 200,
                                child: Con_Wid.paddingWithText(
                                    "${Mdetail!.farmername}",
                                    context: context,
                                    whiteColor,
                                    pIntPadding: 5),
                              )
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Society Code : ",
                              style: ConStyle.style_theme_16s_500w(),
                            ),
                            Con_Wid.paddingWithText(
                                "${Mdetail!.lot}", whiteColor,
                                pIntPadding: 5, context: context)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Society Name : ",
                              style: ConStyle.style_theme_16s_500w(),
                            ),
                            Con_Wid.paddingWithText(
                                "${Mdetail!.lotname}", whiteColor,
                                pIntPadding: 5, context: context)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Animal.ID : ",
                              style: ConStyle.style_theme_16s_500w(),
                            ),
                            Con_Wid.paddingWithText(
                                "${Mdetail!.tagId}", whiteColor,
                                pIntPadding: 5, context: context)
                          ],
                        )
                      ],
                    ),
                  )),
              con_clr.ConClr2
                  ? Con_Wid.fullContainer(
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Last Recorded : ",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                              Milkdetail == false
                                  ? Con_Wid.paddingWithText(
                                  "-", Conclrfontmain, context: context)
                                  : Con_Wid.paddingWithText(
                                  "${Con_List.id_Milk_production[TagIndex].date
                                      .toString().substring(0, 10)}",
                                  Conclrfontmain,
                                  pIntPadding: 5,
                                  context: context)
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Last Milk(kg) : ",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                              Milkdetail == false
                                  ? Con_Wid.paddingWithText(
                                  "0", Conclrfontmain, context: context)
                                  : Con_Wid.paddingWithText(
                                  "${Con_List.id_Milk_production[TagIndex]
                                      .dayMilkTotal}",
                                  Conclrfontmain,
                                  pIntPadding: 5,
                                  context: context)
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Total Milk(kg) : ${weight != null
                                    ? weight
                                    : 0}",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "No Of Records : ",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                              Milkdetail == false
                                  ? Con_Wid.paddingWithText(
                                  "${CountIdno}", Conclrfontmain,
                                  context: context)
                                  : Con_Wid.paddingWithText(
                                  "${Con_List.id_Milk_production[TagIndex]
                                      .daysCount}",
                                  Conclrfontmain,
                                  pIntPadding: 5,
                                  context: context)
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Device id : ${deviceid.toString()}",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Date : ${dateTime.toString()}",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Lat :  ${latitude.toString()}",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Long : ${longitude.toString()}",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                            ]),
                      ],
                    ),
                  ))
                  : Con_Wid.fullContainer1(
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Last Recorded : ",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                              Milkdetail == false
                                  ? Con_Wid.paddingWithText("-", whiteColor,
                                  context: context)
                                  : Con_Wid.paddingWithText(
                                  "${Con_List.id_Milk_production[TagIndex].date
                                      .toString() == "" &&
                                      Con_List.id_Milk_production[TagIndex].date
                                          .toString() == "null" ? Con_List
                                      .id_Milk_production[TagIndex].date
                                      .toString().substring(0, 10) : Con_List
                                      .id_Milk_production[TagIndex].date
                                      .toString()}",
                                  whiteColor,
                                  pIntPadding: 5,
                                  context: context)
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Last Milk(kg) : ",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                              Milkdetail == false
                                  ? Con_Wid.paddingWithText("0", whiteColor,
                                  context: context)
                                  : Con_Wid.paddingWithText(
                                  "${Con_List.id_Milk_production[TagIndex]
                                      .dayMilkTotal}",
                                  whiteColor,
                                  pIntPadding: 5,
                                  context: context)
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Total Milk(kg) : ${weight != null
                                    ? weight
                                    : 0}",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                              // Milkdetail == false
                              //     ? Con_Wid.paddingWithText("0", Conclrfontmain)
                              //     : Con_Wid.paddingWithText(
                              //     "${Con_List.A_Production[TagIndex].lactationMilkTotal}",
                              //     Conclrfontmain)
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "No Of Records : ",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                              Milkdetail == false
                                  ? Con_Wid.paddingWithText(
                                  "${CountIdno}",
                                  context: context,
                                  whiteColor)
                                  : Con_Wid.paddingWithText(
                                  "${Con_List.id_Milk_production[TagIndex]
                                      .daysCount}",
                                  context: context,
                                  whiteColor,
                                  pIntPadding: 5)
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Device id : ${deviceid.toString()}",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Date : ${dateTime.toString()}",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Lat :  ${latitude.toString()}",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Long : ${longitude.toString()}",
                                style: ConStyle.style_theme_16s_500w(),
                              ),
                            ]),
                      ],
                    ),
                  )),
              Con_Wid.fullContainer(
                  child: Container(
                    height: 100,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Con_Wid.paddingWithText(
                                "Morning", context: context, Conclrfontmain),
                            Con_Wid.width(60),
                            Con_Wid.paddingWithText(
                                "Total", context: context, Conclrfontmain),
                            Con_Wid.width(10),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Con_Wid.paddingWithText(
                                "Milk(kg)", context: context, Conclrfontmain),
                            Container(
                              height: 35,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 2,
                                  color: Conclrfontmain,
                                ),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: MilkEntry,
                                onChanged: (value) {
                                  if (MilkEntry != "") {
                                    m1_sum = double.parse('$value');
                                    t1_sum = double.parse('$value') + e1_sum;
                                    int decimals = 2;
                                    num fac = pow(10, decimals);
                                    t1_sum = (t1_sum * fac).round() / fac;
                                    t1.text = '$t1_sum';
                                    setState(() {});
                                  }
                                },
                                style: TextStyle(
                                    color: Conclrfontmain,
                                    fontFamily: "poppins"),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 1, horizontal: 15),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 60,
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 2,
                                  color: Conclrfontmain,
                                ),
                              ),
                              child: Text("${t1.text}"),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
              Con_Wid.fullContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Con_Wid.textFieldWithInter(
                          text: "Bottle No",
                          controller: Bottleno,
                          hintText: "Enter Bottle No"),
                      Con_Wid.textFieldWithInter(
                          text: "Box No",
                          controller: Boxno,
                          hintText: "Enter Box No"),
                      Con_Wid.height(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyCustomWidget(
                              Onchanged: () async {
                                if (MilkEntry.text.isEmpty) {
                                  Con_Wid.Con_Show_Toast(
                                      context, "Enter Morning Milk");
                                } else {
                                  int? bottleNo =
                                  int.tryParse(Bottleno.text.trim().isEmpty?"1":Bottleno.text.trim());
                                  int? boxNo = int.tryParse(Boxno.text.trim().isEmpty?"1":Boxno.text);
                                  if (strDate != "null") {
                                    DateTime first_date = DateTime.parse(
                                        strDate.isNotEmpty
                                            ? strDate
                                            : DateTime.now().toString());
                                    final date1 = DateTime(first_date.year,
                                        first_date.month, first_date.day);

                                    var date2 = DateTime.parse(
                                        Con_Wid.change_date_format(
                                            actual_date));

                                    final difference =
                                        date2
                                            .difference(date1)
                                            .inDays;

                                    dateDifference = difference.toString();
                                    if (int.parse(dateDifference) <= 30) {
                                      if (Lastmilk.isNotEmpty &&
                                          t1.text.isNotEmpty) {
                                        try {
                                          double averageMilk =
                                              (double.parse(Lastmilk) +
                                                  double.parse(t1.text)) /
                                                  2;
                                          double lactationTotal = averageMilk *
                                              double.parse(dateDifference);
                                          Lactation_Total =
                                              lactationTotal.toString();
                                        } catch (e) {
                                          print(
                                              "Error parsing double value: $e");
                                        }
                                      } else {
                                        Lactation_Total = "";
                                      }
                                    }
                                    if (int.parse(dateDifference) > 30) {
                                      if (Lastmilk.isNotEmpty &&
                                          t1.text.isNotEmpty) {
                                        try {
                                          double averageMilk =
                                              (double.parse(Lastmilk) +
                                                  double.parse(t1.text)) /
                                                  2;
                                          double lactationTotal = averageMilk *
                                              30;
                                          Lactation_Total =
                                              lactationTotal.toString();
                                        } catch (e) {
                                          print(
                                              "Error parsing double value: $e");
                                          Lactation_Total = "";
                                        }
                                      } else {
                                        Lactation_Total = "";
                                      }
                                    }
                                  } else {
                                    String maxDateCalvingDetails =
                                        Mdetail!.calvingDate;
                                    maxDateCalvingDetails =
                                        maxDateCalvingDetails.replaceAll(
                                            '(', "");
                                    maxDateCalvingDetails =
                                        maxDateCalvingDetails.replaceAll(
                                            ')', "");
                                    var formatter2 = new DateFormat(
                                        'yyyy-MM-dd');
                                    maxDateCalvingDetails = formatter2.format(
                                        DateTime.parse(maxDateCalvingDetails));
                                    DateTime first_date =
                                    DateTime.parse(maxDateCalvingDetails);
                                    final date1 = DateTime(first_date.year,
                                        first_date.month, first_date.day);

                                    var date2 = DateTime.parse(
                                        Con_Wid.change_date_format(
                                            actual_date));
                                    final difference =
                                        date2
                                            .difference(date1)
                                            .inDays;
                                    dateDifference = difference.toString();
                                    if (double.tryParse(dateDifference) !=
                                        null &&
                                        double.tryParse(t1.text) != null) {
                                      if (double.parse(dateDifference) <= 30) {
                                        double lac_tot =
                                        (double.parse(dateDifference) *
                                            double.parse(t1.text));
                                        Lactation_Total = lac_tot.toString();
                                      } else {
                                        double lac_tot =
                                        (30 * double.parse(t1.text));
                                        Lactation_Total = lac_tot.toString();
                                      }
                                    } else {
                                      Lactation_Total = "";
                                    }
                                  }
                                  List<Milk_production_id> prod = [
                                    Milk_production_id(
                                        tagId: "${widget.index}",
                                        date: actual_date,
                                        parity: parity != 0 ? parity : null,
                                        morningYield: MilkEntry.text != ""
                                            ? MilkEntry.text
                                            : null,
                                        eveningYield: e1.text != "" ? e1.text : null,
                                        nightYield: null,
                                        midnightYield: null,
                                        fat: null,
                                        snf: null,
                                        lactose: null,
                                        protein: null,
                                        fatC: null,
                                        snfC: null,
                                        lactoseC: null,
                                        proteinC: null,
                                        cumulativeMilkTotal: null,
                                        lactationMilkTotal: Lactation_Total,
                                        daysCount: int.parse('$dateDifference'),
                                        SyncStatus: "0",
                                        officialMilk: null,
                                        dayMilkTotal:
                                        t1.text != "" ? t1.text : null,
                                        details: null,
                                        id: Constants.Last_id_milk + 1,
                                        lat: lat,
                                        long: long,
                                        bottleno: bottleNo,
                                        boxno: boxNo,
                                        herd: int.parse(
                                            Mdetail!.herd.toString()),
                                        lot: int.parse(Mdetail!.lot.toString()),
                                        farmer:
                                        int.parse(Mdetail!.farmerCode.toString()),
                                        staff: null,
                                        serverID: null,
                                        clientID: null)
                                  ];
                                  DateTime today_date = DateTime.now();
                                  // if (Con_Wid.change_date_format(strDate) ==
                                  //     Con_Wid.change_date_format(
                                  //         today_date.toString())) {
                                  List<String> newvalue = [
                                    MilkEntry.text != "" ? MilkEntry.text : "0",
                                    e1.text != "" ? e1.text : "0",
                                    t1.text != "" ? t1.text : "0"
                                  ];
                                  switch (stateTextWithIcon) {
                                    case ButtonState.idle:
                                      stateTextWithIcon = ButtonState.loading;
                                      final vehicleres = await ApiCalling
                                          .createPost(
                                          AppUrl().savemilkentry,
                                          "Bearer " + Constants_Usermast.token,
                                          {
                                            "tagId": widget.index,
                                            "inputDate": dateTime.isEmpty?DateTime.now().toString().substring(0,16):dateTime.substring(0,16),
                                            "mor": MilkEntry.text,
                                            "deviceid": deviceid,
                                            "lat": latitude,
                                            "long": longitude,
                                            "boxNo": Bottleno.text.isEmpty?"1":Bottleno.text,
                                            "bottleNo": Boxno.text.isEmpty?"1":Boxno.text,
                                            "createdAt": DateTime.now().toString().substring(0,16),
                                          }
                                          );
                                      if (vehicleres.statusCode == 200) {
                                        Milk_production_id prods =
                                        prod[math.Random().nextInt(
                                            prod.length)];
                                        List<Map> weights_sync_datas = [];
                                        weights_sync_datas.add(
                                            prods.toJson(prods));
                                        SyncDB.insert_table(weights_sync_datas,
                                            Constants.Milk_production_id);
                                        Future.delayed(
                                          Duration(seconds: 3),
                                              () {
                                            setState(() {
                                              stateTextWithIcon =
                                                  ButtonState.success;
                                              if (stateTextWithIcon ==
                                                  ButtonState.success) {
                                                Sync_Json.Get_Master_Data(
                                                    "Milk_production_id");
                                                Future.delayed(
                                                    Duration(seconds: 1),
                                                        () {
                                                      Navigator.pop(context);
                                                    });
                                              }
                                            });
                                          },
                                        );
                                      } else {
                                        Con_Wid.Con_Show_Toast(
                                            context, "Something Went Wrong");
                                        stateTextWithIcon = ButtonState.idle;
                                      }

                                      break;
                                    case ButtonState.loading:
                                      break;
                                    case ButtonState.success:
                                      stateTextWithIcon = ButtonState.idle;
                                      break;
                                    case ButtonState.fail:
                                      stateTextWithIcon = ButtonState.idle;
                                      break;
                                  }
                                  setState(
                                        () {
                                      stateTextWithIcon = stateTextWithIcon;
                                    },
                                  );
                                }
                              },
                              Title: "Save",
                              color: con_clr.ConClr2
                                  ? ConClrBtntxt
                                  : ConClrDialog,
                              stateTextWithIcon: stateTextWithIcon)
                        ],
                      )
                    ],
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
