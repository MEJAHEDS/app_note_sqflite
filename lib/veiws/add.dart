import 'package:app_note_sqflite/sqldb.dart';
import 'package:app_note_sqflite/veiws/read.dart';
import 'package:flutter/material.dart';

import 'package:app_note_sqflite/model/note.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();
  String notes = '';
  bool submit = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(44.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Idea',
                ),
                onChanged: ((value) {
                  setState(() => notes = value);
                }),
              ),
              SizedBox(height: 20.0),
              Center(
                child: MaterialButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () async {
                    var len = await Sqldb().notes();
                    var idl = len.length + 1;
                    var fido = Note(id: idl, note: "$notes");
                    await Sqldb().insertNote(fido);
                    setState(() {
                      submit = true;
                    });
                  },
                  child: Text("Note"),
                ),
              ),
            ],
          )),
    );
  }
}
