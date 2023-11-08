import 'package:flutter/material.dart';

extension PercentageExtension on double {
  List<Color> getColorGradient() {
    if (this >= 50) {
      return const [
        Color(0xFF846AFF),
        Color(0xFF755EE8),
        Colors.purpleAccent,
        Color.fromARGB(255, 244, 131, 66),
      ];
    } else if (this > 25) {
      return const [
        Color.fromARGB(255, 255, 81, 81),
        Color.fromARGB(255, 255, 110, 110),
        Colors.purpleAccent,
        Color.fromARGB(255, 244, 131, 66),
      ];
    } else {
      return const [
        Color.fromARGB(255, 255, 46, 46),
        Color.fromARGB(255, 255, 110, 110),
      ];
    }
  }
}
