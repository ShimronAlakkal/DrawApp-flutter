import 'package:drawing_app/tools/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:drawing_app/model/datapoints.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double strokeWidth = 1;
  Color brushColorDefault = Colors.black;
  List<DataPoints> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.9,
        child: GestureDetector(
          onPanDown: (details) {
            setState(() {
              points.add(
                DataPoints(
                  points: details.localPosition,
                  brushColor: this.brushColorDefault,
                  stroke: this.strokeWidth,
                  
                ),
              );
            });
          },
          onPanUpdate: (details) {
            setState(() {
              points.add(details.localPosition);
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.9,
            child: CustomPaint(
              painter: Painter(
                  points: this.points,
                  stroke: this.strokeWidth,
                  color: this.brushColorDefault),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[200],
        ),
        height: MediaQuery.of(context).size.height * 0.1,
        margin: EdgeInsets.only(left: 7, right: 7, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
                color: this.brushColorDefault,
                onPressed: () {
                  //choose color pallette

                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Brush Color'),
                        content: MaterialPicker(
                            pickerColor: this.brushColorDefault,
                            onColorChanged: (newColor) {
                              setState(() {
                                this.brushColorDefault = newColor;
                              });
                            }),
                        actions: [
                          OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Set Color"))
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.color_lens_outlined)),
            Slider(
                value: strokeWidth,
                max: 10,
                min: 1,
                onChanged: (value) {
                  setState(() {
                    strokeWidth = value;
                  });
                }),
            IconButton(
                onPressed: () {
                  setState(() {
                    try {
                      this.points.removeLast();
                    } on RangeError {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Not Drawn Yet"),
                        ),
                      );
                    }
                  });
                },
                icon: Icon(Icons.undo)),
          ],
        ),
      ),
    );
  }
}
