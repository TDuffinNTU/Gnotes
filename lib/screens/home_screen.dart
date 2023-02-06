import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/notes/notes_notifier.dart';
import 'package:my_app/widgets/spacing.dart';

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
                ref.read(notesProvider.notifier).addNote('Hello world!'),
          ),
          const SizedBox(
            height: 8,
          ),
          FloatingActionButton(
            backgroundColor: Theme.of(context).cardColor,
            onPressed: () => setState(() {
              open = !open;
            }),
            tooltip: 'Toggle Notes Shade',
            child: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Stack(
        children: [
          // TODO create a state provider for isOpen and other homepage state rubbish...
          NoteView(isOpen: open),
          NotesShade(isOpen: open),
        ],
      ),
    );
  }
}

// TODO move to own file
class NoteView extends StatelessWidget {
  const NoteView({super.key, required this.isOpen});

  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: 100.ms,
        curve: Curves.easeInOutCubicEmphasized,
        height: isOpen ? height - Spacing.shadeHeight : height,
        child: Spacing.screenSpacer(
          child: const Placeholder(),
        ),
      ),
    );
  }
}
