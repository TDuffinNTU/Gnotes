import 'package:contextual_menu/contextual_menu.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:my_app/models/notes_model.dart';

import '../screens/edit_note_screen.dart';

class NoteWidget extends ConsumerWidget {
  NoteWidget({
    Key? key,
    required this.context,
    required this.index,
    required this.content,
    required this.animation,
  }) : super(key: key);

  final BuildContext context;
  final int index;
  final String content;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool rightClickEvent = false;
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        child: Listener(
          onPointerDown: (event) {
            rightClickEvent = event.kind == PointerDeviceKind.mouse &&
                event.buttons == kSecondaryMouseButton;
          },
          onPointerUp: (event) async {
            if (rightClickEvent) {
              await popUpContextualMenu(_menu,
                  position: Offset(
                    event.position.dx,
                    event.position.dy,
                  ),
                  placement: Placement.bottomLeft);
            }
          },
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

  final Menu _menu = Menu(
    items: [
      MenuItem(
        label: 'Copy',
        onClick: (_) {
          print('Clicked Copy');
        },
      ),
      MenuItem(
        label: 'Disabled item',
        disabled: true,
      ),
      MenuItem.checkbox(
        key: 'checkbox1',
        label: 'Checkbox1',
        checked: true,
        onClick: (menuItem) {
          print('Clicked Checkbox1');
          menuItem.checked = !(menuItem.checked == true);
        },
      ),
      MenuItem.separator(),
    ],
  );
}
