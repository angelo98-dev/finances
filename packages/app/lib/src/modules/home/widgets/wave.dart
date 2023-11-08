import 'dart:math' as math;

import 'package:finance_core/src/modules/home/widgets/clip.dart';
import 'package:flutter/material.dart';

class WaveWidget extends StatefulWidget {
  const WaveWidget({
    super.key,
    required this.size,
    required this.yOffset,
    required this.color,
    required this.child,
  });

  final Size size;
  final double yOffset;
  final Color color;
  final Widget child;

  @override
  // ignore: library_private_types_in_public_api
  _WaveWidgetState createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> with TickerProviderStateMixin {
  late AnimationController animationController;
  List<Offset> wavePoints = [];

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000))
      ..addListener(() {
        wavePoints.clear();

        final double waveSpeed = animationController.value * 1080;
        final double fullSphere = animationController.value * math.pi * 2;
        final double normalizer = math.cos(fullSphere);
        const double waveWidth = math.pi / 50;
        const double waveHeight = 1.0;

        for (int i = 0; i <= widget.size.width.toInt(); ++i) {
          double calc = math.sin((waveSpeed - i) * waveWidth);
          wavePoints.add(
            Offset(
              i.toDouble(), //X
              calc * waveHeight * normalizer + widget.yOffset, //Y
            ),
          );
        }
      });

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        return ClipPath(
          clipper: ClipperWidget(
            waveList: wavePoints,
          ),
          child: widget.child,
        );
      },
    );
  }
}
