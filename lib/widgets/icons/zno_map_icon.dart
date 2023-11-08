//Converted from SVG to CustomPainter using https://fluttershapemaker.com/

import 'package:flutter/material.dart';

class ZnoMapIcon extends CustomPainter {
  final Color color;
  const ZnoMapIcon({this.color = const Color(0xffF4F4F4)});

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1250000, size.height * 0.7767850);
    path_0.cubicTo(
        size.width * 0.1250000,
        size.height * 0.7767850,
        size.width * 0.1718750,
        size.height * 0.7285725,
        size.width * 0.3125000,
        size.height * 0.7285725);
    path_0.cubicTo(
        size.width * 0.4531250,
        size.height * 0.7285725,
        size.width * 0.5468750,
        size.height * 0.8250000,
        size.width * 0.6875000,
        size.height * 0.8250000);
    path_0.cubicTo(
        size.width * 0.8281250,
        size.height * 0.8250000,
        size.width * 0.8750000,
        size.height * 0.7767850,
        size.width * 0.8750000,
        size.height * 0.7767850);
    path_0.lineTo(size.width * 0.8750000, size.height * 0.1982142);
    path_0.cubicTo(
        size.width * 0.8750000,
        size.height * 0.1982142,
        size.width * 0.8281250,
        size.height * 0.2464285,
        size.width * 0.6875000,
        size.height * 0.2464285);
    path_0.cubicTo(
        size.width * 0.5468750,
        size.height * 0.2464285,
        size.width * 0.4531250,
        size.height * 0.1500000,
        size.width * 0.3125000,
        size.height * 0.1500000);
    path_0.cubicTo(
        size.width * 0.1718750,
        size.height * 0.1500000,
        size.width * 0.1250000,
        size.height * 0.1982142,
        size.width * 0.1250000,
        size.height * 0.1982142);
    path_0.lineTo(size.width * 0.1250000, size.height * 0.7767850);
    path_0.close();

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.07500000;
    paint0Stroke.color = color;
    paint0Stroke.strokeCap = StrokeCap.round;
    paint0Stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_0, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0x00000000);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.2750000, size.height * 0.6250000);
    path_1.lineTo(size.width * 0.2750000, size.height * 0.2500000);

    Paint paint1Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.07500000;
    paint1Stroke.color = color;
    paint1Stroke.strokeCap = StrokeCap.round;
    paint1Stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_1, paint1Stroke);

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0x00000000);
    canvas.drawPath(path_1, paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
