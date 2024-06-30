import 'dart:io';
import 'package:excel/excel.dart';
import 'package:share_plus/share_plus.dart';

class ExcelSheet {
  static Future<void> generateExcelFromJson(
      List<dynamic> jsonData, String Name) async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];
    List<String> keys = [];
    List<List<dynamic>> values = [];
    for (int i = 0; i < jsonData.length; i++) {
      Map<String, dynamic> map = jsonData[i];
      if (keys.isEmpty) {
        keys = map.keys.toList();
      }
      values.add(map.values.toList());
    }
    sheet.appendRow(keys);
    for (int i = 0; i < values.length; i++) {
      sheet.appendRow(values[i]);
      sheet.getColAutoFits;
    }
    String Date = DateTime.now().toString().replaceAll(RegExp(r'[- :.]'), '');
    Directory filePath =
        Directory('/storage/emulated/0/Download/$Name$Date.xlsx');
    final file = File(filePath.path);
    await file.writeAsBytes(await excel.encode()!);
    try {
      Share.shareFiles(['${filePath.path}'], text: 'Great picture');
    } catch (e) {}
  }
}
