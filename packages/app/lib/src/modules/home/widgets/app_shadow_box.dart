import 'package:finance_core/src/core/theme/color.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A common DecoratedBox with shadow and radius.
class AppShadowBox extends ConsumerWidget {
  const AppShadowBox.medium({
    Key? key,
    this.backgroundColor,
    this.borderRadius,
    this.shadowOpacity = 0.5,
    required this.child,
  })  : blurRadius = 16,
        spreadRadius = -5,
        offset = const Offset(0, 10),
        assert(shadowOpacity >= 0 && shadowOpacity <= 1),
        super(key: key);

  const AppShadowBox.large({
    Key? key,
    this.backgroundColor,
    this.borderRadius,
    this.shadowOpacity = 0.5,
    required this.child,
  })  : blurRadius = 24,
        spreadRadius = -5,
        offset = const Offset(0, 10),
        assert(shadowOpacity >= 0 && shadowOpacity <= 1),
        super(key: key);

  const AppShadowBox.custom({
    Key? key,
    this.backgroundColor,
    this.borderRadius,
    this.shadowOpacity = 0.5,
    this.blurRadius = 0,
    this.spreadRadius = 0,
    this.offset = Offset.zero,
    required this.child,
  })  : assert(shadowOpacity >= 0 && shadowOpacity <= 1),
        super(key: key);

  /// The blur radius of the shadow.
  final double blurRadius;

  /// The spread radius of the shadow.
  final double spreadRadius;

  /// The Offset of the shadow.
  final Offset offset;

  /// The radius of the box.
  final BorderRadius? borderRadius;

  /// The color of the background.
  final Color? backgroundColor;

  // The shadow opacity.
  final double shadowOpacity;

  /// The widget below in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appColorThemeProvider);

    final effectiveBackgroundColor = backgroundColor ?? colors.transparent;
    final effectiveBorderRadius = borderRadius ?? BorderRadius.zero;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: effectiveBorderRadius,
        boxShadow: [
          BoxShadow(
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
            offset: offset,
            color: colors.background.withOpacity(shadowOpacity),
          ),
        ],
      ),
      child: child,
    );
  }
}
