//Converted from SVG to CustomPainter using https://fluttershapemaker.com/

import 'package:flutter/material.dart';

class ZnoStorageIcon extends CustomPainter {
  final Color color;
  const ZnoStorageIcon({this.color = const Color(0xffF4F4F4)});

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9166650, size.height * 0.4960732);
    path_0.lineTo(size.width * 0.08333275, size.height * 0.4960732);

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
    path_1.moveTo(size.width * 0.2270828, size.height * 0.2112444);
    path_1.lineTo(size.width * 0.08333275, size.height * 0.4960732);
    path_1.lineTo(size.width * 0.08333275, size.height * 0.7441098);
    path_1.cubicTo(
        size.width * 0.08333275,
        size.height * 0.7660366,
        size.width * 0.09211250,
        size.height * 0.7870659,
        size.width * 0.1077405,
        size.height * 0.8025707);
    path_1.cubicTo(
        size.width * 0.1233685,
        size.height * 0.8180780,
        size.width * 0.1445647,
        size.height * 0.8267878,
        size.width * 0.1666662,
        size.height * 0.8267878);
    path_1.lineTo(size.width * 0.8333325, size.height * 0.8267878);
    path_1.cubicTo(
        size.width * 0.8554350,
        size.height * 0.8267878,
        size.width * 0.8766300,
        size.height * 0.8180780,
        size.width * 0.8922575,
        size.height * 0.8025707);
    path_1.cubicTo(
        size.width * 0.9078875,
        size.height * 0.7870659,
        size.width * 0.9166650,
        size.height * 0.7660366,
        size.width * 0.9166650,
        size.height * 0.7441098);
    path_1.lineTo(size.width * 0.9166650, size.height * 0.4960732);
    path_1.lineTo(size.width * 0.7729150, size.height * 0.2112444);
    path_1.cubicTo(
        size.width * 0.7660175,
        size.height * 0.1974695,
        size.width * 0.7553825,
        size.height * 0.1858773,
        size.width * 0.7422050,
        size.height * 0.1777710);
    path_1.cubicTo(
        size.width * 0.7290300,
        size.height * 0.1696646,
        size.width * 0.7138375,
        size.height * 0.1653659,
        size.width * 0.6983325,
        size.height * 0.1653576);
    path_1.lineTo(size.width * 0.3016650, size.height * 0.1653576);
    path_1.cubicTo(
        size.width * 0.2861625,
        size.height * 0.1653659,
        size.width * 0.2709700,
        size.height * 0.1696646,
        size.width * 0.2577925,
        size.height * 0.1777710);
    path_1.cubicTo(
        size.width * 0.2446172,
        size.height * 0.1858773,
        size.width * 0.2339820,
        size.height * 0.1974695,
        size.width * 0.2270828,
        size.height * 0.2112444);
    path_1.lineTo(size.width * 0.2270828, size.height * 0.2112444);
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

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.2500000, size.height * 0.6614317);
    path_2.lineTo(size.width * 0.2504175, size.height * 0.6614317);

    Paint paint2Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.07500000;
    paint2Stroke.color = color;
    paint2Stroke.strokeCap = StrokeCap.round;
    paint2Stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_2, paint2Stroke);

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = const Color(0x00000000);
    canvas.drawPath(path_2, paint2Fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.4166675, size.height * 0.6614317);
    path_3.lineTo(size.width * 0.4170850, size.height * 0.6614317);

    Paint paint3Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.07500000;
    paint3Stroke.color = color;
    paint3Stroke.strokeCap = StrokeCap.round;
    paint3Stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_3, paint3Stroke);

    Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = const Color(0x00000000);
    canvas.drawPath(path_3, paint3Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
