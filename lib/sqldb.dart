import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/note.dart';

class Sqldb {
  Future<Database> sqflite() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'notes_database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, note TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

  Future<void> insertNote(Note note) async {
    // Get a reference to the database.
    final db = await sqflite();

    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("insert successfully");
  }

  Future<List<Note>> notes() async {
    // Get a reference to the database.
    final db = await sqflite();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('notes');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'],
        note: maps[i]['note'],
      );
    });
  }

  Future<void> updateNote(Note note) async {
    // Get a reference to the database.
    final db = await sqflite();

    // Update the given Dog.
    await db.update(
      'notes',
      note.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(int id) async {
    // Get a reference to the database.
    final db = await sqflite();

    // Remove the Dog from the database.
    await db.delete(
      'notes',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> deleteAllNote() async {
    // Get a reference to the database.
    final db = await sqflite();

    // Remove the Dog from the database.
    await db.delete(
      'notes',
      // Use a `where` clause to delete a specific dog.
    );
  }

  Stream<List<Note>> get notes {
    return sqflite().asStream().map((event) => event.query('notes')).map(
        (event) => event.map((e) => Note.fromMap(e)).toList(growable: false));
  }
}
