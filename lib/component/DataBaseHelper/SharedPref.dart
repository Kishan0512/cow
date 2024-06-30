import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SrdPrefkey {
  static String spUserid = "user_id";
  static String spgroupId = "groupId";
  static String spfarmerId = "farmerId";
  static String spUserName = "user_name";
  static String sppassword = "password";
  static String spstatus_code = "status_code";
  static String spcompany = "company";
  static String spid = "id";
  static String spstaff = "staff";
  static String spSyncPendingData = "SyncPendingData";
  static String sptoken = "token";
  static String spzone = "zone";
  static String spmobileNumber = "mobileNumber";
  static String spis_deleted = "is_deleted";
  static String spQRCode = "QRCode";
  static String language = "language";
}

class SharedPref {
  static read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) == "null" ||
        prefs.getString(key) == "" ||
        prefs.getString(key) == "[]" ||
        prefs.getString(key) == null) {
      return "";
    }

    return json.decode(prefs.getString(key) ?? '');
  }

  static clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static save_string(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, (value));
  }

  static read_string(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getString(key) ?? '');
  }

  static save_int(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static read_int(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getInt(key) ?? 0);
  }

  static remove_key(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static savelist(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, (value));
  }

  static readlist(String key) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> Value = prefs.getStringList(key) ?? [];
    if (Value.isEmpty) {
      return Value;
    }
    return Value;
  }

  static read_bool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static save_bool(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
