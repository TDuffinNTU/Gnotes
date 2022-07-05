import 'package:contextual_menu/contextual_menu.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:my_app/models/notes/notes_notifier.dart';

import '../screens/edit_note_screen.dart';

class NoteWidget extends ConsumerWidget {
  const NoteWidget({
    Key? key,
    required this.context,
    required this.index,
    required this.content,
  }) : super(key: key);

  final BuildContext context;
  final int index;
  final String content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool rightClickEvent = false;
    return Listener(
      onPointerDown: (event) {
        rightClickEvent = event.kind == PointerDeviceKind.mouse &&
            event.buttons == kSecondaryMouseButton;
      },
      onPointerUp: (event) async {
        if (rightClickEvent) {
          await popUpContextualMenu(_buildMenu(ref),
              position: Offset(
                event.position.dx,
                event.position.dy,
              ),
              placement: Placement.bottomRight);
        }
      },
      child: Card(
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 100,
            maxWidth: 350,
            minHeight: 200,
            maxHeight: 200,
          ),
          child: AdwActionRow(
            title: content,
            end: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref.read(notesProvider.notifier).delNote(index);
              },
            ),
            onActivated: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditNoteScreen(index: index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Menu _buildMenu(WidgetRef ref) {
    return Menu(
      items: [
        MenuItem(
          label: 'Delete',
          onClick: (_) => ref.read(notesProvider.notifier).delNote(index),
        ),
        MenuItem(label: 'Edit'),
        MenuItem(label: 'Duplicate'),
      ],
    );
  }
}
