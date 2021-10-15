import 'package:flutter/material.dart';

class TextModel {
  String name;
  TextStyle textStyle;
  double top;
  double left;
  String key;
  bool isSelected;
  TextAlign textAlign;
  double scale;

  TextModel(
      {required this.name,
      required this.textStyle,
      required this.top,
      required this.key,
      required this.isSelected,
      required this.textAlign,
      required this.scale,
      required this.left});
}
