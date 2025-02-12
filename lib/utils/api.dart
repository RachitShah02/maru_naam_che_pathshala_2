import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'utils.dart';

class ApiService {
  static Future<String> getData(
      {required String endPoint, String page = '1', String query = ''}) async {
    String uid = GetStorage().read(Keys.sid) ?? '';
    final res = await http.get(
        Uri.parse(
            'http://192.168.1.16//mnpapi/api.php?endPoint=$endPoint$query&page=$page'),
        headers: {
          'content-type': 'application/json',
          'Access-Key': '1234',
          'Sid': uid,
        });
    if (res.statusCode == 200) {
      return res.body;
    }
    return "[]";
  }

  static Future<String> postData(
      {required String endPoint, required Map<String, String> data}) async {
    String uid = GetStorage().read(Keys.sid) ?? '';
    final res = await http.post(
        Uri.parse('http://192.168.1.16//mnpapi/api.php?endPoint=$endPoint'),
        body: jsonEncode(data),
        headers: {
          'Access-Key': '1234',
          'Sid': uid,
          'Content-Type': 'application/json',
        });
    if (res.statusCode == 200) {
      return res.body;
    }
    return "[]";
  }

  static Future<String> updateData(
      {required String endPoint, required Map<String, String> data}) async {
    String uid = GetStorage().read(Keys.sid) ?? '';
    final res = await http.put(
      Uri.parse('http://192.168.1.16//mnpapi/api.php?endPoint=$endPoint'),
      headers: {'Access-Key': '1234', 'Sid': uid},
      body: jsonEncode(data),
    );

    if (res.statusCode == 200) {
      return res.body;
    }
    return "[]";
  }
}
