import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nurse_psc/api/api_database.dart';

List<String> genderOptions = ['Laki-laki', 'Perempuan'];

class RegisterPengajar extends StatefulWidget {
  const RegisterPengajar({super.key});

  @override
  State<RegisterPengajar> createState() => _RegisterPengajarState();
}

class _RegisterPengajarState extends State<RegisterPengajar> {
  final _formKeyRegisterPengajar = GlobalKey<FormBuilderState>();

  late Future<Crud> _futureSetDaftarPengajar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKeyRegisterPengajar,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Image(
                    image: AssetImage('assets/images/register-image.png'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Pendaftaran Pengajar',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                    name: 'nama',
                    decoration: const InputDecoration(
                        labelText: 'Nama', border: OutlineInputBorder()),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderDropdown(
                    name: 'jenis_kelamin',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    decoration: const InputDecoration(
                        labelText: 'Jenis Kelamin',
                        border: OutlineInputBorder()),
                    items: genderOptions
                        .map((gender) => DropdownMenuItem(
                              alignment: AlignmentDirectional.center,
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                    name: 'alamat',
                    decoration: const InputDecoration(
                        labelText: 'Alamat', border: OutlineInputBorder()),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
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
                    child: const Text('Daftar'),
                    onPressed: () {
                      if (_formKeyRegisterPengajar.currentState!
                          .saveAndValidate()) {
                        EasyLoading.show(status: 'Mohon Tunggu');
                        _futureSetDaftarPengajar =
                            ApiDatabase().setDaftarPengajar(
                          _formKeyRegisterPengajar.currentState!.value['nama'],
                          _formKeyRegisterPengajar
                              .currentState!.value['jenis_kelamin'],
                          _formKeyRegisterPengajar
                              .currentState!.value['alamat'],
                          _formKeyRegisterPengajar.currentState!.value['email'],
                          _formKeyRegisterPengajar.currentState!.value['password'],
                        );
                        _futureSetDaftarPengajar.then((value) {
                          if (value.status == 'Success') {
                            EasyLoading.dismiss();
                            AwesomeDialog(
                              context: context,
                              dismissOnBackKeyPress: false,
                              dismissOnTouchOutside: false,
                              dialogType: DialogType.success,
                              animType: AnimType.scale,
                              title: value.status,
                              desc: value.pesannya,
                              btnOkOnPress: () {
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                            ).show();
                          } else {
                            EasyLoading.dismiss();
                            AwesomeDialog(
                              context: context,
                              dismissOnBackKeyPress: false,
                              dismissOnTouchOutside: false,
                              dialogType: DialogType.error,
                              animType: AnimType.scale,
                              title: value.status,
                              desc: value.pesannya,
                              btnOkOnPress: () {},
                            ).show();
                          }
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
