import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_taker/features/create_update_note_screen/bloc/bloc.dart';
import 'package:note_taker/features/create_update_note_screen/bloc/event.dart';
import 'package:note_taker/features/create_update_note_screen/bloc/state.dart';
import 'package:note_taker/shared/db/database.dart';

import 'screen_wrapper.dart';

class CreateUpdateNoteScreen extends StatelessWidget {
  final Note? note;

  const CreateUpdateNoteScreen({super.key, this.note});

  @override
  Widget build(BuildContext context) {
    return CreateUpdateNoteScreenWrapper(
      note: note,
      child:
          BlocBuilder<CreateUpdateNoteScreenBloc, CreateUpdateNoteScreenState>(
            builder: (context, state) => Scaffold(
              backgroundColor: Color(0xFFFDF3BF),
              appBar: AppBar(
                backgroundColor: Color(0xFFFDF3BF),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(state.screenTitle),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 32,
                  ),
                  child: Column(
                    children: [
                      _buildTitleField(context, state.note.title),
                      const SizedBox(height: 16),
                      _buildContentField(context, state.note.content),
                      Spacer(),
                      _buildSaveButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildTitleField(BuildContext context, String title) {
    return TextField(
      controller: TextEditingController(text: title)
        ..selection = TextSelection.collapsed(offset: title.length),
      onChanged: (value) {
        context.read<CreateUpdateNoteScreenBloc>().add(
          NoteTitleChangedEvent(value),
        );
      },
      decoration: InputDecoration(
        labelText: 'Title',
        border: OutlineInputBorder(),
      ),
      maxLines: 4,
      minLines: 1,
    );
  }

  Widget _buildContentField(BuildContext context, String content) {
    return TextField(
      controller: TextEditingController(text: content)
        ..selection = TextSelection.collapsed(offset: content.length),
      onChanged: (value) {
        context.read<CreateUpdateNoteScreenBloc>().add(
          NoteContentChangedEvent(value),
        );
      },
      decoration: InputDecoration(
        labelText: 'Content',
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
      ),
      maxLines: 15,
      minLines: 5,
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<CreateUpdateNoteScreenBloc>().add(NoteSavedEvent());
        Navigator.of(context).pop(true);
      },
      child: Text('Save'),
    );
  }
}
