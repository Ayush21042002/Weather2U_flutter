import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather2u/api/api_constants.dart';
import 'package:weather2u/utils/color_scheme.dart';
import 'package:weather2u/widgets/theme_selector.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather2u/widgets/weather_display.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late WeatherFactory ws;
  late Position _currentPosition;
  String _city = "";

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    ws = new WeatherFactory(ApiConstants.API_KEY);

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _currentPosition = await Geolocator.getCurrentPosition();
    return _currentPosition;
  }

  Map<String, List<Color>> _gradientsList = {
    'Mid-Night': [
      ApplicationColors.midnightStartColor,
      ApplicationColors.midnightEndColor
    ],
    'Night': [
      ApplicationColors.nightStartColor,
      ApplicationColors.nightEndColor
    ],
    'Twilight': [
      ApplicationColors.twilightStartColor,
      ApplicationColors.twilightEndColor
    ],
    'Dawn-Dusk': [
      ApplicationColors.dawnDuskStartColor,
      ApplicationColors.dawnDuskEndColor
    ],
    'Morning-Eve': [
      ApplicationColors.morningEveStartColor,
      ApplicationColors.morningEveEndColor
    ],
    'Day': [ApplicationColors.dayStartColor, ApplicationColors.dayEndColor],
  };

  Color _gradientStart = ApplicationColors.dayStartColor;
  Color _gradientEnd = ApplicationColors.dayEndColor;

  void _changeTheme(List<Color> colors) {
    if (colors[0] != _gradientStart || colors[1] != _gradientEnd) {
      setState(() {
        _gradientStart = colors[0];
        _gradientEnd = colors[1];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: _determinePosition(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error.toString()}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: Text(
                    'Could Not access user location',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }

              return Scaffold(
                backgroundColor: Colors.blueGrey,
                body: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 25,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            'Weather2U',
                            style: TextStyle(
                              fontFamily: 'Pattaya',
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 40,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.white,
                            width: 4,
                          )),
                          margin: const EdgeInsets.all(4),
                          child: Card(
                            color: Colors.transparent,
                            elevation: 3,
                            child: Column(
                              children: [
                                TextField(
                                  onSubmitted: (value) {
                                    if (value.trim().isNotEmpty) {
                                      setState(() {
                                        _city = value;
                                      });
                                    }
                                  },
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Pattaya'),
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    labelText: 'Enter City',
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Pattaya',
                                    ),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _city = "";
                                      });
                                    },
                                    child: const Text(
                                      'Current Location',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        WeatherDisplay(_currentPosition, _city, ws),
                        ThemeSelector(_gradientsList, _changeTheme),
                      ],
                    ),
                  ),
                  height: double.infinity,
                  // width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    _gradientStart,
                    _gradientEnd,
                  ])),
                ),
              );
            }),
      ),
    );
  }
}
