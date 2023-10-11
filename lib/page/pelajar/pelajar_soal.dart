import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nurse_psc/api/api_database.dart';

class PelajarSoal extends StatefulWidget {
  const PelajarSoal({super.key});

  @override
  State<PelajarSoal> createState() => _PelajarSoalState();
}

class _PelajarSoalState extends State<PelajarSoal> {
  late Future<List<ListPelajarSoal>> _futurePelajarSoal;
  late Future<Crud> _futureSetPelajarSoalSelesai;
  List<String> selectedItemValue = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String idMatpel = ModalRoute.of(context)?.settings.arguments as String;
    _futurePelajarSoal = ApiDatabase().getPelajarSoal(idMatpel);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text(
          "Soal",
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
      body: FutureBuilder<List<ListPelajarSoal>>(
        future: _futurePelajarSoal,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return _buildErrorWidget();
            }
            if (snapshot.data!.isEmpty) {
              return _buildEmptyWidget();
            } else {
              return _buildDataWidget(snapshot);
            }
          } else {
            return _buildLoadingWidget();
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          minWidth: double.maxFinite,
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: const Text('Selesai'),
          onPressed: () {
            _futurePelajarSoal.then((value) {
              // print(selectedItemValue.length);
              // print(value.length);
              if (value.length == selectedItemValue.length) {
                AwesomeDialog(
                  context: context,
                  dismissOnBackKeyPress: false,
                  dismissOnTouchOutside: false,
                  dialogType: DialogType.question,
                  animType: AnimType.scale,
                  title: 'Sudah Selesai Menjawab?',
                  // desc: 'Pastikan Jawaban Anda Sudah Baik & Benar!',
                  btnCancelText: 'Belum',
                  btnCancelOnPress: () {},
                  btnOkText: 'Sudah',
                  btnOkOnPress: () {
                    print(value.asMap()[1]?.jawabanBenar);
                    // for (var elementSoal in value) {
                    //   elementSoal.id;
                    // }
                    var index = 0;
                    for (var element in selectedItemValue) {
                      // print(element);
                      if (value.asMap()[index]?.jawabanBenar == element) {
                        _futureSetPelajarSoalSelesai = ApiDatabase()
                            .setPelajarStatusSoal(value.asMap()[index]?.id,
                                element, value.asMap()[index]?.nilaiBenar);
                      } else {
                        _futureSetPelajarSoalSelesai = ApiDatabase()
                            .setPelajarStatusSoal(
                                value.asMap()[index]?.id, element, '0');
                      }
                      index++;
                    }

                    _futureSetPelajarSoalSelesai.then((value) {
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
                              Navigator.pushNamed(
                                  context, '/soal-pelajar-matpel');
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
                  },
                ).show();
              } else {
                AwesomeDialog(
                  context: context,
                  dismissOnBackKeyPress: false,
                  dismissOnTouchOutside: false,
                  dialogType: DialogType.error,
                  animType: AnimType.scale,
                  title: 'Jawaban Tidak Lengkap!',
                  desc: 'Ada Soal Yang Belum Terjawab',
                  btnOkOnPress: () {},
                ).show();
              }
            });
          },
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: FloatingActionButton.extended(
        onPressed: () {
          String idMatpel =
              ModalRoute.of(context)?.settings.arguments as String;
          _futurePelajarSoal = ApiDatabase().getPelajarSoal(idMatpel);
          setState(() {});
        },
        icon: const Icon(Icons.refresh, color: Colors.white),
        label: const Text('Refresh', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: Theme.of(context).primaryColor,
      strokeWidth: 3.0,
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete,
                size: 100,
              ),
              Text(
                "Tidak Ada Data",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      onRefresh: () async {
        String idMatpel = ModalRoute.of(context)?.settings.arguments as String;
        _futurePelajarSoal = ApiDatabase().getPelajarSoal(idMatpel);
        setState(() {});
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
    );
  }

  Widget _buildDataWidget(AsyncSnapshot snapshot) {
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: Theme.of(context).primaryColor,
      strokeWidth: 3.0,
      onRefresh: () async {
        String idMatpel = ModalRoute.of(context)?.settings.arguments as String;
        _futurePelajarSoal = ApiDatabase().getPelajarSoal(idMatpel);
        setState(() {});
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: snapshot.data?.length,
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
          );
        },
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: Colors.white,
            title: Text(
              snapshot.data![index].soal,
              textAlign: TextAlign.justify,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('A. ' + snapshot.data![index].jawabanA),
                Text('B. ' + snapshot.data![index].jawabanB),
                Text('C. ' + snapshot.data![index].jawabanC),
                Text('D. ' + snapshot.data![index].jawabanD),
                Text('E. ' + snapshot.data![index].jawabanE),
                FormBuilderRadioGroup(
                  name: 'jawaban_benar',
                  onChanged: (value) {
                    if (selectedItemValue.asMap()[index] != null) {
                      selectedItemValue.removeAt(index);
                      selectedItemValue.insert(index, value.toString());
                    } else {
                      selectedItemValue.add(value.toString());
                    }
                  },
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
              ],
            ),
          );
        },
      ),
    );
  }
}
