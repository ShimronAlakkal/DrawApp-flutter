import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Brush extends CustomPainter {
  double stroke;
  Color brushColor;
  List<Offset> points;
  Brush({required this.stroke, required this.brushColor, required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint bg = Paint()..color = Colors.white;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawRect(rect, bg);

    Paint brush = Paint();
    brush.color = brushColor;
    brush.strokeCap = StrokeCap.round;
    brush.strokeWidth = stroke;

    for (int i = 0; i < points.length; i++) {
      canvas.drawLine(points[i], points[i + 1], brush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
