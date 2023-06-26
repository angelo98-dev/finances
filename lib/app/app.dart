import 'package:finances/modules/home/view.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mes Enveloppes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(212, 104, 58, 183),
        ),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(212, 104, 58, 183),
            //a11y button recommandation min height
            minimumSize: const Size.fromHeight(kMinInteractiveDimension),
          ),
        ),
      ),
      home: const HomePage(
        title: 'Mes Enveloppes',
      ),
    );
  }
}
