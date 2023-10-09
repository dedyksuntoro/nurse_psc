import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:nurse_psc/api/api_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PelajarHome extends StatefulWidget {
  const PelajarHome({super.key});

  @override
  State<PelajarHome> createState() => _PelajarHomeState();
}

class _PelajarHomeState extends State<PelajarHome> {
  String namaUser = "";

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namaUser = prefs.getString('nama')!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ClipOval(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
        ),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Nurse-PSC',
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            Text(
              'Pelajar',
              overflow: TextOverflow.fade,
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        ),
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorLight,
              ])),
        ),
      ),
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        strokeWidth: 3.0,
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: [
              SizedBox(
                height: 330,
                child: ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        colors: <Color>[
                          Theme.of(context).primaryColor.withAlpha(100),
                          Theme.of(context).primaryColorLight.withAlpha(100),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 300,
                child: ClipPath(
                  clipper: WaveClipperOne(),
                  child: Container(
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
              ),
              SizedBox(
                height: 315,
                child: ClipPath(
                  clipper: WaveClipperOne(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        colors: <Color>[
                          Theme.of(context).primaryColor.withAlpha(100),
                          Theme.of(context).primaryColorLight.withAlpha(100),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Halo, $namaUser!',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Card(
                        elevation: 6,
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            GestureDetector(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: const Icon(
                                    Icons.book_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                                title: const Text(
                                  'Materi',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                  ),
                                ),
                                subtitle: const Text('Materi pembelajaran'),
                                trailing: const Icon(Icons.arrow_forward_ios),
                              ),
                              onTap: () {},
                            ),
                            GestureDetector(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: const Icon(
                                    Icons.edit_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                                title: const Text(
                                  'Soal',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                  ),
                                ),
                                subtitle: const Text('Soal pembelajaran'),
                                trailing: const Icon(Icons.arrow_forward_ios),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 6,
                        margin: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: const ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.logout_rounded,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                              ),
                            ),
                            subtitle: Text('Keluar dari akun'),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          onTap: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.question,
                              animType: AnimType.scale,
                              title: 'Keluar',
                              desc: 'Anda yakin ingin keluar?',
                              btnOkOnPress: () {
                                ApiDatabase().logout();
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              },
                              btnCancelOnPress: () {},
                            ).show();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
