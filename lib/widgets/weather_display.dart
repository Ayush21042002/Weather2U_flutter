import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather2u/widgets/current_weather.dart';
import 'package:weather2u/widgets/line_chart.dart';

class WeatherDisplay extends StatelessWidget {
  final String city;
  final Position position;
  final WeatherFactory ws;

  WeatherDisplay(this.position, this.city, this.ws);

  Future<List<Weather>> queryWeather(BuildContext context) async {
    print("Called");
    // FocusScope.of(context).requestFocus(FocusNode());
    List<Weather> _weatherData;
    if (city.trim().isEmpty) {
      Weather weather = await ws.currentWeatherByLocation(
        position.latitude,
        position.longitude,
      );
      List<Weather> forecasts = await ws.fiveDayForecastByLocation(
        position.latitude,
        position.longitude,
      );
      _weatherData = [weather, ...forecasts];
    } else {
      Weather weather = await ws.currentWeatherByCityName(city);
      List<Weather> forecasts = await ws.fiveDayForecastByCityName(city);

      _weatherData = [weather, ...forecasts];
    }
    return _weatherData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Weather>>(
      future: queryWeather(context),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              children: [
                CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                Text(
                  'Weather Data Loading......',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                'Restart The App or Enter correct city name',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        }

        // print(snapshot.data![0]);
        // print(snapshot.data![1]);

        List<Weather> forecast =
            snapshot.data!.sublist(1, snapshot.data!.length);

        Weather todayWeather = snapshot.data![0];
        List<Feature> features = [
          Feature(
            title: "Temperature",
            color: Colors.orange,
            data: forecast.map((e) {
              double? temp = e.temperature!.celsius;
              temp = (temp! + 30) / 80;
              return temp;
            }).toList(),
          ),
          Feature(
            title: "Max Temperature",
            color: Colors.red,
            data: forecast.map((e) {
              double? temp = e.tempMax!.celsius;
              temp = (temp! + 30) / 80;
              return temp;
            }).toList(),
          ),
          Feature(
            title: "Min Temperature",
            color: Colors.white,
            data: forecast.map((e) {
              double? temp = e.tempMin!.celsius;
              temp = (temp! + 30) / 80;
              return temp;
            }).toList(),
          ),
        ];

        return SingleChildScrollView(
          child: Column(
            children: [
              CurrentWeather(
                name: '${todayWeather.areaName}, ${todayWeather.country}',
                condition: todayWeather.weatherDescription,
                temp: todayWeather.temperature!.celsius,
                maxTemp: todayWeather.tempMax!.celsius,
                minTemp: todayWeather.tempMin!.celsius,
                windSpeed: todayWeather.windSpeed,
              ),
              LineChart(features),
            ],
          ),
        );
      },
    );
  }
}
