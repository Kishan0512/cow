// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/Dashboard/Dashboard.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/AllCattleList.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/AnimalTransfer.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/AllCattleList/CattleStatusTimeline.dart';
import 'package:herdmannew/component/DataBaseHelper/Con_List.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Icons.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Textstyle.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/component/Gobal_Widgets/Constants.dart';
import 'package:herdmannew/model/Animal_Details_id.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/A_SQL_Trigger/A_NetworkHelp.dart';
import '../../../component/DataBaseHelper/Sync_Database.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Con_Usermast.dart';
import '../../../component/Gobal_Widgets/DatePicker.dart';
import '../../../model/Animal_Disposal.dart';
import '../../../model/Animal_Treatment.dart';
import '../../../model/Breeding_reproduction_id.dart';
import '../../../model/Milk_production_id.dart';
import '../../Dashboard/Genomix_entry.dart';
import 'Update_Animal_Id.dart';

class profile extends StatefulWidget {
  String index;

  profile(this.index);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  bool loading = false;
  String Sex = "";
  List Date = [];
  TextEditingController soldTo = TextEditingController(),
      price = TextEditingController();
  List<String> disposaltypeadd = [];
  String mStrFromdate = DateFormat('MM/dd/yyyy HH:mm').format(DateTime.now());
  List<String> Msystem = [];
  List<String> Mreason = [];
  String actual_date = "";
  List<int> array_val = [0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300];
  List<Sales> standerd = [];
  List<Sales> MilkingYield = [];
  List<Sales> AICurve = [];
  List<Sales> PregnantCurve = [];
  List<Sales> VaccinationCurve = [];
  List<Sales> TreatmentCurve = [];
  List<Profile_Details> mListDetail = [];
  Animal_Details_id? Mdetail;
  List<Milk_production_id> Mprodetail = [];
  List<Milk_production_id> MilkingEntry = [];
  List<Breeding_reproduction_id> breedingdetails = [];
  List<Animal_Treatment> tretmentdetails = [];
  int openpi = 0;
  int Gestation = 0;
  String lastsire = "";
  String age = "";
  DateTime? Dry;
  int Drydays = 0;
  double milkYield = 0;
  int pickMilk = 0;
  double Daycount = 0;
  double avg = 0;
  DateTime? Expectedcalvingdate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
    getList();
    getuserimfo();
    mGraph();
    setState(() {});
  }

  getuserimfo() {
    getage();
    if (Mdetail!.statusname.toString() != "Heifer") {
      if (Mdetail!.calvingDate != null &&
          Mdetail!.calvingDate.toString().trim() != "") {
        DateTime now = DateTime.now();
        DateTime Calving = DateTime.parse(Mdetail!.calvingDate);
        Duration diff = now.difference(Calving);
        openpi = diff.inDays + 1;
        Dry = DateTime.parse(Mdetail!.calvingDate).add(Duration(days: 280));
        setState(() {});
      }
    }
  }

  getage() {
    try {
      if (Mdetail!.dryDate != null) {
        DateTime now = DateTime.now();
        DateTime Drydate = DateTime.parse(Mdetail!.dryDate);
        Duration diff = now.difference(Drydate);
        Drydays = diff.inDays;
        setState(() {});
      }
    } catch (e) {}
    if (Mdetail!.dOB != null) {
      DateTime now = DateTime.now();
      DateTime birthday = DateTime.parse(Mdetail!.dOB);
      Duration diff = now.difference(birthday);
      if (diff.inDays < 30) {
        age = "${diff.inDays.toString()} Day";
        setState(() {});
      } else if (diff.inDays > 30 && diff.inDays < 365) {
        age = "${diff.inDays / 30} Month";
        setState(() {});
      } else if (diff.inDays > 365) {
        final duration = Duration(days: diff.inDays);
        final years = duration.inDays ~/ 365;
        final months = (duration.inDays % 365) ~/ 30;
        age = "$years years & $months months";
        setState(() {});
      }
    }
    var dateheat = Mdetail?.heatDate;
    if (dateheat != null &&
        dateheat.toString().trim() != "" &&
        dateheat.toString().toLowerCase() != "null" &&
        dateheat.toString().isNotEmpty) {
      //print("ok" + dateheat.toString());
      DateTime now = DateTime.now();
      DateTime Heat = DateTime.parse(dateheat.toString());
      Duration diff = now.difference(Heat);
      Gestation = diff.inDays + 1;
      Expectedcalvingdate = DateTime.parse(dateheat).add(Duration(days: 280));
    }
  }

  getData() async {
    if (Con_List.M_Milk_paramter.isEmpty ||
        Con_List.id_reproduction.isEmpty ||
        Con_List.id_Milk_production.isEmpty ||
        Con_List.A_Treatment.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_parameter);
      Sync_Json.Get_Master_Data(Constants.Breeding_reproduction_id);
      Sync_Json.Get_Master_Data(Constants.Tbl_Health_treatment);
      Sync_Json.Get_Master_Data(Constants.Milk_production_id);
    }

    breedingdetails = Con_List.id_reproduction
        .where((e) => e.tagId.toString() == widget.index.toString())
        .toList();
    breedingdetails.sort(
      (a, b) => b.parity.toString().compareTo(a.parity.toString()),
    );

    tretmentdetails = Con_List.A_Treatment.where(
        (e) => e.tagId.toString() == widget.index.toString()).toList();
    MilkingEntry = Con_List.id_Milk_production
        .where((element) => element.tagId.toString() == widget.index.toString())
        .toList();
    MilkingEntry.sort(
      (a, b) => b.date.toString().compareTo(a.date.toString()),
    );

    var box = await Hive.openBox<Animal_Disposal>("Animal_diedDetails");
    try {
      Constants.Last_id_Animal_diedDetails =
          int.parse(box.keys.last.toString());
    } catch (e) {
      Constants.Last_id_Animal_diedDetails = 0;
    }
  }

  getList() {
    Mdetail = Con_List.id_Animal_Details
        .firstWhere((element) => element.tagId == widget.index.toString());

    if (Mdetail!.statusname == "Pregnant Dry") {
      Mprodetail = Con_List.id_Milk_production
          .where((element) => element.tagId == widget.index.toString())
          .toList();
      if (Mprodetail.isNotEmpty) {
        Mprodetail.forEach((element) {
          if (element.lactationMilkTotal != null &&
              int.tryParse(element.lactationMilkTotal.toString()) != null) {
            milkYield += int.parse(element.lactationMilkTotal.toString());
          }
          if (element.dayMilkTotal != null &&
              int.tryParse(element.dayMilkTotal.toString()) != null) {
            pickMilk += int.parse(element.dayMilkTotal.toString());
          }
          if (element.daysCount != null &&
              int.tryParse(element.daysCount.toString()) != null) {
            Daycount += int.parse(element.daysCount.toString());
          }
        });
        if (Daycount != 0 && milkYield != 0) {
          avg = milkYield / Daycount;
          setState(() {});
        }
      }
    }
    adddata(Mdetail);
    if (Mdetail!.sexFlg == 1) {
      Sex = "Male";
    } else {
      Sex = "Female";
    }
    setState(() {});
    Con_List.M_Milk_paramter.forEach((e) {
      if (e.breed.toString() == Mdetail!.breed.toString()) {
        Con_List.M_Milk_paramter.forEach((element) {
          Date.add(element.tFDMilk);
        });
      }
    });
  }

  adddata(Mdetail) {
    getuserimfo();
    if (Mdetail.statusname != "Calf") {
      if (Mdetail.statusname != null) {
        var filteredList = Con_List.id_reproduction.where(
            (element) => element.tagId.toString() == Mdetail!.tagId.toString());
        if (filteredList.isNotEmpty) {
          lastsire = filteredList.last.Sirename.toString();
        }
      }
    }
    if (Mdetail.statusname == "Milking") {
      if (Mdetail!.breedingStatus == "Open Unbred") {
        mListDetail.add(Profile_Details(
            Title1: "Animal ID No.",
            Value1: Mdetail!.tagId.toString(),
            Title2: "LotCode/Name",
            Value2: "${Mdetail!.lotcode}/${Mdetail!.lotname}"));
        mListDetail.add(Profile_Details(
            Title1: "Farmer Code",
            Value1: Mdetail.farmerCode.toString(),
            Title2: "Farmer Name",
            Value2: "${Mdetail!.farmername}"));
        mListDetail.add(Profile_Details(
            Title1: "Sex",
            Value1: Mdetail!.sexFlg == 1 ? "Male" : "Female",
            Title2: "Age",
            Value2: "$age"));
        mListDetail.add(Profile_Details(
            Title1: "Breed Name",
            Value1: "${Mdetail!.breedname}",
            Title2: "Status",
            Value2: "${Mdetail!.statusname}"));
        mListDetail.add(Profile_Details(
            Title1: "Breeding Status",
            Value1: "${Mdetail!.breedingStatus}",
            Title2: "Open Period",
            Value2: "$openpi"));
        mListDetail.add(Profile_Details(
            Title1: "last calving Date",
            Value1:
                "${Mdetail!.calvingDate != null ? Mdetail!.calvingDate.toString().substring(0, 10) : ""} ",
            Title2: "Days in Milk",
            Value2: "$openpi"));
        mListDetail.add(Profile_Details(
            Title1: "Milk Yield",
            Value1: "$milkYield",
            Title2: "Peak Yield",
            Value2: "$pickMilk"));
        mListDetail.add(Profile_Details(
            Title1: "Expected Dry date",
            Value1: Dry != null ? Dry.toString().substring(0, 10) : "",
            Title2: "",
            Value2: ""));
      } else {
        mListDetail.add(Profile_Details(
            Title1: "Animal ID No.",
            Value1: Mdetail!.tagId.toString(),
            Title2: "LotCode/Name",
            Value2: "${Mdetail!.lotcode}/${Mdetail!.lotname}"));
        mListDetail.add(Profile_Details(
            Title1: "Farmer Code",
            Value1: Mdetail.farmerCode.toString(),
            Title2: "Farmer Name",
            Value2: "${Mdetail!.farmername}"));
        mListDetail.add(Profile_Details(
            Title1: "Sex",
            Value1: Mdetail!.sexFlg == 1 ? "Male" : "Female",
            Title2: "Age",
            Value2: "$age"));
        mListDetail.add(Profile_Details(
            Title1: "Breed Name",
            Value1: "${Mdetail!.breedname}",
            Title2: "Status",
            Value2: "${Mdetail!.statusname}"));
        mListDetail.add(Profile_Details(
            Title1: "Breeding Status",
            Value1: "${Mdetail!.breedingStatus}",
            Title2: "Open Period",
            Value2: "${openpi}"));
        mListDetail.add(Profile_Details(
            Title1: "Last calving Date",
            Value1:
                "${Mdetail!.calvingDate != null ? Mdetail!.calvingDate.toString().substring(0, 10) : ""} ",
            Title2: "Days In Milk",
            Value2: "${openpi}"));
        mListDetail.add(Profile_Details(
            Title1: "Last Sire",
            Value1: lastsire,
            Title2: "No of AI",
            Value2: "${Mdetail!.heatSeq}"));
        mListDetail.add(Profile_Details(
          Title1: "Last Heat Date",
          Value1: Mdetail!.heatDate != null
              ? Mdetail!.heatDate.toString().substring(0, 10)
              : "",
          Title2: "Expected Dry Date",
          Value2: Dry != null ? Dry.toString().substring(0, 10) : "",
        ));
      }
    } else if (Mdetail.statusname == "Calf") {
      mListDetail.add(Profile_Details(
          Title1: "Animal ID No.",
          Value1: Mdetail!.tagId.toString(),
          Title2: "LotCode/Name",
          Value2: "${Mdetail!.lotcode}/${Mdetail!.lotname}"));
      mListDetail.add(Profile_Details(
          Title1: "Farmer Code",
          Value1: Mdetail.farmerCode.toString(),
          Title2: "Farmer Name",
          Value2: "${Mdetail!.farmername}"));
      mListDetail.add(Profile_Details(
          Title1: "Breed Name",
          Value1: "${Mdetail!.breedname}",
          Title2: "Age",
          Value2: age));
      mListDetail.add(Profile_Details(
          Title1: "Breeding Status",
          Value1: "${Mdetail!.breedingStatus}",
          Title2: "Status",
          Value2: "${Mdetail!.statusname}"));
    } else if (Mdetail.statusname == "Heifer") {
      mListDetail.add(Profile_Details(
          Title1: "Animal ID No.",
          Value1: Mdetail!.tagId.toString(),
          Title2: "LotCode/Name",
          Value2: "${Mdetail!.lotcode}/${Mdetail!.lotname}"));
      mListDetail.add(Profile_Details(
          Title1: "Farmer Code",
          Value1: Mdetail.farmerCode.toString(),
          Title2: "Farmer Name",
          Value2: "${Mdetail!.farmername}"));
      mListDetail.add(Profile_Details(
          Title1: "Sex",
          Value1: Mdetail!.sexFlg == 1 ? "Male" : "Female",
          Title2: "Age",
          Value2: age));
      mListDetail.add(Profile_Details(
          Title1: "Breed Name",
          Value1: "${Mdetail!.breedname}",
          Title2: "Status",
          Value2: "${Mdetail!.statusname}"));
      mListDetail.add(Profile_Details(
          Title1: "Breeding Status",
          Value1: "${Mdetail!.breedingStatus}",
          Title2: "No of A.I",
          Value2: "${Mdetail!.heatSeq}"));
      mListDetail.add(Profile_Details(
          Title1: "Last Heat Date",
          Value1: Mdetail!.heatDate != null &&
                  Mdetail!.heatDate.toString().trim() != "" &&
                  Mdetail!.heatDate.toString().toLowerCase() != "null" &&
                  Mdetail!.heatDate.toString().isNotEmpty
              ? Mdetail!.heatDate.toString().substring(0, 10)
              : "",
          Title2: "Last Sire",
          Value2: lastsire));
    } else if (Mdetail.statusname == "Draft") {
      mListDetail.add(Profile_Details(
          Title1: "Animal ID No.",
          Value1: Mdetail!.tagId.toString(),
          Title2: "LotCode/Name",
          Value2: "${Mdetail!.lotcode}/${Mdetail!.lotname}"));
      mListDetail.add(Profile_Details(
          Title1: "Farmer Code",
          Value1: Mdetail.farmerCode.toString(),
          Title2: "Farmer Name",
          Value2: "${Mdetail!.farmername}"));
      mListDetail.add(Profile_Details(
          Title1: "Sex",
          Value1: Mdetail!.sexFlg == 1 ? "Male" : "Female",
          Title2: "Age",
          Value2: age));
      mListDetail.add(Profile_Details(
          Title1: "Breed Name",
          Value1: "${Mdetail!.breedname}",
          Title2: "Status",
          Value2: "${Mdetail!.statusname}"));
    } else if (Mdetail.statusname == "Pregnant Milking") {
      mListDetail.add(Profile_Details(
          Title1: "Animal ID No.",
          Value1: Mdetail!.tagId.toString(),
          Title2: "LotCode/Name",
          Value2: "${Mdetail!.lotcode}/${Mdetail!.lotname}"));
      mListDetail.add(Profile_Details(
          Title1: "Farmer Code",
          Value1: Mdetail.farmerCode.toString(),
          Title2: "Farmer Name",
          Value2: "${Mdetail!.farmername}"));
      mListDetail.add(Profile_Details(
          Title1: "Sex",
          Value1: Mdetail!.sexFlg == 1 ? "Male" : "Female",
          Title2: "Age",
          Value2: age));
      mListDetail.add(Profile_Details(
          Title1: "Breed Name",
          Value1: "${Mdetail!.breedname}",
          Title2: "Status",
          Value2: "${Mdetail!.statusname}"));
      mListDetail.add(Profile_Details(
          Title1: "Breeding Status",
          Value1: "${Mdetail!.breedingStatus}",
          Title2: "Calving To Conception",
          Value2: ""));
      mListDetail.add(Profile_Details(
          Title1: "Last calving Date",
          Value1:
              "${Mdetail!.calvingDate != null ? Mdetail!.calvingDate.toString().substring(0, 10) : ""} ",
          Title2: "Days In Milk",
          Value2: "${Mdetail!.totalMilk}"));
      mListDetail.add(Profile_Details(
          Title1: "Last Sire",
          Value1: lastsire,
          Title2: "No of AI",
          Value2: "${Mdetail!.heatSeq}"));
      mListDetail.add(Profile_Details(
          Title1: "Last Heat Date",
          Value1: Mdetail!.heatDate != null
              ? Mdetail!.heatDate.toString().substring(0, 10)
              : "",
          Title2: "Gestation Days",
          Value2: "$Gestation"));
      mListDetail.add(Profile_Details(
          Title1: "Expected Dry Date",
          Value1: Dry != null ? Dry.toString().substring(0, 10) : "",
          Title2: "Expected Calving Date",
          Value2:
              // ignore: unrelated_type_equality_checks
              Expectedcalvingdate != ""
                  ? Expectedcalvingdate.toString().substring(0, 10)
                  : ""));
      mListDetail.add(Profile_Details(
          Title1: "PD Cheak Date",
          Value1: Mdetail.pDDate != null
              ? Mdetail.pDDate.toString().substring(0, 10)
              : "",
          Title2: "",
          Value2: ""));
    } else if (Mdetail.statusname == "Pregnant") {
      mListDetail.add(Profile_Details(
          Title1: "Animal ID No.",
          Value1: Mdetail!.tagId.toString(),
          Title2: "LotCode/Name",
          Value2: "${Mdetail!.lotcode}/${Mdetail!.lotname}"));
      mListDetail.add(Profile_Details(
          Title1: "Farmer Code",
          Value1: Mdetail.farmerCode.toString(),
          Title2: "Farmer Name",
          Value2: "${Mdetail!.farmername}"));
      mListDetail.add(Profile_Details(
          Title1: "Sex",
          Value1: Mdetail!.sexFlg == 1 ? "Male" : "Female",
          Title2: "Age",
          Value2: age));
      mListDetail.add(Profile_Details(
          Title1: "Breed Name",
          Value1: "${Mdetail!.breedname}",
          Title2: "Status",
          Value2: "${Mdetail!.statusname}"));
      mListDetail.add(Profile_Details(
          Title1: "Breeding Status",
          Value1: "${Mdetail!.breedingStatus}",
          Title2: "No of AI",
          Value2: "${Mdetail!.heatSeq}"));
      mListDetail.add(Profile_Details(
          Title1: "Last Sire",
          Value1: lastsire,
          Title2: "Last Heat Date",
          Value2: Mdetail!.heatDate != null
              ? Mdetail!.heatDate.toString().substring(0, 10)
              : ""));
      mListDetail.add(Profile_Details(
          Title1: "PD Cheak Date",
          Value1: Mdetail.pDDate != null
              ? Mdetail.pDDate.toString().substring(0, 10)
              : "",
          Title2: "Gestation Days",
          Value2: "$Gestation"));
      mListDetail.add(Profile_Details(
          Title1: "Expected Calving date",
          Value1: Expectedcalvingdate != ""
              ? Expectedcalvingdate.toString().substring(0, 10)
              : "",
          Title2: "",
          Value2: ""));
    } else if (Mdetail.statusname == "Pregnant Dry") {
      mListDetail.add(Profile_Details(
          Title1: "Animal ID No.",
          Value1: Mdetail!.tagId.toString(),
          Title2: "LotCode/Name",
          Value2: "${Mdetail!.lotcode}/${Mdetail!.lotname}"));
      mListDetail.add(Profile_Details(
          Title1: "Farmer Code",
          Value1: Mdetail!.farmerCode.toString(),
          Title2: "Farmer Name",
          Value2: "${Mdetail!.farmername}"));
      mListDetail.add(Profile_Details(
          Title1: "Sex",
          Value1: Mdetail!.sexFlg == 1 ? "Male" : "Female",
          Title2: "Age",
          Value2: age));
      mListDetail.add(Profile_Details(
          Title1: "Breed Name",
          Value1: "${Mdetail!.breedname}",
          Title2: "Status",
          Value2: "${Mdetail!.statusname}"));
      mListDetail.add(Profile_Details(
          Title1: "Breeding Status",
          Value1: "${Mdetail!.breedingStatus}",
          Title2: "Calving to Conception",
          Value2: openpi.toString()));
      mListDetail.add(Profile_Details(
          Title1: "Last Sire",
          Value1: lastsire,
          Title2: "No of AI",
          Value2: "${Mdetail!.heatSeq}"));
      mListDetail.add(Profile_Details(
          Title1: "Last Heat Date",
          Value1: Mdetail!.heatDate != null
              ? Mdetail!.heatDate.toString().substring(0, 10)
              : "",
          Title2: "Gestation Days",
          Value2: "$Gestation"));
      mListDetail.add(Profile_Details(
          Title1: "Pd Cheak Date",
          Value1: Mdetail!.pDDate != null
              ? Mdetail!.pDDate.toString().substring(0, 10)
              : "",
          Title2: "Expected Calving Date",
          Value2: Expectedcalvingdate != ""
              ? Expectedcalvingdate.toString().substring(0, 10)
              : ""));
      mListDetail.add(Profile_Details(
          Title1: "Dry Days",
          Value1: "$Drydays",
          Title2: "Last Dry Off Date",
          Value2: Mdetail!.dryDate != null
              ? Mdetail!.dryDate.toString().substring(0, 10)
              : ""));
      mListDetail.add(Profile_Details(
          Title1: "Milk Yield",
          Value1: "$milkYield",
          Title2: "Avg Yield",
          Value2: "${avg.toStringAsFixed(2)}"));
      mListDetail.add(Profile_Details(
          Title1: "Peak Yield", Value1: "$pickMilk", Title2: "", Value2: ""));
    } else {
      mListDetail.add(Profile_Details(
          Title1: "Animal ID No.",
          Value1: Mdetail!.tagId.toString(),
          Title2: "LotCode/Name",
          Value2: "${Mdetail!.lotcode}/${Mdetail!.lotname}"));
      mListDetail.add(Profile_Details(
          Title1: "Farmer Code",
          Value1: Mdetail.farmerCode.toString(),
          Title2: "Farmer Name",
          Value2: "${Mdetail!.farmername}"));
      mListDetail.add(Profile_Details(
          Title1: "Sex",
          Value1: Mdetail!.sexFlg == 1 ? "Male" : "Female",
          Title2: "Age",
          Value2: age));
      mListDetail.add(Profile_Details(
          Title1: "Breed Name",
          Value1: "${Mdetail!.breedname}",
          Title2: "Status",
          Value2: "${Mdetail!.statusname}"));
    }
  }

  maximumBreedMilkYield(double mbScale, double mbRamp, double mbOffset,
      double mbDecay, int mbDay) {
    var milk = mbScale *
        math.exp(-mbDecay * mbDay) *
        (1 - math.exp((mbOffset - mbDay) / mbRamp) / 2);
    double multiplier = .5;
    var vals = ((milk * 0.453) * multiplier).round();
    return ((milk * 0.453) * multiplier).round();
  }

  mGraph() {
    if (Date.isNotEmpty) {
      for (int i = 0; i < array_val.length; i++) {
        standerd.add(Sales(
            array_val[i],
            int.parse(maximumBreedMilkYield(double.parse(Date[0].toString()),
                    20, 0, 0.002, array_val[i])
                .toString())));
      }
    } else {
      standerd = [];
    }
  }

  Future<bool> onBackPress() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return const AllCattleListScreen();
      },
    ));

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "Profile",
          Actions: [
            Con_Wid.mIconButton(
                VisualDensity: VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return Genomix_entry(int.parse(widget.index));
                    },
                  ));
                },
                icon: Icon(Icons.add)),
            Con_Wid.mIconButton(
                VisualDensity: VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return Animal_update(index: widget.index,);
                    },
                  ));
                 },
                icon: Icon(Icons.upload)),
            Con_Wid.mIconButton(
              onPressed: () {
                Disposal_dialog();
              },
              icon: const Image(
                height: 30,
                width: 30,
                color: whiteColor,
                image: AssetImage("assets/images/Disposal.webp"),
              ),
            ),
            InkWell(
              radius: 30,
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return animalTransfer(int.parse(widget.index));
                  },
                ));
              },
              child: Container(
                alignment: Alignment.centerRight,
                height: 70,
                width: 50,
                child: const Image(
                  image: AssetImage("assets/images/transfer.webp"),
                ),
              ),
            ),
            Con_Wid.mIconButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  String id = "";
                  id = Con_List.id_Animal_Details
                      .where((element) =>
                          element.tagId.toString() == widget.index.toString())
                      .first
                      .id
                      .toString();
                  List<dynamic> data = [];
                  var update_ani;

                  var res = await ApiCalling.getDataByToken(
                      AppUrl().refreshAnimalDataInServer + widget.index);

                  var response = await ApiCalling.createPost(
                      AppUrl().AnimalRefresh,
                      "Bearer ${Constants_Usermast.token}",
                      {"tagid": widget.index, "TBLSTR": "Animal_Details:0"});

                  if (response.statusCode == 200) {
                    update_ani = jsonDecode(response.body);
                    data = update_ani[0];
                    if (data.isNotEmpty) {
                      var box = await Hive.openBox<Animal_Details_id>(
                          'Animal_Details_id');

// Delete the item with the specified index
                      await box.delete(id);

// Close the box after the deletion
                      await box.close();

                      print("Deleted item at index $id");

// Open the box again
                      var box1 = await Hive.openBox<Animal_Details_id>(
                          'Animal_Details_id');

// Add the updated data to the box
                      data.forEach((e) {
                        box1.put(int.parse(e['id'].toString()),
                            Animal_Details_id.fromJson(e));
                      });

// Close the box again
                      await box1.close();

                      print("Updated data added to the box");

                      await Sync_Json.Get_Master_Data('Animal_Details_id');
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return profile(widget.index);
                        },
                      ));
                    }
                  }
                  var response1 = await ApiCalling.createPost(
                      AppUrl().AnimalRefresh,
                      "Bearer ${Constants_Usermast.token}", {
                    "tagid": widget.index,
                    "TBLSTR": "Breeding_reproduction:0"
                  });
                  if (response1.statusCode == 200) {
                    var jsondecode = jsonDecode(response1.body);
                    List data = jsondecode[0];
                    if (data.isNotEmpty) {
                      var box = await Hive.openBox<Breeding_reproduction_id>(
                          'Breeding_reproduction_id');

                      for (int i = 0; i < data.length; i++) {
                        await box.delete(data[i]['id'].toString());
                      }
                      data
                          .map((e) => box.put("${e['id']}",
                              Breeding_reproduction_id.fromJson(e)))
                          .toList();
                      for (int i = 0; i < data.length; i++) {
                        var r = await box.get(data[i]['id'].toString());
                      }
                    }
                  }
                },
                icon: Own_Refresh),
          ],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const AllCattleListScreen();
              },
            ));
          },
        ),
        body: Stack(children: [
          Con_Wid.backgroundContainer(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Mdetail!.statusname.toString().toLowerCase() == "null" ||
                              Mdetail!.statusname.toString().toLowerCase() == ""
                          ? const Image(
                              fit: BoxFit.fill,
                              width: 90,
                              height: 60,
                              image: AssetImage("assets/images/no image.webp"))
                          : Image(
                              fit: BoxFit.fill,
                              width: 90,
                              height: 60,
                              image: AssetImage(
                                  "assets/images/${Mdetail!.speciesname.toString().toLowerCase()}${Mdetail!.statusname.toString().toLowerCase() == "null" ? "" : '-' + Mdetail!.statusname.toString().toLowerCase()}.webp")),
                      const Image(
                          fit: BoxFit.fill,
                          width: 90,
                          height: 60,
                          image: AssetImage("assets/images/no image.webp")),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                      child: Container(
                    // alignment: Alignment.centerRight,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: con_clr.ConClr2 ? ConClrLightBack : Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                          mListDetail.map((e) => Info_tile_wid(e)).toList(),
                    ),
                  )),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 340,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(children: [
                    //Initialize the chart widget
                    SfCartesianChart(
                        enableAxisAnimation: false,
                        primaryXAxis: CategoryAxis(
                            labelRotation: 90,
                            axisLine:
                                AxisLine(width: 2, color: Colors.grey.shade800),
                            labelStyle: TextStyle(color: Colors.grey.shade800),
                            majorTickLines:
                                MajorTickLines(color: Colors.grey.shade800),
                            majorGridLines: MajorGridLines(width: 0),
                            title: AxisTitle(
                                text: Con_Wid.Lang_Cng("Day in Milk"))),
                        primaryYAxis: NumericAxis(
                            axisLine: AxisLine(width: 2, color: Colors.white),
                            labelStyle: TextStyle(color: Colors.grey.shade800),
                            majorTickLines:
                                MajorTickLines(color: Colors.grey.shade800),
                            majorGridLines: MajorGridLines(width: 1),
                            title: AxisTitle(
                                text: Con_Wid.Lang_Cng("Milk Yield"))),
                        title: ChartTitle(
                            text: Con_Wid.Lang_Cng('Lactation Curve')),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<Sales, String>>[
                          LineSeries<Sales, String>(
                            color: ConClrCharred,
                            dataSource: standerd,
                            xValueMapper: (Sales sales, _) =>
                                sales.yearval.toString(),
                            yValueMapper: (Sales sales, _) => sales.salesval,
                          )
                        ]),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: standerd.isNotEmpty
                            ? SfSparkLineChart.custom(
                                trackball: const SparkChartTrackball(
                                    activationMode:
                                        SparkChartActivationMode.tap),
                                xValueMapper: (int index) =>
                                    standerd[index].yearval,
                                yValueMapper: (int index) =>
                                    standerd[index].salesval,
                                dataCount: 5,
                              )
                            : Container(),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: 25,
                      child: Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Con_Wid.circal(5, ConClrCharred),
                              Con_Wid.gText(
                                "Standard",
                                style:
                                    ConStyle.Style_white_8s_500w(ConClrCharred),
                              ),
                              Con_Wid.circal(5, ConClrCharyell),
                              Con_Wid.gText(
                                "Milk(kg)",
                                style: ConStyle.Style_white_8s_500w(
                                    ConClrCharyell),
                              ),
                              Con_Wid.circal(5, ConClrCharpurp),
                              Con_Wid.gText(
                                "A.I",
                                style: ConStyle.Style_white_8s_500w(
                                    ConClrCharpurp),
                              ),
                              Con_Wid.circal(5, ConClrChargreen),
                              Con_Wid.gText(
                                "Preg.",
                                style: ConStyle.Style_white_8s_500w(
                                    ConClrChargreen),
                              ),
                              Con_Wid.circal(5, ConClrChartail),
                              Con_Wid.gText(
                                "vaction",
                                style: ConStyle.Style_white_8s_500w(
                                    ConClrChartail),
                              ),
                              Con_Wid.circal(5, ConClrCharblue),
                              Con_Wid.gText(
                                "Treatment",
                                style: ConStyle.Style_white_8s_500w(
                                    ConClrCharblue),
                              ),
                            ]),
                      ]),
                    ),
                  ]),
                ),
                DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                          indicatorColor:
                              con_clr.ConClr2 ? whiteColor : BlackColor,
                          tabs: [
                            Tab(
                              child: Con_Wid.gText("Breeding",
                                  style: TextStyle(
                                      color: con_clr.ConClr2
                                          ? whiteColor
                                          : BlackColor)),
                            ),
                            Tab(
                              child: Con_Wid.gText("Milking",
                                  style: TextStyle(
                                      color: con_clr.ConClr2
                                          ? whiteColor
                                          : BlackColor)),
                            ),
                            Tab(
                              child: Con_Wid.gText("Treatment",
                                  style: TextStyle(
                                      color: con_clr.ConClr2
                                          ? whiteColor
                                          : BlackColor)),
                            )
                          ]),
                      Container(
                        height: 500,
                        child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              _tabBarWidget(_breedingDataNew),
                              _tabBarWidget(_Milkinhg),
                              _tabBarWidget(_treatmentData)
                            ]),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
          loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container()
        ]),
        //floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        floatingActionButton: FloatingActionButton.extended(
            shape: RoundedRectangleBorder(),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return cattlestatustimeline(index: widget.index);
                },
              ));
            },
            label: Text(
              "Add Activity",
              style: TextStyle(fontSize: 16),
            )),
      ),
    );
  }

  Disposal_dialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState1) {
            return Material(
              color: Colors.transparent,
              child: Container(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5, vertical: con_clr.ConClr2 ? 220 : 150),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10, bottom: 20),
                          height: double.infinity,
                          width: double.infinity,
                          decoration: con_clr.ConClr2
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: const LinearGradient(
                                    colors: ConClrAppbarGreadiant,
                                  ))
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: ConClrSelected),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, left: 10),
                                child: Con_Wid.gText(
                                  "Disposal Entry",
                                  style: ConStyle.style_white_14s_500w(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 65),
                          child: Container(
                            decoration: con_clr.ConClr2
                                ? BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30)),
                                    color: con_clr.ConClr2
                                        ? ConClrMainLight
                                        : whiteColor,
                                  )
                                : BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5)),
                                    color: con_clr.ConClr2
                                        ? ConClrMainLight
                                        : whiteColor,
                                  ),
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  children: [
                                    Con_Wid.height(10),
                                    Container(
                                      child: Date_Picker(
                                        daysCount: 5,
                                        selectionColor: ConClrDialog,
                                        selectedTextColor: Colors.white,
                                        onDateChange: (value) {
                                          setState(() {
                                            mStrFromdate = value.toString();
                                          });
                                        },
                                        onPressed: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: Mdetail!
                                                              .calvingDate ==
                                                          null
                                                      ? DateTime.parse(
                                                          Mdetail!.dOB)
                                                      : DateTime.parse(
                                                          Mdetail!.calvingDate),
                                                  lastDate: DateTime.now())
                                              .then((value) {
                                            setState(() {
                                              if (value == null) {
                                                mStrFromdate = value.toString();
                                              } else {
                                                mStrFromdate = value.toString();
                                              }
                                            });
                                          });
                                        },
                                        buttencolor: ConClrDialog,
                                      ),
                                    ),
                                    CondropDown(
                                      title: 'Select Disposal Type',
                                      itemList: Con_List.M_disposal.map(
                                          (e) => e.name.toString()).toList(),
                                      SelectedList: disposaltypeadd,
                                      onSelected: (List<String> value) {
                                        setState1(() {
                                          disposaltypeadd.contains(value);
                                          disposaltypeadd = value;
                                        });
                                      },
                                    ),
                                    listEquals(disposaltypeadd, ["Sold"])
                                        ? Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Con_Wid.textFieldWithInter(
                                                      text: "Sold To",
                                                      controller: soldTo,
                                                      hintText: "Sold To"),
                                                  Con_Wid.textFieldWithInter(
                                                      TextInput_Type:
                                                          TextInputType.number,
                                                      text: "Price",
                                                      controller: price,
                                                      hintText: "Enter price")
                                                ]),
                                          )
                                        : Container(),
                                    listEquals(disposaltypeadd, ["Died"])
                                        ? Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CondropDown(
                                                    title: 'Select System',
                                                    itemList: Con_List
                                                                .M_systemAffected
                                                            .map((e) => e.name
                                                                .toString())
                                                        .toList(),
                                                    SelectedList: Msystem,
                                                    onSelected:
                                                        (List<String> value) {
                                                      setState1(() {
                                                        Msystem = value;
                                                      });
                                                    },
                                                  )
                                                ]),
                                          )
                                        : Container(),
                                    listEquals(disposaltypeadd, ["Unknown"])
                                        ? Container()
                                        : Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Con_Wid.height(5),
                                                  CondropDown(
                                                    title: 'Select Reason',
                                                    itemList: Con_List
                                                            .M_disposalSubOptions
                                                        .map((e) =>
                                                            e.name).toList(),
                                                    SelectedList: Mreason,
                                                    onSelected:
                                                        (List<String> value) {
                                                      setState1(() {
                                                        Mreason = value;
                                                      });
                                                    },
                                                  ),
                                                ]),
                                          ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Con_Wid.selectionContainer(
                                            height: 38,
                                            width: 87,
                                            text: "Cancel",
                                            context: context,
                                            ontap: () {
                                              Navigator.pop(context);
                                            },
                                            textcolor: con_clr.ConClr2
                                                ? whiteColor
                                                : ConClrSelected,
                                            Color: con_clr.ConClr2
                                                ? ConClrLightBack
                                                : whiteColor),
                                        Con_Wid.selectionContainer(
                                            height: 38,
                                            width: 87,
                                            text: "Submit",
                                            context: context,
                                            ontap: () {
                                              String herd = "";
                                              String lot = "";
                                              String farmer1 = "";
                                              String reason1 = "";
                                              String died = "";
                                              if (Mreason.isNotEmpty) {
                                                Con_List.M_disposalSubOptions
                                                    .forEach((element) {
                                                  if (element.name ==
                                                      Mreason[0].toString()) {
                                                    reason1 =
                                                        element.id.toString();
                                                  }
                                                });
                                              }
                                              if (Msystem.isNotEmpty) {
                                                Con_List.M_systemAffected
                                                    .forEach((element) {
                                                  if (element.name ==
                                                      Msystem[0].toString()) {
                                                    died =
                                                        element.id.toString();
                                                  }
                                                });
                                              }

                                              var date;
                                              if (mStrFromdate == null) {
                                                date = new DateTime.now();
                                                var formatter1 = new DateFormat(
                                                    'MM/dd/yyyy HH:mm');
                                                actual_date =
                                                    formatter1.format(date);
                                                var formatter = new DateFormat(
                                                    'dd-MM-yyyy');
                                              } else {
                                                actual_date =
                                                    mStrFromdate.toString();
                                              }
                                              List<Animal_Disposal>
                                                  animalDetails = [
                                                Animal_Disposal(
                                                    oldTagId:
                                                        "${Mdetail!.tagId}",
                                                    tagId: "${Mdetail!.tagId}",
                                                    date: actual_date,
                                                    soldTo: soldTo.text != ""
                                                        ? soldTo.text
                                                        : "",
                                                    soldPrice: price.text != ""
                                                        ? double.parse(
                                                            price.text)
                                                        : "0.0",
                                                    herd: int.parse(Mdetail!
                                                        .herd
                                                        .toString()),
                                                    lot: int.parse(Mdetail!.lot
                                                        .toString()),
                                                    farmer: int.parse(Mdetail!
                                                        .farmer
                                                        .toString()),
                                                    oldDetails:
                                                        "${Mdetail!.tagId}",
                                                    details: null,
                                                    disposalReason:
                                                        reason1 != ""
                                                            ? int.parse(reason1)
                                                            : 0,
                                                    diedReason: died != ""
                                                        ? int.parse(died)
                                                        : null,
                                                    id: Constants
                                                            .Last_id_Animal_diedDetails +
                                                        1,
                                                    createdAt: DateTime.now()
                                                        .toString(),
                                                    updatedAt: null,
                                                    lastUpdatedByUser: null,
                                                    createdByUser: int.parse(
                                                        Constants_Usermast
                                                            .user_id
                                                            .toString()),
                                                    staff: 1,
                                                    disposaltype: 1,
                                                    SyncStatus: "0",
                                                    ServerId: "")
                                              ];
                                              Animal_Disposal rnd =
                                                  animalDetails[math.Random()
                                                      .nextInt(animalDetails
                                                          .length)];
                                              List<Map> weights_sync_datas = [];
                                              weights_sync_datas
                                                  .add(rnd.toJson(rnd));
                                              SyncDB.insert_table(
                                                  weights_sync_datas,
                                                  Constants
                                                      .Tbl_Animal_diedDetails);
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return DashBoardScreen();
                                                },
                                              ));
                                              setState1(() {});
                                            },
                                            textcolor: whiteColor,
                                            Color: con_clr.ConClr2
                                                ? ConClrbluelight
                                                : ConClrSelected),
                                      ],
                                    ),
                                    Con_Wid.height(10),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _tabBarWidget(dataWidget) {
    return Container(
      height: 500,
      width: 500,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          dataWidget(),
        ],
      ),
    );
  }

  Widget _Milkinhg() {
    return Container(
      height: 500,
      child: Column(children: [
        SizedBox(
          height: 10,
        ),
        Table(
          children: [
            TableRow(decoration: BoxDecoration(color: Colors.grey), children: [
              Container(
                  alignment: Alignment.center,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text("Date", textAlign: TextAlign.center)),
                      Expanded(
                          child: Text("Morning", textAlign: TextAlign.center)),
                      Expanded(
                          child: Text("Evening", textAlign: TextAlign.center)),
                      Expanded(
                          child: Text("Total", textAlign: TextAlign.center))
                    ],
                  ))
            ]),
            TableRow(children: [
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: MilkingEntry.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: index % 2 == 1 ? Colors.blue.shade200 : null,
                      height: 30,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${MilkingEntry[index].date.toString() == "null" ? MilkingEntry[index].date.toString() : MilkingEntry[index].date.toString().substring(0, 10)}",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${MilkingEntry[index].morningYield}",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${MilkingEntry[index].eveningYield}",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${MilkingEntry[index].dayMilkTotal.toString().contains(".") ? MilkingEntry[index].dayMilkTotal.toString().substring(0, MilkingEntry[index].dayMilkTotal.toString().indexOf(".") + 2) : MilkingEntry[index].dayMilkTotal.toString()}",
                                textAlign: TextAlign.center,
                              ),
                            )
                          ]),
                    );
                  },
                ),
              )
            ])
          ],
        )
      ]),
    );
  }

  Widget _breedingDataNew() {
    return Container(
      height: 500,
      child: ListView.builder(
          itemCount: breedingdetails.length,
          itemBuilder: (BuildContext context, index) {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color:
                      con_clr.ConClr2 ? ConClrLightBack : Colors.blue.shade400,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Con_Wid.gText("Parity"),
                            Con_Wid.gText("DryDate"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "  ${breedingdetails[index].parity}",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "${breedingdetails[index].dateOfDry.toString() == "null" || breedingdetails[index].dateOfDry.toString() == "" ? "" : breedingdetails[index].dateOfDry.toString().substring(0, 10)}  ",
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Container(height: 2, color: ConClrLightBack2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Con_Wid.gText("Calving Date"),
                            Con_Wid.gText("PD Date"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              " ${breedingdetails[index].dateOfCalving.toString().isNotEmpty ? breedingdetails[index].dateOfCalving.toString().substring(0, 10) : ""}",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "${breedingdetails[index].pDDate.toString().isNotEmpty ? breedingdetails[index].dateOfCalving : ""}",
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                        Container(height: 2, color: ConClrLightBack2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Con_Wid.gText("HeatSeq"),
                            Con_Wid.gText("AIT"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "  ${breedingdetails[index].heatSeq}",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "${breedingdetails[index].AITname}  ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }

  Widget Info_tile_wid(Profile_Details e) {
    return Column(
      children: [
        Container(height: 2, color: ConClrLightBack2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Con_Wid.gText("${e.Title1}"),
            Con_Wid.gText("${e.Title2}"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "${e.Value1}",
                style: TextStyle(color: ConClrSelected),
              ),
            ),
            Expanded(
              child: Text(
                "${e.Value2}",
                textAlign: TextAlign.end,
                style: TextStyle(color: ConClrCharred),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _treatmentData() {
    return Container(
      height: 500,
      child: ListView.builder(
          itemCount: tretmentdetails.length,
          itemBuilder: (BuildContext context, index) {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: ConClrLightBack,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Con_Wid.gText("  Visit ID"),
                          Con_Wid.gText("Date  "),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "  ${tretmentdetails[index].visitID}",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${tretmentdetails[index].fromDate.toString() == "null" ? "" : breedingdetails[index].dateOfDry.toString().substring(0, 10)}  ",
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Container(height: 2, color: ConClrLightBack2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("  Doctor"),
                          Text("Diagnosis  "),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " ${tretmentdetails[index].doctor}",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${tretmentdetails[index].diagnosis}",
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                      Container(height: 2, color: ConClrLightBack2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("  Cost"),
                          Text("Medicine  "),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "  ${tretmentdetails[index].cost}",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            //todo medicine
                            "${tretmentdetails[index].details}  ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
          }),
    );
  }
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}

class Profile_Details {
  String Title1;
  String Value1;
  String Title2;
  String Value2;

  Profile_Details({
    required this.Title1,
    required this.Value1,
    required this.Title2,
    required this.Value2,
  });
}
