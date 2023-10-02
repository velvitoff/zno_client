//Converted from SVG to CustomPainter using https://fluttershapemaker.com/

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

//Copy this CustomPainter code to the Bottom of the File
class ZnoStarLargeIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(60, 10.0001);
    path_0.lineTo(75.45, 41.3001);
    path_0.lineTo(110, 46.3501);
    path_0.lineTo(85, 70.7001);
    path_0.lineTo(90.9, 105.1);
    path_0.lineTo(60, 88.8501);
    path_0.lineTo(29.1, 105.1);
    path_0.lineTo(35, 70.7001);
    path_0.lineTo(10, 46.3501);
    path_0.lineTo(44.55, 41.3001);
    path_0.lineTo(60, 10.0001);
    path_0.close();

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1000000;
    paint0Stroke.strokeCap = StrokeCap.round;
    paint0Stroke.strokeJoin = StrokeJoin.round;
    paint0Stroke.shader = ui.Gradient.linear(
        Offset(size.width * 0.9250000, size.height * 0.9500000),
        Offset(size.width * 0.07500208, size.height * 0.2125000),
        const [Color(0xffC5942A), Color(0xffFFED2F)],
        [0, 1]);
    canvas.drawPath(path_0, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.08333333, size.height * 0.08333333),
        Offset(size.width * 0.9166667, size.height * 0.8750000),
        const [Color(0xffFFF375), Color(0xffCD9D34)],
        [0, 1]);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
