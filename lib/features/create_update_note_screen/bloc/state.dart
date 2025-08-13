import 'package:note_taker/shared/db/database.dart';

class CreateUpdateNoteScreenState {
  final String screenTitle;
  final Note note;

  CreateUpdateNoteScreenState.full({
    required this.screenTitle,
    required this.note,
  });

  CreateUpdateNoteScreenState(Note? note)
    : note = note ?? Note(id: 0, title: '', content: ''),
      screenTitle = note == null ? 'Create Note' : 'Edit Note';

  CreateUpdateNoteScreenState copyWith({String? screenTitle, Note? note}) {
    return CreateUpdateNoteScreenState.full(
      screenTitle: screenTitle ?? this.screenTitle,
      note: note ?? this.note,
    );
  }
}
