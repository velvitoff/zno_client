import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class GoldenBorder extends CustomPainter {
  GoldenBorder({required this.sWidth});

  final double sWidth;
  final Paint p = Paint();
  final radius = const Radius.circular(10);

  @override
  void paint(Canvas canvas, Size size) {
    RRect innerRect = RRect.fromRectAndRadius(
        Rect.fromLTRB(
            sWidth, sWidth, size.width - sWidth, size.height - sWidth),
        radius);
    RRect outerRect = RRect.fromRectAndRadius(Offset.zero & size, radius);

    p.shader = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(size.width, size.height),
        const [Color(0xFFFFE042), Color(0xFFEDC453)]);
    Path borderPath = _calculateBorderPath(outerRect, innerRect);
    canvas.drawPath(borderPath, p);
  }

  Path _calculateBorderPath(RRect outerRect, RRect innerRect) {
    Path outerRectPath = Path()..addRRect(outerRect);
    Path innerRectPath = Path()..addRRect(innerRect);
    return Path.combine(PathOperation.difference, outerRectPath, innerRectPath);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
