//Converted from SVG to CustomPainter using https://fluttershapemaker.com/

import 'package:flutter/material.dart';

class ZnoBookIcon extends CustomPainter {
  final Color color;
  const ZnoBookIcon({this.color = const Color(0xffF4F4F4)});

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1666672, size.height * 0.8061171);
    path_0.cubicTo(
        size.width * 0.1666672,
        size.height * 0.7787073,
        size.width * 0.1776417,
        size.height * 0.7524220,
        size.width * 0.1971770,
        size.height * 0.7330390);
    path_0.cubicTo(
        size.width * 0.2167120,
        size.height * 0.7136585,
        size.width * 0.2432070,
        size.height * 0.7027683,
        size.width * 0.2708350,
        size.height * 0.7027683);
    path_0.lineTo(size.width * 0.8333350, size.height * 0.7027683);

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
    path_1.moveTo(size.width * 0.2708350, size.height * 0.08267878);
    path_1.lineTo(size.width * 0.8333350, size.height * 0.08267878);
    path_1.lineTo(size.width * 0.8333350, size.height * 0.9094659);
    path_1.lineTo(size.width * 0.2708350, size.height * 0.9094659);
    path_1.cubicTo(
        size.width * 0.2432070,
        size.height * 0.9094659,
        size.width * 0.2167120,
        size.height * 0.8985780,
        size.width * 0.1971770,
        size.height * 0.8791976);
    path_1.cubicTo(
        size.width * 0.1776417,
        size.height * 0.8598146,
        size.width * 0.1666672,
        size.height * 0.8335293,
        size.width * 0.1666672,
        size.height * 0.8061195);
    path_1.lineTo(size.width * 0.1666672, size.height * 0.1860273);
    path_1.cubicTo(
        size.width * 0.1666672,
        size.height * 0.1586176,
        size.width * 0.1776417,
        size.height * 0.1323305,
        size.width * 0.1971770,
        size.height * 0.1129488);
    path_1.cubicTo(
        size.width * 0.2167120,
        size.height * 0.09356732,
        size.width * 0.2432070,
        size.height * 0.08267878,
        size.width * 0.2708350,
        size.height * 0.08267878);
    path_1.lineTo(size.width * 0.2708350, size.height * 0.08267878);
    path_1.close();

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
