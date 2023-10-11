import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_quill/flutter_quill.dart' as textEditor_quill;
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nurse_psc/api/api_database.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class PengajarMateriTambah extends StatefulWidget {
  const PengajarMateriTambah({super.key});

  @override
  State<PengajarMateriTambah> createState() => _PengajarMateriTambahState();
}

class _PengajarMateriTambahState extends State<PengajarMateriTambah> {
  final textEditor_quill.QuillController _controllerMateri =
      textEditor_quill.QuillController.basic();
  final _formKeyPengajarMateriTambah = GlobalKey<FormBuilderState>();
  List itemMataPelajaran = [];

  late Future<Crud> _futureSetPengajarMateriTambah;
  late Future<List<ListPengajarMataPelajaran>> _futurePengajarMataPelajaran;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futurePengajarMataPelajaran = ApiDatabase().getPengajarMataPelajaran();
    _futurePengajarMataPelajaran.then((value) {
      setState(() {
        itemMataPelajaran = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text(
          "Tambah Materi",
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
          key: _formKeyPengajarMateriTambah,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderDropdown(
                  name: 'mata_pelajaran',
                  decoration: const InputDecoration(
                      labelText: 'Mata Pelajaran',
                      border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  items: itemMataPelajaran
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.id.toString(),
                          child: Text(
                            e.mataPelajaran.toString(),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                child: textEditor_quill.QuillToolbar.basic(
                  color: Colors.grey,
                  controller: _controllerMateri,
                  multiRowsDisplay: false,
                  showAlignmentButtons: true,
                ),
              ),
              Container(
                // color: Colors.grey[200],
                margin: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: SizedBox(
                  height: 400.0,
                  child: textEditor_quill.QuillEditor.basic(
                    locale: const Locale('id'),
                    placeholder: 'Isi materi pelajaran',
                    autoFocus: false,
                    controller: _controllerMateri,
                    readOnly: false, // true for view only mode
                  ),
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
                    // print(_controllerMateri.document.toDelta().toJson());
                    final deltaOps =
                        _controllerMateri.document.toDelta().toJson();

                    final converter = QuillDeltaToHtmlConverter(
                      List.castFrom(deltaOps),
                      ConverterOptions.forEmail(),
                    );

                    final html = converter.convert();
                    if (_formKeyPengajarMateriTambah.currentState!
                        .saveAndValidate()) {
                      EasyLoading.show(status: 'Mohon Tunggu');
                      _futureSetPengajarMateriTambah =
                          ApiDatabase().setPengajarMateriTambah(
                        _formKeyPengajarMateriTambah
                            .currentState!.value['mata_pelajaran'],
                        html,
                      );
                      _futureSetPengajarMateriTambah.then((value) {
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
                                    context, '/materi-pengajar');
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
