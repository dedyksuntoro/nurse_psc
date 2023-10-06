import 'package:flutter/material.dart';
import 'package:nurse_psc/page/login.dart';
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
        '/register-pelajar': (context) => const RegisterPelajar(),
        '/register-pengajar': (context) => const RegisterPengajar(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}
