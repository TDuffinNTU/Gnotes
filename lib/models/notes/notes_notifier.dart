import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/notes/note_model.dart';

final notesProvider = StateNotifierProvider<NotesNotifier, List<NoteModel>>(
    (ref) => NotesNotifier());

class NotesNotifier extends StateNotifier<List<NoteModel>> {
  NotesNotifier() : super([]);

  // TODO can we use local_hero somehow..?
  void addNote(String content) {
    state = [...state, NoteModel(content: content)];
  }

  void setNote(int index, String newContent) {
    state = [
      for (int i = 0; i < state.length; i++)
        index == i ? state[i].copyWith(content: newContent) : state[i]
    ];
  }

  void delNote(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (index != i) state[i]
    ];
  }

  NoteModel getNote(int index) => state[index];
}
