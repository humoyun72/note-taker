import 'package:note_taker/shared/model/note.dart';

class NoteRepository {
  final List<Note> notes = List.generate(
      10,
      (index) => Note(
          id: index,
          title: "Title $index",
          content: "Content $index"
      )
  );

  Future<List<Note>> getNotes() async {
    return notes;
  }
}