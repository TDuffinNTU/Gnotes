import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/notes_notifier.dart';
import 'package:my_app/widgets/screen_space.dart';

class EditNoteScreen extends ConsumerWidget {
  final int index;

  const EditNoteScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // read used here because otherwise we're gonna have a bad time
    final TextEditingController tec =
        TextEditingController(text: ref.read(notesProvider)[index].content);
    return ScreenSpacing(
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
                  ref.watch(notesProvider.notifier).setNote(index, tec.text);
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
              TextButton(
                onPressed: () {
                  ref.watch(notesProvider.notifier).delNote(index);
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
