import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/note_model.dart';

final animatedListKeyProvider =
    Provider((ref) => GlobalKey<AnimatedListState>());

final notesProvider = StateNotifierProvider<NotesNotifier, List<NoteModel>>(
    (ref) => NotesNotifier(listKey: ref.read(animatedListKeyProvider)));

class NotesNotifier extends StateNotifier<List<NoteModel>> {
  NotesNotifier({required this.listKey}) : super([]);

  final GlobalKey<AnimatedListState> listKey;

  AnimatedListState? get _animatedList => listKey.currentState;

  void addNote(String content) {
    state = [...state, NoteModel(content: content)];
    _animatedList!.insertItem(state.length - 1,
        duration: const Duration(milliseconds: 100));
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

  NoteModel getNote(int index) => state[index];
}
