import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Icons.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:share_plus/share_plus.dart';

import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../Alarm/Alarm.dart';
import 'CustomReport.dart';

class CustomReportsDetail extends StatefulWidget {
  String reportSelected;
  String filterSelected;
  String txtValue;
  String routeSelected;
  String societySelected;
  String farmerSelected;
  String parameter;

  CustomReportsDetail(
      this.reportSelected,
      this.filterSelected,
      this.txtValue,
      this.routeSelected,
      this.societySelected,
      this.farmerSelected,
      this.parameter);

  @override
  State<CustomReportsDetail> createState() => _CustomReportsDetailState();
}

class _CustomReportsDetailState extends State<CustomReportsDetail> {
  List<String> mListFarmerId = [];
  bool temp = false;
  bool temp1 = false;
  int total_count=0;
  List<dynamic> mReportdata = [];
  List<String> keys = [];
  int mobile=0;
  List<List<dynamic>> values = [];
  String mStrFromdate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  // @override
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();

    get_new_custom_report();
  }

  get_new_custom_report() async {
    var res = await ApiCalling.createPost(AppUrl().getCustomReport,
        "Bearer " + Constants_Usermast.token.toString(), {
      "reportBy": widget.reportSelected,
      "cond": widget.filterSelected == "" ? ">" : widget.filterSelected,
      "valueInt": widget.txtValue == "" ? "0" : widget.txtValue,
      "herd": widget.routeSelected,
      "lot": widget.societySelected,
      "farmer": widget.farmerSelected
    });
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {

      if (res.body.toString() != "") {
        mReportdata = jsonDecode(res.body);
        total_count =mReportdata.length;
        mReportdata.forEach((element) {
          element.remove('Mobile No');

        });
        for (int i = 0; i < mReportdata.length; i++) {
          Map<String, dynamic> map = mReportdata[i];
          if (keys.isEmpty) {
            keys = map.keys.toList();
            mobile = keys.indexOf("Farmer MobileNumber");
          }

          values.add(map.values.toList());
        }
        temp = true;
      }
      temp1 = true;
    } else {
      temp1 = true;
    }
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mStrFromdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    return WillPopScope(
      onWillPop: () {
        return Future(
          () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return CustomReportScreen();
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "Custom Report    $total_count",
          Actions: [
            Con_Wid.mIconButton(
                onPressed: () {
                  _generatePdfAndView();
                },
                icon: Own_Share)
          ],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return CustomReportScreen();
              },
            ));
          },
        ),
        body:  !temp
            ? temp1
            ? const Center(
          child: Text("No Data Found"),
        )
            : const Center(
          child: CircularProgressIndicator(),
        )
            : mReportdata.isEmpty
            ? const Center(
          child: Text("No Data Found"),
        )
            :SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: Con_Wid.containerBackGroundColor(),
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith((states) => ConClrDialog,),
                columnSpacing: 5,

                columns: keys
                    .map((column) => DataColumn(
                            label: Container(width: 125,
                              child: Text(
                          "$column",
                          textAlign: TextAlign.center,style: TextStyle(color: Colors.white),
                        ),
                            )))
                    .toList(),
                rows: List<DataRow>.generate(
                  values.length,
                  (index) => DataRow(
                      cells: List<DataCell>.generate(
                    values[index].length,
                    (innerIndex) =>mobile==innerIndex? DataCell(
                      InkWell(onTap: () {

                         _callNumber(values[index][innerIndex]);

                      },child: Container(width: 125,child: Text(values[index][innerIndex].toString(),textAlign: TextAlign.center))),
                    ): DataCell(
                      Container(width: 125,child: Text(values[index][innerIndex].toString(),textAlign: TextAlign.center)),
                    ),
                  )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  _callNumber(String nom) async{
    String number = nom.toString(); //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
  headerData(String header) {
    return Con_Wid.popinsfont(
        header, const Color(0XFF223347), FontWeight.w600, 6, context);
  }

  rowData(String data) {
    return Con_Wid.popinsfont(
        data, const Color(0XFF466A92), FontWeight.w600, 6, context);
  }

  Future _generatePdfAndView() async {
    final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);

    pdf.addPage(
      pdfLib.MultiPage(
        pageFormat: PdfPageFormat.a3,
        build: (context) => [
          pdfLib.Table.fromTextArray(context: context, data: <List<String>>[
            <String>[
              '${widget.reportSelected}' +
                  ' - Report- ' +
                  (DateTime.now().toString().substring(0, 10))
            ],
            ['']
          ]),
          pdfLib.Table.fromTextArray(context: context, data: <List<dynamic>>[
            keys.map((column) => "$column").toList(),
            for(int i=0;i<values.length;i++)
               values[i],
          ]),
        ],
      ),
    );

    final String dir = (await getExternalStorageDirectory())!.path;
    final String path = '$dir/herdman_custom_report.pdf';
    final File file = File(path);
    await file.writeAsBytes(List.from(await pdf.save()));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    try {
      await Share.shareFiles(
        ['${path}'],
        text: "Report",
      );
    } catch (e) {
      print("error" + e.toString());
    }
  }
}
