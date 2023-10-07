import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nurse_psc/api/api_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKeyLogin = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKeyLogin,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Image(
                    image: AssetImage('assets/images/login-image.png'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(
                        labelText: 'Email', border: OutlineInputBorder()),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                    name: 'password',
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Password', border: OutlineInputBorder()),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    minWidth: double.maxFinite,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: prosesLogin,
                    child: const Text('Login'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          surfaceTintColor: Colors.transparent),
                      onPressed: () {
                        Navigator.pushNamed(context, '/register-pelajar');
                      },
                      child: const Text('Daftar Pelajar'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          surfaceTintColor: Colors.transparent),
                      onPressed: () {
                        Navigator.pushNamed(context, '/register-pengajar');
                      },
                      child: const Text('Daftar Pengajar'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> prosesLogin() async {
    if (_formKeyLogin.currentState!.saveAndValidate()) {
      EasyLoading.show(status: 'Mohon Tunggu');

      dynamic data = await ApiDatabase().login(
        _formKeyLogin.currentState!.value['email'],
        _formKeyLogin.currentState!.value['password'],
      );

      if (data['token'] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', data['token']);
        prefs.setString('id', data['id']);
        prefs.setString('nama', data['nama']);
        prefs.setString('jenis_kelamin', data['jenis_kelamin']);
        prefs.setString('alamat', data['alamat']);
        prefs.setString(
          'email',
          _formKeyLogin.currentState!.value['email'],
        );
        prefs.setString('tipe_user', data['tipe_user']);
        prefs.setString(
          'password',
          _formKeyLogin.currentState!.value['password'],
        );
        EasyLoading.dismiss();
        if (data['tipe_user'] == 'Pelajar') {
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, '/home-pelajar');
          }
        } else if (data['tipe_user'] == 'Pengajar') {
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, '/home-pengajar');
          }
        }
      } else {
        EasyLoading.dismiss();
        if (context.mounted) {
          AwesomeDialog(
            context: context,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: data['status'],
            desc: data['pesannya'],
            btnOkOnPress: () {},
          ).show();
        }
      }
    }
  }
}
