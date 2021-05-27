import 'package:flutter/material.dart';

class ThemeCard extends StatelessWidget {
  final String name;
  final List<Color>? gradientColors;
  final Function changeTheme;

  ThemeCard(
    this.name,
    this.gradientColors,
    this.changeTheme,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white54,
      child: TextButton(
        onPressed: () {
          if (gradientColors != null) {
            print(gradientColors);
            changeTheme(gradientColors);
          }
        },
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      elevation: 2,
    );
  }
}
