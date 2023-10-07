import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String _baseUrl = "http://192.168.0.113/api_nurse_psc/";

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

  // Tambah Pengajar
  Future<Crud> setDaftarPengajar(
      nama, jenisKelamin, alamat, email, password) async {
    final response =
        await http.post(Uri.parse('${_baseUrl}set_daftar.php'), body: {
      'nama': nama,
      'jenis_kelamin': jenisKelamin,
      'alamat': alamat,
      'email': email,
      'tipe_user': 'Pengajar',
      'password': password,
    });
    if (response.statusCode == 200) {
      return Crud.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  // Tambah Pelajar
  Future<Crud> setDaftarPelajar(
      nama, jenisKelamin, alamat, email, password) async {
    final response =
        await http.post(Uri.parse('${_baseUrl}set_daftar.php'), body: {
      'nama': nama,
      'jenis_kelamin': jenisKelamin,
      'alamat': alamat,
      'email': email,
      'tipe_user': 'Pelajar',
      'password': password,
    });
    if (response.statusCode == 200) {
      return Crud.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}

class Crud {
  final String pesannya;
  final String status;

  const Crud({
    required this.pesannya,
    required this.status,
  });

  factory Crud.fromJson(Map<String, dynamic> json) {
    return Crud(
      pesannya: json['pesannya'].toString(),
      status: json['status'].toString(),
    );
  }
}
