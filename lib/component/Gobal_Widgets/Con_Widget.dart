import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/SyncReport/SyncReport.dart';
import 'package:herdmannew/component/DataBaseHelper/Con_List.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/tost.dart';
import 'package:intl/intl.dart';

import '../../Model_local/Language_model.dart';
import '../../UiScreens/Activity/weights/Monthyearselected.dart';
import '../../UiScreens/DrawerScreens/AllCattleList/CattleStatusTimeline.dart';
import '../DataBaseHelper/Sync_Json.dart';
import 'Con_Icons.dart';
import 'Con_Textstyle.dart';

abstract class Con_Wid {
  static String time = "";
  static String date = "";

  static String Lang_Cng(String pStrValue) {
    if (Con_List.GlbLanguageData.isEmpty) {
      Sync_Json.Get_Master_Data('language');
    }
    List<Language_model> Lang_res = Con_List.GlbLanguageData.where((e) =>
            e.key.toLowerCase() == Constants_Usermast.language.toLowerCase())
        .toList()
        .where((e) =>
            e.engvalue.toLowerCase().trimLeft().trimRight() ==
            pStrValue.toLowerCase().trimLeft().trimRight())
        .toList();
    if (Lang_res.isNotEmpty) {
      return Lang_res.first.Value.toString();
    } else {
      return pStrValue;
    }
  }

  static Widget gText(String pStrValue,
      {TextStyle? style, TextAlign? textAlign}) {
    String Lang_res = Lang_Cng(pStrValue);
    if (Lang_res.isNotEmpty) {
      return Text(
        '${Lang_res}',
        style: style,
        textAlign: textAlign,
      );
    } else {
      return Text(
        '$pStrValue',
        style: style,
        textAlign: textAlign,
      );
    }
  }

  static AppBar appBar(
      {String? cTile,
      required String? title,
      required List<Widget> Actions,
      double? elevation,
      required void Function() onBackTap}) {
    return AppBar(
      leading: mIconButton(onPressed: onBackTap, icon: Own_ArrowBack),
      actions: Actions,
      centerTitle: cTile != null
          ? cTile == ""
              ? true
              : false
          : true,
      elevation: elevation != null ? elevation : 0,
      flexibleSpace: appBarColor(),
      title: gText(
        "$title",
        style: ConStyle.Style_white_16s_700w(),
      ),
    );
  }

  static circal(double pRadius, Color pcolor) {
    return CircleAvatar(
      radius: pRadius,
      backgroundColor: pcolor,
    );
  }

  static height(double height) {
    return SizedBox(
      height: height,
    );
  }

  static width(double width) {
    return SizedBox(
      width: width,
    );
  }

  static Widget popinsfont(String text, Color color, FontWeight fontWeight,
      double fontSize, BuildContext context) {
    return gText(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontFamily: 'Poppins',
        overflow: TextOverflow.ellipsis,
        fontWeight: fontWeight,
        fontStyle: FontStyle.normal,
        fontSize: fontSize * (MediaQuery.of(context).size.width / 3) / 100,
      ),
    );
  }

  static Widget text_font(String text,
      {TextStyle? style, TextAlign? textAlign}) {
    return gText(
      text,
      textAlign: textAlign,
      style: style,
    );
  }

  static div() {
    return const SizedBox(
      height: 30,
      width: 10,
    );
  }

  static InkWell floatingButton(
      {required void Function() onTap,
      required double height,
      required double width}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipOval(
              child: Image.asset("assets/images/floating.webp"),
            ),
          ],
        ),
      ),
    );
  }

  static InkWell floatingButtontimeline12(
      {required void Function() onTap,
      required double height,
      required double width}) {
    return InkWell(
        onTap: onTap,
        child: SizedBox(
            width: width,
            height: height,
            child: Container(
              child: Image.asset("assets/images/add.webp"),
            )));
  }

  static InkWell floatingButtontimeline(
      {required void Function() onTap,
      required double height,
      required double width}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ConClrSelected,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipOval(
              child: Image.asset("assets/images/floatingtimeline.webp",
                  color: whiteColor),
            ),
            const Icon(
              Icons.add,
              color: whiteColor,
              size: 40,
            )
          ],
        ),
      ),
    );
  }

  static Container fullContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 3),
      padding: const EdgeInsets.all(5),
      decoration: con_clr.ConClr2
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: ConClrMainLight,
            )
          : BoxDecoration(),
      child: child,
    );
  }

  static Container fullContainer1({required Widget child}) {
    return Container(
      margin: EdgeInsets.only(bottom: 3),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: ConClrDialog,
      ),
      child: child,
    );
  }

  static Container fullContainerwithborder(
      {required Widget child,
      required double rtop,
      required double ltop,
      required double rbottom,
      required double lbottom}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(rtop),
            topLeft: Radius.circular(ltop),
            bottomRight: Radius.circular(rbottom),
            bottomLeft: Radius.circular(lbottom)),
        color: con_clr.ConClr2 ? ConClrMainLight : whiteColor,
      ),
      child: child,
    );
  }

  static change_date_format(String date) {
    if (date == null ||
        date.toString() == "null" ||
        date == "N/A" ||
        date == "" ||
        date.trim().isEmpty) {
      return DateTime.now().toString();
    }

    var dateFormat = DateFormat('yyyy-MM-dd');
    try {
      var utcDate = "${date}T00:00:00.000Z"; // add UTC time zone
      var dateTime =
          dateFormat.parse(utcDate).toLocal(); // convert to local time zone
      return dateFormat.format(dateTime);
    } catch (e) {
      print(e);
      return "N/A";
    }
  }

  static Container backgroundContainer({required Widget child}) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(6),
      decoration: containerBackGroundColor(),
      child: child,
    );
  }

  static BoxDecoration containerBackGroundColor() {
    return con_clr.ConClr2
        ? const BoxDecoration(
            // color: ConClrMain,
            gradient: LinearGradient(
                colors: ConClrMainGreadiant,
                transform: GradientRotation(1),
                begin: Alignment(-2, 0),
                end: Alignment(2, 0)))
        : BoxDecoration(color: whiteColor1);
  }

  static paddingWithText(String txt, pClr,
      {double pIntPadding = 0, required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(left: (pIntPadding == 0 ? 25 : pIntPadding)),
      child: Con_Wid.popinsfont(txt, pClr, FontWeight.w600, 11, context),
    );
  }

  static Datepickerwithtime(
      {void Function(Object)? Onchanged,
      TextEditingController? controller,
      required String hintText,
      required BuildContext context}) {
    return Container(
      height: 45,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8, right: 10, left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        border: Border.all(
          width: 2,
          color: ConClrborderdrop,
        ),
      ),
      child: TextField(
        onChanged: Onchanged ?? (value) {},
        readOnly: true,
        controller: controller,
        style: googleInterFont(),
        onTap: () {
          showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now())
              .then((value) {
            showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 12, minute: 00))
                .then((value1) {

              controller?.text =
                  "${value.toString().substring(0, 10)} ${value1!.hour}:${value1.minute}:00.000";
            });
          });
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: Lang_Cng(hintText),
          hintStyle: googleInterFont(),
        ),
      ),
    );
  }

  static onlyreadContainer(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: 45,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8, right: 10, left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        border: Border.all(
          width: 2,
          color: ConClrborderdrop,
        ),
      ),
      child: gText(text, style: const TextStyle(color: ConClrBtntxt)),
    );
  }

  static textFieldWithInter(
      {String? text,
      bool? readonly,
      Widget? Trealing,
      void Function(Object)? Onchanged,
      required TextEditingController? controller,
      TextInputType? TextInput_Type,
      Color? color1,
      String? eRror,
      double? width,
      required String hintText}) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Container(
            height: eRror != null ?60 : 45 ,
            width: width ?? double.infinity - 100,
            child: TextField(
              readOnly: readonly == null ? false : true,
              keyboardType: TextInput_Type ?? TextInputType.text,
              controller: controller,
              style: TextStyle(
                color:
                    con_clr.ConClr2 ? color1 ?? ConClrborderdrop : BlackColor,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
              ),
              onChanged: Onchanged ?? (value) {},
              decoration: InputDecoration(
                suffix: Trealing,
                errorStyle: TextStyle(fontSize: 11),
                errorText: eRror != "" ? eRror : null,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                hintText: Lang_Cng(hintText),
                labelText: Lang_Cng(hintText),
                labelStyle: TextStyle(
                  color:
                      con_clr.ConClr2 ? color1 ?? ConClrborderdrop : BlackColor,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
                hintStyle: TextStyle(
                  color:
                      con_clr.ConClr2 ? color1 ?? ConClrborderdrop : BlackColor,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static textFieldWithIntersmall(
      TextEditingController? controller, String hinttext) {
    return Expanded(
      child: Container(
        height: 38,
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          border: Border.all(
            width: 2,
            color: con_clr.ConClr2 ? ConClrLightBack : ConClrSelected,
          ),
        ),
        child: TextFormField(
          textAlign: TextAlign.center,
          controller: controller,
          style: googleInterFont(),
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintStyle: googleInterFont(),
              hintText: Lang_Cng(hinttext)),
        ),
      ),
    );
  }

  static googleInterFont() {
    return const TextStyle(
      color: ConClrBtntxt,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 14,
    );
  }

  static Container appBarColor() {
    return con_clr.ConClr2
        ? Container(
            decoration: const BoxDecoration(
                // color: ConClrLightBack,
                gradient: LinearGradient(
                    colors: ConClrAppbarGreadiant,
                    transform: GradientRotation(1.55),
                    begin: Alignment(-1, 0))),
          )
        : Container(
            decoration: const BoxDecoration(
                // color: ConClrLightBack,
                color: ConClrSelected),
          );
  }



  static Widget gLineDivider() {
    return const Divider(
      color: Colors.white,
      height: 1,
      thickness: 1,
      indent: 10,
      endIndent: 15,
    );
  }

  static Sync_Dialog({
    required BuildContext context,
  }) {
    Dialog errorDialog = Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 250,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    gText(
                      'Warning !!!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    gText(
                      'There are some data which is not yet synced to Server',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    MainButton(
                        OnTap: () {
                          Sync_report.getdata().then((value) {
                            Sync_report.Sync_data().then((value) {
                              Navigator.of(context).pop();
                            });
                          });
                        },
                        pStrBtnName: Lang_Cng('Sync Now'),
                        height: 40,
                        width: 120,
                        fontSize: 16),
                  ],
                ),
              ),
            ),
            Positioned(
                top: -40,
                child: CircleAvatar(
                  backgroundColor: ConClrSelected,
                  radius: 40,
                  child: Icon(
                    Icons.assistant_photo,
                    color: Colors.white,
                    size: 40,
                  ),
                )),
          ],
        ));
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => errorDialog);
  }

  static Nointernet({
    required String id,
    required BuildContext context,
  }) {
    Dialog errorDialog = Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 250,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    gText(
                      'Warning !!!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    gText(
                      'There is no internet Connection,\nYour data save go to sync report',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    MainButton(
                        OnTap: () {
                          Sync_report.getdata().then((value) {
                            Sync_report.Sync_data().then((value) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return cattlestatustimeline(
                                    index: id,
                                  );
                                },
                              ));
                            });
                          });
                        },
                        pStrBtnName: Lang_Cng('Sync Now'),
                        height: 40,
                        width: 120,
                        fontSize: 16),
                  ],
                ),
              ),
            ),
            Positioned(
                top: -40,
                child: CircleAvatar(
                  backgroundColor: ConClrSelected,
                  radius: 40,
                  child: Icon(
                    Icons.assistant_photo,
                    color: Colors.white,
                    size: 40,
                  ),
                )),
          ],
        ));
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => errorDialog);
  }

  static showTypesDetailContainer(String text, BuildContext context) {
    return Container(
      height: 45,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
      decoration: BoxDecoration(
        color: con_clr.ConClr2 ? ConClrbluelight : ConClrDialog,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Con_Wid.popinsfont(
              text, Colors.white, FontWeight.w600, 11, context)),
    );
  }
  static selectionContainer1({
    Color? textcolor,
    required String text,
    required void Function() ontap,
    required Color,
    required double height,
    required double width,
    required BuildContext context,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 1, bottom: 1),
          decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: con_clr.ConClr2 ? Colors.grey : ConClrSelected),
            color: Color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Con_Wid.popinsfont(
              text, textcolor ?? Colors.white, FontWeight.w600, 9, context),
        ),
      ),
    );
  }
  static selectionContainer({
    Color? textcolor,
    required String text,
    required void Function() ontap,
    required Color,
    required double height,
    required double width,
    required BuildContext context,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 1, bottom: 1),
          decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: con_clr.ConClr2 ? Colors.grey : ConClrSelected),
            color: Color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Con_Wid.popinsfont(
              text, textcolor ?? Colors.white, FontWeight.w600, 11, context),
        ),
      ),
    );
  }

  static selectionContainerforblack({
    required String text,
    required void Function() ontap,
    required Color,
    required Color fontcolor,
    required double height,
    required double width,
    required BuildContext context,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: Color,
            borderRadius: BorderRadius.circular(10),
          ),
          child:
              Con_Wid.popinsfont(text, fontcolor, FontWeight.w600, 13, context),
        ),
      ),
    );
  }

  static Widget AnimSyncBtn(
      {required AnimationController controller,
      required void Function() OnTap}) {
    return GestureDetector(
      onTap: OnTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 30,
        width: 30,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/sync (2).webp"))),
        child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            return Transform.rotate(
                angle: controller.value * 2 * math.pi,
                child: Image.asset("assets/images/sync (1).webp"));
          },
        ),
      ),
    );
  }

  static containerWith12Border(double height, List<Widget> children) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: height,
            width: double.infinity,
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0XFFA5C7F6),
              border: Border.all(
                width: 10,
                color: const Color(0XFFE9F0F9),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  static void Con_Show_Toast(BuildContext context, String message,
      [MaterialColor color = Colors.red]) {
    Toast.show(context, "$message");
  }

  static Keybord({required BuildContext context}) {
    bool _keyboardVisible = false;
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return _keyboardVisible;
  }

  static Future GlbDatePicker(
      {String? first,
      String? formate,
      bool? isdatetime,
      required BuildContext pcontext}) async {
    DateTime pickedDate = await showDatePicker(
            context: pcontext,
            initialDate: DateTime.now(), //get today's date
            firstDate: first != null
                ? DateTime.parse(first)
                : DateTime(
                    2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime.now()) ??
        DateTime.now();
    String formattedDate = formate != null
        ? DateFormat('yyyy-MM-dd').format(pickedDate)
        : DateFormat('MM/dd/yyyy HH:mm').format(
            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
    return (isdatetime ?? false) ? pickedDate.toString() : formattedDate.toString();
  }

  static ConLoding(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      barrierColor: ConClrLodingback,
      context: context,
      builder: (context) => Center(
        child: Con_Loding(),
      ),
    );
  }

  static Widget Con_Loding() {
    return Container(
      width: 200,
      height: 60.0,
      decoration: con_clr.ConClr2
          ? BoxDecoration(
              // color: ConClrLightBack,
              gradient: const LinearGradient(colors: ConClrAppbarGreadiant),
              borderRadius: BorderRadius.circular(4.0),
            )
          : BoxDecoration(
              color: ConClrSelected,
              borderRadius: BorderRadius.circular(4.0),
            ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Image.asset('assets/images/Loding.gif',
                gaplessPlayback: true, width: 40, height: 40),
            width(10),
            Center(
              child: gText(
                "Please Wait...",
                style: const TextStyle(
                  inherit: false,
                  fontSize: 15,
                  color: whiteColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget mIconButton(
      {required void Function() onPressed,
      required Widget icon,
      double? iconSize,
      VisualDensity? VisualDensity,
      Color? color}) {
    return IconButton(
      visualDensity: VisualDensity,
      onPressed: onPressed,
      icon: icon,
      splashRadius: 18,
      iconSize: iconSize,
      color: color,
    );
  }


  static Widget MainButton({
    bool? Rounded,
    bool? Selected,
    required void Function() OnTap,
    required String pStrBtnName,
    required double height,
    required double width,
    bool? isborder,
    required double fontSize,
  }) {
    isborder = isborder ?? false;
    return InkWell(
      splashColor: ConClrMain,
      onTap: OnTap,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(2),
        decoration: con_clr.ConClr2
            ? const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                gradient: LinearGradient(
                    colors: ConClrAppbarGreadiant,
                    transform: GradientRotation(4.7)))
            : const BoxDecoration(),
        // color: ConClrBtn,
        child: Container(
          alignment: Alignment.center,
          height: height,
          width: width,
          decoration: con_clr.ConClr2
              ? const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ConClrMain,
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 5),
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  gradient: LinearGradient(
                      colors: ConClrMainGreadiant,
                      transform: GradientRotation(1.55)),
                  // color: ConClrBtn,
                )
              : const BoxDecoration(
                  color: ConClrSelected,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
              child: gText(
            pStrBtnName,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: ConClrMainBtn,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                height: 1),
          )),
        ),
      ),
    );
  }

  static Datepicker(TextEditingController? controller, String hintText,
      BuildContext context, String Date) {
    DateTime? _selected;
    int _currentYear;
    _currentYear = DateTime.now().year;
    int firstYear = 2000;
    int lastYear = DateTime.now().year;
    return Container(
      height: 45,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8, right: 10, left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        border: Border.all(
          width: 2,
          color: ConClrborderdrop,
        ),
      ),
      child: TextFormField(
        readOnly: true,
        controller: controller,
        style: googleInterFont(),
        onTap: () {
          if (Date == "Time") {
            showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now())
                .then((value) {
              String hour = value!.hourOfPeriod.toString().padLeft(2, '0');
              String minute = value.minute.toString().padLeft(2, '0');
              String period = value.period == DayPeriod.am ? 'AM' : 'PM';
               controller?.text = "$hour:$minute";
            });
          }
          if (Date == "Date") {
            showDatePicker(
                    context: context,
                    initialDate: _selected ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now())
                .then((value) {
              controller?.text = "${value?.year}/${value?.month}/${value?.day}";
            });
          }
          if (Date == "Month") {
            showMonthYearPicker(
                    context: context,
                    initialDate: _selected ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now())
                .then((value) {
              controller?.text = "${value?.year}/${value?.month}";
            });
          }
          if (Date == "Year") {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                    child: Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: lastYear - firstYear + 1,
                    itemBuilder: (BuildContext context, int index) {
                      final year = firstYear + index;
                      return InkWell(
                        onTap: () {
                          _currentYear = year;
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          color:
                              year == _currentYear ? Colors.blue : Colors.white,
                          child: Text(
                            year.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: year == _currentYear
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ));
              },
            );
          }
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: Lang_Cng(hintText),
          hintStyle: googleInterFont(),
        ),
      ),
    );
  }
}

class Con_CheckBoxList extends StatefulWidget {
  List<String> itemlist;
  bool? isMultiSelect;
  List<String> pListSelected;
  ValueChanged<List<String>> onSelected;
  Widget? sec_Widget;

  Con_CheckBoxList(
      {required this.itemlist,
      this.sec_Widget,
      this.isMultiSelect,
      required this.pListSelected,
      required this.onSelected});

  @override
  State<Con_CheckBoxList> createState() => _Con_CheckBoxListState();
}

class _Con_CheckBoxListState extends State<Con_CheckBoxList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isMultiSelect==true)
    {
      if(!widget.itemlist.contains("Select all"))
      widget.itemlist.insert(0, "Select all");
    }
  }
  @override
  Widget build(BuildContext context) {
    widget.isMultiSelect = widget.isMultiSelect ?? false;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.itemlist.length,
      itemBuilder: (context, index) {
        return Material(
          color: Colors.transparent,
          child: CheckboxListTile(

              visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity),
              controlAffinity: ListTileControlAffinity.leading,
              secondary: widget.sec_Widget,
              checkColor: con_clr.ConClr2 ? ConClrMainLight : whiteColor,
              activeColor: con_clr.ConClr2 ? ConClrLightBack : ConClrSelected,
              title: Text(widget.itemlist[index]),
              value: widget.pListSelected.contains(widget.itemlist[index]),
              onChanged: (value) {
                if(widget.isMultiSelect==true && index==0)
                  {
                    if(value!)
                      {
                        setState(() {
                          widget.pListSelected.addAll(widget.itemlist);
                        });
                      }else {

                      if (widget.pListSelected.contains(widget.itemlist[index])) {

                        setState(() {
                          widget.pListSelected.removeRange(0, widget.pListSelected.length);
                        });
                      }
                    }
                  }else {
                  if (!widget.isMultiSelect!) {
                    widget.pListSelected.clear();
                  ;
                  }
                  if (value!) {

                    if (!widget.pListSelected.contains(
                        widget.itemlist[index])) {

                      setState(() {
                        widget.pListSelected.add(widget.itemlist[index]);
                      });
                    }
                  } else {

                    if (widget.pListSelected.contains(widget.itemlist[index])) {

                      setState(() {
                        widget.pListSelected.removeWhere(
                                (String city) =>
                            city == widget.itemlist[index]);
                      });
                    }
                  }
                }
                widget.onSelected(widget.pListSelected);

              }),
        );
      },
    );
  }
}

class ConTextField extends StatefulWidget {
  bool isactive;
  String Title;
  TextEditingController Controller;
  String HintText;
  Widget? prefixIcon;
  bool? ObscureText;
  Widget? SuffixIcon;
  bool? Autofocus;
  void Function() OnTap;
  void Function(PointerDownEvent)? Ontapout;
  void Function(String)? Onsubmit;
  void Function(String)? Onchanged;

  ConTextField(
      {required this.isactive,
      required this.Title,
      required this.Controller,
      required this.HintText,
      this.prefixIcon,
      this.Onchanged,
      required this.OnTap,
      this.ObscureText,
      this.Autofocus,
      this.SuffixIcon,
      this.Onsubmit,
      this.Ontapout});

  @override
  State<ConTextField> createState() => _ConTextFieldState();
}

class _ConTextFieldState extends State<ConTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 60,
      decoration: widget.isactive
          ? BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                    color: con_clr.ConClr2
                        ? Color.fromRGBO(0, 0, 0, 0.25)
                        : Color.fromRGBO(18, 121, 215, 0.3),
                    offset: Offset(0, 4),
                    blurRadius: 104)
              ],
              color: con_clr.ConClr2 ? ConClrBtnlow : ConClrSelected,
            )
          : const BoxDecoration(),
      child: Center(
        child: TextField(
          onTapOutside: widget.Ontapout,
          onChanged: widget.Onchanged,
          onSubmitted: widget.Onsubmit,
          autofocus: widget.Autofocus ?? false,
          onTap: widget.OnTap,
          obscureText: widget.ObscureText ?? false,
          cursorColor: CursorColor,
          controller: widget.Controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: Con_Wid.Lang_Cng(widget.Title),
            labelStyle: TextStyle(
              color: con_clr.ConClr2
                  ? ConClrWhite50
                  : widget.isactive
                      ? whiteColor
                      : ConClrSelected,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.SuffixIcon,
            suffixIconColor: whiteColor,
            hintText: Con_Wid.Lang_Cng(widget.HintText),
            hintStyle: const TextStyle(
              color: whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: TextStyle(
            color: con_clr.ConClr2
                ? whiteColor
                : widget.isactive
                    ? whiteColor
                    : ConClrSelected,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class CondropDown extends StatefulWidget {
  String title;
  String? value;
  bool? isMultiSelect;
  bool? outside;
  bool? Error;
  Color? color1;
  List<String> itemList;
  List<String> SelectedList;
  ValueChanged<List<String>> onSelected;

  CondropDown({
    this.color1,
    this.isMultiSelect,
    this.Error,
    this.value,
    this.outside,
    required this.title,
    required this.itemList,
    required this.SelectedList,
    required this.onSelected,
  });

  @override
  State<CondropDown> createState() => _CondropDownState();
}

class _CondropDownState extends State<CondropDown> {
  bool searchlot = false;
  final TextEditingController _txtInput = TextEditingController();
  List<String> mListSelected = [];
  List<String> mListAll = [];
  bool Selected = false;

  @override
  void initState() {
    super.initState();
    mListSelected = widget.SelectedList;
    if(widget.outside==true){
      get();
    }
  }
get(){
  Selected=true;
  mListSelected.add(widget.value.toString());

}
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        mListAll = widget.itemList;
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState1) {
                return Material(
                  color: Colors.transparent,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: con_clr.ConClr2 ? 220 : 150),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 20),
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
                                if (searchlot)
                                  Container(
                                    height: 50,
                                    width: 200,
                                    child: ConTextField(
                                      Autofocus: true,
                                      Onchanged: (value) {
                                        setState1(() {
                                          widget.itemList = mListAll
                                              .where((e) => e
                                                  .toLowerCase()
                                                  .contains(
                                                      value.toLowerCase()))
                                              .toList();
                                          setState1(() {});
                                        });
                                      },
                                      isactive: true,
                                      Title: Con_Wid.Lang_Cng("Search"),
                                      Controller: _txtInput,
                                      prefixIcon: Own_Search_White,
                                      OnTap: () {},
                                      HintText: '',
                                    ),
                                  )
                                else
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 10),
                                    child: Con_Wid.gText(
                                      widget.title,
                                      style: ConStyle.style_white_14s_500w(),
                                    ),
                                  ),
                                Con_Wid.mIconButton(
                                    onPressed: () {
                                      if (searchlot) {
                                        setState1(() {
                                          searchlot = false;
                                          _txtInput.clear();
                                        });
                                      } else {
                                        setState1(() {
                                          setState(() {
                                            widget.itemList = mListAll;
                                            searchlot = true;
                                          });
                                        });
                                      }
                                    },
                                    icon: searchlot
                                        ? Own_Close_white
                                        : Own_Search_White)
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
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Con_CheckBoxList(
                                        isMultiSelect: widget.isMultiSelect,
                                        itemlist: widget.itemList,
                                        pListSelected: mListSelected,
                                        onSelected: (value) {
                                          mListSelected = value;
                                        },
                                      ),
                                    ),
                                    Con_Wid.height(10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Con_Wid.selectionContainer(
                                            height: 38,
                                            width: 87,
                                            text: "Cancel",
                                            ontap: () {
                                              if (mListSelected.isNotEmpty) {
                                                mListSelected.clear();
                                              }
                                              Selected = false;
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            textcolor: con_clr.ConClr2
                                                ? whiteColor
                                                : ConClrSelected,
                                            Color: con_clr.ConClr2
                                                ? ConClrLightBack
                                                : whiteColor,
                                            context: context),
                                        Con_Wid.width(10),
                                        Con_Wid.selectionContainer(
                                            height: 38,
                                            width: 87,
                                            text: "Ok",
                                            ontap: () {
                                              if (mListSelected.isNotEmpty) {
                                                Selected = true;
                                                widget.onSelected.call(mListSelected);
                                                setState(() {});
                                              }
                                              Navigator.pop(context);
                                            },
                                            textcolor: whiteColor,
                                            Color: con_clr.ConClr2
                                                ? ConClrbluelight
                                                : ConClrSelected,
                                            context: context),
                                        Con_Wid.width(10),
                                      ],
                                    ),
                                    Con_Wid.height(10),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      child: Container(
        height: Selected
            ? 43
            : widget.Error == true
                ? 43
                : 30,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: con_clr.ConClr2
                      ? widget.color1 != null
                          ? widget.color1!
                          : ConClrborderdrop
                      : BlackColor,
                  width: 1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Selected
                ? Row(
                    children: [
                      Con_Wid.gText(
                        widget.title,
                        style: TextStyle(
                            fontSize: 12,
                            color: con_clr.ConClr2
                                ? widget.color1 ?? ConClrborderdrop
                                : Colors.black54),
                      )
                    ],
                  )
                : widget.Error == true
                    ? Row(
                        children: [
                          Con_Wid.gText(
                            widget.title,
                            style:
                                TextStyle(fontSize: 12, color: ConClrpending),
                          )
                        ],
                      )
                    : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 7,
                  child: Con_Wid.gText(
                    (mListSelected.isEmpty
                        ? widget.title
                        : mListSelected
                            .toString()
                            .replaceAll("[", '')
                            .replaceAll("]", '')),
                    style: ConStyle.Style_white_14s_700w(con_clr.ConClr2
                        ? widget.color1 != null
                            ? widget.color1!
                            : ConClrborderdrop
                        : BlackColor),
                  ),
                ),
                Expanded(
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 18,
                    color: con_clr.ConClr2 ? ConClrMain : BlackColor,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Datepicker extends StatefulWidget {
  TextEditingController? controller;
  String hintText;
  String Date;

  Datepicker(this.controller, this.hintText, this.Date);

  @override
  State<Datepicker> createState() => _DatepickerState();
}

class _DatepickerState extends State<Datepicker> {
  DateTime? _selected;
  int _currentYear = DateTime.now().year;
  int firstYear = 2000;
  int lastYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8, right: 10, left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        border: Border.all(
          width: 2,
          color: ConClrborderdrop,
        ),
      ),
      child: TextFormField(
        readOnly: true,
        controller: widget.controller,
        style: Con_Wid.googleInterFont(),
        onTap: () {
          if (widget.Date == "Date") {
            showDatePicker(
                    context: context,
                    initialDate: _selected ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now())
                .then((value) {
              widget.controller?.text =
                  "${value?.year}/${value?.month}/${value?.day}";
            });
          }
          if (widget.Date == "Month") {
            showMonthYearPicker(
                    context: context,
                    initialDate: _selected ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now())
                .then((value) {
              widget.controller?.text =
                  "${value?.year}/${value?.month}/${value?.day}";
            });
          }
          if (widget.Date == "Year") {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    height: 200,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel")),
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("ok"))
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: lastYear - firstYear + 1,
                            itemBuilder: (BuildContext context, int index) {
                              final year = firstYear + index;
                              return InkWell(
                                onTap: () {
                                  _currentYear = year;
                                  widget.controller?.text = year.toString();
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  color: year == _currentYear
                                      ? Colors.blue
                                      : Colors.white,
                                  child: Text(
                                    year.toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: year == _currentYear
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ));
              },
            );
          }
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: Con_Wid.Lang_Cng(widget.hintText),
          hintStyle: Con_Wid.googleInterFont(),
        ),
      ),
    );
  }
}

DateTime Now = DateTime.now();
DateFormat DTF = DateFormat('MMM dd yyyy');
DateFormat DayF = DateFormat('EEEE');

DateFilter(String pStrDate) {
  pStrDate == GetDayDate(0)
      ? pStrDate = 'Today'
      : pStrDate == GetDayDate(1)
          ? pStrDate = 'Yesterday'
          : pStrDate == GetDayDate(2)
              ? pStrDate = GetDay(2)
              : pStrDate == GetDayDate(3)
                  ? pStrDate = GetDay(3)
                  : pStrDate == GetDayDate(4)
                      ? pStrDate = GetDay(4)
                      : pStrDate == GetDayDate(5)
                          ? pStrDate = GetDay(5)
                          : pStrDate == GetDayDate(6)
                              ? pStrDate = GetDay(6)
                              : pStrDate = pStrDate;

  return pStrDate;
}

GetDayDate(int Day) {
  if (Day == 0) {
    return DTF.format(Now);
  } else {
    return DTF.format(Now.subtract(Duration(days: Day))).toString();
  }
}

GetDay(int Day) {
  if (Day > 1) {
    return DayF.format(DTF.parse(GetDayDate(Day)));
  }
}

class Choice_Chip extends StatefulWidget {
  List<String> ButtonName;
  ValueChanged<String> onSelected;
  Color BackClr, RoundClr, SelectedBackClr, SelectedRoundClr;
  String? StrDefault;
  int? indexdefault;

  Choice_Chip(
      {required this.ButtonName,
      required this.onSelected,
      required this.BackClr,
      required this.RoundClr,
      required this.SelectedBackClr,
      required this.SelectedRoundClr,
      this.StrDefault,
      this.indexdefault});

  @override
  State<Choice_Chip> createState() => _Choice_ChipState();
}

class _Choice_ChipState extends State<Choice_Chip> {
  List<bool> Selected = [];
  String StrDefault = '';

  @override
  void initState() {
    super.initState();
    Selected = List.filled(widget.ButtonName.length, false);
    setState(() {
      StrDefault = widget.StrDefault ?? '';
      if (StrDefault.isNotEmpty) {
        Selected[widget.ButtonName.indexOf(StrDefault)] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.ButtonName.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: () {
                setState(() {
                  Selected = List.filled(widget.ButtonName.length, false);
                  Selected[index] = true;
                });
                widget.onSelected.call(widget.ButtonName[index]);
              },
              child: Container(
                height: 28,
                width: 22 +
                    (widget.ButtonName[index].length > 4
                        ? (widget.ButtonName[index].length * 12)
                        : (widget.ButtonName[index].length * 18)),
                // width: 24 + (widget.ButtonName[index].length * 16),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 1,
                          offset: Offset(0, 3))
                    ],
                    color: Selected[index]
                        ? widget.SelectedBackClr
                        : widget.BackClr,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: widget.RoundClr)),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 22,
                        width: 22,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            color: Selected[index]
                                ? widget.SelectedRoundClr
                                : widget.RoundClr,
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                            child: Selected[index]
                                ? const Icon(
                                    Icons.done_rounded,
                                    size: 20,
                                    color: Colors.white,
                                  )
                                : Container()),
                      ),
                      Expanded(
                          flex: 3,
                          child: Con_Wid.gText(widget.ButtonName[index],
                              style: TextStyle(
                                  color: Selected[index]
                                      ? Colors.white
                                      : widget.SelectedRoundClr))),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Anim_Filter extends StatefulWidget {
  List<Widget> Children;
  ValueChanged<bool> SelectedCall;
  bool selected;

  Anim_Filter(
      {required this.Children,
      required this.selected,
      required this.SelectedCall});

  @override
  State<Anim_Filter> createState() => _Anim_FilterState();
}

class _Anim_FilterState extends State<Anim_Filter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  widget.selected = !widget.selected;
                  widget.SelectedCall.call(widget.selected);
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      )
                    ],
                    color: Color(0xFF1E4468),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                height: 40,
                width: 40,
                child: Icon(Icons.filter_alt_rounded, color: Colors.white),
              ),
            ),
            AnimatedContainer(
              margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    )
                  ],
                  color:
                      widget.selected ? Color(0xFFDBE7F9) : Color(0xFFDBE7F9),
                  border: Border.all(width: 2, color: Colors.white)),
              width:
                  widget.selected ? 0 : MediaQuery.of(context).size.width / 1.5,
              height: widget.selected
                  ? MediaQuery.of(context).size.height / 3
                  : MediaQuery.of(context).size.height / 3,
              alignment: widget.selected
                  ? Alignment.center
                  : AlignmentDirectional.topCenter,
              duration: const Duration(milliseconds: 700),
              curve: Curves.fastOutSlowIn,
              child: Column(children: widget.Children),
            )
          ]),
    );
  }
}
