import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nurse_psc/api/api_database.dart';

class PelajarPenilaianDetail extends StatefulWidget {
  const PelajarPenilaianDetail({super.key});

  @override
  State<PelajarPenilaianDetail> createState() => _PelajarPenilaianDetailState();
}

class _PelajarPenilaianDetailState extends State<PelajarPenilaianDetail> {
  late Future<List<ListPelajarPenilaianDetail>> _futurePelajarPenilaianDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String idMatpel = ModalRoute.of(context)?.settings.arguments as String;
    _futurePelajarPenilaianDetail =
        ApiDatabase().getPelajarPenilaianDetail(idMatpel);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text(
          "Penilaian Detail",
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
      body: FutureBuilder<List<ListPelajarPenilaianDetail>>(
        future: _futurePelajarPenilaianDetail,
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
          String idMatpel =
              ModalRoute.of(context)?.settings.arguments as String;
          _futurePelajarPenilaianDetail =
              ApiDatabase().getPelajarPenilaianDetail(idMatpel);
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
        _futurePelajarPenilaianDetail =
            ApiDatabase().getPelajarPenilaianDetail(idMatpel);
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
        _futurePelajarPenilaianDetail =
            ApiDatabase().getPelajarPenilaianDetail(idMatpel);
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
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nilai: ${snapshot.data![index].nilai}'),
                  Text('Jawaban: ${snapshot.data![index].jawaban}'),
                ],
              ),
            );
          }),
    );
  }
}
