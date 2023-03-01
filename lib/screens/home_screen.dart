import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/home_screen/home_screen_notifier.dart';
import 'package:my_app/models/notes/notes_notifier.dart';
import 'package:my_app/widgets/note_view.dart';

import '../widgets/notes_shade.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AdwaitaThemeData.light(),
      darkTheme: AdwaitaThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  var open = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Theme.of(context).cardColor,
            onPressed: () =>
                ref.read(notesProvider.notifier).addNote('Hello poop!'),
          ),
          const SizedBox(
            height: 8,
          ),
          FloatingActionButton(
            backgroundColor: Theme.of(context).cardColor,
            onPressed:
                ref.read(homeScreenStateProvider.notifier).toggleNotesShade,
            tooltip: 'Toggle Notes Shade',
            child: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Stack(
        children: const [
          NoteView(),
          NotesShade(),
        ],
      ),
    );
  }
}
