import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/InsemiationDetails.dart';
import 'package:herdmannew/component/DataBaseHelper/Sync_Api.dart';

import '../../component/DataBaseHelper/Sync_Database.dart';
import '../../component/Gobal_Widgets/Con_Color.dart';
import '../../component/Gobal_Widgets/Con_Textstyle.dart';
import '../../model/Visit_Registration.dart';
import '../Activity/add_pd_details.dart';
import '../Activity/pm_certification.dart';
import '../Activity/sc_certification.dart';
import '../DrawerScreens/Action/Action.dart';
import '../DrawerScreens/Alarm/Alarm.dart';
import '../DrawerScreens/AllCattleList/Abortion_page.dart';
import '../DrawerScreens/AllCattleList/CalvingDetails.dart';
import '../DrawerScreens/AllCattleList/CattleStatusTimeline.dart';
import '../DrawerScreens/AllCattleList/TreatmentAndVaccination.dart';
import '../DrawerScreens/VisitRegistration/VisitRegistration.dart';

class Api_Dailog extends StatefulWidget {
  String? rescode,
      code,
      tag,
      farmer,
      farmername,
      society,
      societyname,
      name,
      path;
  String? visitcode;

  Api_Dailog(
      [this.rescode,
      this.code,
      this.tag,
      this.farmer,
      this.farmername,
      this.society,
      this.societyname,
      this.name,
      this.path,
      this.visitcode]);

  @override
  State<Api_Dailog> createState() => _Api_DailogState();
}

class _Api_DailogState extends State<Api_Dailog> {
  bool image = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Anima();
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted) {
      Future.delayed(Duration(seconds: 4)).then((value) {
        setState(() {
          image = true;
        });
      });
    }
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        child: Column(children: [
          Anima(),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 1.5,
            child: Sync_Api.MstrResponsecode == "200"
                ? Text("${widget.name}\nSuccessfully",
                    style: const TextStyle(
                      color: fontBlackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ))
                : const Text("Something want wrong",
                    style: TextStyle(
                      color: fontBlackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 2,
            child: Text(DateTime.now().toString().substring(0, 10),
                style: ConStyle.style_white_18s_600w()),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsetsDirectional.only(top: 30),
            height: MediaQuery.of(context).size.height / 2.7,
            width: MediaQuery.of(context).size.width / 1.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey, width: 1)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 10,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.grey))),
                  child: Sync_Api.MstrResponsecode == "200"
                      ? Text(
                          "Order No : ${widget.name == "Animal Registration" ? widget.code : Sync_Api.MstrResponse}",
                          style: ConStyle.Style_white_13s_700w(Colors.black))
                      : Text("GO To Sync Report",
                          style: ConStyle.Style_white_13s_700w(Colors.red)),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("TagID : ${widget.tag}"),
                      Text("Farmer Name : ${widget.farmername}"),
                      Text("Farmer Code : ${widget.farmer}"),
                      Text("Society Name : ${widget.societyname}"),
                      Text("Society Code : ${widget.society}"),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {});
              // if (Sync_Api.MstrResponse != "" && widget.visitcode != null) {
              //   SyncDB.Visit_Complete(widget.visitcode!, widget.tag!);
              // }
              widget.path == "Action"
                  ? Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return ActionScreen();
                      },
                    ))
                  : widget.path == "Activity"
                      ? Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return cattlestatustimeline(index: widget.tag!);
                          },
                        ))
                      : widget.path == "Alarm"
                          ? Navigator.pushReplacement(context,
                              MaterialPageRoute(
                              builder: (context) {
                                return AlarmScreen();
                              },
                            ))
                          : Navigator.pushReplacement(context,
                              MaterialPageRoute(
                              builder: (context) {
                                return VisitRegistrationScreen();
                              },
                            ));
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              height: MediaQuery.of(context).size.height / 20,
              width: MediaQuery.of(context).size.width / 5,
              child: Text("Got it"),
            ),
          ),
        ]),
      ),
    );
  }

  Widget Anima() {
    return Container(
      margin: EdgeInsets.only(
          bottom: 20, top: MediaQuery.of(context).size.height / 10),
      width: MediaQuery.of(context).size.width / 2.9,
      height: MediaQuery.of(context).size.height / 3.9 - kToolbarHeight,
      child: Sync_Api.MstrResponsecode == "200"
          ? image
              ? Image(image: AssetImage("assets/images/check.webp"))
              : Image.asset("assets/images/check1.gif")
          : Image.asset("assets/images/error.png"),
    );
  }
}

class Api_Dailog1 extends StatefulWidget {
  String? rescode,
      code,
      tag,
      farmer,
      farmername,
      society,
      societyname,
      name,
      path;
  String? visitcode;
  Visit_Registration? visitmodel;

  Api_Dailog1(
  {this.rescode,
      this.code,
      this.visitmodel,
      this.tag,
      this.farmer,
      this.farmername,
      this.society,
      this.societyname,
      this.name,
      this.path,
      this.visitcode});

  @override
  State<Api_Dailog1> createState() => _Api_Dailog1State();
}

class _Api_Dailog1State extends State<Api_Dailog1> {
  bool image = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Anima();
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted) {
      Future.delayed(Duration(seconds: 4)).then((value) {
        setState(() {
          image = true;
        });
      });
    }
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        child: Column(children: [
          Anima(),
          Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text("${widget.name}\nSuccessfully",
                  style: const TextStyle(
                    color: fontBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ))),
          Container(
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 2,
            child: Text(DateTime.now().toString().substring(0, 10),
                style: ConStyle.style_white_18s_600w()),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsetsDirectional.only(top: 30),
            height: MediaQuery.of(context).size.height / 2.7,
            width: MediaQuery.of(context).size.width / 1.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey, width: 1)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                flex: 2,
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 10,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey))),
                    child: Text(
                        "Order No : ${widget.name == "Animal Registration" ? widget.code : Sync_Api.MstrResponse}",
                        style: ConStyle.Style_white_13s_700w(Colors.black))),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("TagID : ${widget.tag}"),
                      Text("Farmer Name : ${widget.farmername}"),
                      Text("Farmer Code : ${widget.farmer}"),
                      Text("Society Name : ${widget.societyname}"),
                      Text("Society Code : ${widget.society}"),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {});
              if (widget.path != "Visit" && Sync_Api.MstrResponse != "" && widget.visitcode != null) {
                SyncDB.Visit_Complete(widget.visitcode!, widget.tag!);
              }
              widget.path == "Action"
                  ? Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return ActionScreen();
                      },
                    ))
                  : widget.path == "Activity"
                      ? Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return cattlestatustimeline(index: widget.tag!);
                          },
                        ))
                      : widget.path == "Alarm"
                          ? Navigator.pushReplacement(context,
                              MaterialPageRoute(
                              builder: (context) {
                                return AlarmScreen();
                              },
                            ))
                          :widget.path == "Visit" ? get() : Navigator.pushReplacement(context,
                              MaterialPageRoute(
                              builder: (context) {
                                return VisitRegistrationScreen();
                              },
                            ));
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              height: MediaQuery.of(context).size.height / 20,
              width: MediaQuery.of(context).size.width / 5,
              child: Text("Got it"),
            ),
          ),
        ]),
      ),
    );
  }

  Widget Anima() {
    return Container(
        margin: EdgeInsets.only(
            bottom: 20, top: MediaQuery.of(context).size.height / 10),
        width: MediaQuery.of(context).size.width / 2.9,
        height: MediaQuery.of(context).size.height / 3.9 - kToolbarHeight,
        child: image
            ? Image(image: AssetImage("assets/images/check.webp"))
            : Image.asset("assets/images/check1.gif"));
  }

  get(){
    switch (widget.visitmodel!.compliaintid) {
      case 13:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Insemiationdetails(
              index: widget.visitmodel!.animalID,
              VisitID: widget.visitmodel!.visitID.toString(),
            );
          },
        ));
        break;
      case 24:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return sccertification(
              visitmodel: widget.visitmodel!,
            );
          },
        ));
        break;
      case 25:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return pm_certification(widget.visitmodel!);
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
      case 25:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return pm_certification(widget.visitmodel!.animalID);
          },
        ));
        break;
      case 30:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Abortion_Details(
              index: widget.visitmodel!.animalID.toString(),
            );
          },
        ));
        break;
      case 31:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return CalvingDetails(index: widget.visitmodel!.animalID.toString());
          },
        ));
        break;
      default:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Treatmentandvaccination(Visitmodel: widget.visitmodel!,index: widget.visitmodel!.animalID,path: widget.path,);
          },
        ));
        break;
    }
  }
}
