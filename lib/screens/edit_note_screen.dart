import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/notes_model.dart';

class EditNoteScreen extends ConsumerWidget {
  final int index;

  const EditNoteScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // read used here because otherwise we're gonna have a bad time
    final TextEditingController tec =
        TextEditingController(text: ref.read(notesProvider)[index].content);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: TextFormField(
              controller: tec,
              maxLines: 10,
            ),
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                ref.watch(notesProvider.notifier).delNote(index);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton(
              onPressed: () {
                ref.watch(notesProvider.notifier).setNote(index, tec.text);
                Navigator.of(context).pop();
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ],
    );
  }
}
