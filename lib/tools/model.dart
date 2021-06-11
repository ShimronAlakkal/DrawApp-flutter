import 'dart:ui';
import 'package:drawing_app/model/datapoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  List<List<DataPoints>> points = [];

  Painter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    penTool(this.points, canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void penTool(List<List<DataPoints>> points, Canvas canvas, Size size) {
    for (int i = 0; i < this.points.length; i++) {
      for (int j = 0; j < this.points[i].length - 1; j++) {
        canvas.drawLine(points[i][j].points, points[i][j + 1].points,
            points[i][j].painterObject);
      }
    }
  }
}
