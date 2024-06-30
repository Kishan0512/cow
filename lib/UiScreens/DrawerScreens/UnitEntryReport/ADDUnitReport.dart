// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/UnitEntryReport/UnitReport.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_ApiUrl.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_NetworkHelp.dart';
import 'package:herdmannew/component/DataBaseHelper/Con_List.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:intl/intl.dart';
import '../../../component/Gobal_Widgets/Con_Widget.dart';
import 'package:http/http.dart' as http;

class Add_UnitReport extends StatefulWidget {
  Map? e;

  Add_UnitReport({this.e});

  @override
  State<Add_UnitReport> createState() => _Add_UnitReportState();
}

class _Add_UnitReportState extends State<Add_UnitReport> {
  bool iskmvalid = false;
  bool loading = false;
  TextEditingController date = TextEditingController();
  TextEditingController outsideDCS = TextEditingController();
  TextEditingController fromTime = TextEditingController();
  TextEditingController toTime = TextEditingController();
  TextEditingController startUnit = TextEditingController();
  TextEditingController endUnit = TextEditingController();
  TextEditingController totalUnit = TextEditingController();
  TextEditingController Remark = TextEditingController();
  TextEditingController Noofvist = TextEditingController();
  List<String> Selectedcenter = [];
  List<String> SelectedVehical = [];
  List<String> SelecteDCS = [];
  List<String> SelectedPurpose = [];
  List<String> SelectedUser = [];
  String center = "Within center";
  List<dynamic> centerList = [];
  int vehicalid = 0;

  @override
  void initState() {
    super.initState();
    if (widget.e != null) {
      date.text =
          DateFormat("yyyy/MM/dd").format(DateTime.parse(widget.e!['Date']));
      outsideDCS.text = widget.e!['OutSideDCS'].toString() == "null"
          ? ""
          : widget.e!['OutSideDCS'].toString();
      fromTime.text = widget.e!['From Time'].toString() == "null"
          ? ""
          : widget.e!['From Time'].toString();
      toTime.text = widget.e!['To Time'].toString() == "null"
          ? ""
          : widget.e!['To Time'].toString();
      startUnit.text = widget.e!['Start Unit'].toString() == "null"
          ? ""
          : widget.e!['Start Unit'].toString();
      endUnit.text = widget.e!['End Unit'].toString() == "null"
          ? ""
          : widget.e!['End Unit'].toString();
      totalUnit.text = widget.e!['TotalUnit'].toString() == "null"
          ? ""
          : widget.e!['TotalUnit'].toString();
      Noofvist.text = widget.e!['NoOfVisit'].toString() == "null"
          ? ""
          : widget.e!['NoOfVisit'].toString();
      Remark.text = widget.e!['Note'].toString() == "null"
          ? ""
          : widget.e!['Note'].toString();
      Selectedcenter.add(widget.e!['center name']);
      SelectedVehical.add(widget.e!['vehicle No']);
      SelectedPurpose.add(widget.e!['Purpose']);
      SelectedUser.add(Constants_Usermast.user_name);
      setState(() {});
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(
          () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return UnitReport();
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
          appBar: Con_Wid.appBar(
            title: "Add Unit Entry Report",
            Actions: [],
            onBackTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return UnitReport();
                },
              ));
            },
          ),
          body: Stack(alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                child: Column(children: [
                  Con_Wid.height(10),
                  Con_Wid.Datepicker(date, "Select Date", context, "Date"),
                  Row(
                    children: [
                      Radio(
                        value: "Within center",
                        groupValue: center,
                        onChanged: (value) {
                          setState(() {
                            center = value.toString();
                          });
                        },
                      ),
                      Con_Wid.text_font("Within center"),
                      Radio(
                        value: "Outside center",
                        groupValue: center,
                        onChanged: (value) {
                          setState(() {
                            center = value.toString();
                          });
                        },
                      ),
                      Con_Wid.text_font("Outside center"),
                    ],
                  ),
                  CondropDown(
                    title: "Center",
                    itemList:
                        Con_List.CenterList.map((e) => e['Name'].toString()).toList(),
                    SelectedList: Selectedcenter,
                    onSelected: (value) {
                      setState(() {
                        Selectedcenter = value;
                      });
                    },
                  ),
                  CondropDown(
                    title: "Vehicle",
                    itemList: Con_List.M_Vehicle_data.map(
                        (e) => e.vehicleNo.toString()).toList(),
                    SelectedList: SelectedVehical,
                    onSelected: (value) {
                      setState(() {
                        SelectedVehical = value;
                        vehicalid = Con_List.M_Vehicle_data.where(
                                (element) =>
                            element.vehicleNo ==
                                SelectedVehical[0].toString()).first.iD;
                        getkm();
                        setState(() {});
                      });
                    },
                  ),
                  CondropDown(
                    isMultiSelect: true,
                    title: "DCS",
                    itemList: Con_List.DcsList.map((e) => e['name'].toString())
                        .toList(),
                    SelectedList: SelecteDCS,
                    onSelected: (value) {
                      setState(() {
                        SelecteDCS = value;
                      });
                    },
                  ),
                  Con_Wid.textFieldWithInter(
                      controller: outsideDCS, hintText: 'Outside DCS'),
                  Con_Wid.height(10),
                  Con_Wid.Datepicker(fromTime, "From Time", context, "Time"),
                  Con_Wid.Datepicker(toTime, "To Time", context, "Time"),
                  Con_Wid.textFieldWithInter(
                      controller: startUnit, hintText: 'Start Unit'),
                  Con_Wid.textFieldWithInter(
                    controller: endUnit,
                    hintText: 'End Unit',
                    eRror: iskmvalid ? "Please Enter Valid Value" : "",
                    Onchanged: (p0) {
                      var one = int.parse(startUnit.text);
                      var data;

                      String r = p0.toString();
                      // String r = endKM.text;
                      var two = int.parse(r);
                      setState(() {
                        if (two < one) {
                          iskmvalid = true;
                          data = 0;
                        } else {
                          iskmvalid = false;
                          data = two - one;
                          totalUnit.text = data.toString();
                        }
                      });
                    },
                  ),
                  Con_Wid.textFieldWithInter(
                      readonly: true,
                      controller: totalUnit,
                      hintText: 'Total Unit'),
                  CondropDown(
                    title: "Purpose",
                    itemList: Con_List.M_Vehicle_purpose.map(
                        (e) => e.visitPurpose.toString()).toList(),
                    SelectedList: SelectedPurpose,
                    onSelected: (value) {
                      setState(() {
                        SelectedPurpose = value;
                      });
                    },
                  ),
                  Con_Wid.textFieldWithInter(
                      controller: Remark, hintText: 'Remarks'),
                  Con_Wid.textFieldWithInter(
                      controller: Noofvist, hintText: 'No Of Visit'),
                  CondropDown(
                    title: "User BY",
                    itemList: [Constants_Usermast.user_name.toString()],
                    SelectedList: SelectedUser,
                    onSelected: (value) {
                      setState(() {
                        SelectedUser = value;
                      });
                    },
                  ),
                  Con_Wid.height(10),
                  Con_Wid.MainButton(
                      OnTap: () async {
                        setState(() {
                          loading = true;
                        });
                        List<Map> temp = [];
                        SelecteDCS.forEach((e) {
                          String id = Con_List.DcsList.firstWhere(
                                  (element) => element['name'] == e.toString())['ID']
                              .toString();
                          temp.add({"id": int.parse(id), 'Name': e});
                        });

                        Map DATA = {
                          "Date": date.text,
                          "EndUnit": int.parse(endUnit.text),
                          "FromTime": fromTime.text,
                          "ID": null,
                          "NoOfVisit": Noofvist.text,
                          "Note": Remark.text,
                          "Purpose": Con_List.M_Vehicle_purpose.where(
                              (element) =>
                                  element.visitPurpose.toString() ==
                                  SelectedPurpose[0].toString()).first.iD,
                          "StartUnit": int.parse(startUnit.text),
                          "ToTime": toTime.text,
                          "TotalCost": null,
                          "TotalUnit": int.parse(totalUnit.text),
                          "UsedBy": Constants_Usermast.user_id,
                          "centername": Selectedcenter[0],
                          "outsideDisc": outsideDCS.text,
                          "selectedLots": temp,
                          "vehicleNo": Con_List.M_Vehicle_data.where(
                              (element) =>
                                  element.vehicleNo ==
                                  SelectedVehical[0].toString()).first.iD
                        };
                        if (widget.e != null) {
                          var response = await ApiCalling.createPut(
                              AppUrl().GET_UNITCRUD + "/" + widget.e!['ID'].toString(),
                              "Bearer " + Constants_Usermast.token.toString(),
                              DATA);
                          print(response.statusCode);
                          print(response.body);
                          if (response.statusCode == 200) {
                            Con_Wid.Con_Show_Toast(
                                context, "Data Insert Successfully");
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return UnitReport();
                              },
                            ));
                          } else {
                            Con_Wid.Con_Show_Toast(
                                context, "Something Went Wrong");
                            setState(() {
                              loading = true;
                            });
                          }
                        } else {
                          var response = await ApiCalling.createPost(
                              AppUrl().GET_UNITCRUD,
                              "Bearer ${Constants_Usermast.token}",
                              DATA);
                          print(response.statusCode);
                          print(response.body);
                          if (response.statusCode == 200) {
                            Con_Wid.Con_Show_Toast(
                                context, "Data Insert Successfully");
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return UnitReport();
                              },
                            ));
                          } else {
                            Con_Wid.Con_Show_Toast(
                                context, "Something Went Wrong");
                            setState(() {
                              loading = true;
                            });
                          }
                        }
                      },
                      pStrBtnName: "Save",
                      height: 50,
                      width: 160,
                      fontSize: 16),
                  Con_Wid.height(20)
                ]),
              ),
              loading ? CircularProgressIndicator() : Container()
            ],
          )),
    );
  }
  getkm() async {
    final res = await http.get(
        Uri.parse(
            AppUrl().vehicleLastKM  + vehicalid.toString()),
        headers: {
          'authorization': "Bearer " + Constants_Usermast.token,
          "Accept": "application/json"
        });
    if(res.statusCode == 200)
    {
      Map data = jsonDecode(res.body);
      startUnit.text = data['data']['LastKM'].toString();
      print(data);
      setState(()  {});
    }
  }
}
