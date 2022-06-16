import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notesProvider =
    StateNotifierProvider<NotesNotifier, List<Note>>((ref) => NotesNotifier());

@immutable
class Note {
  const Note({required this.content});
  final String content;

  Note copyWith({String? content}) {
    return Note(content: content ?? this.content);
  }
}

class NotesNotifier extends StateNotifier<List<Note>> {
  NotesNotifier() : super([]);

  void addNote(String content) => state = [...state, Note(content: content)];

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

  Note getNote(int index) => state[index];
}
