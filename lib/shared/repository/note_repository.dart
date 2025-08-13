import 'package:note_taker/shared/db/database.dart';

class NoteRepository {
  final NotesDatabase _notesDatabase;

  NoteRepository(this._notesDatabase);

  Future<List<Note>> getNotes() async {
    await _notesDatabase.insertNote(NotesCompanion.insert(
      title: "Mock note",
      content: "Mock1 content",
    ));

    return _notesDatabase.getAllNotes();
  }

  Future<void> saveNote(Note note) async {
    if (note.id == 0) {
      await _notesDatabase.insertNote(
        NotesCompanion.insert(title: note.title, content: note.content),
      );
    } else {
      await _notesDatabase.updateNote(note);
    }
  }
}
