import 'dart:convert';
import 'dart:io';

import 'package:herdmannew/component/Gobal_Widgets/Con_Usermast.dart';
import 'package:http/http.dart' as http;

class ApiCalling {
  static createPost(String url, String header, var body) async {

    try {
      return http
          .post(Uri.parse(url),
              headers: header != null
                  ? {HttpHeaders.authorizationHeader: header}
                  : null,
              body: jsonEncode(body))
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        return response;
      });
    } catch (e) {
      print("ApiCalling.createPost Error ==> $e");
    }
  }

  static Future<http.Response> getDataByToken(String url) async {
    final res = await http.get(Uri.parse(url),
        headers: {"Authorization": "Bearer " + Constants_Usermast.token});
    return res;
  }

  static Future patchRequest(
    String url,
    body,
  ) async {
    var response = await http.patch(Uri.parse(url),
        headers: {"Authorization": "Bearer " + Constants_Usermast.token},
        body: jsonEncode(body));
    return response;
  }

  static CreateGet(String url, Map body) {
    return http.post(Uri.parse(url), body: body).then((http.Response response) {
      int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        return null;
      } else {
        final responseObject = jsonDecode(response.body);
        return responseObject;
      }
    });
  }

  static getdata(String url, String header) async {
    final res = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer " + header});
    return res;
  }

  static NormalGet(String url) async {
    final res = await http.get(Uri.parse(url));
    return res;
  }

  static createPut(String url, String header, var body) async {
    return http
        .put(Uri.parse(url),
            headers: header != null
                ? {HttpHeaders.authorizationHeader: header}
                : null,
            body: jsonEncode(body))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        return null;
      } else {
        return response;
      }
    });
  }

  static createPatch(String url, String header, var body) async {
    return http
        .patch(Uri.parse(url),
            headers: header != null
                ? {HttpHeaders.authorizationHeader: header}
                : null,
            body: jsonEncode(body))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        return null;
      }
      return response;
    });
  }

  static Delete(String url, String header) {
    return http
        .delete(
      Uri.parse(url),
      headers:
          header != null ? {HttpHeaders.authorizationHeader: header} : null,
    )
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        return null;
      }
      return response;
    });
  }
}
