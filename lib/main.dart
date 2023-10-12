import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nurse_psc/page/login.dart';
import 'package:nurse_psc/page/pelajar/pelajar_home.dart';
import 'package:nurse_psc/page/pelajar/pelajar_materi.dart';
import 'package:nurse_psc/page/pelajar/pelajar_penilaian.dart';
import 'package:nurse_psc/page/pelajar/pelajar_penilaian_detail.dart';
import 'package:nurse_psc/page/pelajar/pelajar_soal.dart';
import 'package:nurse_psc/page/pelajar/pelajar_soal_matpel.dart';
import 'package:nurse_psc/page/pengajar/pengajar_mata_pelajaran.dart';
import 'package:nurse_psc/page/pengajar/pengajar_home.dart';
import 'package:nurse_psc/page/pengajar/pengajar_materi.dart';
import 'package:nurse_psc/page/pengajar/pengajar_materi_tambah.dart';
import 'package:nurse_psc/page/pengajar/pengajar_soal.dart';
import 'package:nurse_psc/page/pengajar/pengajar_soal_matpel.dart';
import 'package:nurse_psc/page/pengajar/pengajar_soal_tambah.dart';
import 'package:nurse_psc/page/register_pelajar.dart';
import 'package:nurse_psc/page/register_pengajar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => const Login(),

        // PELAJAR
        '/register-pelajar': (context) => const RegisterPelajar(),
        '/home-pelajar': (context) => const PelajarHome(),
        '/materi-pelajar': (context) => const PelajarMateri(),
        '/soal-pelajar-matpel': (context) => const PelajarSoalMatpel(),
        '/soal-pelajar': (context) => const PelajarSoal(),
        '/penilaian-pelajar': (context) => const PelajarPenilaian(),
        '/penilaian-pelajar-detail': (context) => const PelajarPenilaianDetail(),

        // PENGAJAR
        '/register-pengajar': (context) => const RegisterPengajar(),
        '/home-pengajar': (context) => const PengajarHome(),
        '/mata-pelajaran-pengajar': (context) => const PengajarMataPelajaran(),
        '/materi-pengajar': (context) => const PengajarMateri(),
        '/materi-pengajar-tambah': (context) => const PengajarMateriTambah(),
        '/soal-pengajar-matpel': (context) => const PengajarSoalMatpel(),
        '/soal-pengajar': (context) => const PengajarSoal(),
        '/soal-pengajar-tambah': (context) => const PengajarSoalTambah(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        primaryColorLight: Colors.deepPurpleAccent,
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
      home: const Login(),
    );
  }
}
