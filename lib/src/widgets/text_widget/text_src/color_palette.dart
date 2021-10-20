import 'package:flutter/material.dart';

class ColorPalette extends StatefulWidget {
  final Color? activeColor;
  final List<Color> colors;
  final Function(Color) onColorPicked;

  const ColorPalette({
    Key? key,
    this.activeColor,
    required this.onColorPicked,
    required this.colors,
  }) : super(key: key);

  @override
  _ColorPaletteState createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  late Color _activeColor;

  @override
  void initState() {
    _activeColor = widget.activeColor ?? widget.colors[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _activeColor = Colors.transparent;
                    widget.onColorPicked(Colors.transparent);
                  });
                },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(
                          color: Theme.of(context).colorScheme.onSurface)),
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                          image: AssetImage('assets/disable.png',
                              package: 'stickereditor'))),
                  // child: const Icon(Icons.remove_circle),
                ),
              ),
            ),
          ),
          ...widget.colors
              .map(
                (color) => _ColorHolder(
                  color: color,
                  active: color == _activeColor,
                  onTap: (color) {
                    setState(() => _activeColor = color);
                    widget.onColorPicked(color);
                  },
                ),
              )
              .toList()
        ],
      ),
    );
  }
}

class _ColorHolder extends StatelessWidget {
  final Color color;
  final Function(Color) onTap;
  final bool active;

  const _ColorHolder({
    required this.color,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: active
            ? Border.fromBorderSide(
                BorderSide(color: Theme.of(context).colorScheme.onSurface))
            : null,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () => onTap(color),
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              border: Border.fromBorderSide(
                  BorderSide(color: Theme.of(context).colorScheme.onSurface)),
              borderRadius: BorderRadius.circular(50),
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
