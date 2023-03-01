import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/home_screen/home_screen_notifier.dart';
import 'package:my_app/widgets/spacing.dart';

class NoteView extends ConsumerWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: 100.ms,
        curve: Curves.easeInOutCubicEmphasized,
        height: ref.watch(homeScreenStateProvider).isNoteShadeOpen
            ? height - Spacing.shadeHeight
            : height,
        child: Spacing.screenSpacer(
          child: const Placeholder(),
        ),
      ),
    );
  }
}
