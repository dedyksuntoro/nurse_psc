import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nurse_psc/api/api_database.dart';
import 'package:flutter_quill/flutter_quill.dart' as textEditor_quill;

class PelajarMateri extends StatefulWidget {
  const PelajarMateri({super.key});

  @override
  State<PelajarMateri> createState() => _PelajarMateriState();
}

class _PelajarMateriState extends State<PelajarMateri> {
  textEditor_quill.QuillController _controllerMateri =
      textEditor_quill.QuillController.basic();
  late Future<List<ListPelajarMateri>> _futurePelajarMateri;
  late Future<Crud> _futureSetPelajarMateriSelesai;
  late Future<CountStatusMateri> _futureGetPelajarMateriStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futurePelajarMateri = ApiDatabase().getPelajarMateri();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text(
          "Materi",
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
      body: FutureBuilder<List<ListPelajarMateri>>(
        future: _futurePelajarMateri,
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
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: FloatingActionButton.extended(
        onPressed: () {
          _futurePelajarMateri = ApiDatabase().getPelajarMateri();
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
        _futurePelajarMateri = ApiDatabase().getPelajarMateri();
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
        _futurePelajarMateri = ApiDatabase().getPelajarMateri();
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
              title: Text(snapshot.data![index].mataPelajaran),
              onTap: () {
                showModalBottomSheet<void>(
                  isScrollControlled: true,
                  enableDrag: false,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12))),
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: Stack(
                        children: [
                          Container(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                                Flexible(
                                  child: Text(
                                    snapshot.data![index].mataPelajaran,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                const Opacity(
                                  opacity: 0.0,
                                  child: IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 50.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Html(
                                    data: snapshot.data![index].materi,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MaterialButton(
                                      minWidth: double.maxFinite,
                                      color: Theme.of(context).primaryColor,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        EasyLoading.show(
                                            status: 'Mohon Tunggu');
                                        _futureGetPelajarMateriStatus =
                                            ApiDatabase()
                                                .getPelajarCountStatusMateri(
                                                    snapshot.data![index].id);
                                        _futureGetPelajarMateriStatus
                                            .then((valueStatusMateri) {
                                          if (valueStatusMateri.statusMateri ==
                                              '0') {
                                            _futureSetPelajarMateriSelesai =
                                                ApiDatabase()
                                                    .setPelajarStatusMateri(
                                                        snapshot
                                                            .data![index].id);
                                            _futureSetPelajarMateriSelesai
                                                .then((value) {
                                              if (value.status == 'Success') {
                                                EasyLoading.dismiss();
                                                AwesomeDialog(
                                                  context: context,
                                                  dismissOnBackKeyPress: false,
                                                  dismissOnTouchOutside: false,
                                                  dialogType:
                                                      DialogType.success,
                                                  animType: AnimType.scale,
                                                  title: value.status,
                                                  desc: value.pesannya,
                                                  btnOkOnPress: () {
                                                    setState(() {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/materi-pelajar');
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
                                          } else {
                                            EasyLoading.dismiss();
                                            AwesomeDialog(
                                              context: context,
                                              dismissOnBackKeyPress: false,
                                              dismissOnTouchOutside: false,
                                              dialogType: DialogType.error,
                                              animType: AnimType.scale,
                                              title: 'Sudah Selesai',
                                              desc:
                                                  'Anda Sudah Menyelesaikan Materi Ini.\nSilahkan Menuju Menu Soal Untuk Mengerjakan Soal Materi Ini!',
                                              btnOkOnPress: () {},
                                            ).show();
                                          }
                                        });
                                      },
                                      child: const Text('Selesaikan Materi'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }),
    );
  }
}
