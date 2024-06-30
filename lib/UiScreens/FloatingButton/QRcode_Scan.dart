import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/Dashboard/Dashboard.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/profile.dart';
import 'package:herdmannew/UiScreens/FloatingButton/CattleRegistrationScreen.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../component/DataBaseHelper/Con_List.dart';
import '../../component/Gobal_Widgets/Con_Icons.dart';
import '../../component/Gobal_Widgets/Con_Usermast.dart';
import '../Dashboard/cattle_add.dart';
import '../Dashboard/cattle_manual.dart';

class QRcode_Scan extends StatefulWidget {
  bool Mobileregistration_perm;

  QRcode_Scan(this.Mobileregistration_perm);

  @override
  State<QRcode_Scan> createState() => _QRcode_ScanState();
}

class _QRcode_ScanState extends State<QRcode_Scan> {
  TextEditingController Manuallytagno = TextEditingController();
  String result = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _result = "Lets start to scan";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // get();
  }

  get() async {
    final status2 = await Permission.camera.request();
    if (status2.isPermanentlyDenied) {
      openAppSettings();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
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
          title: "cattle Registration",
          Actions: [],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return CattleRegistrationScreen();
              },
            ));
          },
        ),
        body: Con_Wid.backgroundContainer(
            child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  if (await Permission.camera.isGranted) {
                    _scanQr();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Camera Permission is Denied"),
                      action: SnackBarAction(
                        label: "Setting",
                        onPressed: () => openAppSettings(),
                      ),
                    ));
                    // Con_Wid.Con_Show_Toast(
                    //     context, "Camera Permission is Denied");
                  }
                },
                child: Image.asset(
                  "assets/images/scan_now.webp",
                  fit: BoxFit.cover,
                  height: 350,
                ),
              ),
              Con_Wid.paddingWithText(
                  "Enter the Tag No Manually", Conclrfontmain,
                  context: context),
              Con_Wid.height(20),
              Con_Wid.MainButton(
                  OnTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: SizedBox(
                            height: 250,
                            child: Column(children: [
                              Container(
                                  height: 80,
                                  width: double.infinity,
                                  decoration: con_clr.ConClr2
                                      ? const BoxDecoration(
                                          gradient: LinearGradient(
                                          colors: ConClrAppbarGreadiant,
                                        ))
                                      : BoxDecoration(color: ConClrDialog),
                                  child: Stack(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Con_Wid.mIconButton(
                                              color: fontwhiteColor,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Own_Close),
                                        ],
                                      ),
                                      Center(
                                        child: Con_Wid.popinsfont(
                                            "Enter Tag-No of \nCattle Manually",
                                            fontwhiteColor,
                                            FontWeight.w600,
                                            13,
                                            context),
                                      )
                                    ],
                                  )),
                              Con_Wid.height(10),
                              Con_Wid.textFieldWithInter(
                                  TextInput_Type: TextInputType.number,
                                  text: "",
                                  controller: Manuallytagno,
                                  hintText: "Tag No"),
                              Con_Wid.height(10),
                              Con_Wid.MainButton(
                                  OnTap: () {
                                    bool flagWarranty = false;
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    // if (widget.Mobileregistration_perm == false) {
                                    //   Navigator.pop(context);
                                    //   Con_Wid.Con_Show_Toast(context,
                                    //       "Sorry you are not authorised,\nPlease contact Administrator");
                                    // } else
                                    {
                                      setState(() {
                                        Manuallytagno.text.isEmpty
                                            ? flagWarranty = true
                                            : flagWarranty = false;
                                      });
                                      if (Manuallytagno.text.isEmpty) {
                                        Con_Wid.Con_Show_Toast(
                                            context, "Enter TagId");
                                      } else {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog');
                                        //getSWData();
                                        _result = Manuallytagno.text;
                                        check_db(_result);
                                      }
                                    }
                                  },
                                  pStrBtnName: "Continue",
                                  height: 45,
                                  width: 170,
                                  fontSize: 14)
                            ]),
                          ),
                        );
                      },
                    );
                  },
                  pStrBtnName: "Manual Entry",
                  height: 45,
                  width: double.infinity,
                  fontSize: 15,
                  isborder: true)
            ],
          ),
        )),
      ),
    );
  }

  check_db(String done) async {
    String Tag = "";
    for (int i = 0; i < Con_List.id_Animal_Details.length; i++) {
      if (Con_List.id_Animal_Details[i].tagId.toString().contains(done)) {
        Tag = Con_List.id_Animal_Details[i].tagId.toString();
      }
    }
    if (Tag != "") {
      int index = int.parse(Tag.toString());
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return profile(index.toString());
        },
      ));
    }
    else {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return manual_entry(manualentry:done);
          },
        ));
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text(
                  "You are offline, if this animal is already register then it is delete automatic from local"),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Con_Wid.MainButton(
                        OnTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return DashBoardScreen();},
                          ));},
                        pStrBtnName: "Cancel",
                        height: 40,
                        width: 80,
                        fontSize: 16),
                    Con_Wid.MainButton(
                        OnTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return New_Cattle(
                                manualentry: done,
                              );
                            },
                          ));
                        },
                        pStrBtnName: "Ok",
                        height: 40,
                        width: 80,
                        fontSize: 16)
                  ],
                )
              ],
            );
          },
        );
      }
    }
  }

//430055221133
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
          _result = code1;
        });
        {
          check_db(_result);
        }
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return QRcode_Scan(widget.Mobileregistration_perm);
          },
        ));
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
