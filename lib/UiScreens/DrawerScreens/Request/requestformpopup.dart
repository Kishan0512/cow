import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/Request/Request.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_ApiUrl.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_NetworkHelp.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

import '../../../camera.dart';

class request_form_popup extends StatefulWidget {
  String requestid;
  String status;
  bool notshow;

  request_form_popup(this.notshow,this.requestid, this.status);

  @override
  State<request_form_popup> createState() => _request_form_popupState();
}

class _request_form_popupState extends State<request_form_popup> {
  List<dynamic> keys = [];
  List<List<dynamic>> values = [];
  List<dynamic> keys1 = [];
  List<List<dynamic>> values1 = [];
  List JSON = [];
  List JSON1 = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDate();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(
          () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return RequestScreen();
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "Request Details",
          Actions: [],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return RequestScreen();
              },
            ));
          },
        ),
        body: isLoading
            ? Stack(children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        JSON.isNotEmpty
                            ? DataTable(

                          horizontalMargin: 5,
                          columnSpacing: 10,
                          headingRowColor:
                          MaterialStateProperty.resolveWith(
                                  (states) => Colors.greenAccent),
                          columns: keys
                              .map((column) => DataColumn(
                              label: Text(
                                column,
                                textAlign: TextAlign.center,
                              )))
                              .toList(),
                          rows: List<DataRow>.generate(
                            values.length,
                                (index) => DataRow(
                              cells: List<DataCell>.generate(
                                values[index].length,
                                    (innerIndex) => DataCell(Container(
                                  width: 110,
                                  child: Center(
                                    child: Text(values[index]
                                    [innerIndex]
                                        .toString()),
                                  ),
                                )),
                              ),
                            ),
                          ),
                        )
                            : Container(),
                        SizedBox(
                          height: 100,
                        ),
                        JSON1.isNotEmpty
                            ? DataTable(
                          headingRowColor:
                          MaterialStateProperty.resolveWith(
                                  (states) => Colors.greenAccent),
                          columns: keys1
                              .map((column) => DataColumn(
                              label: Text(
                                column,
                                textAlign: TextAlign.center,
                              )))
                              .toList(),
                          rows: List<DataRow>.generate(
                            values1.length,
                                (index) => DataRow(
                              cells: List<DataCell>.generate(
                                values1[index].length,
                                    (innerIndex) => DataCell(
                                  Text(values1[index][innerIndex]
                                      .toString()),
                                ),
                              ),
                            ),
                          ),
                        )
                            : Container()
                      ],
                    ),
                  ))),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //32
                Constants_Usermast.groupId == 32
                    ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: GetRetButton33(),
                  ),
                )
                    : Container(),
                //32
                Constants_Usermast.groupId == 32
                    ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: GetDelButton33(),
                  ),
                )
                    : Container(),

                Constants_Usermast.groupId != 22 && Constants_Usermast.groupId != 32
                    ? widget.status == "On the Way" //Normal
                // || widget.status == "Requested"
                    ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: GetApproveButton(),
                  ),
                )
                    : Container()
                    : Container(),
                !widget.notshow ?
                Constants_Usermast.groupId == 22 ?
                widget.status == "Requested" ? //Normal
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: GetApproveButton(),
                  ),
                )
                    : Container() : Container() : Container(),
                Constants_Usermast.groupId == 22
                    ? (widget.status == "Requested" ||
                    widget.status == "Approved") //Normal
                    ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(bottom: 5.0),
                      child: GetRejButton(),
                    ),
                  ),
                )
                    : Container()
                    : Container(),
              ],
            ),
          ),
        ],)
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  getDate() async {
    var res = await ApiCalling.getdata(
        AppUrl().getRequestDetails + "/" + widget.requestid,
        Constants_Usermast.token);
    JSON = jsonDecode(res.body);
    if (res.statusCode == 200) {
      for (int i = 0; i < JSON.length; i++) {
        Map<dynamic, dynamic> map = JSON[i];
        if (keys.isEmpty) {
          keys = map.keys.toList();
        }
        values.add(map.values.toList());
      }
    }

    var res1 = await ApiCalling.getdata(
        AppUrl().getRequestDetailsSub + "/" + widget.requestid,
        Constants_Usermast.token);
    JSON1 = jsonDecode(res1.body);

    if (res1.statusCode == 200) {
      for (int i = 0; i < JSON1.length; i++) {
        Map<dynamic, dynamic> map = JSON1[i];
        if (keys1.isEmpty) {
          keys1 = map.keys.toList();
        }
        values1.add(map.values.toList());
      }
      setState(() {
        isLoading = true;
      });
    }
  }
  GetApproveButton() =>
      SizedBox(
        width: 120,
        child: AnimatedButton(
          height: 50,
          width: 120,
          color: Colors.green,
          onPressed: () async {
            final vehicleres = await ApiCalling.createPatch(
                AppUrl().getRequestUpdate + "/" + widget.requestid,
                "Bearer " + Constants_Usermast.token,
                {"status": Constants_Usermast.groupId != 22 ? "G" : "A"});

            Con_Wid.Con_Show_Toast(context, "Request Submitted Succecssfully");

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return RequestScreen();
            },));
          },
          child: widget.status == "On the Way"
              ? Text('Received',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold))
              : Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text('મંજૂર',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ),

        ),
      );

  GetRejButton() =>
      SizedBox(

        width: 120,
        child: AnimatedButton(
          height: 50,
          width: 120,
          color: Colors.red,
          onPressed: () async {
            final vehicleres = await ApiCalling.createPatch(
                AppUrl().getRequestUpdate + "/" + widget.requestid,
                "Bearer " + Constants_Usermast.token,
                {"status": "J"});
            Con_Wid.Con_Show_Toast(context, "Request Submitted Succecssfully");

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return RequestScreen();
            },));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text('અસ્વીકાર',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ),

        ),
      );

  GetRetButton33() =>
      SizedBox(
        width: 120,
        child: AnimatedButton(
          height: 50,
          width: 120,
          color: Colors.red,
          onPressed: () async {
            final vehicleres = await ApiCalling.createPatch(
                AppUrl().getRequestUpdate + "/" + widget.requestid,
                "Bearer " + Constants_Usermast.token,
                {"status": "R"});
            Con_Wid.Con_Show_Toast(context, "Request Submitted Succecssfully");

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return RequestScreen();
            },));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text('Return',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ),

        ),
      );

  GetDelButton33() =>
      SizedBox(
        width: 120,
        child: AnimatedButton(
          height: 50,
          width: 120,
          color: Colors.green,
          onPressed: () async {
            final vehicleres = await ApiCalling.createPatch(
                AppUrl().getRequestUpdate + "/" + widget.requestid,
                "Bearer " + Constants_Usermast.token,
                {"status": "P"});
            Con_Wid.Con_Show_Toast(context, "Request Submitted Succecssfully");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return RequestScreen();
            },));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text('Deliver',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ),

        ),
      );
}
