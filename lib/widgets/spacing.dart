import 'package:flutter/cupertino.dart';

/// Helper class for other spacing functionality.
class Spacing {
  /// Value for padding between the window edge and body elements.
  static const double screen = 16;

  /// A [Padding] widget that applies `screenSpacing` padding to its child.
  static Widget screenSpacer({required Widget child}) => Padding(
        padding: const EdgeInsets.all(screen),
        child: child,
      );

  /// The minimum size of the window before we enforce a smaller screen layout.
  static const double smallLayoutSize = 350;

  /// The height of the Notes Shade.
  static const double shadeHeight = 200;

  /// The padding between notes cards.
  static const double cardSpacing = 16;

  /// Minimum size of the program.
  static const Size minimumWindowSize = Size(300, 600);

  static bool isWideScreen(BuildContext context) =>
      MediaQuery.of(context).size.width > Spacing.smallLayoutSize;
}
