// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:herdmannew/UiScreens/Activity/pm_certification.dart';
import 'package:herdmannew/UiScreens/Dashboard/Dashboard.dart';
import 'package:herdmannew/component/DataBaseHelper/Sync_Database.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Icons.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Con_Textstyle.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../../component/Gobal_Widgets/Constants.dart';
import '../../../model/Animal_Details_id.dart';
import '../../../model/Visit_Registration.dart';
import '../../Activity/add_pd_details.dart';
import '../../Activity/sc_certification.dart';
import '../../Dashboard/cattle_manual.dart';
import '../Alarm/Alarm.dart';
import '../AllCattleList/Abortion_page.dart';
import '../AllCattleList/CalvingDetails.dart';
import '../AllCattleList/InsemiationDetails.dart';
import '../AllCattleList/TreatmentAndVaccination.dart';

class VisitRegistrationScreen extends StatefulWidget {
  const VisitRegistrationScreen({super.key});

  @override
  State<VisitRegistrationScreen> createState() =>
      _VisitRegistrationScreenState();
}

class _VisitRegistrationScreenState extends State<VisitRegistrationScreen> {
  int pendingCount = 0;
  int completedCount = 0;
  int cancelledCount = 0;
  int reallocated = 0;
  String date_today = "";
  String formattedDate = "";
  String formattedDate1 = "";
  String formattedDate3 = "";
  int totaldatecount = 0;
  TextEditingController mTec_animalID = TextEditingController();
  final costcontroller = TextEditingController();
  bool visible_search_bar = false;
  List<Visit_Registration> filteredUsers = [];
  TextEditingController search = TextEditingController();
  var formatter = DateFormat('dd-MM-yyyy');
  DateTime visitDate = DateTime.now();
  DateTime visitmsg = DateTime.now();
  String FilterDate = DateTime.now().toString().substring(0, 10);
  late Timer _Timer;
  // List<String> animalid = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    getvisitdata();
    getRefresh();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _Timer.cancel();
    super.dispose();
  }
  Future<bool> onBackPress() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return DashBoardScreen();
      },
    ));
    return Future.value(false);
  }
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
       return onBackPress();
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
                        filteredUsers = Con_List.M_Visitragistration.where((u) =>
                            (u.visitID.toString().contains(value.toLowerCase()) ||
                                u.dCSCode
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                u.farmerCode
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                u.complaint
                                    .toString()
                                    .contains(value.toLowerCase()) ||
                                u.address
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                u.status
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                u.dCSName
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                u.visitCost
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))).toList();
                        setState(() {});
                      });
                    },
                    controller: search,
                    style: const TextStyle(
                        color: Colors.white, fontFamily: "poppins"),
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: ("Search Visit id"),
                      hintStyle:
                          TextStyle(color: Colors.white, fontFamily: "poppins"),
                    ),
                  ),
                ),
                actions: [
                  Con_Wid.mIconButton(
                      onPressed: () {
                        visible_search_bar = false;
                        filteredUsers = Con_List.M_Visitragistration.where((e) =>
                                e.date.toString().substring(0, 10) == FilterDate)
                            .toList();

                        setState(() {});
                      },
                      icon: Own_Close)
                ],
              )
            : Con_Wid.appBar(
                title: "Visit Registration",
                Actions: [
                  Con_Wid.mIconButton(
                      VisualDensity:
                          VisualDensity(horizontal: VisualDensity.minimumDensity),
                      onPressed: () async {
                        await SyncDB.SyncTable("VISITREGISTRATION", true)
                            .then((value) {
                          setState(() {
                            filteredUsers = Con_List.M_Visitragistration.where(
                                (e) =>
                                    e.date.toString().substring(0, 10) ==
                                    FilterDate).toList();
                            filteredUsers
                                .sort((a, b) => a.dCSCode.toString().compareTo(b.dCSCode.toString()));
                            filteredUsers.sort((b,a) => int.parse(a.visitCost.toString()).compareTo(int.parse(b.visitCost.toString())));
                            filteredUsers.sort((a, b) {
                              Map<String, int> statusOrder = {
                                "Pending": 0,
                                "Reallocated": 1,
                                "Canceled": 2,
                                "Compeleted": 3,
                              };
                              int compareStatus =
                                  statusOrder[a.status.toString()]!.compareTo(
                                      statusOrder[b.status.toString()]!);
                              return compareStatus;
                            });

                            getvisitdata();
                          });
                        });
                      },
                      icon: Own_Refresh),
                  Con_Wid.mIconButton(
                      onPressed: () async {
                        FilterDate = await Con_Wid.GlbDatePicker(
                            pcontext: context, formate: "11");
                        setState(() {
                          filteredUsers = Con_List.M_Visitragistration.where(
                              (e) =>
                                  e.date.toString().substring(0, 10) ==
                                  FilterDate).toList();
                          filteredUsers
                              .sort((a, b) => a.dCSCode.toString().compareTo(b.dCSCode.toString()));
                          filteredUsers.sort((b,a) => int.parse(a.visitCost.toString()).compareTo(int.parse(b.visitCost.toString())));
                          filteredUsers.sort((a, b) {
                            Map<String, int> statusOrder = {
                              "Pending": 0,
                              "Reallocated": 1,
                              "Canceled": 2,
                              "Compeleted": 3,
                            };
                            int compareStatus = statusOrder[a.status.toString()]!
                                .compareTo(statusOrder[b.status.toString()]!);
                            return compareStatus;
                          });

                          getvisitdata();
                        });
                      },
                      icon: Own_calendar,
                      VisualDensity: VisualDensity(
                          horizontal: VisualDensity.minimumDensity)),
                  Con_Wid.mIconButton(
                      VisualDensity:
                          VisualDensity(horizontal: VisualDensity.minimumDensity),
                      onPressed: () {
                        visible_search_bar = true;
                        setState(() {});
                      },
                      icon: Own_Search)
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
            child: Column(children: [
          Con_Wid.fullContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // InkWell(onTap: () {
                //   showDialog(context: context, builder: (context) {
                //     return Create_new_cattle();
                //   },);
                // },child: Container(height: 100,color: Colors.cyan,)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    paddingTxt("Pending \n       ${pendingCount}", 0, 0),
                    paddingTxt("Completed\n      ${completedCount}", 0, 0),
                    paddingTxt("Relocated\n       ${reallocated}",
                        MediaQuery.of(context).size.width / 40, 0),
                    paddingTxt("Cancelled\n       ${cancelledCount}",
                        MediaQuery.of(context).size.width / 20, 0),
                    paddingTxt("Total\n  ${filteredUsers.length}",
                        MediaQuery.of(context).size.width / 40, 0),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredUsers.isEmpty
                ? const Center(
                    child: Image(
                        height: 150,
                        width: 150,
                        image: AssetImage("assets/images/No-Data-Found.webp")),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      Color cardColor;
                      Color textColr;
                      switch (filteredUsers[index].status) {
                        case "Pending":
                          cardColor = ConClrpending;
                          break;
                        case "Reallocated":
                          cardColor = ConClrReallocated;
                          break;
                        case "Compeleted":
                          cardColor = ConClrCompeleted;
                          break;
                        case "Canceled":
                          cardColor = ConClrCanceled;
                          break;
                        default:
                          cardColor = ConClrCompeleted;
                      }
                      if ((filteredUsers[index].requestType == 19 ||
                              filteredUsers[index].requestType == 1008 ||
                              filteredUsers[index].visitCost == 400) &&
                          filteredUsers[index].status == "Pending") {
                        cardColor = Colors.blue;
                      }
                      if (filteredUsers[index].date.toString().isNotEmpty) {
                        String inputDate =
                            "${filteredUsers[index].date.toString()}";
                        DateTime date = DateTime.parse(inputDate).toLocal();
                        formattedDate = DateFormat('dd-MM-yyyy hh:mm a').format(date);
                        formattedDate1 = DateFormat('EEEE yyyy').format(date);
                        formattedDate3 = DateFormat('hh:mm a').format(date);
                      }

                      return con_clr.ConClr2
                          ? Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1, color: fontwhiteColor)),
                              width: double.infinity,
                              child: Stack(children: [
                                InkWell(
                                  onTap: () {
                                    var formatter = DateFormat('dd-MM-yyyy');
                                    var dates = formatter.format(DateTime(
                                        visitmsg.year,
                                        visitmsg.month,
                                        visitmsg.day - 3));

                                    String date_card = formatter.format(
                                        DateTime.parse(
                                            filteredUsers[index].date));

                                    String diffrentece = DateFormat('dd-MM-yyyy')
                                        .format(DateTime.now());

                                    if (totaldatecount > 0) {
                                      if (diffrentece == date_card) {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return SimpleDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0)),
                                                children: [
                                                  Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5,
                                                              bottom: 18,
                                                              right: 18,
                                                              left: 18),
                                                      child: Text(
                                                        '''આપના દ્વારા નોંધાયેલ બીજદાનની  ''' +
                                                            totaldatecount
                                                                .toString() +
                                                            '''  વિઝીટ પુરી થયેલ નથી અથવાતેની ડેટા એન્ટ્રી બાકી છે, કૃપાકરીને પહેલાં બાકી એ.આઈ.ની વિઝીટ/ કેતેની ડેટા એન્ટ્રી પુરી કરો તે પછીજ નવી એન્ટ્રી કરી શકાશે.''',
                                                        style: const TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Con_Wid.MainButton(
                                                          OnTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          pStrBtnName: 'Ok',
                                                          height: 45,
                                                          width: 170,
                                                          fontSize: 12)
                                                    ],
                                                  )
                                                ],
                                              );
                                            });
                                      }
                                    }

                                    if (filteredUsers[index].complaint == 'AI') {
                                      // if (Constants_Usermast.groupId == 6) {
                                      //   _bln = true;
                                      // } else {
                                      //   _bln = false;
                                      // }
                                      // ShowStatusDialog(visitModel, ctxt, index); //Priyank Remove
                                      _dlgs(filteredUsers[index], "", false,
                                          context, index);
                                    } else if (filteredUsers[index].status ==
                                        'Pending') {
                                      if (filteredUsers[index].animalID != null) {

                                        check_db(filteredUsers[index], "",
                                            context, false);
                                      } else {
                                        _dlgs(filteredUsers[index], "", false,
                                            context, index);
                                      }
                                    }
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Con_Wid.popinsfont(
                                                "Visit id : ${filteredUsers[index].visitID}",
                                                fontwhiteColor,
                                                FontWeight.normal,
                                                10,
                                                context),
                                            Spacer(),
                                            Con_Wid.mIconButton(
                                                onPressed: () {},
                                                icon: OwnM_number,
                                                color: fontwhiteColor,
                                                iconSize: 20),
                                            Con_Wid.popinsfont(
                                                "${filteredUsers[index].farmerMobile}",
                                                fontwhiteColor,
                                                FontWeight.normal,
                                                10,
                                                context),
                                          ],
                                        ),
                                        Con_Wid.height(5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Con_Wid.popinsfont(
                                                "Farmer code : ${filteredUsers[index].farmerCode}",
                                                fontwhiteColor,
                                                FontWeight.normal,
                                                10,
                                                context),
                                            Spacer(),
                                            Con_Wid.popinsfont(
                                                "FarmerName : ${filteredUsers[index].farmerName}",
                                                fontwhiteColor,
                                                FontWeight.normal,
                                                10,
                                                context),
                                          ],
                                        ),
                                        Con_Wid.height(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Con_Wid.popinsfont(
                                                "Reg Date : \n${filteredUsers[index].date}",
                                                fontwhiteColor,
                                                FontWeight.normal,
                                                10,
                                                context),
                                            Spacer(),
                                            Con_Wid.popinsfont(
                                                "Society Code : \n${filteredUsers[index].dCSCode}",
                                                fontwhiteColor,
                                                FontWeight.normal,
                                                10,
                                                context),
                                          ],
                                        ),
                                        Con_Wid.height(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Con_Wid.popinsfont(
                                                "Complaint : \n${filteredUsers[index].complaint}",
                                                fontwhiteColor,
                                                FontWeight.normal,
                                                10,
                                                context),
                                            Spacer(),
                                            Con_Wid.popinsfont(
                                                "Society Name : ${filteredUsers[index].dCSName}",
                                                fontwhiteColor,
                                                FontWeight.normal,
                                                10,
                                                context),
                                          ],
                                        ),
                                        Con_Wid.height(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Con_Wid.popinsfont(
                                                "Register No : ${filteredUsers[index].registerNo}",
                                                fontwhiteColor,
                                                FontWeight.normal,
                                                10,
                                                context),
                                            Spacer(),
                                            Con_Wid.popinsfont(
                                                "Address : ${filteredUsers[index].address}",
                                                fontwhiteColor,
                                                FontWeight.normal,
                                                10,
                                                context),
                                          ],
                                        ),
                                        Con_Wid.height(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Constants_Usermast.groupId != 6
                                                ? Con_Wid.popinsfont(
                                                    "Visit Cost : ${filteredUsers[index].visitCost}",
                                                    fontwhiteColor,
                                                    FontWeight.normal,
                                                    10,
                                                    context)
                                                : Container(),
                                            Spacer(),
                                            Con_Wid.popinsfont(
                                                "Species : ${filteredUsers[index].species == 1 ? "Cow" : "Buffalo"}",
                                                fontwhiteColor,
                                                FontWeight.normal,
                                                10,
                                                context),
                                          ],
                                        ),
                                        Container(
                                          height: 5,
                                          color: Colors.white.withOpacity(0.4),
                                          margin: const EdgeInsets.only(
                                              top: 20,
                                              left: 5,
                                              right: 5,
                                              bottom: 5),
                                        ),
                                        Container(
                                          child: Column(children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                filteredUsers[index].status ==
                                                        "Canceled"
                                                    ? Container(
                                                        height: 40,
                                                        child: Con_Wid
                                                            .selectionContainer(
                                                                text: "Cancelled",
                                                                context: context,
                                                                ontap: () {},
                                                                Color:
                                                                    Colors.white,
                                                                height: 24,
                                                                width: 100,
                                                                textcolor:
                                                                    cardColor),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                filteredUsers[index].status ==
                                                        'Pending'
                                                    ? Container(
                                                        height: 40,
                                                        child: Con_Wid
                                                            .selectionContainer(
                                                                text: "Cancel",
                                                                context: context,
                                                                ontap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return Dialog(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              170,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius:
                                                                                  BorderRadius.circular(10),
                                                                              color: ConClrMainLight),
                                                                          child: Column(
                                                                              children: [
                                                                                Container(
                                                                                  height: 60,
                                                                                  width: double.infinity,
                                                                                  decoration: const BoxDecoration(
                                                                                      gradient: LinearGradient(
                                                                                    colors: ConClrAppbarGreadiant,
                                                                                  )),
                                                                                  child: Center(
                                                                                    child: Con_Wid.popinsfont("Canceled Visit ?", fontwhiteColor, FontWeight.w600, 7, context),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                    child: Container(
                                                                                  padding: EdgeInsets.only(left: 15, right: 15),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Con_Wid.paddingWithText("Do you want to cancel a visit ?", context: context, Conclrfontmain),
                                                                                      Con_Wid.height(10),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Con_Wid.MainButton(
                                                                                              OnTap: () {
                                                                                                Navigator.pop(context);
                                                                                              },
                                                                                              pStrBtnName: "No",
                                                                                              height: 35,
                                                                                              width: 90,
                                                                                              fontSize: 16),
                                                                                          Con_Wid.width(5),
                                                                                          Con_Wid.MainButton(
                                                                                              OnTap: () {
                                                                                                CancelVisit(filteredUsers[index].visitID.toString());
                                                                                                setState(() {});
                                                                                              },
                                                                                              pStrBtnName: "yes",
                                                                                              height: 35,
                                                                                              width: 90,
                                                                                              fontSize: 16)
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ))
                                                                              ]),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                Color:
                                                                    Colors.white,
                                                                height: 24,
                                                                width: 78,
                                                                textcolor:
                                                                    cardColor),
                                                      )
                                                    : Container(),

                                                // if (_searchedData.value[index].isSynced == 1)
                                                //   Icon(Icons.check),
                                                // new Expanded(
                                                //   child: new Text(_searchedData.value[index].status,
                                                //       style: new TextStyle(color: textColor, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                                                //       textAlign: TextAlign.right),
                                                // ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                filteredUsers[index].status ==
                                                        'Compeleted'
                                                    ? Container(
                                                        height: 40,
                                                        width: 70,
                                                        child: Image.asset(
                                                          'assets/images/Completed.webp',
                                                          fit: BoxFit.fill,
                                                        ))
                                                    : Container(),
                                                filteredUsers[index].status ==
                                                        'Compeleted'
                                                    ? Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Icon(Icons
                                                                .cloud_download),
                                                            Text(" Report")
                                                          ],
                                                        ),
                                                        // onPressed: () {
                                                        //   // _downloadReport(_searchedData.value[index]);
                                                        // }
                                                      )
                                                    : Container(),
                                                filteredUsers[index].status ==
                                                        'Compeleted'
                                                    ? Container(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                child: InkWell(
                                                              onTap: () async {
                                                                costcontroller
                                                                        .text =
                                                                    Con_List
                                                                        .M_Visitragistration[
                                                                            index]
                                                                        .visitCost
                                                                        .toString();
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Dialog(
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            200,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(
                                                                                10),
                                                                            color:
                                                                                ConClrMainLight),
                                                                        child: Column(
                                                                            children: [
                                                                              Container(
                                                                                height: 60,
                                                                                width: double.infinity,
                                                                                decoration: const BoxDecoration(
                                                                                    gradient: LinearGradient(
                                                                                  colors: ConClrAppbarGreadiant,
                                                                                )),
                                                                                child: Stack(
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                                                                      child: Con_Wid.popinsfont("Cost Update", fontwhiteColor, FontWeight.w600, 7, context),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                  child: Container(
                                                                                padding: const EdgeInsets.only(left: 15, right: 15),
                                                                                child: Column(
                                                                                  children: [
                                                                                    Con_Wid.height(10),
                                                                                    Con_Wid.textFieldWithInter(text: "", controller: costcontroller, hintText: "Enter cost"),
                                                                                    Con_Wid.height(10),
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Con_Wid.MainButton(
                                                                                            OnTap: () {
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                            pStrBtnName: "Cancel",
                                                                                            height: 45,
                                                                                            width: 90,
                                                                                            fontSize: 16),
                                                                                        Con_Wid.MainButton(OnTap: () {}, pStrBtnName: "Save", height: 45, width: 90, fontSize: 16)
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ))
                                                                            ]),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: Container(
                                                                  height: 40,
                                                                  width: 70,
                                                                  child:
                                                                      Image.asset(
                                                                    'assets/images/Cost1.webp',
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  )),
                                                            ))
                                                            // Text(
                                                            //     '\u{20B9}${"Cost"}')
                                                          ],
                                                        ),
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                          ]),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                if ((filteredUsers[index].status ==
                                            'Compeleted' ||
                                        filteredUsers[index].status ==
                                            'Completed') &&
                                    (filteredUsers[index].visitCost == 250 ||
                                        filteredUsers[index].visitCost == 400))
                                  Positioned(
                                      top: 150,
                                      left: 145,
                                      child: Image.asset(
                                        "images/visit_reg.png",
                                        height: 100,
                                        width: 100,
                                      ))
                              ]),
                            )
                          : InkWell(
                              onTap: filteredUsers[index].status == "Canceled" ||
                                      filteredUsers[index].status == 'Compeleted'
                                  ? () {}
                                  : () async {
                                      var formatter = DateFormat('dd-MM-yyyy');
                                      var dates = formatter.format(DateTime(
                                          visitmsg.year,
                                          visitmsg.month,
                                          visitmsg.day - 3));

                                      String date_card = formatter.format(
                                          DateTime.parse(
                                              filteredUsers[index].date));

                                      String diffrentece =
                                          DateFormat('dd-MM-yyyy')
                                              .format(DateTime.now());

                                      if (totaldatecount > 0) {}

                                      if (filteredUsers[index].complaint ==
                                          'AI') {
                                        _dlgs(filteredUsers[index], "", false,
                                            context, index);
                                      } else if (filteredUsers[index].status ==
                                          'Pending') {
                                        if (filteredUsers[index].animalID !=
                                            null) {

                                          await Sync_Json.Get_Master_Data(
                                              Constants.Tbl_Master_staff);

                                          if (Con_List.A_Treatment.any(
                                              (element) =>
                                                  element.tagId.toString() ==
                                                      filteredUsers[index]
                                                          .animalID
                                                          .toString() &&
                                                  DateTime.now()
                                                          .difference(
                                                              DateTime.parse(
                                                                  element
                                                                      .updatedAt))
                                                          .inHours
                                                          .toInt() <=
                                                      6)) {
                                            _dlgs(filteredUsers[index], "", false,
                                                context, index);
                                          } else {
                                            await Sync_Json.Get_Master_Data(Constants.Tbl_Animal_details);
                                              if(Con_List.id_Animal_Details.any((element) => element.id.toString() == filteredUsers[index]
                                                  .animalID.toString())) {
                                                check_db(filteredUsers[index], "",
                                                context, false);
                                              }else{
                                                _dlgs(filteredUsers[index], "", false,
                                                    context, index);
                                              }
                                          }
                                        } else {
                                          _dlgs(filteredUsers[index], "", false,
                                              context, index);
                                        }
                                      }
                                    },
                              child: Card(
                                margin: const EdgeInsets.only(
                                    left: 5, right: 5, top: 10),
                                borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: filteredUsers[index].status.toString() == "Pending"?((filteredUsers[index].requestType == 19 ||
                                    filteredUsers[index].requestType == 1008 ||
                                    filteredUsers[index].visitCost == 400) &&
                                    filteredUsers[index].status == "Pending")?Colors.blue:Colors.red:filteredUsers[index].status.toString() == "Canceled"?Colors.pink:Colors.green,
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15))),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset(
                                                fit: BoxFit.fill,
                                                width: 220,
                                                "assets/images/Rectangle 199.png",
                                                 color: Colors.transparent,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                      "${filteredUsers[index].status}",
                                                      style: const TextStyle(
                                                          color: whiteColor,
                                                          fontSize: 15)),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        ((filteredUsers[index].requestType == 19 ||
                                            filteredUsers[index].requestType == 1008 ||
                                            filteredUsers[index].visitCost == 400) &&
                                            filteredUsers[index].status == "Pending") ?  const Text(
                                            "(Emergency)",
                                            style: TextStyle(
                                                color: whiteColor,
                                                fontSize: 14)):Container(),
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 20,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10))),
                                              child: Center(
                                                  child: Text(
                                                "VISIT ID : ${filteredUsers[index].visitID}",
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: fontColorSelected),
                                              )),
                                            ))
                                      ],
                                    ),
                                    Con_Wid.height(5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      margin: const EdgeInsets.only(top: 8),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    " $formattedDate",
                                                    style:
                                                        ConStyle.style_Blk_11s(),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(vertical: 6),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            InkWell(
                                                                onTap: () {
                                                                  _callNumber(
                                                                      filteredUsers[
                                                                              index]
                                                                          .farmerMobile);
                                                                },
                                                                child: Container(
                                                                  height: 14,
                                                                  width: 14,
                                                                  child:
                                                                      OwnM_number,
                                                                )),
                                                            Con_Wid.width(5),
                                                            Text(
                                                                "${filteredUsers[index].farmerMobile}",
                                                                style: ConStyle
                                                                    .style_Blk_14s(
                                                                        pColor: Colors
                                                                            .white)),
                                                          ]),
                                                    ),
                                                    filteredUsers[index].status ==
                                                            'Compeleted'
                                                        ? Con_Wid.gText(
                                                            "Tag Id : ${filteredUsers[index].animalID}",
                                                            style: ConStyle
                                                                .style_Blk_14s())
                                                        : Container(),
                                                  ]),
                                            ],
                                          ),
                                          Con_Wid.height(2),
                                          Wrap(
                                            runAlignment:
                                                WrapAlignment.spaceBetween,
                                            children: [
                                              Con_Wid.gText(
                                                  "${filteredUsers[index].farmerName}",
                                                  style: const TextStyle(
                                                      fontSize: 11.5,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: "Poppins",color: Colors.white)),

                                            ],
                                          ),
                                          Con_Wid.height(2),
                                          Con_Wid.gText(
                                              "Complaint : ${filteredUsers[index].complaint}",
                                              style:
                                              ConStyle.style_Blk_11s()),
                                          Con_Wid.height(2),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Con_Wid.gText(
                                                  "Farmer Code : ${filteredUsers[index].farmerCode}",
                                                  style:
                                                      ConStyle.style_Blk_11s()),
                                              Con_Wid.gText(
                                                  "Register No : ${filteredUsers[index].registerNo}",
                                                  style:
                                                      ConStyle.style_Blk_11s()),
                                            ],
                                          ),
                                          Con_Wid.height(2),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Con_Wid.gText(
                                                  "Society Code : ${filteredUsers[index].dCSCode}",
                                                  style:
                                                      ConStyle.style_Blk_11s()),
                                              Constants_Usermast.groupId != 6
                                                  ? Con_Wid.gText(
                                                      "Visit Cost : ${filteredUsers[index].visitCost}",
                                                      style: ConStyle
                                                          .style_Blk_11s())
                                                  : Container(),
                                            ],
                                          ),
                                          Con_Wid.height(2),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Con_Wid.gText(
                                                    "Society name : ${filteredUsers[index].dCSName}",
                                                    style:
                                                        ConStyle.style_Blk_11s()),
                                                Con_Wid.gText(
                                                    "Species : ${filteredUsers[index].species == 1 ? "Cow" : "Buffalo"}",
                                                    style:
                                                        ConStyle.style_Blk_11s()),
                                              ]),
                                          Con_Wid.height(2),
                                          Wrap(
                                            alignment: WrapAlignment.start,
                                            children: [
                                              Con_Wid.gText(
                                                  "Address : ${filteredUsers[index].address}",
                                                  style:
                                                      ConStyle.style_Blk_11s()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Con_Wid.height(10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        filteredUsers[index].status == "Canceled"
                                            ? Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.pinkAccent.shade100,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5)),
                                                ),
                                                height: 25,
                                                width: 120,
                                                child: const Text("Canceled",
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                              )
                                            : Container(),
                                        filteredUsers[index].status == 'Pending'
                                            ? InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                        child: Container(
                                                          height: 170,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: con_clr
                                                                      .ConClr2
                                                                  ? ConClrMainLight
                                                                  : whiteColor),
                                                          child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 60,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration: con_clr
                                                                          .ConClr2
                                                                      ? const BoxDecoration(
                                                                          gradient:
                                                                              LinearGradient(
                                                                          colors:
                                                                              ConClrAppbarGreadiant,
                                                                        ))
                                                                      : const BoxDecoration(
                                                                          color:
                                                                              ConClrDialog),
                                                                  child: Center(
                                                                    child: Con_Wid.popinsfont(
                                                                        "Canceled Visit ?",
                                                                        fontwhiteColor,
                                                                        FontWeight
                                                                            .w600,
                                                                        15,
                                                                        context),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              15,
                                                                          right:
                                                                              15),
                                                                  child: Column(
                                                                    children: [
                                                                      Con_Wid
                                                                          .height(
                                                                              15),
                                                                      Con_Wid.paddingWithText(
                                                                          "Do you want to cancel a visit ?",
                                                                          Conclrfontmain,
                                                                          context:
                                                                              context),
                                                                      Con_Wid
                                                                          .height(
                                                                              10),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .center,
                                                                        children: [
                                                                          Con_Wid.MainButton(
                                                                              OnTap: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              pStrBtnName: "No",
                                                                              height: 35,
                                                                              width: 90,
                                                                              fontSize: 16),
                                                                          Con_Wid.width(
                                                                              5),
                                                                          Con_Wid.MainButton(
                                                                              OnTap: () {
                                                                                CancelVisit(filteredUsers[index].visitID.toString());
                                                                                Navigator.pop(context);
                                                                              },
                                                                              pStrBtnName: "yes",
                                                                              height: 35,
                                                                              width: 90,
                                                                              fontSize: 16)
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              ]),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: const BoxDecoration(
                                                    color: whiteColor1,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                  height: 25,
                                                  width: 120,
                                                  child: const Text("Cancel",
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                                ),
                                              )
                                            : Container(),
                                        filteredUsers[index].status ==
                                                'Compeleted'
                                            ? Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.green.shade200,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5)),
                                                ),
                                                height: 25,
                                                width: 120,
                                                child: const Text("Compeleted",
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                              )
                                            : Container(),
                                        Con_Wid.width(20),
                                        filteredUsers[index].status ==
                                                    "Canceled" ||
                                                filteredUsers[index].status ==
                                                    'Compeleted'
                                            ? Container()
                                            : InkWell(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 25,
                                                  width: 120,
                                                  decoration: const BoxDecoration(
                                                    color: whiteColor1,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                  child: Text(
                                                      "${filteredUsers[index].status}",
                                                      style: const TextStyle(
                                                          fontSize: 12)),
                                                ),
                                              )
                                      ],
                                    ),
                                    Con_Wid.height(5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        filteredUsers[index].status ==
                                                'Compeleted'
                                            ? Container(
                                                height: 70,
                                                width: 70,
                                                child: Image.asset(
                                                  'assets/images/Completed.webp',
                                                  fit: BoxFit.fill,
                                                ))
                                            : Container(),
                                        filteredUsers[index].status ==
                                                'Compeleted'
                                            ? Container(
                                                child: InkWell(
                                                  onTap: () async {
                                                    var response;
                                                    if (filteredUsers[index]
                                                            .complaint
                                                            .toString()
                                                            .toLowerCase() ==
                                                        "pm / death verification") {
                                                      response = await ApiCalling
                                                          .getDataByToken(
                                                              "${AppUrl().DownloadPm}/${filteredUsers[index].visitID}?type=false");

                                                   } else {
                                                      response = await ApiCalling
                                                          .getDataByToken(
                                                              "${AppUrl().DownloadSC}/${filteredUsers[index].visitID}?type=sc");
                                                    }

                                                    Directory? tempPath =
                                                        await getExternalStorageDirectory();
                                                    String path = tempPath!.path;
                                                    final String fileName =
                                                        "${response.headers["content-disposition"].toString().substring(response.headers["content-disposition"].toString().indexOf("=")+1,response.headers["content-disposition"].toString().indexOf("pdf")-1)}.pdf";

                                                    File file =
                                                        File('$path/$fileName');
                                                    if (!await file.exists()) {
                                                      await file.create();
                                                      await file.writeAsBytes(
                                                          response.bodyBytes);
                                                      try {
                                                        await Share.shareFiles(
                                                            ['$path/$fileName'],
                                                            text: "Report");
                                                      } catch (e) {
                                                        if (kDebugMode) {
                                                          print("error$e");
                                                        }
                                                      }
                                                    }else{
                                                      await file.writeAsBytes(
                                                          response.bodyBytes);
                                                      try {
                                                        await Share.shareFiles(
                                                            ['$path/$fileName'],
                                                            text: "Report");
                                                      } catch (e) {
                                                        if (kDebugMode) {
                                                          print("error$e");
                                                        }
                                                      }
                                                    }
                                                  },
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Icon(Icons.cloud_download),
                                                      Text(" Report")
                                                    ],
                                                  ),
                                                ),
                                                // onPressed: () {
                                                //   // _downloadReport(_searchedData.value[index]);
                                                // }
                                              )
                                            : Container(),
                                        filteredUsers[index].status ==
                                                'Compeleted'
                                            ? Container(
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                        child: InkWell(
                                                      onTap: () async {
                                                        costcontroller.text =
                                                            Con_List
                                                                .M_Visitragistration[
                                                                    index]
                                                                .visitCost
                                                                .toString();
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Dialog(
                                                              child: Container(
                                                                height: 200,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                10),
                                                                    color: con_clr
                                                                            .ConClr2
                                                                        ? ConClrMainLight
                                                                        : whiteColor),
                                                                child: Column(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            60,
                                                                        width: double
                                                                            .infinity,
                                                                        decoration: con_clr
                                                                                .ConClr2
                                                                            ? const BoxDecoration(
                                                                                gradient:
                                                                                    LinearGradient(
                                                                                colors: ConClrAppbarGreadiant,
                                                                              ))
                                                                            : const BoxDecoration(
                                                                                color: ConClrDialog),
                                                                        child:
                                                                            Stack(
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
                                                                                  "Cost Update",
                                                                                  fontwhiteColor,
                                                                                  FontWeight.w600,
                                                                                  15,
                                                                                  context),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                          child:
                                                                              Container(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                15,
                                                                            right:
                                                                                15),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Con_Wid.height(
                                                                                10),
                                                                            Con_Wid.textFieldWithInter(
                                                                                text: "",
                                                                                controller: costcontroller,
                                                                                hintText: "Enter cost"),
                                                                            Con_Wid.height(
                                                                                10),
                                                                            Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.center,
                                                                              children: [
                                                                                Con_Wid.MainButton(
                                                                                    OnTap: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    pStrBtnName: "Cancel",
                                                                                    height: 45,
                                                                                    width: 90,
                                                                                    fontSize: 16),
                                                                                Con_Wid.MainButton(OnTap: () {}, pStrBtnName: "Save", height: 45, width: 90, fontSize: 16)
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ))
                                                                    ]),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                          height: 40,
                                                          width: 70,
                                                          child: Image.asset(
                                                            'assets/images/Cost1.webp',
                                                            fit: BoxFit.fill,
                                                          )),
                                                    ))
                                                    // Text(
                                                    //     '\u{20B9}${"Cost"}')
                                                  ],
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                    Con_Wid.height(10)
                                  ]),
                                ),
                              ),
                            );
                    },
                  ),
          ),
        ])),
      ),
    );
  }

  paddingTxt(String txt, double dx, double dy) {
    return Transform.translate(
      offset: Offset(dx, dy),
      child:
          Con_Wid.popinsfont(txt, Conclrfontmain, FontWeight.w600, 10, context),
    );
  }

  Future _dlgs(Visit_Registration visitModel, String pStrType, bool redirect,
      BuildContext context, index) async {
    List note1 = [];
    note1 = Con_List.id_Animal_Details
        .where((element) =>
            element.farmerCode.toString() == visitModel.farmerCode.toString() &&
            element.lot.toString() == visitModel.lotID.toString())
        .map((e) => e.tagId.toString())
        .toList();
    List note = note1.toSet().toList();

    String _selectedItem = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState1) {
            return Dialog(
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: con_clr.ConClr2 ? ConClrMainLight : whiteColor),
                child: Column(children: [
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: con_clr.ConClr2
                        ? const BoxDecoration(
                            gradient: LinearGradient(
                            colors: ConClrAppbarGreadiant,
                          ))
                        : BoxDecoration(color: ConClrDialog),
                    child: Center(
                      child: Con_Wid.popinsfont(
                          "Enter Tag No of cattle manually",
                          fontwhiteColor,
                          FontWeight.w600,
                          12,
                          context),
                    ),
                  ),
                  Container(height: 190,
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 15),
                    child: Column(
                      children: [
                        // DropdownButton(
                        //   hint: Text("Select Tag ID"),
                        //   // value: _selectedItem,
                        //   onChanged: (value) {
                        //     _selectedItem = value.toString();
                        //     mTec_animalID.text = value.toString();
                        //   },
                        //   items: note.map((item) {
                        //     return DropdownMenuItem(
                        //       value: item,
                        //       child: Text(item.toString()),
                        //     );
                        //   }).toList(),
                        // ),
                        Con_Wid.height(10),
                        Con_Wid.textFieldWithInter(
                            Onchanged: (p0) {
                              setState1(() {
                                _selectedItem = p0.toString();
                              });
                            },
                            TextInput_Type: TextInputType.number,
                            controller: mTec_animalID,
                            hintText: "Enter Tag ID"),
                        Con_Wid.height(10),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Con_Wid.MainButton(
                                  OnTap: () {
                                    visitModel.compliaintid == 25
                                        ? Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                            builder: (context) {
                                              return pm_certification(
                                                  visitModel);
                                            },
                                          ))
                                        : visitModel.compliaintid == 24
                                            ? Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                                builder: (context) {
                                                  return sccertification(
                                                    visitmodel: visitModel,
                                                  );
                                                },
                                              ))
                                            : null;
                                  },
                                  pStrBtnName: "Skip",
                                  height: 35,
                                  width: 170,
                                  fontSize: 12),
                            ),
                            Con_Wid.width(10),
                            Expanded(
                              child: Con_Wid.MainButton(
                                  OnTap: () async {
                                    await Sync_Json.Get_Master_Data(
                                        Constants.Tbl_Master_staff);

                                    String Farmer = "";
                                    await validateTagId(_selectedItem)
                                        .then((value) {
                                      if (value) {
                                        if (_selectedItem == "") {
                                          Con_Wid.Con_Show_Toast(
                                              context, "Enter TagId");
                                        } else if (Con_List.A_Treatment.any(
                                            (element) =>
                                                (element.tagId.toString() ==
                                                        _selectedItem &&
                                                    DateTime
                                                                .now()
                                                            .difference(DateTime
                                                                .parse(element
                                                                    .updatedAt))
                                                            .inHours
                                                            .toInt() <=
                                                        6 && !(visitModel.compliaintid ==
                                                    13 ||
                                                    visitModel
                                                        .compliaintid ==
                                                        24
                                                    ||
                                                    visitModel
                                                        .compliaintid ==
                                                        25 ||
                                                    visitModel.compliaintid ==
                                                        28 ||
                                                    visitModel.compliaintid ==
                                                        30 ||
                                                    visitModel.compliaintid ==
                                                        31))
                                        )) {

                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                child: Container(
                                                  height: 170,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: con_clr.ConClr2
                                                          ? ConClrMainLight
                                                          : whiteColor),
                                                  child: Column(children: [
                                                    Container(
                                                      height: 60,
                                                      width: double.infinity,
                                                      decoration: con_clr
                                                              .ConClr2
                                                          ? const BoxDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                              colors:
                                                                  ConClrAppbarGreadiant,
                                                            ))
                                                          : const BoxDecoration(
                                                              color:
                                                                  ConClrDialog),
                                                      child: Center(
                                                        child:
                                                            Con_Wid.popinsfont(
                                                                "Warring",
                                                                fontwhiteColor,
                                                                FontWeight.w600,
                                                                15,
                                                                context),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    const Text(
                                                      'Enter Other TagId Because This Animal Already Treated, You Can Treate after 6 hours',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Spacer()
                                                  ]),
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          if (Con_List.id_Animal_Details
                                              .where((et) =>
                                                  et.tagId.toString() ==
                                                  _selectedItem)
                                              .isNotEmpty) {
                                            Farmer = Con_List.id_Animal_Details
                                                .where((e) =>
                                                    e.tagId.toString() ==
                                                    _selectedItem)
                                                .first
                                                .farmer
                                                .toString();
                                          }
                                          if (Farmer == "" || Farmer == null) {
                                            if (pStrType == "") {
                                              if (visitModel.compliaintid ==
                                                  13) {
                                                pStrType = "Insemination";
                                              } else if (visitModel
                                                      .compliaintid ==
                                                  28) {
                                                pStrType = "PD";
                                              } else if (visitModel
                                                      .compliaintid ==
                                                  5) {
                                                pStrType = "Treatment";
                                              }
                                            }
                                            visitModel.animalID =
                                                _selectedItem.trim();
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return manual_entry(
                                                  manualentry: _selectedItem,
                                                  name: "Visit",
                                                  id: visitModel.visitID
                                                      .toString(),
                                                  visitmodel: visitModel,
                                                );
                                              },
                                            ));
                                            return;
                                          }
                                          if (Farmer.isNotEmpty) {
                                            if (visitModel.farmerid == Farmer) {
                                              if (pStrType == "") {
                                                if (visitModel.compliaintid ==
                                                    13) {
                                                  pStrType = "Insemination";
                                                } else if (visitModel
                                                        .compliaintid ==
                                                    28) {
                                                  pStrType = "PD";
                                                } else if (visitModel
                                                        .compliaintid ==
                                                    5) {
                                                  pStrType = "Treatment";
                                                }
                                              }
                                              visitModel.animalID =
                                                  _selectedItem.trim();
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return manual_entry(
                                                    manualentry: _selectedItem,
                                                    name: "Visit",
                                                    id: visitModel.visitID
                                                        .toString(),
                                                    visitmodel: visitModel,
                                                  );
                                                },
                                              ));
                                              return;
                                            }
                                          }
                                          if (visitModel.compliaintid == 13) {
                                            List<Animal_Details_id> statuslist =
                                                Con_List.id_Animal_Details
                                                    .where((element) =>
                                                        element.tagId
                                                            .toString() ==
                                                        _selectedItem)
                                                    .toList();
                                            if (statuslist.length > 0) {
                                              String status = statuslist
                                                  .first.breedingStatus
                                                  .toString();
                                              if (status == "" ||
                                                  status == "null" ||
                                                  status == "Aborted") {
                                                Con_Wid.Con_Show_Toast(context,
                                                    "Breeding Status not found");
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    return Insemiationdetails(
                                                      path: "visitre",
                                                      index: _selectedItem,
                                                      VisitID: visitModel
                                                          .visitID
                                                          .toString(),
                                                    );
                                                  },
                                                ));
                                              } else {
                                                pageRoute(
                                                    visitModel,
                                                    _selectedItem,
                                                    visitModel.visitID
                                                        .toString());
                                              }
                                            } else {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop('dialog');
                                              visitModel.animalID =
                                                  _selectedItem.trim();
                                              check_db(filteredUsers[index], "",
                                                  context, false);
                                            }
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop('dialog');
                                            visitModel.animalID =
                                                _selectedItem.trim();
                                            check_db(filteredUsers[index], "",
                                                context, false);
                                          }
                                        }
                                      } else {
                                        Con_Wid.Con_Show_Toast(
                                            context, "Enter Valid TagID");
                                      }
                                    });
                                  },
                                  pStrBtnName: "Continue",
                                  height: 35,
                                  width: 170,
                                  fontSize: 12),
                            )
                          ],
                        ),
                        Spacer()
                      ],
                    ),
                  )
                ]),
              ),
            );
          },
        );
      },
    );
  }

  Navigater_got(BuildContext context) {
    Navigator.pop(context);
  }

  check_db(Visit_Registration visitmodel, String pStrType, BuildContext context,
      bool redirect) async {
    int count = Con_List.id_Animal_Details.length;

    if (count > 0) {
      switch (visitmodel.compliaintid) {
        // added insemination details if complaint id is 13
        case 13:
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Insemiationdetails(
                index: visitmodel.animalID,
                VisitID: visitmodel.visitID.toString(),
              );
            },
          ));
          break;
        case 24:
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return sccertification(
                visitmodel: visitmodel,
              );
            },
          ));
          break;
        case 25:
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return pm_certification(visitmodel);
            },
          ));
          break;
        // added pd details navigation if complain id is 28
        case 28:
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return add_pd_details();
            },
          ));
          break;
        // case 6:
        //   Navigator.push(
        //       context,
        //       CupertinoPageRoute(
        //           builder: (context) => Add_insemination_details(
        //               value: timeline_intent(
        //                   visitRegistrationModel: model,
        //                   tag: model.animalId))));
        //   break;
        case 25:
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return pm_certification(visitmodel.animalID);
            },
          ));
          break;
        case 30:
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Abortion_Details(
                index: visitmodel.animalID.toString(),
              );
            },
          ));
          break;
        case 31:
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return CalvingDetails(index: visitmodel.animalID.toString());
            },
          ));
          break;
        default:
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Treatmentandvaccination(
                Visitmodel: visitmodel,
                index: visitmodel.animalID,
                path: "Visit",
              );
            },
          ));
          break;
      }
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => manual_entry(
                manualentry: visitmodel.animalID.toString(),
                name: "Visit",
                id: visitmodel.visitID.toString(),
                visitmodel: visitmodel,
              ));
    }
  }

  Future<bool> validateTagId(String text) async {
    if (Constants_Usermast.QRCode == "false") {
      return true;
    }
    if (text.length == 12 && text != "000000000000") {
      String tag = text;

      int sum = 0;

      for (int i = 0; i < tag.length; i++) {
        int multipliedValue = (tag.length - i - 1) * int.tryParse(tag[i])!;
        if (multipliedValue >= 0) sum += multipliedValue;
      }

      double value = (sum / 9).toDouble();

      int y = int.tryParse(value.toString().split('.')[1][0])!;

      if (y == int.tryParse(tag[11])!) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  pageRoute(Visit_Registration visitmodel, String iD, String visitid) {
    String mStrheatdays = "";
    Animal_Details_id Mdetail =
        Con_List.id_Animal_Details.firstWhere((e) => e.tagId == iD.toString());
    bool enable_abort_entry = false,
        enable_calving_entry = false,
        enable_insem_btn = false,
        enable_pd_entry = false,
        enable_dryoff_entry = false;

    if (Mdetail.heatDate != null && Mdetail.heatDate.toString() != "") {
      mStrheatdays = DateTime.now()
          .difference(DateTime.parse("${Mdetail.heatDate}"))
          .inDays
          .toString();
    }
    if (Mdetail.statusname.toString().toLowerCase() == 'Heifer'.toLowerCase() ||
        Mdetail.statusname.toString().toLowerCase() ==
            'Milking'.toLowerCase() ||
        Mdetail.statusname.toString().toLowerCase() == 'Dry'.toLowerCase()) {
      setState(() {
        enable_insem_btn = true;
      });
    }
    if ((Mdetail.breedingStatus.toString().toLowerCase() ==
            'Pregnant'.toLowerCase()) &&
        int.parse(mStrheatdays) > 200) {
      setState(() {
        enable_calving_entry = true;
      });
    }
    enable_pd_entry = false;
    if ((Mdetail.breedingStatus.toString().toLowerCase() ==
                'Open Bred'.toLowerCase() ||
            Mdetail.breedingStatus.toString().toLowerCase() ==
                'Heifer Bred'.toLowerCase()) &&
        int.parse(mStrheatdays) > 45) {
      setState(() {
        enable_pd_entry = true;
      });
    }

    if ((Mdetail.breedingStatus.toString().toLowerCase() ==
                'Open Bred'.toLowerCase() ||
            Mdetail.breedingStatus.toString().toLowerCase() ==
                'Pregnant'.toLowerCase()) &&
        int.parse(mStrheatdays) > 45) {
      setState(() {
        enable_abort_entry = true;
      });
    }

    if (Mdetail.statusname.toString().toLowerCase() ==
            'Pregnant Milking'.toLowerCase() ||
        Mdetail.statusname.toString().toLowerCase() ==
            'Milking'.toLowerCase()) {
      setState(() {
        enable_dryoff_entry = true;
      });
    }
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: 100,
              color: con_clr.ConClr2 ? ConClrMainLight : whiteColor,
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                      height: 60,
                      width: double.infinity,
                      decoration: con_clr.ConClr2
                          ? const BoxDecoration(
                              gradient: LinearGradient(
                              colors: ConClrAppbarGreadiant,
                            ))
                          : BoxDecoration(color: ConClrDialog),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
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
                            child: Con_Wid.popinsfont("Filter", fontwhiteColor,
                                FontWeight.w600, 15, context),
                          )
                        ],
                      )),
                  Con_Wid.height(15),
                  Visibility(
                    visible: enable_insem_btn,
                    child: Con_Wid.MainButton(
                        width: 170,
                        height: 45,
                        fontSize: 16,
                        pStrBtnName: 'Insemiation',
                        OnTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Insemiationdetails(
                                path: "visitre",
                                index: iD,
                                VisitID: visitid,
                              );
                            },
                          ));
                        }),
                  ),
                  Con_Wid.height(10),
                  Visibility(
                    visible: enable_calving_entry,
                    child: Con_Wid.MainButton(
                        width: 170,
                        height: 45,
                        fontSize: 16,
                        pStrBtnName: 'Calving Details',
                        OnTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return CalvingDetails(
                                path: "visitre",
                                index: iD,
                                vistid: visitid,
                              );
                            },
                          ));
                        }),
                  ),
                  Con_Wid.height(10),
                  Visibility(
                    visible: enable_pd_entry,
                    child: Con_Wid.MainButton(
                        width: 170,
                        height: 45,
                        fontSize: 16,
                        pStrBtnName: 'PD Details',
                        OnTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return add_pd_details(
                                path: "visitre",
                                index: iD,
                                visitid: visitid,
                              );
                            },
                          ));
                        }),
                  ),
                  Con_Wid.height(10),
                  Visibility(
                    visible: enable_abort_entry,
                    child: Con_Wid.MainButton(
                        width: 170,
                        height: 45,
                        fontSize: 16,
                        pStrBtnName: 'Abortion',
                        OnTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Abortion_Details(
                                path: "visitre",
                                index: iD,
                                visit: visitid,
                              );
                            },
                          ));
                        }),
                  ),
                  Con_Wid.height(10),
                  Visibility(
                    visible: enable_dryoff_entry,
                    child: Con_Wid.MainButton(
                        width: 170,
                        height: 45,
                        fontSize: 16,
                        pStrBtnName: 'Treatment',
                        OnTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Treatmentandvaccination(
                                Visitmodel: visitmodel,
                                index: visitmodel.animalID,
                                path: "Visit",
                              );
                            },
                          ));
                        }),
                  ),
                  Con_Wid.height(20),
                ]),
              ),
            ),
          );
        });
  }

  CancelVisit(String VisitId) {
    SyncDB.updatevisitid(VisitId);
    setState(() {
      Con_List.M_Visitragistration.where((e) => e.visitID.toString() == VisitId)
          .toList()
          .forEach((element) {
        element.status = 'Canceled';
      });
      filteredUsers = Con_List.M_Visitragistration.where(
          (e) => e.date.toString().substring(0, 10) == FilterDate).toList();
    });
  }

  _callNumber(String nom) async {
    String number = nom.toString(); //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
  getdata() async {
    if (Con_List.M_Userherds.isEmpty ||
        Con_List.M_Visitragistration.isEmpty ||
        Con_List.id_Animal_Details.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_herd);
      Sync_Json.Get_Master_Data(Constants.Tbl_VISITREGISTRATION);
      Sync_Json.Get_Master_Data(Constants.Tbl_Animal_details);
    }
    filteredUsers = Con_List.M_Visitragistration.where(
            (e) => e.date.toString().substring(0, 10) == FilterDate).toList();

    filteredUsers.sort((a, b) => a.dCSCode.toString().compareTo(b.dCSCode.toString()));
    filteredUsers.sort((b,a) => int.parse(a.visitCost.toString()).compareTo(int.parse(b.visitCost.toString())));
    filteredUsers.sort((a, b) {
      Map<String, int> statusOrder = {
        "Pending": 0,
        "Reallocated": 1,
        "Canceled": 2,
        "Compeleted": 3,
      };
      int compareStatus = statusOrder[a.status.toString()]!
          .compareTo(statusOrder[b.status.toString()]!);
      return compareStatus;
    });


    setState(() {});
  }

  getvisitdata() {
    pendingCount = filteredUsers
        .where((element) => element.status == "Pending")
        .toList()
        .length;
    completedCount = filteredUsers
        .where((element) =>
    element.status == "Compeleted" || element.status == "Completed")
        .toList()
        .length;

    cancelledCount = filteredUsers
        .where((element) => element.status == "Canceled")
        .toList()
        .length;

    reallocated = filteredUsers
        .where((element) => element.status == "Reallocated")
        .toList()
        .length;

    date_today = DateFormat('dd-MM-yyyy').format(DateTime.now());
    totaldatecount = filteredUsers
        .where((element) => element.date != date_today)
        .toList()
        .length;
  }
getRefresh(){
  _Timer =  Timer.periodic(Duration(seconds: 3), (timer) async {
    getdata();
    getvisitdata();
    });
}
}
