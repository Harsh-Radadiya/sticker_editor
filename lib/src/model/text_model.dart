import 'package:flutter/material.dart';

class TextModel {
  String name;
  TextStyle textStyle;
  double top;
  double left;
  bool isSelected;
  TextAlign textAlign;
  double scale;

  TextModel(
      {required this.name,
      required this.textStyle,
      required this.top,
      required this.isSelected,
      required this.textAlign,
      required this.scale,
      required this.left});
}
