import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/Report/Report.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:share_plus/share_plus.dart';

import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../component/Gobal_Widgets/Con_Icons.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../../component/Gobal_Widgets/Con_Widget.dart';
import '../Alarm/Alarm.dart';

class Report_view extends StatefulWidget {
  String reportSelected;
  String routeSelected;
  String societySelected;
  String farmerSelected;
  String Staffid;
  String rb_date;
  String Startdate;
  String EndDate;

  Report_view(this.reportSelected, this.routeSelected, this.societySelected,
      this.farmerSelected,this.Staffid ,this.rb_date, this.Startdate, this.EndDate);

  @override
  State<Report_view> createState() => _Report_viewState();
}

class _Report_viewState extends State<Report_view> {
  List<dynamic> mReportdata = [];
  bool temp = false;
  bool temp1 = false;
  int total_count=0;
  int  mobile=0;
  List<int>  DateFor=[];

  List<String> keys = [];
  List<List<dynamic>> values = [];
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    var res = await ApiCalling.createPost(
        AppUrl().getReportAi, "Bearer " + Constants_Usermast.token.toString(), {
      "reportBy": widget.reportSelected,
      "fromDate": widget.Startdate.toString(),
      "toDate": widget.EndDate.toString(),
      "dateType": "Date",
      "herd": widget.routeSelected,
      "lot": widget.societySelected,
      "farmer": "${widget.farmerSelected.toString()}",
      "staff": widget.Staffid.isEmpty ?Constants_Usermast.staff.toString():widget.Staffid,
      "uid": ""
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
            if(widget.reportSelected=="Abortion Done")
              {
                for (int i = 0; i < keys.length; i++) {
                  if (keys[i] == "name") {
                    keys[i] = "Sire Name";
                  }
                }
              }//7020566560
            mobile = keys.indexOf("Farmer MobileNumber");
            for (int i = 0; i < keys.length; i++) {
              if (keys[i].toLowerCase().contains("date")) {
                DateFor.add(i);
              }
            }
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

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context,
            DialogRoute(
              context: context,
              builder: (context) {
                return ReportScreen();
              },
            ));
        return Future(() => true);
      },
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "Report     $total_count",
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
                return ReportScreen();
              },
            ));
          },
        ),
        body:!temp
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
                      child: Text(widget.reportSelected=="Calving Done" && column=="Date"?"Calving date":widget.reportSelected=="Calving Done" && column=="Calving Type option"?"Calf Sex":"$column",
                        textAlign: TextAlign.center,style: TextStyle(color: Colors.white),
                      ),
                    )))
                    .toList(),
                rows: List<DataRow>.generate(
                  values.length,
                      (index) => DataRow(
                      cells: List<DataCell>.generate(
                        values[index].length,
                            (innerIndex) => mobile==innerIndex? DataCell(
                              InkWell(onTap: () {
                                _callNumber(values[index][innerIndex]);

                              },child: Container(width: 125,child: Text(values[index][innerIndex].toString(),textAlign: TextAlign.center))),
                            ):DateFor.any((element) => element==innerIndex)==true? DataCell( Container(width: 125,child: Text(values[index][innerIndex].toString().substring(0,10),textAlign: TextAlign.center)),): DataCell(
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
    return Padding(
      padding: const EdgeInsets.only(left: 1),
      child: Con_Wid.popinsfont(
          data, const Color(0XFF466A92), FontWeight.w600, 5, context),
    );
  }

  Future _generatePdfAndView() async {
    final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);
    pdf.addPage(
      pdfLib.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pdfLib.Table.fromTextArray(
              cellAlignment: pdfLib.Alignment.center,
              context: context,
              data: <List<String>>[
                <String>['${widget.reportSelected}' + ' - Report '],
                <String>[
                  'UserName : ${Constants_Usermast.user_name}                                         Total Record : ${mReportdata.length.toString()}'
                ],
              ]),
          pdfLib.Table.fromTextArray(context: context, data: <List<String>>[
            <String>[
              ' Start Period : ' +
                  '${widget.Startdate}' +
                  "       " +
                  ' End Period : ' +
                  '${widget.EndDate}'
            ],
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
    final String path =
        '$dir/herdman_report' + '${DateTime.now().toString()}' + '.pdf';
    final File file = File(path);
    await file.writeAsBytes(List.from(await pdf.save()));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    try {
      await Share.shareFiles(['$path'], text: "Report");

//      Navigator.pop(context);
    } catch (e) {
      print("error" + e.toString());
    }
  }
}
