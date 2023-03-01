import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/home_screen/home_state_model.dart';
import 'package:my_app/models/notes/note_model.dart';

final homeScreenStateProvider =
    StateNotifierProvider<HomeStateNotifier, HomeStateModel>(
        (ref) => HomeStateNotifier());

class HomeStateNotifier extends StateNotifier<HomeStateModel> {
  HomeStateNotifier()
      : super(HomeStateModel(isNoteShadeOpen: true, selectedNote: null));

  void selectNote(NoteModel? note) {
    state = state.copyWith(selectedNote: note);
  }

  void toggleNotesShade() {
    state = state.copyWith(isNoteShadeOpen: !state.isNoteShadeOpen);
  }
}
