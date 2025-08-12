import 'package:get_it/get_it.dart';
import 'package:note_taker/features/home_screen/injections.dart';
import 'package:note_taker/shared/repository/note_repository.dart';

void initAppDependencies() {
  initSharedDependencies();
  InitHomeScreenDependencies();
}

void initSharedDependencies() {
  GetIt.I.registerSingleton(NoteRepository());
}