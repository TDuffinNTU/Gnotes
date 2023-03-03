import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/notes/note_model.dart';
import 'package:uuid/uuid.dart';

/// Provides information about the notes, and synchronises this with UI elements.
final notesProvider = StateNotifierProvider<NotesNotifier, List<NoteModel>>(
    (ref) => NotesNotifier());

class NotesNotifier extends StateNotifier<List<NoteModel>> {
  NotesNotifier() : super([]);

  void addNote() {
    final id = const Uuid().v1();

    state = [
      ...state,
      NoteModel(
        id: id,
        content: id,
        created: DateTime.now(),
      )
    ];
  }

  void updateNote(NoteModel updatedNote) {
    state = [
      for (NoteModel note in state)
        note.id == updatedNote.id ? updatedNote : note
    ];
  }

  void deleteNote(NoteModel toDelete) {
    // TODO check if homescreenstatemodel is showing this note and unselect it on delete!
    state = state.where((note) => note.id != toDelete.id).toList();
  }
}
