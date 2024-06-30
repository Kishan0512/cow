import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:herdmannew/component/Gobal_Widgets/ButtonState.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Textstyle.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/model/Animal_Details_id.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../../component/Gobal_Widgets/MyCustomWidget.dart';
import 'AllCattleList.dart';

class animalTransfer extends StatefulWidget {
  int index;

  animalTransfer(this.index);

  @override
  State<animalTransfer> createState() => _animalTransferState();
}

class _animalTransferState extends State<animalTransfer> {
  bool farmerEmpy = false;
  ButtonState stateTextWithIcon = ButtonState.idle;
  List<String> mListStrSocity = [];
  List<String> mListSelectsocity = [];
  List<String> farmer = [];
  List<String> mListSelectfarmer = [];
  Animal_Details_id? Mdetail;
  int mIntSelectFarmerid = 0;
  int mIntSelectsocityid = 0;
  int mIntSelectsocityHerd = 0;

  @override
  void initState() {
    super.initState();
    getdata();
    getList();
  }

  getdata() {
    if (Con_List.M_Userlots.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_lot);
    }
  }

  getList() {
    for (int i = 0; i < Con_List.M_Userlots.length; i++) {
      mListStrSocity.add(Con_List.M_Userlots[i].name.toString());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Con_Wid.appBar(
        title: "Animal Transfer",
        Actions: [],
        onBackTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return AllCattleListScreen();
            },
          ));
        },
      ),
      body: Con_Wid.backgroundContainer(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Con_Wid.fullContainerwithborder(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 7,
                    decoration: BoxDecoration(
                        color: con_clr.ConClr2 ? ConClrLightBack : ConClrDialog,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Text(
                      "Tag Id : ${widget.index}",
                      style: ConStyle.style_white_18s_500w(),
                    ),
                  )
                ],
              ),
              rtop: 20,
              lbottom: 0,
              ltop: 20,
              rbottom: 0),
          Con_Wid.height(5),
          Con_Wid.fullContainerwithborder(
              child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CondropDown(
                        title: 'Select Society',
                        itemList: Con_List.M_Userlots.map(
                            (e) => "${e.code}-${e.name}").toList(),
                        SelectedList: mListSelectsocity,
                        onSelected: (List<String> value) {
                          setState(() {
                            mListSelectsocity = value;
                            mIntSelectsocityid = Con_List.M_Userlots.where(
                                    (e) => value.any((u) => u.contains(e.code)))
                                .first
                                .id;
                            mIntSelectsocityHerd = Con_List.M_Userlots.where(
                                    (e) => value.any((u) => u.contains(e.code)))
                                .first
                                .herd;
                          });
                        },
                      ),
                      CondropDown(
                        color1: ConsfontBlackColor,
                        title: 'Select Farmer',
                        itemList: Con_List.M_Farmer.where((e) =>
                                mIntSelectsocityid != 0
                                    ? mIntSelectsocityid.toString() ==
                                        e.lot.toString()
                                    : true)
                            .map((e) =>
                                "${e.code.toString()}-${e.name.toString()}")
                            .toList()
                          ..sort((a, b) =>
                              a.split('-').first.compareTo(b.split('-').first)),
                        SelectedList: mListSelectfarmer,
                        onSelected: (List<String> value) {

                          setState(() {
                            mListSelectfarmer = value;

                            try {
                              mIntSelectFarmerid = Con_List.M_Farmer.firstWhere((e) => "${e.code}-${e.name}" == mListSelectfarmer[0].toString()).id;


                            } catch (e) {
                              print("ERROR    " + e.toString());
                            }
                          });
                        },
                      ),
                      Con_Wid.height(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyCustomWidget(
                              stateTextWithIcon: stateTextWithIcon,
                              Onchanged: () async {
                                var res;
                                if (mListSelectsocity.isEmpty) {
                                  Con_Wid.Con_Show_Toast(
                                      context, "Select Society");
                                } else if (mListSelectfarmer.isEmpty) {
                                  Con_Wid.Con_Show_Toast(
                                      context, "Select Farmer");
                                } else {
                                  switch (stateTextWithIcon) {
                                    case ButtonState.idle:
                                      stateTextWithIcon = ButtonState.loading;
                                      res = await ApiCalling.createPost(
                                          AppUrl().animalTransfer,
                                          "Bearer " +
                                              Constants_Usermast.token
                                                  .toString(),
                                          {
                                            "TagID": widget.index,
                                            "Herd": mIntSelectsocityHerd,
                                            "lot": mIntSelectsocityid,
                                            "Farmer": mIntSelectFarmerid,
                                            "Date": DateFormat('MM-dd-yyyy')
                                                .format(DateTime.now()),
                                            "transferStatus": "S",
                                            "UID": Constants_Usermast.user_id
                                          });
                                      print({
                                        "TagID": widget.index,
                                        "Herd": mIntSelectsocityHerd,
                                        "lot": mIntSelectsocityid,
                                        "Farmer": mIntSelectFarmerid,
                                        "Date": DateFormat('MM-dd-yyyy')
                                            .format(DateTime.now()),
                                        "transferStatus": "S",
                                        "UID": Constants_Usermast.user_id
                                      });


                                      if (await res.statusCode == 200) {
                                        refreh(widget.index.toString())
                                            .then((value) {
                                          Future.delayed(
                                            Duration(seconds: 2),
                                            () {
                                              setState(() {
                                                stateTextWithIcon =
                                                    ButtonState.success;
                                              });
                                            },
                                          ).then((value) {
                                            Future.delayed(
                                              Duration(seconds: 1),
                                              () {
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                  builder: (context) {
                                                    return AllCattleListScreen();
                                                  },
                                                ));
                                              },
                                            );
                                          });

                                          // Con_Wid.Con_Show_Toast(context,
                                          //     'Animal transfered successfully');
                                        });
                                      }
                                      break;
                                    case ButtonState.loading:
                                      break;
                                    case ButtonState.success:
                                      stateTextWithIcon = ButtonState.idle;
                                      break;
                                    case ButtonState.fail:
                                      stateTextWithIcon = ButtonState.idle;
                                      break;
                                  }
                                }
                                setState(
                                  () {
                                    stateTextWithIcon = stateTextWithIcon;
                                  },
                                );
                              },
                              Title: "Save",
                              color: ConClrSelected),
                        ],
                      ),
                    ],
                  )),
              rtop: 0,
              lbottom: 20,
              ltop: 0,
              rbottom: 20),
        ],
      )),
    );
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
}
//105158255242
