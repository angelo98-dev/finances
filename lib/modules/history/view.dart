import 'package:finances/core/theme/color.dart';
import 'package:finances/core/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@riverpod
String city(CityRef ref) => 'France';

class HistoryView extends ConsumerWidget {
  const HistoryView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = ref.watch(textThemeProvider);
    final color = ref.watch(appColorThemeProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.surface,
        title: Text(
          'SpendWise',
          style: style.h4.primary,
        ),
      ),
    );
  }
}
