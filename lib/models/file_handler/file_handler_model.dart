import 'dart:io';

import 'package:my_app/models/notes/note_model.dart';
import 'package:path_provider/path_provider.dart';

// THE PLAN: we'll attempt to pull files from this model
// at startup thru NotesNotifier. Note notifier can then
// handle FileHandler's API in sync with its own state, and this can
// just be kept dumb and stateless

/// Notes are stored as individual .txt files that contain
/// the serialised JSON for each note.
///
/// [FileHandler] is a super-simple API to handle getting
/// and setting the data for these notes
class FileHandler {
  /// Finds the location of our notes.
  /// Creates the [Directory] if not found.
  Future<Directory> getNotesPath() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return await Directory('${documentsDirectory.path}/gnotes').create();
  }

  /// Attempts to load notes from the disk.
  /// Returns an empty [List<NoteModel>] if none found.
  Future<List<NoteModel>> getNotes() async {
    throw UnimplementedError();
  }

  /// Saves a [NoteModel] to disk.
  /// Creates the file if it doesn't already exist.
  Future<void> saveNote() async {
    // TODO figure out how we'll sync (likely a unique ID)
    throw UnimplementedError();
  }
}
