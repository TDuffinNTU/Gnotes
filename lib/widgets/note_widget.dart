import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

import '../screens/edit_note_screen.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({
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
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        child: AdwActionRow(
          title: content,
          end: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
          onActivated: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditNoteScreen(index: index),
            ),
          ),
        ),
      ),
    );
  }
}
