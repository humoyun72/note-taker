import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: 50)();

  TextColumn get content => text()();
}

@DriftDatabase(tables: [Notes])
class NotesDatabase extends _$NotesDatabase {
  NotesDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Create
  Future<int> insertNote(NotesCompanion note) => into(notes).insert(note);

  // Read all notes
  Future<List<Note>> getAllNotes() => select(notes).get();

  // Read one note by id
  Future<Note?> getNoteById(int id) {
    return (select(notes)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  // Update
  Future<bool> updateNote(Note note) => update(notes).replace(note);

  // Delete
  Future<int> deleteNoteById(int id) =>
      (delete(notes)..where((tbl) => tbl.id.equals(id))).go();

  // @override
  // MigrationStrategy get migration => MigrationStrategy(
  //   onCreate: (Migrator m) async {
  //     await m.createAll();
  //
  //     await batch((b) {
  //       b.insert(
  //         notes,
  //         NotesCompanion.insert(title: 'Mock1', content: 'Mock1 content'),
  //       );
  //     });
  //   },
  //   onUpgrade: (Migrator m, int from, int to) async {
  //     if (from < 1) {
  //       // Add any upgrade logic here if needed
  //     }
  //   },
  // );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'notes.sqlite'));
    return NativeDatabase(file);
  });
}
