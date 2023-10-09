import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nurse_psc/api/api_database.dart';

class PengajarMataPelajaranTambah extends StatefulWidget {
  const PengajarMataPelajaranTambah({super.key});

  @override
  State<PengajarMataPelajaranTambah> createState() =>
      _PengajarMataPelajaranTambahState();
}

class _PengajarMataPelajaranTambahState
    extends State<PengajarMataPelajaranTambah> {
  final _formKeyPengajarMataPelajaranTambah = GlobalKey<FormBuilderState>();

  late Future<Crud> _futureSetPengajarMataPelajaranTambah;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text(
          "Tambah Mata Pelajaran",
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
          key: _formKeyPengajarMataPelajaranTambah,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'mata_pelajaran',
                  decoration: const InputDecoration(
                      labelText: 'Mata Pelajaran',
                      border: OutlineInputBorder()),
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
                  child: const Text('Tambah Data'),
                  onPressed: () {
                    if (_formKeyPengajarMataPelajaranTambah.currentState!
                        .saveAndValidate()) {
                      EasyLoading.show(status: 'Mohon Tunggu');
                      _futureSetPengajarMataPelajaranTambah =
                          ApiDatabase().setPengajarMataPelajaranTambah(
                        _formKeyPengajarMataPelajaranTambah
                            .currentState!.value['mata_pelajaran'],
                      );
                      _futureSetPengajarMataPelajaranTambah.then((value) {
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
                                Navigator.pushNamed(
                                    context, '/mata-pelajaran-pengajar');
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
