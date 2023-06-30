import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tap_builder/tap_builder.dart';

export 'package:tap_builder/tap_builder.dart' show TapState;

class GestureBuilder extends StatefulWidget {
  const GestureBuilder({
    Key? key,
    required this.builder,
    this.autofocus = false,
    this.canRequestFocus = true,
    this.focusNode,
    this.mouseCursor,
    this.onFocusChange,
    this.onTap,
    this.semanticLabel,
  }) : super(key: key);

  final TapWidgetBuilder builder;
  final bool autofocus;
  final bool canRequestFocus;
  final FocusNode? focusNode;
  final MouseCursor? mouseCursor;
  final ValueChanged<bool>? onFocusChange;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  State<GestureBuilder> createState() => _GestureBuilderState();
}

class _GestureBuilderState extends State<GestureBuilder> {
  FocusNode? _internalNode;
  FocusNode get focusNode => widget.focusNode ?? _internalNode!;

  @override
  void initState() {
    super.initState();
    _initNode();
  }

  @override
  void dispose() {
    _internalNode?.dispose();
    super.dispose();
  }

  void _initNode() {
    if (widget.focusNode == null) {
      _internalNode = FocusNode();
    }
    focusNode.onKeyEvent = (node, event) => _onKeyEvent(event);
  }

  @override
  void didUpdateWidget(covariant GestureBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      _initNode();
    }
  }

  KeyEventResult _onKeyEvent(KeyEvent event) {
    final logicalKey = event.logicalKey == LogicalKeyboardKey.enter;
    final physicalKey = event.physicalKey == PhysicalKeyboardKey.enter;
    final handle = event is KeyDownEvent && (logicalKey || physicalKey);
    final effectiveOnTap = widget.onTap;

    if (effectiveOnTap != null && handle) {
      effectiveOnTap();

      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics.fromProperties(
      properties: SemanticsProperties(
        button: widget.onTap != null,
        label: widget.semanticLabel,
      ),
      child: TapBuilder(
        canRequestFocus: widget.canRequestFocus,
        onFocusChange: widget.onFocusChange,
        onTap: widget.onTap,
        focusNode: focusNode,
        autofocus: widget.autofocus,
        builder: widget.builder,
        mouseCursorBuilder: (context, state, isFocused) =>
            widget.mouseCursor ??
            defaultMouseCursorBuilder(
              context,
              state,
              isFocused,
            ),
      ),
    );
  }
}
