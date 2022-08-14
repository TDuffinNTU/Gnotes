import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/notes/note_model.dart';
import 'package:my_app/models/notes/notes_notifier.dart';
import 'package:my_app/widgets/notes_appbar_contet.dart';
import 'package:my_app/widgets/notes_drawer.dart';
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
      appBar: AppBar(
        // TODO grab title from "selected note" provider
        title: const Text('TITLE GOES HERE'),
        centerTitle: true,
        leading: const NotesAppbarContent(),
      ),
      drawer: const NotesDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Spacing.screenSpacer(
            child:
                notes.isEmpty ? const Text('Add a note below...') : Container(),
          ),
        ),
      ),
    );
  }
}
