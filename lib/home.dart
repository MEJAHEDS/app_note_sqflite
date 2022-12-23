import 'package:app_note_sqflite/sqldb.dart';
import 'package:app_note_sqflite/veiws/add.dart';
import 'package:app_note_sqflite/veiws/read.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'model/note.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Sqldb sqldb = Sqldb();

  get idl => null;

  bool dar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App notes ")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 1, 100, 181),
              ),
              child: Text(
                'Take Note',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            ListTile(
              title: const Text('Add Note'),
              onTap: () {
                setState(() {
                  dar = true;
                });

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Read Notes'),
              onTap: () {
                setState(() {
                  dar = false;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Delete Notes'),
              onTap: () async {
                await Sqldb().deleteAllNote();
                setState(() {
                  dar = false;
                });

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: dar != false ? Add() : Read(),
    );
  }
}
