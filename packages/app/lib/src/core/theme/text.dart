import 'package:finance_core/src/core/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'text.freezed.dart';

Provider<AppTextTheme> textThemeProvider = Provider<AppTextTheme>((ref) {
  return AppTextTheme.main();
});

@freezed
class AppTextTheme with _$AppTextTheme {
  const factory AppTextTheme({
    required AppTextStyle h1,
    required AppTextStyle h2,
    required AppTextStyle h3,
    required AppTextStyle h4,
    required AppTextStyle subtitle,
    required AppTextStyle body,
    required AppTextStyle caption,
    required AppTextStyle legend,
  }) = _AppTextTheme;

  const AppTextTheme._();

  factory AppTextTheme.main() => AppTextTheme(
        h1: AppTextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w600,
        ),
        h2: AppTextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w600,
        ),
        h3: AppTextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
        h4: AppTextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        subtitle: AppTextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
        body: AppTextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        caption: AppTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        legend: AppTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      );
}

class AppTextStyle {
  AppTextStyle({
    this.fontFamily = defaultFontFamily,
    this.fontSize,
    this.fontWeight,
  }) : _appColorTheme = AppColorTheme.light();

  TextStyle withColor(Color color) => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  final AppColorTheme _appColorTheme;
  final String? fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;

  static const defaultFontFamily = 'Lato';

  TextStyle get primary => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: _appColorTheme.primary,
      );

  TextStyle get secondary => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: _appColorTheme.secondary,
      );

  TextStyle get surface => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: _appColorTheme.surface,
      );
}

extension TextStyleExtension on TextStyle {
  TextStyle get normal => copyWith(fontWeight: FontWeight.normal);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle withOpacity(double opacity) => copyWith(
        color: color?.withOpacity(opacity),
      );
}
