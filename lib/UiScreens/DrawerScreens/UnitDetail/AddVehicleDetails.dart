import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_NetworkHelp.dart';
import 'package:herdmannew/component/DataBaseHelper/Con_List.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:http/http.dart' as http;
import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../../component/Gobal_Widgets/Con_Widget.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import 'UnitDetail.dart';

class AddVehicleDetails extends StatefulWidget {
  AddVehicleDetails({Key? key}) : super(key: key);
  static Map unit = {};
  @override
  State<AddVehicleDetails> createState() => _AddVehicleDetailsState();
}

class _AddVehicleDetailsState extends State<AddVehicleDetails> {
  TextEditingController vahicleno = TextEditingController();
  TextEditingController starttime = TextEditingController();
  TextEditingController drivername = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController startkm = TextEditingController();
  TextEditingController outsideDCS = TextEditingController();
  String Regularvahicle = "Yes";
  List<String> vehicalpurpose = [];
  List<String> Selectedcenter = [];
  List<String> Mvehicalpurpose = [];
  List<String> SelecteDCS = [];
  List<String> vehicaldata = [];
  List<String> Mvehicaldata = [];
  String vehicalid = "";
  String lastkm = "";
  bool iskmvalid = false;
  bool loading = false;
  String lat = '', long = '';
  var vihical = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String d = DateTime.now().day.toString();
    String m = DateTime.now().month.toString();
    String y = DateTime.now().year.toString();
    String h = DateTime.now().hour.toString();
    String mi = DateTime.now().minute.toString();

    starttime.text = "$y-$m-$d $h:$mi";
    get();
    getList();
  }

  getList() {
    print(Con_List.M_Vehicle_data.length);
    for (int i = 0; i < Con_List.M_Vehicle_purpose.length; i++) {
      vehicalpurpose.add(Con_List.M_Vehicle_purpose[i].visitPurpose.toString());
    }
    Con_List.M_Vehicle_data.forEach((e) {
      vehicaldata.add(e.vehicleNo);
    });
  }

  get() async {
    if (Con_List.M_Vehicle_data.isEmpty || Con_List.M_Vehicle_purpose.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_vehicle_purpose);
      Sync_Json.Get_Master_Data(Constants.Tbl_vehicle_data);
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    lat = position.latitude.toString();
    long = position.longitude.toString();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(
          () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return UnitDetailScreen();
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "Add Vehicle Details",
          Actions: [],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return UnitDetailScreen();
              },
            ));
          },
        ),
        body: Stack(children: [
          Con_Wid.backgroundContainer(
            child: SingleChildScrollView(
                child: Con_Wid.fullContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Con_Wid.paddingWithText("Regular Vehicle", Conclrfontmain,
                  context: context),
              Row(
                children: [
                  Radio(
                    value: "Yes",
                    groupValue: Regularvahicle,
                    onChanged: (value) {
                      Regularvahicle = value.toString();
                      setState(() {});
                    },
                  ),
                  Con_Wid.popinsfont(
                      "Yes", Conclrfontmain, FontWeight.w600, 10, context),
                  Radio(
                    value: "No",
                    groupValue: Regularvahicle,
                    onChanged: (value) {
                      setState(() {
                        Regularvahicle = value.toString();
                      });
                    },
                  ),
                  Con_Wid.popinsfont(
                      "No", Conclrfontmain, FontWeight.w600, 10, context),
                  Radio(
                    value: "Replacement",
                    groupValue: Regularvahicle,
                    onChanged: (value) {
                      setState(() {
                        Regularvahicle = value.toString();
                      });
                    },
                  ),
                  Con_Wid.popinsfont("Replacement", Conclrfontmain,
                      FontWeight.w600, 10, context),
                ],
              ),
              //todo
              Regularvahicle == "No"
                  ? Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Con_Wid.textFieldWithInter(
                                text: "Enter Vehicle No.",
                                controller: vahicleno,
                                hintText: "Enter Vehicle No "),
                          ]),
                    )
                  : Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Con_Wid.paddingWithText(
                            //     "Vehicle No.", Conclrfontmain),
                            CondropDown(
                              title: 'Select Vehicle',
                              itemList: vehicaldata,
                              SelectedList: Mvehicaldata,
                              onSelected: (List<String> value) async {
                                Mvehicaldata = value;
                                vehicalid = Con_List.M_Vehicle_data.where((element) => element.vehicleNo.toString()==value[0].toString()).first.iD.toString();
                                getkm();
                                setState(()  {});
                              },
                            ),
                          ]),
                    ),
              //todo

              Con_Wid.height(5),
              Con_Wid.paddingWithText("Start Time.", Conclrfontmain,
                  context: context),
              Con_Wid.Datepickerwithtime(
                  controller: starttime,
                  hintText: "Start Time",
                  context: context),
              //todo
              //Con_Wid.paddingWithText("Purpose.", Conclrfontmain),
              CondropDown(
                title: 'Select Purpose',
                itemList: vehicalpurpose,
                SelectedList: Mvehicalpurpose,
                onSelected: (List<String> value) {
                  setState(() {
                    Mvehicalpurpose = value;
                  });
                },
              ),
              Con_Wid.height(10),
              Regularvahicle == "Replacement"
                  ? Con_Wid.textFieldWithInter(
                      controller: drivername,
                      hintText: "Enter Driver Name / Vehicle No.")
                  : Con_Wid.textFieldWithInter(
                      controller: drivername, hintText: "Enter Driver Name"),
              lastkm == ""?Container():Con_Wid.paddingWithText("Last KM : $lastkm", Conclrfontmain, context: context),
              Con_Wid.textFieldWithInter(eRror: iskmvalid ? "Please enter start km more than last km" : "",
                  TextInput_Type: TextInputType.number,
                  text: "Start K.M",
                  controller: startkm,
                  Onchanged: (p0) {
                    int a = int.parse(startkm.text)-int.parse(lastkm);
                    if(a<0)
                      {
                        iskmvalid = true;
                      }else{
                      iskmvalid = false;
                    }
                    setState(() {});
                  },
                  hintText: "Start K.M."),

              Con_Wid.height(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Con_Wid.selectionContainer(
                          text: "Reset",
                          context: context,
                          textcolor:
                              con_clr.ConClr2 ? whiteColor : ConClrDialog,
                          ontap: () {},
                          Color: con_clr.ConClr2 ? ConClrLightBack : whiteColor,
                          height: 40,
                          width: 100)),
                  Con_Wid.div(),
                  Expanded(
                      child: Con_Wid.selectionContainer(
                          text: "Submit",
                          context: context,
                          ontap: () async {
                            setState(() {
                              loading = true;
                            });

                            Map note = {};
                            if (Regularvahicle == "No") {
                              if (vahicleno.text == "") {
                                Con_Wid.Con_Show_Toast(
                                    context, "Enter Vehicle No.");
                                setState(() {
                                  loading = false;
                                });
                              }  else if (Mvehicalpurpose.isEmpty) {
                                Con_Wid.Con_Show_Toast(
                                    context, "Select Purpose");
                                setState(() {
                                  loading = false;
                                });
                              } else if (drivername.text == "") {
                                Con_Wid.Con_Show_Toast(
                                    context, "Enter Driver Name");
                                setState(() {
                                  loading = false;
                                });
                              } else if (iskmvalid == true) {
                                Con_Wid.Con_Show_Toast(
                                    context, "Enter Valid K.M.");
                                setState(() {
                                  loading = false;
                                });
                              } else if (startkm.text == "") {
                                Con_Wid.Con_Show_Toast(
                                    context, "Enter Start K.M.");
                                setState(() {
                                  loading = false;
                                });
                              } else {
                                note = {
                                  "Purpose": Con_List.M_Vehicle_purpose.where(
                                      (e) =>
                                          e.visitPurpose ==
                                          Mvehicalpurpose[0]).first.iD,
                                  "StartDatetime": starttime.text,
                                  "StartUnit": int.parse(startkm.text),
                                  "StartLat": lat,
                                  "StartLong": long,
                                  "ReplaceVehicleNo": int.parse(vahicleno.text),
                                  "RegularVehicleNo": false,
                                  "DriverNickName": drivername.text,
                                };
                                var res = await ApiCalling.createPost(
                                    AppUrl().vehicleUnitDetails,
                                    "Bearer " + Constants_Usermast.token.toString(),
                                    note);
                                print(res.body);

                                if (res.statusCode == 200) {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return UnitDetailScreen();
                                        },
                                      ));
                                }
                              }
                            } else {
                              if (Regularvahicle == "Yes" && Mvehicaldata.isEmpty)
                              {
                                Con_Wid.Con_Show_Toast(
                                    context, "Select Vehicle");
                                setState(() {
                                  loading = false;
                                });
                              } else if (Mvehicalpurpose.isEmpty) {
                                Con_Wid.Con_Show_Toast(
                                    context, "Select Purpose");
                                setState(() {
                                  loading = false;
                                });
                              } else if (drivername.text == "") {
                                Con_Wid.Con_Show_Toast(
                                    context, "Enter Driver Name");
                                setState(() {
                                  loading = false;
                                });
                              } else if (iskmvalid == true) {
                                Con_Wid.Con_Show_Toast(
                                    context, "Enter Valid K.M.");
                                setState(() {
                                  loading = false;
                                });
                              } else if (startkm.text == "") {
                                Con_Wid.Con_Show_Toast(
                                    context, "Enter Start K.M.");
                                setState(() {
                                  loading = false;
                                });
                              } else {
                                print("hii");
                                note = {
                                  "Purpose": Con_List.M_Vehicle_purpose.where(
                                      (e) =>
                                          e.visitPurpose ==
                                          Mvehicalpurpose[0]).first.iD,
                                  "StartDatetime": starttime.text,
                                  "StartUnit": int.parse(startkm.text),
                                  "StartLat": lat,
                                  "StartLong": long,
                                  "RegularVehicleNo": true,
                                  "DriverNickName": drivername.text,
                                  'VehicleNo': vehicalid
                                };
                                var res = await ApiCalling.createPost(
                                    AppUrl().vehicleUnitDetails,
                                    "Bearer " + Constants_Usermast.token.toString(),
                                    note);
                                print(res.body);

                                if (res.statusCode == 200) {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return UnitDetailScreen();
                                        },
                                      ));
                                }
                              }
                            }

                          },
                          Color:
                              con_clr.ConClr2 ? ConClrbluelight : ConClrDialog,
                          height: 40,
                          width: 100))
                ],
              )
            ],
          ),
        ))),
          loading ?Center(child: CircularProgressIndicator(),):Container()
      ]),
    ));
  }
  getkm() async {
    final res = await http.get(
        Uri.parse(
            AppUrl().vehicleLastKM  + vehicalid),
        headers: {
          'authorization': "Bearer " + Constants_Usermast.token,
          "Accept": "application/json"
        });
    if(res.statusCode == 200)
    {
      Map data = jsonDecode(res.body);
      startkm.text = data['data']['LastKM'].toString();
      lastkm = startkm.text;
      print(data);
      setState(()  {});
    }
  }
}
