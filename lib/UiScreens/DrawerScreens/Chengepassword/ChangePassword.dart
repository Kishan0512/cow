import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_NetworkHelp.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Toast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

import '../../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../../component/Gobal_Widgets/Con_Icons.dart';
import '../../Dashboard/Dashboard.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool mBlnShowpassword = false;
  bool mBlnShowConpassword = false;
  bool mBlncurrentpass = true;
  bool mBlncurrentshowpass = false;
  bool mBlnPassword = false;
  bool mBlnConPassword = false;
  TextEditingController current_pass = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController c_pass = TextEditingController();

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
        appBar: Con_Wid.appBar(
          title: "Change Password",
          Actions: [],
          onBackTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return DashBoardScreen();
              },
            ));
          },
        ),
        body: Con_Wid.backgroundContainer(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  height: 150,
                  width: 150,
                  image: AssetImage("assets/images/password.webp")),
              ConTextField(
                Autofocus: true,
                isactive: mBlncurrentpass,
                ObscureText: mBlncurrentshowpass ? false : true,
                Controller: current_pass,
                prefixIcon: Icon(Icons.lock_outlined, color: con_clr.ConClr2 ? whiteColor : mBlncurrentpass ? whiteColor :ConClrDialog),
                SuffixIcon: Con_Wid.mIconButton(
                    onPressed: () {
                      setState(() {
                        mBlncurrentshowpass = !mBlncurrentshowpass;
                      });
                    },
                    icon: mBlncurrentpass
                        ? (mBlncurrentshowpass ? Own_close_eye : Own_open_eye)
                        : Container()),
                HintText: "Enter your Current Paasword",
                Title: "Current Password",
                OnTap: () {
                  setState(() {
                    mBlncurrentpass = true;
                    mBlnPassword = false;
                    mBlnConPassword = false;
                  });
                },
              ),
              ConTextField(
                isactive: mBlnPassword,
                ObscureText: mBlnShowpassword ? false : true,
                Controller: pass,
                prefixIcon:  Icon(Icons.lock_outline, color: con_clr.ConClr2 ?whiteColor : mBlnPassword ? whiteColor :ConClrDialog),
                SuffixIcon: Con_Wid.mIconButton(
                    onPressed: () {
                      setState(() {
                        mBlnShowpassword = !mBlnShowpassword;
                      });
                    },
                    icon: mBlnPassword
                        ? (mBlnShowpassword ? Own_close_eye : Own_open_eye)
                        : Container()),
                HintText: "Type your password",
                Title: "New Password",
                OnTap: () {
                  setState(() {
                    mBlncurrentpass = false;
                    mBlnPassword = true;
                    mBlnConPassword = false;
                  });
                },
              ),
              ConTextField(
                isactive: mBlnConPassword,
                ObscureText: mBlnShowConpassword ? false : true,
                Controller: c_pass,
                prefixIcon:  Icon(Icons.lock_outline , color: con_clr.ConClr2 ? whiteColor : mBlnConPassword ? whiteColor : ConClrDialog),
                SuffixIcon: Con_Wid.mIconButton(
                    onPressed: () {
                      setState(() {
                        mBlnShowConpassword = !mBlnShowConpassword;
                      });
                    },
                    icon: mBlnConPassword
                        ? (mBlnShowConpassword ? Own_close_eye : Own_open_eye)
                        : Container()),
                HintText: "Type your password",
                Title: "Confirm Password",
                OnTap: () {
                  setState(() {
                    mBlncurrentpass = false;
                    mBlnPassword = false;
                    mBlnConPassword = true;
                  });
                },
              ),
              Con_Wid.height(40),
              Con_Wid.MainButton(
                  width: 200,
                  height: 45,
                  fontSize: 16,
                  pStrBtnName: 'Update',
                  OnTap: () async {
                    if (current_pass.text.isEmpty) {
                      CustomToast.show(context, "Please enter current password");
                    } else if (pass.text.isEmpty) {
                      CustomToast.show(context, "Please enter new password");
                    } else if (c_pass.text.isEmpty) {
                      CustomToast.show(context, "Please enter confirm password");
                    } else if (pass.text != c_pass.text) {
                      CustomToast.show(context, "Password mismatch");
                    } else {
                      setState(() {});
                      final res = await ApiCalling.createPost(AppUrl().changedpwd,
                          "Bearer " + Constants_Usermast.token, {
                        "username": Constants_Usermast.user_name,
                        "password": pass.text,
                        "newPassword": c_pass.text,
                      });
                      if (res.statusCode == 200) {
                        CustomToast.show(
                            context, "Password changed successfully");
                        var responseJson = json.decode(res.body);
                        if (responseJson['result']['rowsAffected'][0] == "1") {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return DashBoardScreen();
                            },
                          ));
                        }
                      } else {
                        CustomToast.show(context,
                            "No authorization token found, please retry to login");
                      }
                    }
                  })
            ],
          ),
        )),
      ),
    );
  }
}
