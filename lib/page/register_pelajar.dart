import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nurse_psc/api/api_database.dart';

List<String> genderOptions = ['Laki-laki', 'Perempuan'];

class RegisterPelajar extends StatefulWidget {
  const RegisterPelajar({super.key});

  @override
  State<RegisterPelajar> createState() => _RegisterPelajarState();
}

class _RegisterPelajarState extends State<RegisterPelajar> {
  final _formKeyRegisterPelajar = GlobalKey<FormBuilderState>();

  late Future<Crud> _futureSetDaftarPelajar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKeyRegisterPelajar,
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
                    'Pendaftaran Pelajar',
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
                    onPressed: () {
                      if (_formKeyRegisterPelajar.currentState!
                          .saveAndValidate()) {
                        EasyLoading.show(status: 'Mohon Tunggu');
                        _futureSetDaftarPelajar =
                            ApiDatabase().setDaftarPelajar(
                          _formKeyRegisterPelajar.currentState!.value['nama'],
                          _formKeyRegisterPelajar
                              .currentState!.value['jenis_kelamin'],
                          _formKeyRegisterPelajar.currentState!.value['alamat'],
                          _formKeyRegisterPelajar.currentState!.value['email'],
                          _formKeyRegisterPelajar.currentState!.value['password'],
                        );
                        _futureSetDaftarPelajar.then((value) {
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
                    child: const Text('Daftar'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
