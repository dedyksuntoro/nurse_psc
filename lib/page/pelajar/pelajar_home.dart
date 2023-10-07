import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nurse_psc/page/helper/header_widget.dart';

class PelajarHome extends StatefulWidget {
  const PelajarHome({super.key});

  @override
  State<PelajarHome> createState() => _PelajarHomeState();
}

class _PelajarHomeState extends State<PelajarHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: ClipOval(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person_rounded),
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
                Theme.of(context).colorScheme.secondary,
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
              const SizedBox(
                height: 300,
                child: HeaderWidget(300, false, Icons.house_rounded),
              ),
              Column(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "User Information",
                          style: TextStyle(
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
                          onTap: () {},
                        ),
                      )
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
