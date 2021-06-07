import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  double stroke = 2;
  Color color;
  List<Offset> points = [];

  Painter({required this.points, required this.stroke, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Background
    // Paint bg = Paint()..color = Colors.white;
    // Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // canvas.drawRect(rect, bg);

    // paint Brush
    Paint brush = Paint();
    brush.color = this.color;
    brush.strokeCap = StrokeCap.round;
    brush.strokeWidth = this.stroke;
    brush.isAntiAlias = true;
    brush.filterQuality = FilterQuality.high;

    if (this.points.length > 1) {
      for (int i = 0; i < points.length - 1; i++) {
        canvas.drawLine(points[i], points[i + 1], brush);
      }
    } else {
      canvas.drawPoints(PointMode.points, [points[0]], brush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
