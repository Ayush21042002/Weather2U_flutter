import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:weather2u/utils/converter.dart';

class LineChart extends StatelessWidget {
  final List<Feature> features;

  LineChart(this.features);

  @override
  Widget build(BuildContext context) {
    final dates = [1, 2, 3, 4, 5];
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.transparent,
              Colors.white,
            ]),
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
            labelX: dates
                .map(
                  (days) => Converter.dateConverter(
                    DateTime.now().add(
                      Duration(days: days),
                    ),
                  ),
                )
                .toList(),
            labelY: ['-30', '-20', '-10', '0', '10', '20', '30', '40', '50'],
            showDescription: true,
            graphColor: Colors.white,
          ),
          const SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: const Text(
                'Scroll for more measures ---->',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.indigo,
                  fontFamily: 'Pattaya',
                  fontSize: 16,
                ),
              ),
            ),
            height: 50,
          )
        ],
      ),
    );
  }
}
