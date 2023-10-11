import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nurse_psc/api/api_database.dart';

class PelajarSoalMatpel extends StatefulWidget {
  const PelajarSoalMatpel({super.key});

  @override
  State<PelajarSoalMatpel> createState() => _PelajarSoalMatpelState();
}

class _PelajarSoalMatpelState extends State<PelajarSoalMatpel> {
  late Future<List<ListPelajarMataPelajaran>> _futurePelajarMataPelajaran;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futurePelajarMataPelajaran = ApiDatabase().getPelajarMataPelajaran();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text(
          "Pilih Mata Pelajaran",
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
      body: FutureBuilder<List<ListPelajarMataPelajaran>>(
        future: _futurePelajarMataPelajaran,
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
          _futurePelajarMataPelajaran = ApiDatabase().getPelajarMataPelajaran();
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
        _futurePelajarMataPelajaran = ApiDatabase().getPelajarMataPelajaran();
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
        _futurePelajarMataPelajaran = ApiDatabase().getPelajarMataPelajaran();
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
                if (snapshot.data![index].statusMateri == 'null') {
                  AwesomeDialog(
                    context: context,
                    dismissOnBackKeyPress: false,
                    dismissOnTouchOutside: false,
                    dialogType: DialogType.error,
                    animType: AnimType.scale,
                    title: 'Selesaikan Materi',
                    desc:
                        'Materi Belum Anda Selesaikan.\nSelesaikan Dahulu Materi Soal Yang Anda Pilih!',
                    btnOkOnPress: () {},
                  ).show();
                } else {
                  Navigator.pushNamed(
                    context,
                    '/soal-pelajar',
                    arguments: snapshot.data![index].id.toString(),
                  );
                }
              },
            );
          }),
    );
  }
}
