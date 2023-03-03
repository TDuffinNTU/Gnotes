import 'package:contextual_menu/contextual_menu.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:my_app/models/notes/note_model.dart';
import 'package:my_app/models/notes/notes_notifier.dart';

import '../models/home_screen/home_screen_notifier.dart';

class NoteWidget extends ConsumerWidget {
  const NoteWidget({
    super.key,
    required this.note,
  });

  final NoteModel note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool rightClickEvent = false;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Listener(
        onPointerDown: (event) {
          rightClickEvent = event.kind == PointerDeviceKind.mouse &&
              event.buttons == kSecondaryMouseButton;
        },
        onPointerUp: (event) async {
          if (rightClickEvent) {
            await popUpContextualMenu(
              _buildMenu(ref),
              position: Offset(
                event.position.dx,
                event.position.dy,
              ),
              placement: Placement.bottomRight,
            );
          }
        },
        child: Card(
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 100,
              maxWidth: 350,
              minHeight: 80,
              maxHeight: 80,
            ),
            child: AdwActionRow(
              title: note.content,
              end: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ref.read(notesProvider.notifier).deleteNote(note);
                },
              ),
              onActivated: () =>
                  ref.read(homeScreenStateProvider.notifier).selectNote(note),
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
          onClick: (_) => ref.read(notesProvider.notifier).deleteNote(note),
        ),
        MenuItem(label: 'Edit'),
        MenuItem(label: 'Duplicate'),
      ],
    );
  }
}
