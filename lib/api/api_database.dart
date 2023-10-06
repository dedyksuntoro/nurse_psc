import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _baseUrl = "http://192.168.0.7/_local_mppm_api/";

class ApiDatabase {
  Future login(String username, String password) async {
    try {
      Response response = await post(Uri.parse('${_baseUrl}karyawan/login.php'),
          body: {'username': username, 'password': password});
      return jsonDecode(response.body.toString());
    } catch (e) {
      return e.toString();
    }
  }

  Future logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
    } catch (e) {
      return e.toString();
    }
  }
}
