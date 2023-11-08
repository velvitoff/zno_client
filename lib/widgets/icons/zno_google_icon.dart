//Converted from SVG to CustomPainter using https://fluttershapemaker.com/

import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class ZnoGoogleIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(43.611, 20.083);
    path_0.lineTo(42, 20.083);
    path_0.lineTo(42, 20);
    path_0.lineTo(24, 20);
    path_0.lineTo(24, 28);
    path_0.lineTo(35.303, 28);
    path_0.cubicTo(
        33.653999999999996, 32.657, 29.223, 36, 23.999999999999996, 36);
    path_0.cubicTo(17.372999999999998, 36, 11.999999999999996, 30.627,
        11.999999999999996, 24);
    path_0.cubicTo(11.999999999999996, 17.373, 17.372999999999998, 12,
        23.999999999999996, 12);
    path_0.cubicTo(
        27.058999999999997, 12, 29.841999999999995, 13.154, 31.961, 15.039);
    path_0.lineTo(37.617999999999995, 9.382);
    path_0.cubicTo(34.046, 6.053, 29.268, 4, 24, 4);
    path_0.cubicTo(12.955, 4, 4, 12.955, 4, 24);
    path_0.cubicTo(4, 35.045, 12.955, 44, 24, 44);
    path_0.cubicTo(35.045, 44, 44, 35.045, 44, 24);
    path_0.cubicTo(44, 22.659, 43.862, 21.35, 43.611, 20.083);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xfffbc02d);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(6.306, 14.691);
    path_1.lineTo(12.876999999999999, 19.51);
    path_1.cubicTo(14.655, 15.108, 18.961, 12, 24, 12);
    path_1.cubicTo(27.059, 12, 29.842, 13.154, 31.961, 15.039);
    path_1.lineTo(37.617999999999995, 9.382);
    path_1.cubicTo(34.046, 6.053, 29.268, 4, 24, 4);
    path_1.cubicTo(16.318, 4, 9.656, 8.337, 6.306, 14.691);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xffe53935);
    canvas.drawPath(path_1, paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(24, 44);
    path_2.cubicTo(29.166, 44, 33.86, 42.023, 37.409, 38.808);
    path_2.lineTo(31.218999999999998, 33.57);
    path_2.cubicTo(29.211, 35.091, 26.715, 36, 24, 36);
    path_2.cubicTo(
        18.798000000000002, 36, 14.381, 32.683, 12.717, 28.054000000000002);
    path_2.lineTo(6.195, 33.079);
    path_2.cubicTo(9.505, 39.556, 16.227, 44, 24, 44);
    path_2.close();

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = const Color(0xff4caf50);
    canvas.drawPath(path_2, paint2Fill);

    Path path_3 = Path();
    path_3.moveTo(43.611, 20.083);
    path_3.lineTo(43.595, 20);
    path_3.lineTo(42, 20);
    path_3.lineTo(24, 20);
    path_3.lineTo(24, 28);
    path_3.lineTo(35.303, 28);
    path_3.cubicTo(34.510999999999996, 30.237000000000002, 33.071999999999996,
        32.166, 31.215999999999998, 33.571);
    path_3.cubicTo(31.217, 33.57, 31.217999999999996, 33.57, 31.218999999999998,
        33.568999999999996);
    path_3.lineTo(37.409, 38.806999999999995);
    path_3.cubicTo(36.971, 39.205, 44, 34, 44, 24);
    path_3.cubicTo(44, 22.659, 43.862, 21.35, 43.611, 20.083);
    path_3.close();

    Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = const Color(0xff1565c0);
    canvas.drawPath(path_3, paint3Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
