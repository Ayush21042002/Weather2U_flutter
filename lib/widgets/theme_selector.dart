import 'package:flutter/material.dart';
import 'package:weather2u/widgets/theme_card.dart';

class ThemeSelector extends StatelessWidget {
  final Map<String, List<Color>> list;

  final Function changeTheme;

  ThemeSelector(this.list, this.changeTheme);

  @override
  Widget build(BuildContext context) {
    final labels = list.keys.toList();
    final rows = labels.length ~/ 3;
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const Card(
            color: Colors.transparent,
            child: Text(
              'Choose Theme',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Pattaya'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, idx) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ThemeCard(
                    labels[idx * 3],
                    list[labels[idx * 3]],
                    changeTheme,
                  ),
                  ThemeCard(
                    labels[idx * 3 + 1],
                    list[labels[idx * 3 + 1]],
                    changeTheme,
                  ),
                  ThemeCard(
                    labels[idx * 3 + 2],
                    list[labels[idx * 3 + 2]],
                    changeTheme,
                  ),
                ],
              ),
              itemCount: rows,
            ),
          ),
        ],
      ),
    );
  }
}
