import 'package:flutter/material.dart';

import 'option_button.dart';
import 'toolbar_action.dart';

class Toolbar extends StatefulWidget {
  final EditorToolbarAction initialTool;
  final Function(EditorToolbarAction) onToolSelect;

  const Toolbar({
    Key? key,
    this.initialTool = EditorToolbarAction.fontFamilyTool,
    required this.onToolSelect,
  }) : super(key: key);

  @override
  _ToolbarState createState() => _ToolbarState();
}

class _ToolbarState extends State<Toolbar> {
  late EditorToolbarAction _selectedAction;
  @override
  void initState() {
    _selectedAction = widget.initialTool;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OptionButton(
          isActive: _selectedAction == EditorToolbarAction.fontFamilyTool,
          child: const Icon(Icons.title),
          onPressed: () {
            setState(
                () => _selectedAction = EditorToolbarAction.fontFamilyTool);
            widget.onToolSelect(EditorToolbarAction.fontFamilyTool);
          },
        ),
        OptionButton(
          isActive: _selectedAction == EditorToolbarAction.fontOptionTool,
          child: const Icon(Icons.format_bold),
          onPressed: () {
            setState(
                () => _selectedAction = EditorToolbarAction.fontOptionTool);
            widget.onToolSelect(EditorToolbarAction.fontOptionTool);
          },
        ),
        OptionButton(
          isActive: _selectedAction == EditorToolbarAction.fontSizeTool,
          child: const Icon(Icons.format_size),
          onPressed: () {
            setState(() => _selectedAction = EditorToolbarAction.fontSizeTool);
            widget.onToolSelect(EditorToolbarAction.fontSizeTool);
          },
        ),
        OptionButton(
          isActive: _selectedAction == EditorToolbarAction.fontColorTool,
          child: const Icon(Icons.format_color_text),
          onPressed: () {
            setState(() => _selectedAction = EditorToolbarAction.fontColorTool);
            widget.onToolSelect(EditorToolbarAction.fontColorTool);
          },
        ),
        OptionButton(
          isActive: _selectedAction == EditorToolbarAction.backgroundColorTool,
          child: const Icon(Icons.format_color_fill),
          onPressed: () {
            setState(() =>
                _selectedAction = EditorToolbarAction.backgroundColorTool);
            widget.onToolSelect(EditorToolbarAction.backgroundColorTool);
          },
        ),
      ],
    );
  }
}
