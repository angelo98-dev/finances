import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'color.freezed.dart';

//No manage dark theme in this version
final appColorThemeProvider = Provider<AppColorTheme>((ref) {
  return AppColorTheme.light();
});

@freezed
class AppColorTheme with _$AppColorTheme {
  const factory AppColorTheme({
    required Color primary,
    required Color primaryVariant,
    required Color primaryVariant2,
    required Color secondary,
    required Color secondaryVariant,
    required Color background,
    required Color surface,
    required Color neutral800,
    required Color neutral700,
    required Color neutral600,
    required Color neutral400,
    required Color neutral200,
    required Color black,
    required Color neutral100,
    required Color neutral0,
  }) = _AppColorTheme;

  factory AppColorTheme.light() => const AppColorTheme(
        primary: Color.fromARGB(255, 47, 47, 47),
        primaryVariant2: Color(0xFF365A8B),
        primaryVariant: Color(0xFF290455),
        secondary: Color(0xFFFF7272),
        secondaryVariant: Color(0xFF290423),
        background: Color.fromARGB(255, 217, 219, 236),
        surface: Color(0xFFFFFFFF),
        black: Colors.black,
        neutral800: Color(0xFF434D61),
        neutral700: Color(0xFF4C576D),
        neutral600: Color(0xFF687693),
        neutral400: Color(0xFFB2BBCE),
        neutral200: Color(0xFFDAE2F1),
        neutral100: Color(0xFFF0EDF3),
        neutral0: Color(0xFFFFFFFF),
      );
}

extension ColorThemeExtensions on AppColorTheme {
  Color get transparent => const Color(0x00000000);
}
