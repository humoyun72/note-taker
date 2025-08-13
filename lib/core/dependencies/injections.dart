import 'package:get_it/get_it.dart';
import 'package:note_taker/features/home_screen/injections.dart';
import 'package:note_taker/shared/db/database.dart';
import 'package:note_taker/shared/repository/note_repository.dart';

void initAppDependencies() {
  initSharedDependencies();
  initHomeScreenDependencies();
}

void initSharedDependencies() {
  GetIt.I.registerSingleton(NotesDatabase());
  GetIt.I.registerSingleton(NoteRepository(GetIt.I.get()));
}
