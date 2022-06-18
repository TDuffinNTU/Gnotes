import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final animatedListKeyProvider =
    Provider((ref) => GlobalKey<AnimatedListState>());

final notesProvider = StateNotifierProvider<NotesNotifier, List<Note>>(
    (ref) => NotesNotifier(listKey: ref.read(animatedListKeyProvider)));

@immutable
class Note {
  const Note({required this.content});
  final String content;

  Note copyWith({String? content}) {
    return Note(content: content ?? this.content);
  }
}

class NotesNotifier extends StateNotifier<List<Note>> {
  GlobalKey<AnimatedListState> listKey;

  NotesNotifier({required this.listKey}) : super([]);

  AnimatedListState? get _animatedList => listKey.currentState;

  void addNote(String content) {
    state = [...state, Note(content: content)];
    _animatedList!.insertItem(state.length - 1,
        duration: const Duration(milliseconds: 500));
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
    // TODO implement removeditembuilder
    _animatedList!.removeItem(index, (context, animation) => Container());
  }

  Note getNote(int index) => state[index];
}
