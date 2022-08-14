import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/notes/note_model.dart';
import 'package:my_app/widgets/note_widget.dart';

/// Provides information about the notes, and synchronises this with UI elements.
final notesProvider = StateNotifierProvider<NotesNotifier, List<NoteModel>>(
    (ref) => NotesNotifier(animatedListKey: ref.read(animatedListKeyProvider)));

/// Provides a key to synchronise the state of the animated list and the notes provider
final animatedListKeyProvider =
    Provider<GlobalKey<AnimatedListState>>((ref) => GlobalKey());

class NotesNotifier extends StateNotifier<List<NoteModel>> {
  NotesNotifier({required this.animatedListKey}) : super([]);

  final GlobalKey<AnimatedListState> animatedListKey;

  void addNote(String content) {
    state = [
      ...state,
      NoteModel(
        content: content,
        created: DateTime.now(),
      )
    ];

    animatedListKey.currentState!.insertItem(
      state.length - 1,
      duration: const Duration(milliseconds: 100),
    );
  }

  void setNote(int index, String newContent) {
    state = [
      for (int i = 0; i < state.length; i++)
        index == i ? state[i].copyWith(content: newContent) : state[i]
    ];
  }

  void delNote(int index) {
    NoteModel toDelete = state[index];
    state = [
      for (int i = 0; i < state.length; i++)
        if (index != i) state[i]
    ];

    // TODO elevate UI from model
    // TODO smooth shuffling of list contents
    animatedListKey.currentState!.removeItem(
      index,
      duration: const Duration(milliseconds: 250),
      (context, animation) => SlideTransition(
        position:
            Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
                .animate(CurvedAnimation(
                    parent: animation, curve: Curves.fastLinearToSlowEaseIn)),
        child: DeletingNoteWidget(
          content: toDelete.content,
        ),
      ),
    );
  }

  NoteModel getNote(int index) => state[index];
}
