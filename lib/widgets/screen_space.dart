import 'package:flutter/cupertino.dart';

/// Helper class to ensure constant spacing around the app.
class ScreenSpacing extends StatelessWidget {
  const ScreenSpacing({required this.child}) : super(key: null);

  static const double screenSpacing = 32;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(screenSpacing),
      child: child,
    );
  }
}
