import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nurse_psc/page/login.dart';
import 'package:nurse_psc/page/pelajar/pelajar_home.dart';
import 'package:nurse_psc/page/pengajar/pengajar_home.dart';
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

        // PENGAJAR
        '/register-pengajar': (context) => const RegisterPengajar(),
        '/home-pengajar': (context) => const PengajarHome(),
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
