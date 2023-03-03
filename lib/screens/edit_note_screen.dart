import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/notes/notes_notifier.dart';
import 'package:my_app/widgets/spacing.dart';

import '../models/notes/note_model.dart';

class EditNoteScreen extends ConsumerWidget {
  const EditNoteScreen({super.key, required this.note});

  final NoteModel note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController tec = TextEditingController(text: note.content);
    return Spacing.screenSpacer(
      child: Column(
        children: [
          Card(
            child: TextFormField(
              controller: tec,
              maxLines: 10,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  ref.watch(notesProvider.notifier).updateNote(note);
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
              TextButton(
                onPressed: () {
                  ref.watch(notesProvider.notifier).deleteNote(note);
                  Navigator.of(context).pop();
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
