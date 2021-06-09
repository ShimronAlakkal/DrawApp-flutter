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
            setState(
              () {
                // points on start
                points.add(
                  DataPoints(
                    lifted: false,
                    points: details.localPosition,
                    painterObject: Paint()
                      ..color = this.brushColorDefault
                      ..strokeCap = StrokeCap.round
                      ..strokeWidth = this.strokeWidth
                      ..isAntiAlias = true
                      ..filterQuality = FilterQuality.high,
                  ),
                );
              },
            );
          },
          onPanUpdate: (details) {
            setState(
              () {
                // Add the points on drag

                points.add(
                  DataPoints(
                    lifted: false,
                    points: details.localPosition,
                    painterObject: Paint()
                      ..color = this.brushColorDefault
                      ..strokeCap = StrokeCap.round
                      ..strokeWidth = this.strokeWidth
                      ..isAntiAlias = true
                      ..filterQuality = FilterQuality.high,
                  ),
                );
              },
            );
          },
          onPanEnd: (details) {
            setState(
              () {
                points.add(
                  DataPoints(
                    points: this.points[-1].points,
                    painterObject: Paint()..color = Colors.white,
                    lifted: true,
                  ),
                );
              },
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.9,
            child: CustomPaint(
              painter: Painter(
                points: this.points,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(right: 10),
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
                activeColor: this.brushColorDefault,
                value: strokeWidth,
                max: 10,
                min: 1,
                onChanged: (value) {
                  setState(() {
                    strokeWidth = value;
                  });
                }),
            GestureDetector(
              onTap: () {
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
              onLongPress: () {
                setState(() {
                  try {
                    this.points.clear();
                  } on RangeError {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Not Drawn Yet"),
                      ),
                    );
                  }
                });
              },
              child: Icon(
                Icons.undo_rounded,
              ),
            )
          ],
        ),
      ),
    );
  }

// void penTool(List<DataPoints> points){}

}
