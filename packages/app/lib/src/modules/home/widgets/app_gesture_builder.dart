import 'package:finance_core/src/modules/home/widgets/gesture_builder.dart';
import 'package:flutter/widgets.dart';

/// A GestureBuilder with default behavior.
///
/// The default behavior is a scale animation.
class AppGestureBuilder extends StatelessWidget {
  const AppGestureBuilder({
    Key? key,
    this.minScale = 0.9,
    this.maxScale = 1.0,
    this.duration,
    this.alignment = Alignment.center,
    this.curve = Curves.easeInOut,
    this.onTap,
    this.semanticLabel,
    required this.child,
  }) : super(key: key);

  const AppGestureBuilder.upperScale({
    Key? key,
    this.minScale = 0.95,
    this.maxScale = 1.0,
    this.duration,
    this.alignment = Alignment.center,
    this.curve = Curves.easeInOut,
    this.onTap,
    this.semanticLabel,
    required this.child,
  }) : super(key: key);

  final double minScale;
  final double maxScale;
  final Duration? duration;
  final Alignment alignment;
  final Curve curve;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureBuilder(
      semanticLabel: semanticLabel,
      onTap: onTap,
      builder: (context, state, isFocused) {
        final scale = state == TapState.pressed ? minScale : maxScale;

        return AnimatedScale(
          scale: scale,
          duration: duration ?? const Duration(milliseconds: 100),
          alignment: alignment,
          curve: curve,
          child: child,
        );
      },
    );
  }
}
