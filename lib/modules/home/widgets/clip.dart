import 'package:flutter/material.dart';

class ClipperWidget extends CustomClipper<Path> {
  ClipperWidget({
    required this.waveList,
  });
  final List<Offset> waveList;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.addPolygon(waveList, false);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
