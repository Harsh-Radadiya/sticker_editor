import 'package:flutter/material.dart';
import 'package:stickereditor/src/widgets/text_widget/text_src/color_palette.dart';

class FontColorTool extends StatelessWidget {
  final List<Color> colors;
  final Color? activeColor;
  final Function(Color) onColorPicked;

  const FontColorTool({Key? key, 
    required this.colors,
    required this.onColorPicked,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorPalette(
      activeColor: activeColor,
      onColorPicked: onColorPicked,
      colors: colors,
    );
  }
}
