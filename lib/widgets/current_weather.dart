import 'package:flutter/material.dart';

class CurrentWeather extends StatelessWidget {
  final String? name;
  final String? condition;
  final double? temp;
  final double? maxTemp;
  final double? minTemp;
  final double? windSpeed;

  const CurrentWeather({
    this.name,
    this.condition,
    this.temp,
    this.maxTemp,
    this.minTemp,
    this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        margin: const EdgeInsets.all(6),
        color: Colors.transparent,
        child: Column(
          children: [
            Text(
              name!,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontFamily: 'Pattaya',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              condition!.toUpperCase(),
              style: const TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 10,),
            Text(
              'Temperature: ${temp!.toStringAsPrecision(2)} \u2103',
              style: const TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Max: ${maxTemp!.toStringAsPrecision(2)} \u2103',
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  'Min: ${minTemp!.toStringAsPrecision(2)} \u2103',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Text(
              'Wind Speed $windSpeed m/s',
              style: const TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
