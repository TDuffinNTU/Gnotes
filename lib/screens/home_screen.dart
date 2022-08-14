import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/widgets/notes_appbar_contet.dart';
import 'package:my_app/widgets/notes_list_view.dart';
import 'package:my_app/widgets/spacing.dart';
import 'package:window_manager/window_manager.dart';

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
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    bool isWidescreenLayout =
        MediaQuery.of(context).size.width > Spacing.smallLayoutSize;

    // have to set this constantly since some window manager behaviours break the min.size request!
    if (!isWidescreenLayout) {
      // we need a better solution as I fear this is will cause perf. issues
      windowManager.setMinimumSize(Spacing.minimumWindowSize);
    }
    // closes the drawer before we destroy it, otherwise we can cause some lifecycle issues
    if (!isWidescreenLayout) {
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
        leading: isWidescreenLayout ? null : const NotesAppbarContent(),
      ),
      drawer: isWidescreenLayout ? null : const Drawer(child: NotesListView()),
      body: isWidescreenLayout
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
