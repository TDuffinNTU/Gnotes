import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class NotesAppbarContent extends StatelessWidget {
  const NotesAppbarContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AdwButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        child: Transform.translate(
          offset: const Offset(-4, 0),
          child: const Icon(
            Icons.chevron_right,
            size: 18,
          ),
        ),
      ),
    );
  }
}
