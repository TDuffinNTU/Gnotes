import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:my_app/edit_note_screen.dart';
import 'package:my_app/notes_model.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

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
        child: Padding(
          padding: const EdgeInsets.all(30),
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
    return SlideTransition(
      // TODO sort out this anim...
      position: Tween<Offset>(begin: Offset(-.5, 0), end: Offset.zero).animate(
          CurvedAnimation(parent: animation, curve: Curves.elasticInOut)),
      child: AdwActionRow(
        title: content,
        end: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {},
        ),
        onActivated: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditNoteScreen(index: index),
          ),
        ),
      ),
    );
  }
}
