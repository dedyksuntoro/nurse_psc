import 'package:flutter/material.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class RegisterPengajar extends StatefulWidget {
  const RegisterPengajar({super.key});

  @override
  State<RegisterPengajar> createState() => _RegisterPengajarState();
}

class _RegisterPengajarState extends State<RegisterPengajar> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nama',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownMenu<String>(
                  
                  label: const Text('Jenis Kelamin'),
                  initialSelection: list.first,
                  onSelected: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  dropdownMenuEntries:
                      list.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Alamat',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
