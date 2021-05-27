import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';

class LineChart extends StatelessWidget {
  final List<Feature> features;

  LineChart(this.features);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.transparent,
            Colors.white,
          ]
        ),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 64.0),
            child: Text(
              "Temperature Curve For Next 5 Days",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Pattaya',
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Colors.white,
              ),
            ),
          ),
          LineGraph(
            features: features,
            size: Size(300, 400),
            labelX: ['Temperature', 'Max Temp', 'Min Temp'],
            labelY: ['-30', '-20', '-10', '0', '10', '20', '30', '40', '50'],
            showDescription: true,
            graphColor: Colors.white,
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
