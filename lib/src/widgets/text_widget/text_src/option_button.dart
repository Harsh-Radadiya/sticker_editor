import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final bool isActive;
  final Function() onPressed;
  final Widget child;
  final Size? size;

  const OptionButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.isActive = false,
    this.size,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tight(size ?? const Size(45, 45)),
      highlightColor: Theme.of(context).colorScheme.background,
      splashColor: Theme.of(context).colorScheme.background,
      fillColor: isActive ? Theme.of(context).colorScheme.background : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).colorScheme.surface),
      ),
      child: child,
      onPressed: onPressed,
    );
  }
}
