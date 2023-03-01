import 'package:freezed_annotation/freezed_annotation.dart';

import '../notes/note_model.dart';

part 'home_state_model.freezed.dart';

@freezed
class HomeStateModel with _$HomeStateModel {
  factory HomeStateModel({
    required bool isNoteShadeOpen,
    required NoteModel? selectedNote,
  }) = _HomeStateModel;
}
