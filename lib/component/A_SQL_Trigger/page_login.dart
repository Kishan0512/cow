import 'package:herdmannew/component/A_SQL_Trigger/A_ApiUrl.dart';
import 'package:herdmannew/component/A_SQL_Trigger/A_NetworkHelp.dart';
import 'package:herdmannew/component/DataBaseHelper/SharedPref.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';

class api_page_login {
  final String username;
  final String password;
  final String status_code;
  final String company;
  final String id;
  final String staff;
  final String SyncPendingData;
  final String token;
  final int groupId;
  final String zone;
  final int farmerId;
  final String mobileNumber;
  final String is_deleted;
  final String QRCode;

  api_page_login(
      {required this.username,
      required this.password,
      required this.status_code,
      required this.farmerId,
      required this.company,
      required this.id,
      required this.token,
      required this.zone,
      required this.staff,
      required this.SyncPendingData,
      required this.mobileNumber,
      required this.groupId,
      required this.is_deleted,
      required this.QRCode});

  //Logins({ this.username, this.password});
  factory api_page_login.fromJson(
      Map<String, dynamic> json, String status_code, String token, Map body) {
    int _farmerId;
    String _mobileNumber;

    if (json['group'] == 12 && body['farmer'] != null) {
      if (body['farmer'].isNotEmpty) {
        _farmerId = body['farmer'][0]['id'];

        _mobileNumber = body['farmer'][0]['Mobile'].toString();
      }
    }

    return api_page_login(
      username: json['Username'],
      password: json['password'].toString(),
      status_code: status_code,
      company: json['company'].toString(),
      id: json['id'].toString(),
      token: token,
      staff: json["staff"].toString(),
      SyncPendingData: json["SyncPendingData"].toString(),
      groupId: json['group'],
      zone: json['zone'].toString(),
      QRCode: json['QRCode'].toString(),
      mobileNumber: "",
      farmerId: 0,
      is_deleted: json['is_deleted'].toString(),
    );
  }

  static Future logincheck(
      String pStrUsername, String pStrPassword) async {
    if (pStrUsername.endsWith("@hap.in")) {
      AppUrl.CheckNewUrl.value = true;
    } else {
      AppUrl.CheckNewUrl.value = false;
    }
    Map data = {
      "username": pStrUsername.toString(),
      "password": pStrPassword.toString(),
    };
    final Response = await ApiCalling.CreateGet(AppUrl().LOGIN_URL, data);
    if (Response.toString().isNotEmpty && Response.toString() != "null") {
      if(Response['user']['is_deleted']==false || Response['user']['is_deleted']==null){
      api_page_login p = api_page_login.fromJson(Response['user'], "101", Response['token'].toString(), Response);
      if (p.token.isNotEmpty) {
        Constants_Usermast.token = p.token.toString();
        SharedPref.save_string(SrdPrefkey.spUserid.toString(), p.id);
        SharedPref.save_string(
            SrdPrefkey.spUserName.toString(), p.username.toString());
        SharedPref.save_int(SrdPrefkey.spgroupId.toString(), p.groupId);
        SharedPref.save_int(SrdPrefkey.spfarmerId.toString(), p.farmerId);
        SharedPref.save_string(SrdPrefkey.sppassword.toString(), p.password);
        SharedPref.save_string(
            SrdPrefkey.spstatus_code.toString(), p.status_code);
        SharedPref.save_string(SrdPrefkey.spcompany.toString(), p.company);
        SharedPref.save_string(SrdPrefkey.spzone.toString(), p.zone);
        SharedPref.save_string(SrdPrefkey.spid.toString(), p.id);
        SharedPref.save_string(SrdPrefkey.spstaff.toString(), p.staff);
        SharedPref.save_string(
            SrdPrefkey.spSyncPendingData.toString(), p.SyncPendingData);
        SharedPref.save_string(SrdPrefkey.sptoken.toString(), p.token);
        SharedPref.save_string(
            SrdPrefkey.spmobileNumber.toString(), p.mobileNumber);
        SharedPref.save_string(
            SrdPrefkey.spis_deleted.toString(), p.is_deleted);
        SharedPref.save_string(SrdPrefkey.spQRCode.toString(), p.QRCode);
        return true;
      }else{
        return false;
      }
      } else {
        AppUrl.issuspend.value=true;
        return false;
      }
    } else {
      return false;
    }
  }
}
