import 'package:flutter/material.dart';

const List<Color> listColor = [
  Colors.red,
  Colors.amber,
  Colors.blue,
  Colors.green,
  Colors.indigo,
  Colors.pink,
];

class AppTheme {
  final int colorSelect;

  AppTheme({required this.colorSelect})
    : assert(colorSelect >= 0, 'Error no puede ser igual a 0 '),
      assert(colorSelect < listColor.length, 'Error color invalido');

  ThemeData getTheme() {
    return ThemeData(colorSchemeSeed: listColor[colorSelect]);
  }
}
