import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_taker/shared/repository/note_repository.dart';

import 'event.dart';
import 'state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final NoteRepository _noteRepository;
  HomeScreenBloc(this._noteRepository): super(HomeScreenState()) {
    on<LoadNotesEvent>(_loadNotes);
  }

  Future<void> _loadNotes(LoadNotesEvent event, Emitter<HomeScreenState> emit) async {
    final notes = await _noteRepository.getNotes();
    emit(HomeScreenState(notes: notes));
  }
}