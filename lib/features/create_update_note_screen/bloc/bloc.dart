import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_taker/shared/repository/note_repository.dart';

import 'event.dart';
import 'state.dart';

class CreateUpdateNoteScreenBloc
    extends Bloc<CreateUpdateNoteScreenEvent, CreateUpdateNoteScreenState> {
  final NoteRepository _noteRepository;

  CreateUpdateNoteScreenBloc(this._noteRepository, super.initialState) {
    on<NoteTitleChangedEvent>(_onTitleChanged);
    on<NoteContentChangedEvent>(_onContentChanged);
    on<NoteSavedEvent>(_onNoteSaved);
  }

  Future<void> _onTitleChanged(
    NoteTitleChangedEvent event,
    Emitter<CreateUpdateNoteScreenState> emit,
  ) async {
    emit(state.copyWith(note: state.note.copyWith(title: event.title)));
  }

  Future<void> _onContentChanged(
    NoteContentChangedEvent event,
    Emitter<CreateUpdateNoteScreenState> emit,
  ) async {
    emit(state.copyWith(note: state.note.copyWith(content: event.content)));
  }

  Future<void> _onNoteSaved(
    NoteSavedEvent event,
    Emitter<CreateUpdateNoteScreenState> emit,
  ) async {
    await _noteRepository.saveNote(state.note);
  }
}
