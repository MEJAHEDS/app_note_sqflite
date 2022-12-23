import 'package:app_note_sqflite/model/note.dart';
import 'package:flutter/material.dart';
import 'package:app_note_sqflite/sqldb.dart';
import 'package:app_note_sqflite/loading.dart';
import '../loading.dart';

class Read extends StatefulWidget {
  const Read({super.key});

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> {
  final numbers = <int>[1, 2, 3];
  final notes = <Note>[];
  Listd() async {
    var len = await Sqldb().notes();
    notes.clear();
    for (var i = 0; i < len.length; i++) {
      notes.add(len[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    Listd();

    return notes != null
        ? ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 27, 95, 211))),
                    child: ListTile(
                      title: Text(
                        " " + notes[index].toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await Sqldb().deleteNote(notes[index].id);
                      setState(() {});
                    },
                    child: Text("Delete"),
                  ),
                ],
              );
            })
        : Loading();
  }
}
