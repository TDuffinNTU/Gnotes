import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_bitsdojo/libadwaita_bitsdojo.dart';
import 'package:my_app/models/notes/note_model.dart';
import 'package:my_app/models/notes/notes_notifier.dart';

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
  bool notesDrawerOpen = true;
  // pull this out into a state management class imo
  int selectedNote = -1;

  @override
  Widget build(BuildContext context) {
    List<NoteModel> notes = ref.watch(notesProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => notes.add(
              NoteModel(
                content: "new note",
                created: DateTime.now(),
              ),
            ),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Row(
        children: [
          if (notesDrawerOpen) NotesDrawer(), // code smell?
          NoteView(),
        ],
      ),
    );
  }
}

class NoteView extends StatelessWidget {
  const NoteView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.black,
      ),
    );
  }
}

class NotesDrawer extends ConsumerWidget {
  const NotesDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<NoteModel> notes = ref.watch(notesProvider);

    return SizedBox(
      width: 300,
      child: notes.isEmpty
          ? const Center(
              child: Text('Add a note...'),
            )
          : ListView(
              children: List.generate(
                notes.length,
                (index) => ListTile(
                  isThreeLine: true,
                  subtitle: Text(notes[index].created.toString()),
                  title: Text(notes[index].content),
                  onTap: () {},
                ),
              ),
            ),
    );
  }
}
