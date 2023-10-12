import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String _baseUrl = "http://192.168.0.113/api_nurse_psc/";
// String _baseUrl = "http://192.168.1.7/api_nurse_psc/";

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
      Uri.parse('${_baseUrl}get_pengajar_mata_pelajaran.php'),
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
      Uri.parse('${_baseUrl}get_pengajar_materi.php'),
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

  Future<List<ListPelajarMateri>> getPelajarMateri() async {
    SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('${_baseUrl}get_pelajar_materi.php'),
      body: {
        'iduser': localStorage.get('id').toString(),
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => ListPelajarMateri.fromJson(data))
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

  Future<List<ListPengajarSoal>> getPengajarSoal(idMataPelajaran) async {
    SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('${_baseUrl}get_pengajar_soal.php'),
      body: {
        'iduser': localStorage.get('id').toString(),
        'id_mata_pelajaran': idMataPelajaran,
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => ListPengajarSoal.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Crud> setPengajarSoalTambah(idMataPelajaran, soal, jawabanA, jawabanB,
      jawabanC, jawabanD, jawabanE, jawabanBenar, nilaiBenar) async {
    SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    final response = await http
        .post(Uri.parse('${_baseUrl}set_pengajar_soal_tambah.php'), body: {
      'id_user_input': localStorage.get('id').toString(),
      'id_mata_pelajaran': idMataPelajaran,
      'soal': soal,
      'jawaban_a': jawabanA,
      'jawaban_b': jawabanB,
      'jawaban_c': jawabanC,
      'jawaban_d': jawabanD,
      'jawaban_e': jawabanE,
      'jawaban_benar': jawabanBenar,
      'nilai_benar': nilaiBenar,
    });
    if (response.statusCode == 200) {
      return Crud.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Crud> setPelajarStatusMateri(idMateri) async {
    SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    final response = await http
        .post(Uri.parse('${_baseUrl}set_pelajar_materi_selesai.php'), body: {
      'id_materi': idMateri,
      'id_user': localStorage.get('id').toString(),
    });
    if (response.statusCode == 200) {
      return Crud.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<CountStatusMateri> getPelajarCountStatusMateri(idMateri) async {
    SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    final response = await http
        .post(Uri.parse('${_baseUrl}get_pelajar_materi_status.php'), body: {
      'id_materi': idMateri,
      'id_user': localStorage.get('id').toString(),
    });
    if (response.statusCode == 200) {
      return CountStatusMateri.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<ListPelajarMataPelajaran>> getPelajarMataPelajaran() async {
    SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('${_baseUrl}get_pelajar_mata_pelajaran.php'),
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => ListPelajarMataPelajaran.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<ListPelajarSoal>> getPelajarSoal(idMataPelajaran) async {
    SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('${_baseUrl}get_pelajar_soal.php'),
      body: {
        'id_mata_pelajaran': idMataPelajaran,
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => ListPelajarSoal.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Crud> setPelajarStatusSoal(idSoal, jawaban, nilai) async {
    SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    final response = await http
        .post(Uri.parse('${_baseUrl}set_pelajar_soal_selesai.php'), body: {
      'id_soal': idSoal,
      'id_user': localStorage.get('id').toString(),
      'jawaban': jawaban,
      'nilai': nilai,
    });
    if (response.statusCode == 200) {
      return Crud.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<ListPelajarPenilaian>> getPelajarPenilaian() async {
    SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('${_baseUrl}get_pelajar_penilaian.php'),
      body: {
        'id_user': localStorage.get('id').toString(),
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => ListPelajarPenilaian.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<ListPelajarPenilaianDetail>> getPelajarPenilaianDetail(
      idMataPelajaran) async {
    SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('${_baseUrl}get_pelajar_penilaian_detail.php'),
      body: {
        'id_user': localStorage.get('id').toString(),
        'id_mata_pelajaran': idMataPelajaran,
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => ListPelajarPenilaianDetail.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<CountStatusSoal> getPelajarCountStatusSoal(idMataPelajaran) async {
    SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    final response = await http
        .post(Uri.parse('${_baseUrl}get_pelajar_soal_status.php'), body: {
      'id_mata_pelajaran': idMataPelajaran,
      'id_user': localStorage.get('id').toString(),
    });
    if (response.statusCode == 200) {
      return CountStatusSoal.fromJson(jsonDecode(response.body));
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

class CountStatusMateri {
  final String statusMateri;

  const CountStatusMateri({
    required this.statusMateri,
  });

  factory CountStatusMateri.fromJson(Map<String, dynamic> json) {
    return CountStatusMateri(
      statusMateri: json['status_materi'].toString(),
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

class ListPelajarMataPelajaran {
  final String id;
  final String idUserInput;
  final String mataPelajaran;
  final String statusMateri;

  const ListPelajarMataPelajaran({
    required this.id,
    required this.idUserInput,
    required this.mataPelajaran,
    required this.statusMateri,
  });

  factory ListPelajarMataPelajaran.fromJson(Map<String, dynamic> json) {
    return ListPelajarMataPelajaran(
      id: json['id'].toString(),
      idUserInput: json['id_user_input'].toString(),
      mataPelajaran: json['mata_pelajaran'].toString(),
      statusMateri: json['status_materi'].toString(),
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

class ListPelajarMateri {
  final String id;
  final String idUserInput;
  final String idMataPelajaran;
  final String materi;
  final String mataPelajaran;

  const ListPelajarMateri({
    required this.id,
    required this.idUserInput,
    required this.idMataPelajaran,
    required this.materi,
    required this.mataPelajaran,
  });

  factory ListPelajarMateri.fromJson(Map<String, dynamic> json) {
    return ListPelajarMateri(
      id: json['id_materi'].toString(),
      idUserInput: json['id_user_input_materi'].toString(),
      idMataPelajaran: json['id_mata_pelajaran'].toString(),
      materi: json['materi'].toString(),
      mataPelajaran: json['mata_pelajaran'].toString(),
    );
  }
}

class ListPengajarSoal {
  final String id;
  final String idUserInput;
  final String idMataPelajaran;
  final String soal;
  final String jawabanA;
  final String jawabanB;
  final String jawabanC;
  final String jawabanD;
  final String jawabanE;
  final String jawabanBenar;
  final String nilaiBenar;
  final String mataPelajaran;

  const ListPengajarSoal({
    required this.id,
    required this.idUserInput,
    required this.idMataPelajaran,
    required this.soal,
    required this.jawabanA,
    required this.jawabanB,
    required this.jawabanC,
    required this.jawabanD,
    required this.jawabanE,
    required this.jawabanBenar,
    required this.nilaiBenar,
    required this.mataPelajaran,
  });

  factory ListPengajarSoal.fromJson(Map<String, dynamic> json) {
    return ListPengajarSoal(
      id: json['id_soal'].toString(),
      idUserInput: json['id_user_input_soal'].toString(),
      idMataPelajaran: json['id_mata_pelajaran'].toString(),
      soal: json['soal'].toString(),
      jawabanA: json['jawaban_a'].toString(),
      jawabanB: json['jawaban_b'].toString(),
      jawabanC: json['jawaban_c'].toString(),
      jawabanD: json['jawaban_d'].toString(),
      jawabanE: json['jawaban_e'].toString(),
      jawabanBenar: json['jawaban_benar'].toString(),
      nilaiBenar: json['nilai_benar'].toString(),
      mataPelajaran: json['mata_pelajaran'].toString(),
    );
  }
}

class ListPelajarSoal {
  final String id;
  final String idUserInput;
  final String idMataPelajaran;
  final String soal;
  final String jawabanA;
  final String jawabanB;
  final String jawabanC;
  final String jawabanD;
  final String jawabanE;
  final String jawabanBenar;
  final String nilaiBenar;
  final String mataPelajaran;

  const ListPelajarSoal({
    required this.id,
    required this.idUserInput,
    required this.idMataPelajaran,
    required this.soal,
    required this.jawabanA,
    required this.jawabanB,
    required this.jawabanC,
    required this.jawabanD,
    required this.jawabanE,
    required this.jawabanBenar,
    required this.nilaiBenar,
    required this.mataPelajaran,
  });

  factory ListPelajarSoal.fromJson(Map<String, dynamic> json) {
    return ListPelajarSoal(
      id: json['id_soal'].toString(),
      idUserInput: json['id_user_input_soal'].toString(),
      idMataPelajaran: json['id_mata_pelajaran'].toString(),
      soal: json['soal'].toString(),
      jawabanA: json['jawaban_a'].toString(),
      jawabanB: json['jawaban_b'].toString(),
      jawabanC: json['jawaban_c'].toString(),
      jawabanD: json['jawaban_d'].toString(),
      jawabanE: json['jawaban_e'].toString(),
      jawabanBenar: json['jawaban_benar'].toString(),
      nilaiBenar: json['nilai_benar'].toString(),
      mataPelajaran: json['mata_pelajaran'].toString(),
    );
  }
}

class ListPelajarPenilaian {
  final String idUser;
  final String idMataPelajaran;
  final String mataPelajaran;
  final String nilai;

  const ListPelajarPenilaian({
    required this.idUser,
    required this.idMataPelajaran,
    required this.mataPelajaran,
    required this.nilai,
  });

  factory ListPelajarPenilaian.fromJson(Map<String, dynamic> json) {
    return ListPelajarPenilaian(
      idUser: json['id_user'].toString(),
      idMataPelajaran: json['id_mata_pelajaran'].toString(),
      mataPelajaran: json['mata_pelajaran'].toString(),
      nilai: json['nilai'].toString(),
    );
  }
}

class ListPelajarPenilaianDetail {
  final String idUser;
  final String idMataPelajaran;
  final String soal;
  final String jawaban;
  final String nilai;

  const ListPelajarPenilaianDetail({
    required this.idUser,
    required this.idMataPelajaran,
    required this.soal,
    required this.jawaban,
    required this.nilai,
  });

  factory ListPelajarPenilaianDetail.fromJson(Map<String, dynamic> json) {
    return ListPelajarPenilaianDetail(
      idUser: json['id_user'].toString(),
      idMataPelajaran: json['id_mata_pelajaran'].toString(),
      soal: json['soal'].toString(),
      jawaban: json['jawaban'].toString(),
      nilai: json['nilai'].toString(),
    );
  }
}

class CountStatusSoal {
  final String statusSoal;

  const CountStatusSoal({
    required this.statusSoal,
  });

  factory CountStatusSoal.fromJson(Map<String, dynamic> json) {
    return CountStatusSoal(
      statusSoal: json['status_soal'].toString(),
    );
  }
}
