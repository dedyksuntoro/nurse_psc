import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nurse_psc/api/api_database.dart';

class PengajarSoalTambah extends StatefulWidget {
  const PengajarSoalTambah({super.key});

  @override
  State<PengajarSoalTambah> createState() => _PengajarSoalTambahState();
}

class _PengajarSoalTambahState extends State<PengajarSoalTambah> {
  final _formKeyPengajarSoalTambah = GlobalKey<FormBuilderState>();

  late Future<Crud> _futureSetPengajarSoalTambah;
  @override
  Widget build(BuildContext context) {
    String idMatpel = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text(
          "Tambah Soal",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorLight,
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKeyPengajarSoalTambah,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'soal',
                  decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Soal',
                      border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  keyboardType: TextInputType.multiline,
                  minLines: 10,
                  maxLines: null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'jawaban_a',
                  decoration: const InputDecoration(
                      labelText: 'Jawaban A', border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'jawaban_b',
                  decoration: const InputDecoration(
                      labelText: 'Jawaban B', border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'jawaban_c',
                  decoration: const InputDecoration(
                      labelText: 'Jawaban B', border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'jawaban_d',
                  decoration: const InputDecoration(
                      labelText: 'Jawaban D', border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'jawaban_e',
                  decoration: const InputDecoration(
                      labelText: 'Jawaban E', border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'nilai_benar',
                  decoration: const InputDecoration(
                      labelText: 'Nilai Jawaban Benar',
                      border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderRadioGroup(
                  name: 'jawaban_benar',
                  decoration: const InputDecoration(
                      labelText: 'Jawaban Benar', border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  options: [
                    'A',
                    'B',
                    'C',
                    'D',
                    'E',
                  ]
                      .map((jwban) => FormBuilderFieldOption(value: jwban))
                      .toList(growable: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  minWidth: double.maxFinite,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: const Text('Tambah Data'),
                  onPressed: () {
                    if (_formKeyPengajarSoalTambah.currentState!
                        .saveAndValidate()) {
                      // print(_formKeyPengajarSoalTambah
                      //     .currentState!.value['jawaban_benar']);
                      // print(_formKeyPengajarSoalTambah
                      //     .currentState!.value['nilai_benar']);
                      EasyLoading.show(status: 'Mohon Tunggu');
                      _futureSetPengajarSoalTambah =
                          ApiDatabase().setPengajarSoalTambah(
                        idMatpel,
                        _formKeyPengajarSoalTambah.currentState!.value['soal'],
                        _formKeyPengajarSoalTambah
                            .currentState!.value['jawaban_a'],
                        _formKeyPengajarSoalTambah
                            .currentState!.value['jawaban_b'],
                        _formKeyPengajarSoalTambah
                            .currentState!.value['jawaban_c'],
                        _formKeyPengajarSoalTambah
                            .currentState!.value['jawaban_d'],
                        _formKeyPengajarSoalTambah
                            .currentState!.value['jawaban_e'],
                        _formKeyPengajarSoalTambah
                            .currentState!.value['jawaban_benar'],
                        _formKeyPengajarSoalTambah
                            .currentState!.value['nilai_benar'],
                      );
                      _futureSetPengajarSoalTambah.then((value) {
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
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/soal-pengajar',
                                    arguments: idMatpel);
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
    );
  }
}
