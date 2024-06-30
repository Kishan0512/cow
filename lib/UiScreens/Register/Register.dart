import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:herdmannew/UiScreens/Login/LoginScreen.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Icons.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

import '../../component/A_SQL_Trigger/A_ApiUrl.dart';
import '../../component/A_SQL_Trigger/A_NetworkHelp.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  bool mBlnShowpassword = false,
      mBlnShowConpassword = false,
      isupdate = false,
      mBlnUsername = true,
      mBlnUsernumber = false,
      mBlnUseremail = false,
      mBlnPassword = false,
      mBlnConPassword = false;
  TextEditingController uName = TextEditingController(),
      uMobile = TextEditingController(),
      uEmail = TextEditingController(),
      pass = TextEditingController(),
      c_pass = TextEditingController();

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
          appBar: Con_Wid.appBar(
            title: "Register",
            Actions: [],
            onBackTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return Login();
                },
              ));
            },
          ),
          body: Con_Wid.backgroundContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConTextField(
                  Autofocus: true,
                  isactive: mBlnUsername,
                  Controller: uName,
                  prefixIcon:
                      const Icon(Icons.person_outline, color: whiteColor),
                  HintText: "Type your username",
                  Title: "Username",
                  OnTap: () {
                    setState(() {
                      mBlnUsername = true;
                      mBlnUsernumber = false;
                      mBlnUseremail = false;
                      mBlnPassword = false;
                      mBlnConPassword = false;
                    });
                  },
                ),
                ConTextField(
                  Autofocus: true,
                  isactive: mBlnUsernumber,
                  Controller: uMobile,
                  prefixIcon:
                      const Icon(Icons.local_phone_rounded, color: whiteColor),
                  HintText: "Type Mobile Number",
                  Title: "Mobile",
                  OnTap: () {
                    setState(() {
                      mBlnUsername = false;
                      mBlnUsernumber = true;
                      mBlnUseremail = false;
                      mBlnPassword = false;
                      mBlnConPassword = false;
                    });
                  },
                ),
                ConTextField(
                  Autofocus: true,
                  isactive: mBlnUseremail,
                  Controller: uEmail,
                  prefixIcon:
                      const Icon(Icons.email_outlined, color: whiteColor),
                  HintText: "Type Email ID",
                  Title: "Email",
                  OnTap: () {
                    setState(() {
                      mBlnUsername = false;
                      mBlnUsernumber = false;
                      mBlnUseremail = true;
                      mBlnPassword = false;
                      mBlnConPassword = false;
                    });
                  },
                ),
                ConTextField(
                  isactive: mBlnPassword,
                  ObscureText: mBlnShowpassword ? false : true,
                  Controller: pass,
                  prefixIcon: const Icon(Icons.lock_outline, color: whiteColor),
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
                  Title: "Password",
                  OnTap: () {
                    setState(() {
                      mBlnUsername = false;
                      mBlnUsernumber = false;
                      mBlnUseremail = false;
                      mBlnPassword = true;
                      mBlnConPassword = false;
                    });
                  },
                ),
                ConTextField(
                  isactive: mBlnConPassword,
                  ObscureText: mBlnShowConpassword ? false : true,
                  Controller: c_pass,
                  prefixIcon: const Icon(Icons.lock_outline, color: whiteColor),
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
                      mBlnUsername = false;
                      mBlnUsernumber = false;
                      mBlnUseremail = false;
                      mBlnPassword = false;
                      mBlnConPassword = true;
                    });
                  },
                ),
                Con_Wid.height(20),
                Con_Wid.MainButton(
                    width: 200,
                    height: 45,
                    fontSize: 16,
                    pStrBtnName: 'Register',
                    OnTap: () async {
                      await GoogleSignIn().signOut();
                      await FirebaseAuth.instance.signOut();
                    }),
                Con_Wid.height(20),
                Text("Or"),
                Con_Wid.height(20),
                InkWell(
                  onTap: () {
                    signInWithGoogle().then((value) async {
                      User? user = FirebaseAuth.instance.currentUser;
                      final res =
                          await ApiCalling.CreateGet(AppUrl().RegisterFarmer, {
                        "username": user?.email.toString(),
                        "mobile": user?.phoneNumber.toString(),
                        "email": user?.email.toString(),
                        "photo": "",
                        "password": "welcome@123"
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 30,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/google.webp")),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text("Login with Gmail"),
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
