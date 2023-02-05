import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intersperse/intersperse.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:my_app/models/notes/notes_notifier.dart';
import 'package:my_app/widgets/note_widget.dart';
import 'package:my_app/widgets/spacing.dart';

/// DEPRECATED.
class NotesListView extends ConsumerWidget {
  const NotesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Spacing.screenSpacer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AdwButton(
                onPressed: () =>
                    ref.read(notesProvider.notifier).addNote('New Note'),
                child: const Icon(Icons.add),
              ),
              //const Text('Your Notes'),
              if (!Spacing.isWideScreen(context))
                AdwButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Icon(Icons.chevron_left),
                )
            ]
                .intersperse(
                  const SizedBox(width: Spacing.cardSpacing),
                )
                .toList(),
          ),
        ),
        const Divider(),
        Expanded(
          child: AnimatedList(
            controller: ScrollController(),
            initialItemCount: ref.watch(notesProvider).length,
            shrinkWrap: true,
            key: ref.read(animatedListKeyProvider),
            itemBuilder: (_, index, animation) {
              return SizeTransition(
                key: UniqueKey(),
                sizeFactor: animation,
                child: NoteWidget(
                  index: index,
                  content: ref.read(notesProvider)[index].content,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
