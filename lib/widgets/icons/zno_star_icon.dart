//Converted from SVG to CustomPainter using https://fluttershapemaker.com/

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ZnoStarIcon extends CustomPainter {
  const ZnoStarIcon();

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(18.9999, 2.33337);
    path_0.lineTo(24.1499, 12.7667);
    path_0.lineTo(35.6666, 14.45);
    path_0.lineTo(27.3333, 22.5667);
    path_0.lineTo(29.2999, 34.0334);
    path_0.lineTo(18.9999, 28.6167);
    path_0.lineTo(8.69992, 34.0334);
    path_0.lineTo(10.6666, 22.5667);
    path_0.lineTo(2.33325, 14.45);
    path_0.lineTo(13.8499, 12.7667);
    path_0.lineTo(18.9999, 2.33337);
    path_0.close();

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1097368;
    paint0Stroke.strokeCap = StrokeCap.round;
    paint0Stroke.strokeJoin = StrokeJoin.round;
    paint0Stroke.shader = ui.Gradient.linear(
        Offset(size.width * 0.9473684, size.height),
        Offset(size.width * 0.05263158, size.height * 0.2027027),
        const [Color(0xffCD9D34), Color(0xffFFF375)],
        [0, 1]);
    canvas.drawPath(path_0, paint0Stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
