import 'package:finances/core/theme/text.dart';
import 'package:finances/modules/home/widgets/app_gesture_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppDialog extends ConsumerWidget {
  const AppDialog({
    Key? key,
    this.title,
    required this.content,
    this.primaryActionLabel,
    this.primaryActionCallback,
    this.secondaryActionLabel,
    this.secondaryActionCallback,
  }) : super(key: key);

  final String? title;
  final String content;
  final String? primaryActionLabel;
  final VoidCallback? primaryActionCallback;
  final String? secondaryActionLabel;
  final VoidCallback? secondaryActionCallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeTitle = title;
    final safePrimaryActionLabel = primaryActionLabel;
    final safeSecondaryActionLabel = secondaryActionLabel;
    final hasActions =
        safePrimaryActionLabel != null || safeSecondaryActionLabel != null;
    final styles = ref.watch(textThemeProvider);

    return AlertDialog(
      backgroundColor: Colors.white,
      semanticLabel: safeTitle,
      insetPadding: const EdgeInsets.all(14),
      titlePadding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      contentPadding: EdgeInsets.fromLTRB(
        10,
        safeTitle != null ? 10 : 15,
        10,
        hasActions ? 10 : 15,
      ),
      actionsPadding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titleTextStyle: styles.h4.primary.normal,
      title: safeTitle != null
          ? Text(
              safeTitle,
              textAlign: TextAlign.center,
            )
          : null,
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: styles.body.primary,
      ),
      actions: hasActions
          ? [
              if (safePrimaryActionLabel != null)
                ElevatedButton(
                  onPressed: primaryActionCallback,
                  child: Text(
                    safePrimaryActionLabel,
                  ),
                ),
              if (safeSecondaryActionLabel != null)
                Padding(
                  padding: EdgeInsets.only(
                    top: safePrimaryActionLabel != null ? 15 : 0,
                  ),
                  child: Center(
                    child: AppGestureBuilder(
                      onTap: secondaryActionCallback,
                      child: Text(
                        safeSecondaryActionLabel,
                        style: styles.subtitle.primary,
                      ),
                    ),
                  ),
                ),
            ]
          : null,
    );
  }
}
