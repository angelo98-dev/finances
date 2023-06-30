import 'dart:ui';

import 'package:finances/core/theme/color.dart';
import 'package:finances/modules/home/widgets/app_shadow_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Widget used to show a Blur over a view and a Widget over it.
///
/// This Widget should be placed over the view that has to be blurred.
///
/// [ContextualBlurScope] can then be accessed using the `ContextualBlurScope.of(context)` method.
///
class ContextualBlurScope extends StatefulWidget {
  const ContextualBlurScope({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  static ContextualBlurScopeState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ContextualBlurData>()!
        .data;
  }

  @override
  State<ContextualBlurScope> createState() => ContextualBlurScopeState();
}

class ContextualBlurScopeState extends State<ContextualBlurScope> {
  Offset _childOffset = Offset.zero;
  Size _childSize = Size.zero;
  Widget? _child;

  void _updateParameters({
    required Offset offset,
    required Size size,
    required Widget? child,
  }) {
    if (mounted &&
        (child != _child || offset != _childOffset || size != _childSize)) {
      setState(() {
        _child = child;
        _childOffset = offset;
        _childSize = size;
      });
    }
  }

  /// Opens a dialog pointing to a Widget.
  ///
  /// The [offset] is used to position the [child].
  ///
  /// The [child] is the Widget that will replace the pointed widget.
  void showBlur({
    required Offset offset,
    required Size size,
    required Widget child,
  }) {
    _updateParameters(
      child: child,
      offset: offset,
      size: size,
    );
  }

  /// Closes an opened dialog.
  void hideBlur() {
    _updateParameters(
      child: null,
      offset: Offset.zero,
      size: Size.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _ContextualBlurData(
      data: this,
      child: Stack(
        children: [
          widget.child,
          _ContextualBlur(
            onTap: hideBlur,
            offset: _childOffset,
            size: _childSize,
            child: _child,
          ),
        ],
      ),
    );
  }
}

class _ContextualBlurData extends InheritedWidget {
  const _ContextualBlurData({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final ContextualBlurScopeState data;

  @override
  bool updateShouldNotify(_ContextualBlurData oldWidget) {
    return child != oldWidget.child || data != oldWidget.data;
  }
}

/// Displays a blur over all the view and positioned a [child] over it at [childBox] position.
class _ContextualBlur extends ConsumerStatefulWidget {
  const _ContextualBlur({
    Key? key,
    required this.offset,
    required this.size,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  final Offset offset;
  final Size size;
  final Widget? child;
  final VoidCallback onTap;

  @override
  _ContextualBlurState createState() => _ContextualBlurState();
}

class _ContextualBlurState extends ConsumerState<_ContextualBlur>
    with SingleTickerProviderStateMixin {
  late final AnimationController _blurController;

  @override
  void initState() {
    super.initState();
    _blurController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void didUpdateWidget(_ContextualBlur oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.offset != oldWidget.offset ||
        widget.size != oldWidget.size ||
        widget.child != oldWidget.child) {
      if (widget.child != null) {
        _startBlur();
      } else {
        _stopBlur();
      }
    }
  }

  Future<void> _startBlur() async {
    await _blurController.forward();
  }

  Future<void> _stopBlur() async {
    await _blurController.reverse();
  }

  @override
  void dispose() {
    _blurController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(appColorThemeProvider);
    final safeChild = widget.child;

    if (safeChild == null) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        AnimatedBuilder(
          animation: _blurController,
          builder: (context, child) {
            return GestureDetector(
              onTap: widget.onTap,
              behavior: HitTestBehavior.opaque,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 4 * _blurController.value,
                  sigmaY: 4 * _blurController.value,
                ),
                child: ColoredBox(
                  color: colors.neutral800.withOpacity(
                    _blurController.value.clamp(0, 0.44),
                  ),
                  child: const Center(),
                ),
              ),
            );
          },
        ),
        Positioned(
          top: widget.offset.dy,
          left: widget.offset.dx,
          height: widget.size.height,
          width: widget.size.width,
          child: AppShadowBox.custom(
            offset: const Offset(0, 4),
            shadowOpacity: 0.05,
            blurRadius: 10,
            borderRadius: BorderRadius.circular(12),
            child: safeChild,
          ),
        ),
      ],
    );
  }
}
