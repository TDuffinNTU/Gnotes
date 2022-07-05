import 'package:flutter/cupertino.dart';

/// Helper class for other spacing functionality.
class Spacing {
  /// Value for padding between the window edge and body elements.
  static const double screen = 32;

  /// Horizontal space between individual notes in a grid view.
  static const double noteHorizontal = 16;

  /// Vertical space between individual notes in a grid view.
  static const double noteVertical = 16;

  /// A [Padding] widget that applies `screenSpacing` padding to its child.
  static Widget screenSpacer({required Widget child}) => Padding(
        padding: const EdgeInsets.all(screen),
        child: child,
      );
}
