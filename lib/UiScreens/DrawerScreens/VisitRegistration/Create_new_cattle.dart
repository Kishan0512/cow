import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:herdmannew/component/DataBaseHelper/Con_List.dart';
import 'package:herdmannew/component/DataBaseHelper/Sync_Database.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

class Create_new_cattle extends StatefulWidget {
  @override
  State<Create_new_cattle> createState() => _Create_new_cattleState();
}

class _Create_new_cattleState extends State<Create_new_cattle> {
  bool _isLoading = false;
  bool _checkingInServer = true;
  bool _cattleAvailableInServer = false;
  late Map cattle;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcattalelist();
  }

  getcattalelist() async {
    var temp = await SyncDB.cheakcattlelist(
        Con_List.id_Animal_Details[0].tagId.toString());
    if (temp.toString().isNotEmpty) {
      if (temp == "No Data Found") {
        _cattleAvailableInServer = false;
      } else {
        _cattleAvailableInServer = true;
        _checkingInServer = false;
        setState(() {});
        cattle = jsonDecode(temp);
      }
    }
  }

  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      contentPadding: EdgeInsets.all(0.0),
      children: <Widget>[
        Container(
          height: 230,
          child: _isLoading
              ? _loadwed()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: _isLoading ? 50 : 90.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: ConClrAppbarGreadiant,
                      )),
                      child: Center(
                        child: Con_Wid.popinsfont(
                            "QR code not present in the database",
                            fontwhiteColor,
                            FontWeight.w600,
                            12,
                            context),
                      ),
                    ),
                    _middleWidget(),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _loadwed() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Container(height: 30, color: Colors.transparent),
          Con_Wid.paddingWithText(
              "Please wait data is transferring", Conclrfontmain,
              context: context)
        ],
      ),
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
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: [
            CircularProgressIndicator(),
            Con_Wid.paddingWithText(
                "Please wait checking in serve", Conclrfontmain,
                context: context)
          ],
        ),
      ),
    );
  }

  Widget _notFoundWidget() {
    return Column(children: [
      Container(
          alignment: Alignment.center,
          child: Center(
              child: Con_Wid.paddingWithText(
                  "Do you want to add a new cattle?", Conclrfontmain,
                  context: context))),
      Con_Wid.MainButton(
          OnTap: () {},
          pStrBtnName: "Yes",
          height: 45,
          width: 170,
          fontSize: 12),
    ]);
  }

  Widget _transferWidget() {
    return Column(children: [
      Container(
          alignment: Alignment.center,
          child: Center(
            child: Con_Wid.paddingWithText(
                "Do you want to transfer\nthe cattle?", Conclrfontmain,
                context: context),
          )),
      Con_Wid.MainButton(
          OnTap: () {
            //todo api calling animalTransfer
          },
          pStrBtnName: "Yes",
          height: 45,
          width: 170,
          fontSize: 12)
    ]);
  }
}
