import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/home_screen/home_screen_notifier.dart';
import 'package:my_app/models/notes/notes_notifier.dart';
import 'package:my_app/widgets/note_widget.dart';
import 'package:my_app/widgets/spacing.dart';

class NotesShade extends ConsumerWidget {
  const NotesShade({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sync the scrolling state of the notes view to the scrollbar.
    final scrollController = ScrollController();

    return Container(
      color: Theme.of(context).cardColor,
      child: Scrollbar(
        controller: scrollController,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: Spacing.shadeHeight,
            minHeight: Spacing.shadeHeight,
            minWidth: double.infinity,
          ),
          child: ref.read(notesProvider).isEmpty
              ? const Center(child: Text('No Notes'))
              : SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        ref.watch(notesProvider).length,
                        (index) => AspectRatio(
                          aspectRatio: 1,
                          child: NoteWidget(
                            index: index,
                            content: ref.watch(notesProvider)[index].content,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    )
        .animate(
          target: ref.watch(homeScreenStateProvider).isNoteShadeOpen ? 0 : 1,
        )
        .slideY(
          duration: 200.ms,
          curve: Curves.easeInOut,
          end: -1,
        );
  }
}
