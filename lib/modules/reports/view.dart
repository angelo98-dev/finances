import 'package:finances/core/theme/color.dart';
import 'package:finances/core/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Reports extends ConsumerWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = ref.watch(textThemeProvider);
    final colors = ref.watch(appColorThemeProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Text(
          'Reports',
          style: styles.h4.primary,
        ),
      ),
    );
  }
}
