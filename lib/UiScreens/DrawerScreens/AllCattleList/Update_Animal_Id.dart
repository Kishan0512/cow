import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/profile.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

import '../../../camera.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';

class Animal_update extends StatefulWidget {
  String index;
   Animal_update({super.key,required this.index});

  @override
  State<Animal_update> createState() => _Animal_updateState();
}

class _Animal_updateState extends State<Animal_update> {
  String AnimalID = "", QRData = "";
  TextEditingController AnimalTag = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Con_Wid.appBar(
        title: "Rename Animal",
        Actions: [],
        onBackTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return profile(widget.index);
            },
          ));
        },
      ),
      body: Con_Wid.backgroundContainer(
          child: Column(children: [
            Con_Wid.height(20),
            Text(
              "OldTag ID :- ${widget.index}",
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
            Con_Wid.height(40),
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
            Con_Wid.height(10),
            Text("Or"),
            Con_Wid.height(10),
            Con_Wid.textFieldWithInter(controller: AnimalTag, hintText: "Enter Animal Tag ID"),
            Spacer(),
            Con_Wid.MainButton(OnTap: () {
              Con_Wid.Con_Show_Toast(context, "Api Pending");
            }, pStrBtnName: "Save", height: 45, width: 150, fontSize: 16),
            Spacer(),
            Spacer(),
            Spacer(),
            Spacer(),
          ],)),
    );
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
          print(AnimalID);
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
