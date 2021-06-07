import 'package:flutter/cupertino.dart';

class DataPoints {
  List<Offset> points = [];
  Color brushColor;
  double stroke;

  DataPoints(
      {required this.points, required this.brushColor, required this.stroke});
}
