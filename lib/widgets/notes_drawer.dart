import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intersperse/intersperse.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:my_app/models/notes/notes_notifier.dart';
import 'package:my_app/widgets/note_widget.dart';

class NotesDrawer extends ConsumerWidget {
  const NotesDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AdwButton(
                  onPressed: () =>
                      ref.watch(notesProvider.notifier).addNote('New Note'),
                  child: const Icon(Icons.add),
                ),
                const Text('Your Notes'),
                AdwButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Icon(Icons.chevron_left),
                )
              ].intersperse(const SizedBox(width: 8)).toList(),
            ),
          ),
          const Divider(),
          Expanded(
            child: AnimatedList(
              controller: ScrollController(),
              initialItemCount: ref.watch(notesProvider).length,
              shrinkWrap: true,
              key: ref.watch(animatedListKeyProvider),
              itemBuilder: (_, index, animation) {
                return SizeTransition(
                  key: UniqueKey(),
                  sizeFactor: animation,
                  child: NoteWidget(
                    index: index,
                    content: ref.watch(notesProvider)[index].content,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
