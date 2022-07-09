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

  @override
  Widget build(BuildContext context) {
    List<NoteModel> notes = ref.watch(notesProvider);
    return AdwScaffold(
      start: [
        SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AdwHeaderButton(
                  onPressed: () => setState(() {
                    notesDrawerOpen = !notesDrawerOpen;
                  }),
                  icon: const Icon(Icons.menu),
                ),
                const Text('Notes'),
                AdwHeaderButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      notes.add(
                        NoteModel(
                          content: 'content',
                          created: DateTime.now(),
                        ),
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        )
      ],
      actions: AdwActions().bitsdojo,
      body: Row(
        children: [
          // ignore: prefer_const_constructors
          if (notesDrawerOpen) NotesDrawer(), // code smell?
          Expanded(
            child: Container(
              color: Colors.black,
            ),
          ),
        ],
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
      child: ListView(
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
