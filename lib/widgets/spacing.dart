import 'package:flutter/cupertino.dart';

/// Helper class for other spacing functionality.
class Spacing {
  /// Value for padding between the window edge and body elements.
  static const double screen = 32;

  /// Horizontal space between individual notes in the list view.
  static const double noteHorizontal = 16;

  /// Vertical space between individual notes in the list view.
  static const double noteVertical = 8;

  /// A [Padding] widget that applies `screenSpacing` padding to its child.
  static Widget screenSpacer({required Widget child}) => Padding(
        padding: const EdgeInsets.all(screen),
        child: child,
      );

  /// The minimum size of the window before we enforce a smaller screen layout.
  static const double smallLayoutSize = 350;

  /// Minimum size of the program.
  static const Size minimumWindowSize = Size(300, 600);
}
