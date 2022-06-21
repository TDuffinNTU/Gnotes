import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/widgets/note_widget.dart';
import 'package:my_app/models/notes_model.dart';
import 'package:my_app/widgets/screen_space.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
    List<Note> notes = ref.watch(notesProvider);
    return Scaffold(
      body: Center(
        child: ScreenSpacing(
          child: AnimatedList(
            key: ref.read(animatedListKeyProvider),
            itemBuilder: (context, index, animation) {
              return NoteWidget(
                animation: animation,
                context: context,
                index: index,
                content: notes[index].content,
              );
            },
          ),
        ),
      ),
      floatingActionButton: TextButton(
          child: const Text('Add Note'),
          onPressed: () {
            ref.watch(notesProvider.notifier).addNote('New Note');
          }),
    );
  }
}
