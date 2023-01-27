import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/widgets/notes_appbar_contet.dart';
import 'package:my_app/widgets/notes_list_view.dart';
import 'package:my_app/widgets/spacing.dart';

/// Provides a key to keep the scaffold's state in sync with the window state
final homeScreenScaffoldKeyProvider =
    Provider<GlobalKey<ScaffoldState>>((ref) => GlobalKey());

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
    bool widescreen = Spacing.isWideScreen(context);

    // Close the drawer before we destroy it.
    if (!widescreen) {
      final scaffoldState =
          ref.read(homeScreenScaffoldKeyProvider).currentState!;
      if (scaffoldState.hasDrawer) {
        scaffoldState.closeDrawer();
      }
    }
    return Scaffold(
      key: ref.read(homeScreenScaffoldKeyProvider),
      appBar: AppBar(
        // TODO grab title from "selected note" provider
        title: const Text('TITLE GOES HERE'),
        centerTitle: true,
        leading: widescreen ? null : const NotesAppbarContent(),
      ),
      drawer: widescreen ? null : const Drawer(child: NotesListView()),
      body: widescreen
          ? Flex(
              direction: Axis.horizontal,
              children: [
                const SizedBox(
                  width: 250,
                  child: NotesListView(),
                ),
                const VerticalDivider(),
                Container(),
              ],
            )
          : Container(),
    );
  }
}
