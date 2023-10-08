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
  late Future<Loginnya> _futureLogin;

  getStartLoginAs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loginAs = prefs.getString('tipe_user');
    if (loginAs == 'Pelajar') {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home-pelajar');
      }
    } else if (loginAs == 'Pengajar') {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home-pengajar');
      }
    }
  }

  Future<void> prosesLogin() async {
    if (_formKeyLogin.currentState!.saveAndValidate()) {
      EasyLoading.show(status: 'Mohon Tunggu');

      _futureLogin = ApiDatabase().getlogin(
        _formKeyLogin.currentState!.value['email'],
        _formKeyLogin.currentState!.value['password'],
      );

      _futureLogin.then((value) async {
        if (value.token != 'null') {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', value.token);
          prefs.setString('id', value.id);
          prefs.setString('nama', value.nama);
          prefs.setString('jenis_kelamin', value.jenisKelamin);
          prefs.setString('alamat', value.alamat);
          prefs.setString(
            'email',
            _formKeyLogin.currentState!.value['email'],
          );
          prefs.setString('tipe_user', value.tipeUser);
          prefs.setString(
            'password',
            _formKeyLogin.currentState!.value['password'],
          );
          EasyLoading.dismiss();
          if (value.tipeUser == 'Pelajar') {
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, '/home-pelajar');
            }
          } else if (value.tipeUser == 'Pengajar') {
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
              title: 'Login Gagal',
              desc: 'Perikas kembali email dan password Anda!',
              btnOkOnPress: () {},
            ).show();
          }
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStartLoginAs();
  }

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
}
