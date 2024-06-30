import 'dart:convert';

import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../camera.dart';
import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../component/Gobal_Widgets/Con_Textstyle.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../../component/Gobal_Widgets/Con_Widget.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../Dashboard/Dashboard.dart';

class mpptest extends StatefulWidget {
  const mpptest({Key? key}) : super(key: key);

  @override
  State<mpptest> createState() => _mpptestState();
}

class _mpptestState extends State<mpptest> {
  List<dynamic> Select = [
    {"id": 1, "name": "Nill"},
    {"id": 2, "name": "Low - Jelly"},
    {"id": 3, "name": "Medium - Jelly"},
    {"id": 4, "name": "High - Jelly"},
  ];
  bool select = false;
  TextEditingController Remarks = TextEditingController();
  String AnimalID = "", QRData = "";
  int flq = 0;
  int hlq = 0;
  int hrq = 0;
  int frq = 0;
  Widget? r;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() {
    if (Con_List.M_Userherds.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_herd);
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
          title: "MPP test",
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
            child: Con_Wid.fullContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Con_Wid.height(10),
                Text(
                  "Tag ID :- $AnimalID",
                  style: TextStyle(
                      background: Paint()
                        ..color = Colors.blue.shade900
                        ..strokeJoin = StrokeJoin.round
                        ..strokeCap = StrokeCap.round
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 25.0,
                      color: Colors.white,
                      fontSize: 14.0),
                ),
                Con_Wid.height(20),
                AnimatedButton(
                  height: 40,
                  width: 150,
                  child: const Text(
                    'Scan BarCode',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () async {
                    _scanQr();
                  },
                ),
                //Con_Wid.paddingWithText("Route", Conclrfontmain),
                CondropDown(
                  title: 'Select Animal',
                  itemList: Con_List.id_Animal_Details
                      .where((element) =>
                          element.statusname == "Pregnant Milking" ||
                          element.statusname == "Milking")
                      .map((e) => e.tagId.toString())
                      .toList(),
                  SelectedList: [],
                  onSelected: (List<String> value) {
                    setState(() {
                      AnimalID = value[0];
                    });
                  },
                ),
                //Con_Wid.paddingWithText("Society", Conclrfontmain),
                CondropDown(
                  title: 'Select fore quarter front right',
                  itemList: Select.map((e) => e['name'].toString()).toList(),
                  SelectedList: [],
                  onSelected: (List<String> value) {
                    setState(() {
                      frq = Select.firstWhere((element) =>
                          element['name'].toString() ==
                          value[0].toString())['id'];
                    });
                  },
                ),
                CondropDown(
                  title: 'Select fore quarter front left',
                  itemList: Select.map((e) => e['name'].toString()).toList(),
                  SelectedList: [],
                  onSelected: (List<String> value) {
                    setState(() {
                      flq = Select.firstWhere((element) =>
                          element['name'].toString() ==
                          value[0].toString())['id'];
                    });
                  },
                ),
                //Con_Wid.paddingWithText("ID No", Conclrfontmain),
                CondropDown(
                  title: 'Select Hind quarter back right',
                  itemList: Select.map((e) => e['name'].toString()).toList(),
                  SelectedList: [],
                  onSelected: (List<String> value) {
                    setState(() {
                      hrq = Select.firstWhere((element) =>
                          element['name'].toString() ==
                          value[0].toString())['id'];
                    });
                  },
                ),
                CondropDown(
                  title: 'Select Hind quarter back left',
                  itemList: Select.map((e) => e['name'].toString()).toList(),
                  SelectedList: [],
                  onSelected: (List<String> value) {
                    setState(() {
                      hlq = Select.firstWhere((element) =>
                          element['name'].toString() ==
                          value[0].toString())['id'];
                    });
                  },
                ),
                Con_Wid.textFieldWithInter(
                    controller: Remarks, hintText: "Remarks"),
                Con_Wid.height(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Con_Wid.MainButton(
                        width: 170,
                        height: 45,
                        fontSize: 16,
                        pStrBtnName: "Save",
                        OnTap: () {
                          if (AnimalID.isNotEmpty) {
                            MppApi().then((value) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Material(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height -
                                                kToolbarHeight,
                                        child: Column(children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 20,
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      10),
                                              width:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.9,
                                              height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      3.9 -
                                                  kToolbarHeight,
                                              child: Image.asset(
                                                  "assets/images/check1.gif")),
                                          Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.5,
                                              child: const Text(
                                                "MPP Test Done\nSuccessfully",
                                                style: TextStyle(
                                                  color: fontBlackColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              )),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Text(
                                                DateTime.now()
                                                    .toString()
                                                    .substring(0, 10),
                                                style: ConStyle
                                                    .style_white_18s_600w()),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsetsDirectional.only(
                                                top: 30),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.7,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1)),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                1.2,
                                                        height: MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            10,
                                                        decoration: const BoxDecoration(
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .grey))),
                                                        child: Text(
                                                            "Order No : ${value.containsKey("medicine3")?value['medicine3']:value['msg']}",
                                                            style:
                                                                ConStyle.Style_white_13s_700w(Colors.black))),
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                        "TagID \n $AnimalID",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                              Expanded(flex: 5,
                                                                child: (frq == 1 &&
                                                                        flq == 1 &&
                                                                        hrq == 1 &&
                                                                        hlq == 1)
                                                                    ? const Text(
                                                                        "No Mastities",
                                                                        style:
                                                                            TextStyle(fontSize: 15),
                                                                      )
                                                                    : (frq == 1 &&
                                                                            flq == 2 &&
                                                                            hrq == 1 &&
                                                                            hlq == 2)
                                                                        ? const Text(
                                                                            "Teat dipping  with  Santosa supplements",
                                                                            style: TextStyle(
                                                                                fontSize: 15),
                                                                          )
                                                                        : (frq == 3 &&
                                                                                flq == 3 &&
                                                                                hrq == 3 &&
                                                                                hlq == 3)
                                                                            ? const Text(
                                                                                "Udder care  with  M care Plus",
                                                                                style: TextStyle(
                                                                                    fontSize: 15),
                                                                              )
                                                                            : (frq == 1 &&
                                                                                    flq == 4 &&
                                                                                    hrq == 2 &&
                                                                                    hlq == 3)
                                                                                ? const Text(
                                                                                    "Need Dr  support",
                                                                                    style: TextStyle(
                                                                                        fontSize:
                                                                                            15),
                                                                                  )
                                                                                : (frq == 1 &&
                                                                                        flq == 1 &&
                                                                                        hrq == 3 &&
                                                                                        hlq == 3)
                                                                                    ? const Text(
                                                                                        "Udder care  with  M care",style: TextStyle(fontSize: 15),)
                                                                                    : const Text("No Recommendation"),
                                                              ),
                                                ]),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {});
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return DashBoardScreen();
                                                },
                                              ));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  20,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              child: const Text("Got it"),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    );
                                  },
                                );
                              }
                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return Dialog(
                              //       child: Container(
                              //         height:
                              //             MediaQuery.of(context).size.height /
                              //                 2.5,
                              //         child: Column(
                              //           children: [
                              //             Container(
                              //                 color: ConClrDialog,
                              //                 height: MediaQuery.of(context)
                              //                         .size
                              //                         .height /
                              //                     12,
                              //                 width: double.infinity,
                              //                 alignment: Alignment.center,
                              //                 child: const Text(
                              //                   'Recommendation\n To Farmers',
                              //                   textAlign: TextAlign.center,
                              //                   style: TextStyle(
                              //                       color: Colors.white,
                              //                       fontSize: 20),
                              //                 )),
                              //             Spacer(),
                              //             Spacer(),
                              //             Row(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.end,
                              //               children: [
                              //                 Padding(
                              //                   padding:
                              //                       const EdgeInsets.all(8.0),
                              //                   child: ElevatedButton(
                              //                       onPressed: () {
                              //                         Navigator.pushReplacement(
                              //                             context,
                              //                             MaterialPageRoute(
                              //                           builder: (context) {
                              //                             return DashBoardScreen();
                              //                           },
                              //                         ));
                              //                       },
                              //                       child: Text("Ok")),
                              //                 ),
                              //               ],
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // );
                            );
                          } else {
                            Con_Wid.Con_Show_Toast(
                                context, "Please select TagId");
                          }
                        })
                  ],
                )
              ],
            )),
          ),
        ),
      ),
    );
  }

  Future MppApi() async {
    String formattedDateStr =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(DateTime.now());

    final res = await ApiCalling.createPost(
        AppUrl().saveanimaltest, "Bearer ${Constants_Usermast.token}", {
      "id": "0",
      "tagId": AnimalID,
      "flq": flq,
      "hlq": hlq,
      "hrq": hrq,
      "frq": frq,
      "yearMaster": null,
      "camp": null,
      "inputDate": DateFormat("yyyy-MM-dd").format(DateTime.now()),
      "alqMix": null,
      "sampletype": null,
      "result": Remarks.text,
      "testedBy": int.parse(Constants_Usermast.staff),
      "herd": null,
      "lot": null,
      "farmer": null,
      "details": null,
      "cmtRound": null,
      "followTest": null,
      "medicine1": null,
      "medicine2": null,
      "medicine3": null,
      "createdAt": DateFormat("yyyy-MM-dd").format(DateTime.now()),
      "updatedAt": DateFormat("yyyy-MM-dd").format(DateTime.now())
    });
    if (res.statusCode == 200) {

      return jsonDecode(res.body);
    } else {

      return jsonDecode(res.body);
    }
  }

  Future _scanQr() async {
    var qrResult = await BarcodeScanner.scan();
    var code1;

    if (qrResult.rawContent.length > 12) {
      code1 = await getResult(qrResult.rawContent);
    }
    if (qrResult.rawContent.length == 12) {
      code1 = qrResult.rawContent;
    }
    try {
      if (await validateTagId(code1)) {
        setState(() {
          AnimalID = code1;
          select = true;
        });
      } else {
        Con_Wid.Con_Show_Toast(context, "Invalid TagId  $code1");
      }
    } catch (e) {}
  }

  Future<bool> validateTagId(String text) async {
    if (Constants_Usermast.QRCode == "false") {
      return true;
    }
    if (text.length == 12 && text != "000000000000") {
      String tag = text;

      int sum = 0;

      for (int i = 0; i < tag.length; i++) {
        int multipliedValue = (tag.length - i - 1) * int.tryParse(tag[i])!;
        if (multipliedValue >= 0) sum += multipliedValue;
      }

      double value = (sum / 9).toDouble();

      int y = int.tryParse(value.toString().split('.')[1][0])!;

      if (y == int.tryParse(tag[11])!) {
        return true;
      } else {
        return false;
      }
    }

    return false;
  }
}

String hexToASCII(String st) {
  String com = "";
  for (int x = 0; x < st.length; x += 2) {
    String k = st.substring(x, x + 2);
    com += String.fromCharCode(int.parse(k, radix: 16));
  }
  return com;
}

int getInvertedValue(int i, String input, String key, int random) {
  int asciiInputChar = input.codeUnitAt(i);
  int j = i + 2;
  int modvalue = j % key.length;
  int acsciiKey;
  if (modvalue == 0) modvalue = 1;
  acsciiKey = key.codeUnitAt(modvalue - 1);
  int finalvalue = asciiInputChar - (acsciiKey + random);
  return finalvalue;
}

String decryptData(String output, String key) {
  String decryptedText = "";
  for (int i = 0; i < output.length;) {
    int random = 0;
    if (i == 0) {
      random = 13;
    }
    if (i == 1) {
      random = 12;
    }
    if (i == 2) {
      random = 3;
    }
    if (i == 3) {
      random = 4;
    }
    if (i == 4) {
      random = 2;
    }
    if (i == 5) {
      random = 5;
    }
    if (i == 6) {
      random = 7;
    }
    if (i == 7) {
      random = 6;
    }
    if (i == 8) {
      random = 9;
    }
    if (i == 9) {
      random = 14;
    }
    if (i == 10) {
      random = 15;
    }
    if (i == 11) {
      random = 1;
    }
    if (i == 12) {
      random = 8;
    }
    if (i == 13) {
      random = 10;
    }
    if (i == 14) {
      random = 11;
    }

    int asciivalue = getInvertedValue(i, output, key, random);
    String ch = String.fromCharCode(asciivalue);

    decryptedText = decryptedText + ch;
    i++;
  }
  return decryptedText;
}

String getResult(String data) {
  try {
    String decryptedstring = hexToASCII(data);
    return decryptData(decryptedstring, "101");
  } catch (e) {
    return "";
  }
}
