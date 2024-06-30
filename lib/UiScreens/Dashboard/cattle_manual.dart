import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/Dashboard/cattle_add.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/AnimalTransfer.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/VisitRegistration/VisitRegistration.dart';
import 'package:herdmannew/UiScreens/FloatingButton/CattleRegistrationScreen.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_ApiUrl.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_NetworkHelp.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/component/Gobal_Widgets/Constants.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../component/DataBaseHelper/Con_List.dart';
import '../../component/DataBaseHelper/Sync_Json.dart';
import '../../model/Animal_Details_id.dart';
import '../../model/Visit_Registration.dart';
import '../Activity/add_pd_details.dart';
import '../Activity/pm_certification.dart';
import '../Activity/sc_certification.dart';
import '../DrawerScreens/AllCattleList/Abortion_page.dart';
import '../DrawerScreens/AllCattleList/CalvingDetails.dart';
import '../DrawerScreens/AllCattleList/InsemiationDetails.dart';
import '../DrawerScreens/AllCattleList/TreatmentAndVaccination.dart';

class manual_entry extends StatefulWidget {
  String manualentry;
  String? name;
  String? id;
  Visit_Registration? visitmodel;

  manual_entry({required this.manualentry,this.name,this.id,this.visitmodel});

  @override
  State<manual_entry> createState() => _manual_entryState();
}

class _manual_entryState extends State<manual_entry> {
  bool _checkingInServer = true;
  bool _cattleAvailableInServer = false;
  String cattle = "";
  bool temp = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkInServer();
    Constants.qrid.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      contentPadding: EdgeInsets.all(0.0),
      children: <Widget>[
        Container(
          width: 400.0,
          height: 290.0,
          decoration: con_clr.ConClr2
              ? const BoxDecoration(
                  color: Colors.white,
                  borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ))
              : const BoxDecoration(
                  color: whiteColor,
                  borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 90.0,
                decoration: con_clr.ConClr2
                    ? BoxDecoration(
                        gradient: LinearGradient(
                            colors: ConClrAppbarGreadiant,
                            transform: GradientRotation(1.55),
                            begin: Alignment(-1, 0)),
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(5.0),
                          topRight: const Radius.circular(5.0),
                        ))
                    : BoxDecoration(
                        color: ConClrDialog,
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(5.0),
                          topRight: const Radius.circular(5.0),
                        )),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return CattleRegistrationScreen();
                              },
                            ));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 6.0, right: 6.0),
                            child: Icon(
                              Icons.close,
                              color: con_clr.ConClr2
                                  ? Colors.white.withOpacity(0.3)
                                  : whiteColor,
                              size: 30.0,
                            ),
                          )),
                      Center(
                        child: Con_Wid.gText(
                          'QR code not present in the database',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 19.0),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ]),
              ),
              _middleWidget(),
            ],
          ),
        ),
      ],
    );
  }

  _middleWidget() {
    Widget _item;
    if (_checkingInServer) {
      _item = _loadingWidget();
    } else if (!_checkingInServer && !_cattleAvailableInServer) {
      _item = _notFoundWidget();
    } else {
      _item = _transferWidget();
    }
    return _item;
  }

  Widget _loadingWidget() {
    return Column(
      children: [
        Container(
          height: 30,
        ),
        CircularProgressIndicator(),
        Container(
          height: 10,
        ),
        Con_Wid.gText("Please wait checking in server")
      ],
    );
  }

  Widget _notFoundWidget() {
    return Column(children: [
      Container(
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
          alignment: Alignment.center,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Con_Wid.gText(
                'Do you want to add a new cattle?',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: const Color(0xFF082451),
                    fontSize: 17.0),
                textAlign: TextAlign.center,
              ),
            ),
          )),
      Con_Wid.MainButton(
          OnTap: () {
            _checkInServer();
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return New_Cattle(
                  manualentry: widget.manualentry,id: widget.id,name: widget.name,visitmodel: widget.visitmodel,
                );
              },
            ));
          },
          pStrBtnName: "Yes",
          height: 50,
          width: 150,
          fontSize: 16)
    ]);
  }

  Widget _transferWidget() {
    return Stack(
      children: [
        Column(children: [
          Container(
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
              alignment: Alignment.center,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Con_Wid.gText(
                    'Do you want to transfer the cattle?',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: const Color(0xFF082451),
                        fontSize: 17.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
          Con_Wid.MainButton(
              OnTap: () async {
                if(widget.visitmodel != null)
                  {
                    setState(() {
                      temp = true;
                    });
                   final res = await ApiCalling.createPost(
                        AppUrl().animalTransfer,
                        "Bearer " +
                            Constants_Usermast.token
                                .toString(),
                        {
                          "TagID": widget.manualentry,
                          "Herd": int.parse(widget.visitmodel!.herd.toString()),
                          "lot": int.parse(widget.visitmodel!.lotID.toString()),
                          "Farmer": int.parse(widget.visitmodel!.farmerid.toString()),
                          "Date": DateFormat('MM-dd-yyyy')
                              .format(DateTime.now()),
                          "transferStatus": "S",
                          "UID": Constants_Usermast.user_id
                        });


                    if (await res.statusCode == 200) {
                      refreh(widget.manualentry.toString())
                          .then((value) {
                          Future.delayed(
                            Duration(seconds: 1),
                                () {
                                  get();
                            },
                          );
                        });
                    }
                  }else{
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    int index2 = int.parse(widget.manualentry);
                    return animalTransfer(index2);
                  },
                ));
                }
                _checkingInServer = false;
              },
              pStrBtnName: "Yes",
              height: 51,
              width: 150,
              fontSize: 16)
        ]),
        temp ?Center(child: CircularProgressIndicator(),):Container()
      ],
    );
  }

  void _checkInServer() async {
    var res = await ApiCalling.getdata(
        AppUrl().checkCattleAvailable + "${widget.manualentry}",
        Constants_Usermast.token.toString());
    _checkingInServer = false;
    if (res.body != null) {
      var response = res.body;
      if (response == "No Data Found") {
        _cattleAvailableInServer = false;
      } else {
        _cattleAvailableInServer = true;
        _checkingInServer = false;
        //cattle = response;
      }
    }
    if (mounted) {
      setState(() {});
    }
  }
  Future refreh(String index) async {
    String id = "";
    if (Con_List.id_Animal_Details
        .where((et) => et.tagId.toString() == index)
        .isNotEmpty) {
      id = Con_List.id_Animal_Details
          .where((element) => element.tagId.toString() == index)
          .first
          .id
          .toString();
    }
    List<dynamic> data = [];
    var update_ani;
    var response = await ApiCalling.createPost(
        AppUrl().AnimalRefresh,
        "Bearer " + Constants_Usermast.token.toString(),
        {"tagid": index, "TBLSTR": "Animal_Details:0"});
    if (response.statusCode == 200) {
      update_ani = jsonDecode(response.body);
      data = update_ani[0];
    }
    var box = await Hive.openBox<Animal_Details_id>('Animal_Details_id');
    if (id == "") {
      data
          .map((e) => box.put(
          int.parse(e['id'].toString()), Animal_Details_id.fromJson(e)))
          .toList();
    } else {
      await box.delete(id);
      data
          .map((e) => box.put(
          int.parse(e['id'].toString()), Animal_Details_id.fromJson(e)))
          .toList();
    }

    Sync_Json.Get_Master_Data('Animal_Details_id');
  }
  get(){
    switch (widget.visitmodel!.compliaintid) {
      case 13:
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Insemiationdetails(path: "Visit",
              index: widget.visitmodel!.animalID,
              VisitID: widget.visitmodel!.visitID.toString(),
            );
          },
        ));
        break;
      case 24:
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return sccertification(
              visitmodel: widget.visitmodel!,
            );
          },
        ));
        break;
      case 25:
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return pm_certification(widget.visitmodel!);
          },
        ));
        break;
    // added pd details navigation if complain id is 28
      case 28:
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return add_pd_details(path: "Visit",index: widget.manualentry,);
          },
        ));
        break;
      case 30:
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Abortion_Details(path: "Visit",
              index: widget.visitmodel!.animalID.toString(),
            );
          },
        ));
        break;
      case 31:
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return CalvingDetails(path: "Visit",index: widget.visitmodel!.animalID.toString());
          },
        ));
        break;
      default:
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Treatmentandvaccination(Visitmodel: widget.visitmodel!,index: widget.visitmodel!.animalID,path: widget.name,);
          },
        ));
        break;
    }
  }
}
