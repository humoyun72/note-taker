import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:note_taker/features/create_update_note_screen/bloc/state.dart';
import 'package:note_taker/shared/db/database.dart';

import 'bloc/bloc.dart';

class CreateUpdateNoteScreenWrapper extends StatelessWidget {
  final Widget child;
  final Note? note;

  const CreateUpdateNoteScreenWrapper({
    super.key,
    required this.child,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateUpdateNoteScreenBloc(
        GetIt.I.get(),
        CreateUpdateNoteScreenState(note),
      ),
      child: child,
    );
  }
}
