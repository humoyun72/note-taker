abstract class CreateUpdateNoteScreenEvent {
  const CreateUpdateNoteScreenEvent();
}

class NoteTitleChangedEvent extends CreateUpdateNoteScreenEvent {
  final String title;

  const NoteTitleChangedEvent(this.title);
}

class NoteContentChangedEvent extends CreateUpdateNoteScreenEvent {
  final String content;

  const NoteContentChangedEvent(this.content);
}

class NoteSavedEvent extends CreateUpdateNoteScreenEvent {
  const NoteSavedEvent();
}
