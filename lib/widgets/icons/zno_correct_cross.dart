//Converted from SVG to CustomPainter using https://fluttershapemaker.com/

import 'package:flutter/material.dart';

class ZnoCorrectCross extends CustomPainter {
  const ZnoCorrectCross();

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0Stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.08510638;
    paint0Stroke.color = const Color(0xff32882A);
    canvas.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(size.width*0.04295830,size.height*0.04440304,size.width*0.9136191,size.height*0.9121174),bottomRight: Radius.circular(size.width*0.1063830),bottomLeft:  Radius.circular(size.width*0.1063830),topLeft:  Radius.circular(size.width*0.1063830),topRight:  Radius.circular(size.width*0.1063830)),paint0Stroke);

    Paint paint0Fill = Paint()..style=PaintingStyle.fill;
    paint0Fill.color = const Color(0x00F4F4F4);
    canvas.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(size.width*0.04295830,size.height*0.04440304,size.width*0.9136191,size.height*0.9121174),bottomRight: Radius.circular(size.width*0.1063830),bottomLeft:  Radius.circular(size.width*0.1063830),topLeft:  Radius.circular(size.width*0.1063830),topRight:  Radius.circular(size.width*0.1063830)),paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width*0.9423830,size.height*0.9318804);
    path_1.lineTo(size.width*0.05034043,size.height*0.06336717);

    Paint paint1Stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.08510638;
    paint1Stroke.color = const Color(0xff32882A);
    canvas.drawPath(path_1,paint1Stroke);

    Paint paint1Fill = Paint()..style=PaintingStyle.fill;
    paint1Fill.color = const Color(0x00000000);
    canvas.drawPath(path_1,paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(size.width*0.06282213,size.height*0.9250696);
    path_2.lineTo(size.width*0.9491894,size.height*0.07585652);

    Paint paint2Stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.08510638;
    paint2Stroke.color = const Color(0xff32882A);
    canvas.drawPath(path_2,paint2Stroke);

    Paint paint2Fill = Paint()..style=PaintingStyle.fill;
    paint2Fill.color = const Color(0x00000000);
    canvas.drawPath(path_2,paint2Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}