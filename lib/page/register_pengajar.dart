import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

List<String> genderOptions = ['Male', 'Female', 'Other'];

class RegisterPengajar extends StatefulWidget {
  const RegisterPengajar({super.key});

  @override
  State<RegisterPengajar> createState() => _RegisterPengajarState();
}

class _RegisterPengajarState extends State<RegisterPengajar> {
  // String _valGender = _listGender.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: FormBuilder(
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
                  child: FormBuilderDropdown<String>(
                    name: 'gender',
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      // initialValue: 'Male',
                      suffix: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          // _formKey.currentState!.fields['gender']?.reset();
                        },
                      ),
                      hintText: 'Select Gender',
                    ),
                    items: genderOptions
                        .map((gender) => DropdownMenuItem(
                              alignment: AlignmentDirectional.center,
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
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
      ),
    );
  }
}
