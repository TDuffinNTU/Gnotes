import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'note_model.freezed.dart';
part 'note_model.g.dart';

@freezed
class NoteModel with _$NoteModel {
  factory NoteModel({
    required String id,
    required String content,
    required DateTime created,
    @ColorJsonConverter() Color? color,
  }) = _NoteModel;

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
}

class ColorJsonConverter implements JsonConverter<Color?, int?> {
  const ColorJsonConverter();

  @override
  Color? fromJson(int? json) {
    return json != null ? Color(json) : null;
  }

  @override
  int? toJson(Color? object) {
    return object?.value;
  }
}
