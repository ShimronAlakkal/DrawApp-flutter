import 'dart:ui';
import 'package:drawing_app/model/datapoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  List<DataPoints> points = [];

  Painter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    if (this.points.length > 1) {
      for (int i = 0; i < points.length - 1; i++) {
        if (!points[i].lifted) {
          canvas.drawLine(
              points[i].points, points[i + 1].points, points[i].painterObject);
        } else if (points[i].lifted) {
          canvas.drawLine(points[i + 1].points, points[i + 1].points,
              points[i + 1].painterObject);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
