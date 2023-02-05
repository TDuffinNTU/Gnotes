import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_app/widgets/spacing.dart';

class NotesShade extends StatelessWidget {
  const NotesShade({super.key, required this.isOpen});

  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    // Sync the scrolling state of the notes view to the scrollbar.
    final scrollController = ScrollController();

    return Container(
      color: Theme.of(context).cardColor,
      child: Scrollbar(
        controller: scrollController,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: Spacing.shadeHeight),
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                30,
                (index) => const Padding(
                  padding: EdgeInsets.all(Spacing.cardSpacing),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Placeholder(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    )
        .animate(
          target: isOpen ? 0 : 1,
        )
        .slideY(
          duration: 200.ms,
          curve: Curves.easeInOut,
          end: -1,
        );
  }
}
