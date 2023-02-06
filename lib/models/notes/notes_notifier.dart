import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/notes/note_model.dart';

/// Provides information about the notes, and synchronises this with UI elements.
final notesProvider = StateNotifierProvider<NotesNotifier, List<NoteModel>>(
    (ref) => NotesNotifier());

/// Provides a key to synchronise the state of the animated list and the notes provider
final animatedListKeyProvider =
    Provider<GlobalKey<AnimatedListState>>((ref) => GlobalKey());

class NotesNotifier extends StateNotifier<List<NoteModel>> {
  NotesNotifier() : super([]);

  void addNote(String content) {
    state = [
      ...state,
      NoteModel(
        content: content,
        created: DateTime.now(),
      )
    ];
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
