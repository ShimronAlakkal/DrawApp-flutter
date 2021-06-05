import 'package:drawing_app/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Offset> points = [];
  var stroke;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: GestureDetector(
              child: CustomPaint(
                painter: Brush(
                  points: points,
                  brushColor: Colors.black,
                  stroke: 2,
                ),
              ),
              onPanDown: (detail) {
                setState(() {
                  points.add(detail.localPosition);
                  print(points);
                });
              },
              onPanUpdate: (detail) {
                setState(() {
                  points.add(detail.localPosition);
                  print(points);
                });
              },
              onPanEnd: (det) {
                setState(() {});
              },
            ),
          ),
          Container(
            child: Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.color_lens_outlined)),
                Slider(
                    value: stroke,
                    onChanged: (value) {
                      setState(() {
                        stroke = value;
                      });
                    },
                    max: 10,
                    min: 1),
                IconButton(onPressed: () {}, icon: Icon(Icons.undo_rounded)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
