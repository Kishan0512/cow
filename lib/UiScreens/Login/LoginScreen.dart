// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_ApiUrl.dart';
import 'package:herdmannew/component/A_SQL_Trigger/page_login.dart';
import 'package:herdmannew/component/A_SQL_Trigger/page_permission.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Icons.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';
import 'package:herdmannew/component/Gobal_Widgets/Constants.dart';

import '../../camera.dart';
import '../../component/DataBaseHelper/Sync_Database.dart';
import '../../component/Gobal_Widgets/Con_Color.dart';
import '../Dashboard/Dashboard.dart';
import '../DrawerWidget.dart';
import '../Register/Register.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool mBlnShowpassword = false;
  bool isupdate = false;
  bool mBlnUsername = true;
  bool mBlnPassword = false;
  bool isLoading = false;
  double progress = 0.00;
  double withs = 0.0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.delayed(const Duration(milliseconds: 200), () {
          SystemNavigator.pop();
          return true;
        });
      },
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              alignment: Alignment.center,
              children: [
                Con_Wid.backgroundContainer(
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          child: Image.asset(
                              color: ConClrSelected,
                              fit: BoxFit.fill,
                              "assets/images/loginImage.webp")),
                      Expanded(
                        child: SizedBox(
                            height: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Con_Wid.gText("Login",
                                    style: TextStyle(
                                      color: con_clr.ConClr2
                                          ? Colors.white
                                          : ConClrSelected,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700,
                                    ))
                              ],
                            )),
                      ),
                      Expanded(
                        child: ConTextField(
                          Ontapout: (p0) {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus &&
                                currentFocus.focusedChild != null) {
                              currentFocus.focusedChild?.unfocus();
                            }
                          },
                          Autofocus: true,
                          isactive: mBlnUsername,
                          Controller: email,
                          prefixIcon: Icon(Icons.person_outline,
                              color: con_clr.ConClr2
                                  ? whiteColor
                                  : mBlnUsername
                                      ? whiteColor
                                      : ConClrSelected),
                          HintText: "Type your username",
                          Title: "Username",
                          OnTap: () {
                            setState(() {
                              mBlnUsername = true;
                              mBlnPassword = false;
                            });
                          },
                        ),
                      ),
                      Con_Wid.height(10),
                      Expanded(
                        child: ConTextField(
                          Ontapout: (p0) {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus &&
                                currentFocus.focusedChild != null) {
                              currentFocus.focusedChild?.unfocus();
                            }
                          },
                          isactive: mBlnPassword,
                          ObscureText: mBlnShowpassword ? false : true,
                          Controller: pass,
                          prefixIcon: Icon(Icons.lock_outline,
                              color: con_clr.ConClr2
                                  ? whiteColor
                                  : mBlnPassword
                                      ? whiteColor
                                      : ConClrSelected),
                          SuffixIcon: Con_Wid.mIconButton(
                              onPressed: () {
                                setState(() {
                                  mBlnShowpassword = !mBlnShowpassword;
                                });
                              },
                              icon: mBlnPassword
                                  ? (mBlnShowpassword
                                      ? Own_close_eye
                                      : Own_open_eye)
                                  : Container()),
                          HintText: "Type your password",
                          Title: "Password",
                          OnTap: () {
                            setState(() {
                              mBlnPassword = true;
                              mBlnUsername = false;
                            });
                          },
                        ),
                      ),
                      Con_Wid.height(30),
                      AnimatedButton(
                          color: ConClrSelected,
                          width: 240,
                          height: 51,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () async {
                            if (email.text.isNotEmpty && pass.text.isNotEmpty) {
                              await DrawerWidget.dbclear();
                              if (await api_page_login.logincheck(
                                  email.text.trim(), pass.text.trim())) {
                                setState(() {
                                  isLoading = true;
                                });
                                SyncDB.SyncUserData();
                                await getLanguage().then((value) async {
                                  await SyncDB.SyncTable("OneTimeData", true);
                                  loadallData().then((value) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DashBoardScreen()));
                                  });
                                });
                              } else {
                                if(AppUrl.issuspend.value==true)
                                  {
                                    Con_Wid.Con_Show_Toast(context,
                                        'User is suspend');
                                    AppUrl.issuspend.value=false;
                                  }else{
                                  Con_Wid.Con_Show_Toast(context,
                                      "it's worng user id or password");
                                }

                              }
                            } else {
                              Con_Wid.Con_Show_Toast(
                                  context, 'Please Fill All Field');
                            }
                          }),
                      Con_Wid.height(30),
                      InkWell(
                        onTap: () async {
                          signInWithGoogle().then((value) async {
                            User? user = FirebaseAuth.instance.currentUser;
                            if (user!.email.toString().isNotEmpty) {
                              await DrawerWidget.dbclear();
                              if (await api_page_login.logincheck(
                                  user.email.toString(), "welcome@123")) {
                                setState(() {
                                  isLoading = true;
                                });
                                SyncDB.SyncUserData();
                                await getLanguage().then((value) async {
                                  await SyncDB.SyncTable("OneTimeData", true);
                                  loadallData().then((value) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DashBoardScreen()));
                                  });
                                });
                              } else {
                                Con_Wid.Con_Show_Toast(context,
                                    "it's wrong user id or password");
                              }
                            } else {
                              Con_Wid.Con_Show_Toast(
                                  context, 'Please Fill All Field');
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          height: 30,
                          width: MediaQuery.of(context).size.width / 2,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/google.webp")),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Text("Login with Gmail"),
                              ]),
                        ),
                      ),
                      Expanded(flex: 2, child: Container()),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Con_Wid.gText("Don’t have an account?",
                                style: TextStyle(
                                    color: con_clr.ConClr2
                                        ? whiteColor
                                        : BlackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Register()));
                              },
                              child: Con_Wid.gText("Sign up",
                                  style: TextStyle(
                                      color: con_clr.ConClr2
                                          ? Conclrfontmain
                                          : ConClrSelected,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),
                      Con_Wid.height(30),
                    ],
                  ),
                ),
                isLoading
                    ? Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.transparent.withOpacity(0.5),
                        child: Center(
                          child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width - 50,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFCCCCCC),
                                    borderRadius: BorderRadius.circular(20)),
                                alignment: Alignment.centerLeft,
                                height: 40,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Align(
                                  child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        AnimatedContainer(
                                          height: 40,
                                          width: withs,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF004F9E),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          duration: Duration(microseconds: 250),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                "${progress == 0.00 ? progress.toString().substring(0, 3) : progress.toString().substring(0, 4)} %",
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontSize: 15)),
                                          ],
                                        )
                                      ]),
                                ),
                              )),
                        ),
                      )
                    : Container(),
              ],
            )),
      ),
    );
  }

  Future getLanguage() async {
    List Language = [
      "Gujrathi",
      "hindi",
      "Punjabi",
      "Russian",
      "Kannada",
      "Marathi",
      "Tamil"
    ];
    Language.forEach((element) async {
      await SyncDB.language(element);
    });
  }

  _SyncDrawerMenu() async {
    Constants.Page_PermissionList =
        await api_page_permission.GetPagePermission();
    // await SyncDB.GetTable(Constants.Tbl_Page_Permission);
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> loadallData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final tables = [
        "OneTimeData",
        "MASTER_DATA",
        "Milk_production_id",
        "sireStock",
        "Master_Farmer",
        "Master_lot",
        "Breeding_reproduction_id",
        "Animal_Details_id",
        "VISITREGISTRATION",
        "Vehicle_purpose",
        "Vehicle_data"
      ];

      final totalTables = tables.length;
      double completedTables = 0.00;

      for (final table in tables) {
        await SyncDB.SyncTable(table, true);
        completedTables++;
        setState(() {
          progress = completedTables / totalTables * 100;
          withs = (progress * (MediaQuery.of(context).size.width - 50)) / 100;
        });
      }
    } catch (e) {
      print("ERROR   " + e.toString());
    }
  }
}
