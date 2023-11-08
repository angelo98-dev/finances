import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'animations.freezed.dart';

final appAnimationThemeProvider = Provider<AppAnimationTheme>((ref) {
  return AppAnimationTheme.animations;
});

@freezed
class AppAnimationTheme with _$AppAnimationTheme {
  const factory AppAnimationTheme({
    required Duration zero,
    required Duration veryFast,
    required Duration fast,
    required Duration normal,
    required Duration slow,
    required Duration verySlow,
  }) = _AppAnimationTheme;

  static const animations = AppAnimationTheme(
    zero: Duration.zero,
    veryFast: Duration(milliseconds: 100),
    fast: Duration(milliseconds: 200),
    normal: Duration(milliseconds: 300),
    slow: Duration(milliseconds: 400),
    verySlow: Duration(milliseconds: 500),
  );
}
