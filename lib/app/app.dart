import 'package:finances/core/theme/color.dart';
import 'package:finances/core/theme/text.dart';
import 'package:finances/modules/home/view.dart';
import 'package:finances/modules/home/widgets/contextual_blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(appColorThemeProvider);
    final styles = ref.watch(textThemeProvider);

    return MaterialApp(
      title: 'SpendWise',
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: color.neutral100,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: color.primary,
              textStyle: styles.subtitle.surface,
              //a11y button recommandation min height
              minimumSize: const Size.fromHeight(kMinInteractiveDimension),
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: const Color(0xFF755EE8),
            foregroundColor: color.background,
          )),
      home: const Material(
        child: ContextualBlurScope(
          child: HomePage(
            title: 'SpendWise',
          ),
        ),
      ),
    );
  }
}
