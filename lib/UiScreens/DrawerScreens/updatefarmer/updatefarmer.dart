import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';

import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Con_Icons.dart';
import '../../../component/Gobal_Widgets/Con_Toast.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../../component/Gobal_Widgets/Con_Widget.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../Dashboard/Dashboard.dart';

class updatefarmer extends StatefulWidget {
  const updatefarmer({Key? key}) : super(key: key);

  @override
  State<updatefarmer> createState() => _updatefarmerState();
}

class _updatefarmerState extends State<updatefarmer> {
  List<String> mListSelected = [], mSelectedroute = [], mSelectedsociety = [];
  List<dynamic> farmer = [];
  bool selectAll = false;
  TextEditingController serch = TextEditingController();
  bool Getfarmer = false;
  String mStrSociety = "";
  late List<bool> check;
  bool visible_search_bar = false;
  List<dynamic> filteredUsers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getfarmer() async {

    if (mStrSociety.isNotEmpty) {
      final res = await ApiCalling.getdata(AppUrl().farmerData + "$mStrSociety",
          Constants_Usermast.token.toString());

      if (res.statusCode == 200) {
        farmer = jsonDecode(res.body);
        filteredUsers = farmer;
        filteredUsers.sort(
          (a, b) => a['code'].toString().compareTo(b['code'].toString()),
        );
        check = List<bool>.filled(farmer.length, false);
        setState(() {});
      }
    }
  }

  getdata() {
    if (Con_List.M_Userherds.isEmpty || Con_List.M_Userlots.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_herd);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_lot);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(
          () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return DashBoardScreen();
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
        appBar: visible_search_bar
            ? AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: Con_Wid.appBarColor(),
                title: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(
                      width: 2,
                      color: ConClrborderdrop,
                    ),
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        filteredUsers = farmer
                            .where((u) => (u['Name']
                                    .toString()
                                    .contains(value.toUpperCase()) ||
                                u['code']
                                    .toString()
                                    .contains(value.toUpperCase())))
                            .toList();
                      });
                    },
                    controller: serch,
                    style: const TextStyle(
                        color: Colors.white, fontFamily: "poppins"),
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: ("Search Name"),
                      hintStyle:
                          TextStyle(color: Colors.white, fontFamily: "poppins"),
                    ),
                  ),
                ),
                actions: [
                  Con_Wid.mIconButton(
                      onPressed: () {
                        visible_search_bar = false;
                        setState(() {});
                      },
                      icon: Own_Close)
                ],
              )
            : Con_Wid.appBar(
                title: "Update Farmer",
                Actions: [
                  Con_Wid.mIconButton(
                      onPressed: () {
                        visible_search_bar = true;
                        setState(() {});
                      },
                      icon: Own_Search),
                ],
                onBackTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return DashBoardScreen();
                    },
                  ));
                },
              ),
        body: Con_Wid.backgroundContainer(
            child: Con_Wid.fullContainer(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: CondropDown(
                    title: 'Select Route',
                    itemList: Con_List.M_Userherds.map((e) => "${e.id}-${e.Name}")
                        .toList(),
                    SelectedList: mSelectedroute,
                    onSelected: (List<String> value) {
                      setState(() {
                        mSelectedsociety.clear();
                        mSelectedroute = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: CondropDown(
                    title: 'Select Society',
                    itemList: Con_List.M_Userlots.where((e) =>
                        e.herd.toString() ==
                        (mSelectedroute.isNotEmpty
                            ? mSelectedroute[0].split("-").first
                            : "")).map((e) => "${e.code}-${e.name}").toList(),
                    SelectedList: mSelectedsociety,
                    onSelected: (List<String> value) {
                      setState(() {
                        mSelectedsociety = value;
                      });
                    },
                  ),
                ),
                Con_Wid.height(10),
                Con_Wid.MainButton(
                    OnTap: () async {
                      Getfarmer = false;
                      filteredUsers.clear();
                      farmer.clear();
                      if (mSelectedroute.isEmpty) {
                        Con_Wid.Con_Show_Toast(context, "Select Route");
                      } else if (mSelectedsociety.isEmpty) {
                        Con_Wid.Con_Show_Toast(context, "Select Society");
                      } else {
                        if (mSelectedsociety.isNotEmpty) {
                          var temp = mSelectedsociety[0].split("-").first;
                          mStrSociety = Con_List.M_Userlots.firstWhere(
                                  (e) => e.code.toString() == temp.toString())
                              .id
                              .toString();

                        }
                        Getfarmer = true;
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult == ConnectivityResult.mobile ||
                            connectivityResult == ConnectivityResult.wifi) {
                          getfarmer();
                        } else {
                          CustomToast.show(context, "No Internet Connection");
                        }
                      }

                      setState(() {});
                    },
                    isborder: true,
                    pStrBtnName: "Get Data",
                    height: 45,
                    width: 150,
                    fontSize: 16),
                SingleChildScrollView(
                  child: Container(height: MediaQuery.of(context).size.height-280,child: Column(
                    children: [
                      Row(
                        children: [
                          Con_Wid.width(13),
                          Checkbox(
                            value: selectAll,
                            onChanged: (value) {
                              setState(() {
                                selectAll = !selectAll;
                                for (int index = 0;
                                index < this.filteredUsers.length;
                                index++) {
                                  if (!mListSelected.contains(
                                      filteredUsers[index]["id"].toString())) {
                                    mListSelected
                                        .add(filteredUsers[index]["id"].toString());
                                  } else {
                                    mListSelected
                                        .remove(filteredUsers[index]["id"].toString());
                                  }
                                }
                              });
                            },
                          ),
                          Con_Wid.paddingWithText("Select All", fontBlackColor,
                              context: context),
                        ],
                      ),
                      Getfarmer
                          ? filteredUsers.isEmpty
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : Expanded(
                            child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filteredUsers.length,
                        itemBuilder: (context, index) {
                            return Material(
                              color: Colors.transparent,
                              child: CheckboxListTile(
                                  controlAffinity:
                                  ListTileControlAffinity.leading,
                                  secondary: Con_Wid.selectionContainer1(
                                      text: filteredUsers[index]["IsSuspended"] == false ||
                                          filteredUsers[index]
                                          ["IsSuspended"] ==
                                              null
                                          ? "Active"
                                          : "Suspend",

                                      ontap: () {},
                                      context: context,
                                      Color:
                                      filteredUsers[index]["IsSuspended"] == false ||
                                          filteredUsers[index]
                                          ["IsSuspended"] ==
                                              null
                                          ? Colors.lightGreen.shade700
                                          : Colors.red,
                                      height: 30,
                                      width: 70),
                                  checkColor: ConClrMainLight,
                                  activeColor: ConClrLightBack,
                                  title: Text(
                                      "${filteredUsers[index]["code"]}-" +
                                          "${filteredUsers[index]["Name"]}",
                                      style: const TextStyle(fontSize: 12)),
                                  value: selectAll ? true : check[index],
                                  onChanged: (value) {
                                    check[index] = value!;
                                    setState(() {
                                      if (!mListSelected.contains(
                                          filteredUsers[index]["id"]
                                              .toString())) {
                                        mListSelected.add(filteredUsers[index]
                                        ["id"]
                                            .toString());
                                      } else {
                                        mListSelected.remove(
                                            filteredUsers[index]["id"]
                                                .toString());
                                      }
                                    });
                                  }),
                            );
                        },
                      ),
                          )
                          : Container(),
                      Con_Wid.height(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Con_Wid.MainButton(
                              OnTap: () {},
                              isborder: true,
                              pStrBtnName: "Cancel",
                              height: 45,
                              width: 100,
                              fontSize: 16),
                          Con_Wid.width(20),
                          Con_Wid.MainButton(
                              OnTap: () async {
                                var res = await ApiCalling.createPost(AppUrl().UpdateFarmer,
                                    "Bearer " +Constants_Usermast.token.toString(),{"Userid":Constants_Usermast.user_id});
                                if(res.statusCode==200)
                                  {
                                    Map decode=jsonDecode(res.body);
                                    Con_Wid.Con_Show_Toast(context, decode['status']);
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                      return updatefarmer();
                                    },));
                                  }else{
                                  Con_Wid.Con_Show_Toast(context, "Somthing Want to wrong");
                                }
                              },
                              isborder: true,
                              pStrBtnName: "Update",
                              height: 45,
                              width: 100,
                              fontSize: 16)
                        ],
                      )
                    ],
                  )),
                ),

              ],
            ))),
      ),
    );
  }
}
