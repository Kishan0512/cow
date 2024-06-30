import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/Dashboard/Dashboard.dart';
import 'package:herdmannew/camera.dart';

import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../../component/Gobal_Widgets/Con_Color.dart';
import '../../../component/Gobal_Widgets/Con_Icons.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../../component/Gobal_Widgets/Con_Widget.dart';
import '../Alarm/Alarm.dart';

class EVMMedicine extends StatefulWidget {
  const EVMMedicine({super.key});

  @override
  State<EVMMedicine> createState() => _EVMMedicineState();
}

class _EVMMedicineState extends State<EVMMedicine> {
  List<dynamic> EVM = [];
  Color Header = Colors.cyan;
  bool isload=false;
  bool search = false;
  List<dynamic> filteredUsers = [];
  TextEditingController Search = TextEditingController();

  @override
  void initState() {
    GetData();
    super.initState();
  }

  GetData() async {
    setState(() {
      isload=false;
    });
    var response = await ApiCalling.createPost(
        AppUrl().GetEvm,
        "Bearer " + Constants_Usermast.token.toString(),
        {"staff": int.parse(Constants_Usermast.staff)});
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      EVM = decode['data'];
      filteredUsers = decode['data'];
      List<String> customOrder = ['Follow Up', 'Not Cured', 'Partially Cured.', 'Cured'];

      // Sort the list based on the custom order
      EVM.sort((a, b) {
        String statusA = a['Status'];
        String statusB = b['Status'];

        int indexA = customOrder.indexOf(statusA);
        int indexB = customOrder.indexOf(statusB);

        return indexA.compareTo(indexB);
      });

      isload=true;
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
                return DashBoardScreen();
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
        appBar:search ? AppBar(
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
                  EVM = filteredUsers.where((e) =>(
                      e['tagid'].toString().contains(value.toLowerCase()) ||
                      e['Date'].toString().contains(value.toLowerCase()) ||
                      e['Doctor'].toString().toLowerCase().contains(value.toLowerCase()) ||
                      e['farmermobile'].toString().contains(value.toLowerCase()) ||
                      e['farmername'].toString().toLowerCase().contains(value.toLowerCase()) ||
                      e['lotname'].toString().toLowerCase().contains(value.toLowerCase()) ||
                      e['diseasecode'].toString().toLowerCase().contains(value.toLowerCase()) ||
                      e['medicinename'].toString().toLowerCase().contains(value.toLowerCase()) ||
                      e['Status'].toString().toLowerCase().contains(value.toLowerCase()))
                  ).toList();
                  setState(() {});
                });
              },
              controller: Search,
              style:
              TextStyle(color: Colors.white, fontFamily: "poppins"),
              decoration: const InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: ("Search by Tag id, Name, Status"),
                hintStyle: TextStyle(
                    color: Colors.white, fontFamily: "poppins"),
              ),
            ),
          ),
          actions: [
            Con_Wid.mIconButton(
                onPressed: () {
                  search = false;
                  Search.clear();
                  EVM = filteredUsers;
                  setState(() {});
                },
                icon: Own_Close)
          ],
        ): Con_Wid.appBar(
          title: "EVM Medicine",
          Actions: [
            Con_Wid.mIconButton(
                onPressed: () {
                  search = true;
                  setState(() {});
                },
                icon: Own_Search),
            Con_Wid.mIconButton(onPressed: () async {
              GetData();
            }, icon: Icon(Icons.refresh))
          ],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return DashBoardScreen();
              },
            ));
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: isload ? EVM.isEmpty?const Center(
            child: Image(
                height: 150,
                width: 150,
                image:
                AssetImage("assets/images/No-Data-Found.webp")),
          ):ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: EVM.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () =>
                    showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState1) {
                        return Dialog(
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: con_clr.ConClr2
                                    ? fontwhiteColor
                                    : whiteColor),
                            child: Column(children: [
                              Container(
                                height: 60,
                                width: double.infinity,
                                decoration: con_clr.ConClr2
                                    ? BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: ConClrAppbarGreadiant))
                                    : BoxDecoration(color: ConClrDialog),
                                child: Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        Con_Wid.mIconButton(
                                            color: fontwhiteColor,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Own_Close),
                                      ],
                                    ),
                                    Center(
                                      child: Con_Wid.popinsfont(
                                          "Update EVM Medicine",
                                          fontwhiteColor,
                                          FontWeight.w600,
                                          15,
                                          context),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              AnimatedButton(height: 50,width: 100,onPressed: () {
                                Update(int.parse(EVM[index]['id'].toString()),1);
                                Navigator.pop(context);
                              }, child: Text("Cured",style: TextStyle(color: Colors.white),)),Spacer(),
                              AnimatedButton(height: 50,width: 150,onPressed: () {
                                Update(int.parse(EVM[index]['id'].toString()),3);
                                Navigator.pop(context);
                              }, child: Text("Partially Cured",style: TextStyle(color: Colors.white))),Spacer(),
                              AnimatedButton(height: 50,width: 150,onPressed: () {
                                Update(int.parse(EVM[index]['id'].toString()),2);
                                Navigator.pop(context);
                              }, child:  Text("Not Cured",style: TextStyle(color: Colors.white))),Spacer(),
                            ]),
                          ),
                        );
                      },
                    );
                  },
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                      elevation:5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 240,
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(width: MediaQuery.of(context).size.width/2.5,
                                    height: 35,
                                    child: Stack(alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          fit: BoxFit.fill,
                                          width: 220,
                                          "assets/images/Rectangle 199.png",
                                          color: EVM[index]['Status'] == null ?
                                          Color(0xFFD5AD03):
                                          EVM[index]['Status'] ==
                                              "Cured" ?
                                          Color(0xFFC40000)
                                          :
                                          EVM[index]['Status'] ==
                                              "Not Cured" ?
                                          Color(0xFF64A4D9)
                                          :
                                          EVM[index]['Status'] ==
                                              "Partially Cured." ?
                                          Color(0xFF004F9E)
                                          :
                                          EVM[index]['Status'] ==
                                              "Follow Up" ?
                                        Color(0xFF41B6D3):Color(0xFFD5AD03),
                                        ),
                                        Text(
                                            "${EVM[index]['Status']}",
                                            style: TextStyle(
                                                color: whiteColor,
                                                fontSize: 12))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Text.rich(
                                        TextSpan(
                                            children: [
                                              TextSpan(text: 'EVM ID : ', style: TextStyle(color: Colors.black26)),
                                              TextSpan(text: '${EVM[index]['id']}', )
                                            ]
                                        )
                                    ),
                                  ),


                                ],
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                  Text.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(text: 'Tag ID : ', style: TextStyle(color: Colors.black26)),
                                            TextSpan(text: '${EVM[index]['tagid'].toString().substring(EVM[index]['tagid'].toString().indexOf(":") + 1, EVM[index]['tagid'].toString().length)}', )
                                          ]
                                      )
                                  ),
                                  InkWell(onTap: () {
                                    FlutterPhoneDirectCaller.callNumber(EVM[index]['farmermobile'].toString().substring(EVM[index]['farmermobile'].toString().indexOf(":") + 1, EVM[index]['farmermobile'].toString().length));
                                  },
                                    child: Text.rich(
                                        TextSpan(
                                            children: [
                                              TextSpan(text: 'Mobile No : ', style: TextStyle(color: Colors.black26)),
                                              TextSpan(text: '${EVM[index]['farmermobile'].toString().substring(EVM[index]['farmermobile'].toString().indexOf(":") + 1, EVM[index]['farmermobile'].toString().length)}',)
                                            ]
                                        )
                                    ),
                                  ),
                                ],),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: 'Farmer Code-Name : ', style: TextStyle(color: Colors.black26)),
                                          TextSpan(text: '${EVM[index]['farmername'].toString().substring(EVM[index]['farmername'].toString().indexOf(":") + 1, EVM[index]['farmername'].toString().length)}', )
                                        ]
                                    )
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: 'DCS Code-Name : ', style: TextStyle(color: Colors.black26)),
                                          TextSpan(text: '${EVM[index]['lotname'].toString().substring(EVM[index]['lotname'].toString().indexOf("e:") + 2, EVM[index]['lotname'].toString().length)}',)
                                        ]
                                    )
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: 'Medicine used : ', style: TextStyle(color: Colors.black26)),
                                          TextSpan(text: '${EVM[index]['medicinename'].toString().substring(EVM[index]['medicinename'].toString().indexOf(":") + 1, EVM[index]['medicinename'].toString().length)}', )
                                        ]
                                    )
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: 'Diseases Code : ', style: TextStyle(color: Colors.black26)),
                                          TextSpan(text: '${EVM[index]['diseasecode'].toString().substring(EVM[index]['diseasecode'].toString().indexOf(":") + 1, EVM[index]['diseasecode'].toString().length)}',)
                                        ]
                                    )
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: 'Doctor : ', style: TextStyle(color: Colors.black26)),
                                          TextSpan(text: '${EVM[index]['Doctor'].toString().substring(EVM[index]['Doctor'].toString().indexOf(":") + 1, EVM[index]['Doctor'].toString().length)}',)
                                        ]
                                    )
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: 'Date : ', style: TextStyle(color: Colors.black26)),
                                          TextSpan(text: '${EVM[index]['Date'].toString().substring(EVM[index]['Date'].toString().indexOf(":") + 1, EVM[index]['Date'].toString().length)}',)
                                        ]
                                    )
                                ),
                              ),
                              Spacer(),

                               ]),
                      )),
                ),
              );
            },
          ):Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Update(int id,int Code) async {
    var response = await ApiCalling.createPost(
        AppUrl().UpdateEVM,
        "Bearer " + Constants_Usermast.token.toString(),
        {"Id": id,"Status": Code});
    if(response.statusCode==200)
      {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return EVMMedicine();
          },));
      }else{
      Con_Wid.Con_Show_Toast(context, "Something Went Wrong");
    }
  }
}
