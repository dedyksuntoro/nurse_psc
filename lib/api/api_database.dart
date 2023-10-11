import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// String _baseUrl = "http://192.168.0.113/api_nurse_psc/";
String _baseUrl = "http://192.168.1.7/api_nurse_psc/";

class ApiDatabase {
  // Future login(String email, String password) async {
  //   try {
  //     Response response = await post(Uri.parse('${_baseUrl}get_login.php'),
  //         body: {'email': email, 'password': password});
  //     return jsonDecode(response.body.toString());
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }

  Future<Loginnya> getlogin(email, password) async {
    final response =
        await http.post(Uri.parse('${_baseUrl}get_login.php'), body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      return Loginnya.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
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

  Future<List<ListPengajarMataPelajaran>> getPengajarMataPelajaran() async {
    SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$_baseUrl/get_pengajar_mata_pelajaran.php'),
      body: {
        'iduser': localStorage.get('id').toString(),
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => ListPengajarMataPelajaran.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Crud> setPengajarMataPelajaranTambah(mataPelajaran) async {
    SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse('${_baseUrl}set_pengajar_mata_pelajaran_tambah.php'),
        body: {
          'id_user_input': localStorage.get('id').toString(),
          'mata_pelajaran': mataPelajaran,
        });
    if (response.statusCode == 200) {
      return Crud.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<ListPengajarMateri>> getPengajarMateri() async {
    SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$_baseUrl/get_pengajar_materi.php'),
      body: {
        'iduser': localStorage.get('id').toString(),
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => ListPengajarMateri.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Crud> setPengajarMateriTambah(idMataPelajaran, materi) async {
    SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    final response = await http
        .post(Uri.parse('${_baseUrl}set_pengajar_materi_tambah.php'), body: {
      'id_user_input': localStorage.get('id').toString(),
      'id_mata_pelajaran': idMataPelajaran,
      'materi': materi,
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

class Loginnya {
  final String token;
  final String id;
  final String nama;
  final String jenisKelamin;
  final String alamat;
  final String email;
  final String tipeUser;

  const Loginnya({
    required this.token,
    required this.id,
    required this.nama,
    required this.jenisKelamin,
    required this.alamat,
    required this.email,
    required this.tipeUser,
  });

  factory Loginnya.fromJson(Map<String, dynamic> json) {
    return Loginnya(
      token: json['token'].toString(),
      id: json['id'].toString(),
      nama: json['nama'].toString(),
      jenisKelamin: json['jenis_kelamin'].toString(),
      alamat: json['alamat'].toString(),
      email: json['email'].toString(),
      tipeUser: json['tipe_user'].toString(),
    );
  }
}

class ListPengajarMataPelajaran {
  final String id;
  final String idUserInput;
  final String mataPelajaran;

  const ListPengajarMataPelajaran({
    required this.id,
    required this.idUserInput,
    required this.mataPelajaran,
  });

  factory ListPengajarMataPelajaran.fromJson(Map<String, dynamic> json) {
    return ListPengajarMataPelajaran(
      id: json['id'].toString(),
      idUserInput: json['id_user_input'].toString(),
      mataPelajaran: json['mata_pelajaran'].toString(),
    );
  }
}

class ListPengajarMateri {
  final String id;
  final String idUserInput;
  final String idMataPelajaran;
  final String materi;
  final String mataPelajaran;

  const ListPengajarMateri({
    required this.id,
    required this.idUserInput,
    required this.idMataPelajaran,
    required this.materi,
    required this.mataPelajaran,
  });

  factory ListPengajarMateri.fromJson(Map<String, dynamic> json) {
    return ListPengajarMateri(
      id: json['id_materi'].toString(),
      idUserInput: json['id_user_input_materi'].toString(),
      idMataPelajaran: json['id_mata_pelajaran'].toString(),
      materi: json['materi'].toString(),
      mataPelajaran: json['mata_pelajaran'].toString(),
    );
  }
}
