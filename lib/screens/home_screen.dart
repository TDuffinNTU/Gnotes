import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/notes/note_model.dart';
import 'package:my_app/widgets/note_widget.dart';
import 'package:my_app/models/notes/notes_notifier.dart';
import 'package:my_app/widgets/spacing.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: AdwaitaThemeData.light(),
      darkTheme: AdwaitaThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<NoteModel> notes = ref.watch(notesProvider);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Spacing.screenSpacer(
            child: notes.isEmpty
                ? const Text('Add a note below...')
                : Wrap(
                    spacing: Spacing.noteHorizontal,
                    runSpacing: Spacing.noteVertical,
                    children: List.generate(
                      notes.length,
                      (index) => NoteWidget(
                        context: context,
                        index: index,
                        content: notes[index].content,
                      ),
                    ),
                  ),
          ),
        ),
      ),
      floatingActionButton: TextButton(
        child: const Text('Add Note'),
        onPressed: () {
          ref.watch(notesProvider.notifier).addNote('New Note');
        },
      ),
    );
  }
}
