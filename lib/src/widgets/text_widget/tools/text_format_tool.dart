import 'package:flutter/material.dart';
import 'package:stickereditor/src/widgets/text_widget/text_src/option_button.dart';

class TextFormatTool extends StatelessWidget {
  final Function(
    bool bold,
    bool italic,
  ) onTextFormatEdited;
  final Function(bool caps) onCpasLockTaggle;
  final Function(TextAlign textAlign) onTextAlignEdited;
  final TextAlign textAlign;
  final bool bold;
  final bool italic;
  final bool caps;

  const TextFormatTool({
    Key? key,
    required this.onTextFormatEdited,
    required this.onTextAlignEdited,
    required this.onCpasLockTaggle,
    this.textAlign = TextAlign.left,
    this.bold = false,
    this.italic = false,
    this.caps = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _TextFormatEditor(
            bold: bold,
            italic: italic,
            caps: caps,
            onFormatEdited: onTextFormatEdited,
            onCpasLockTaggle: onCpasLockTaggle,
          ),
          const SizedBox(height: 36),
          _TextAlignEditor(
            textAlign: textAlign,
            onTextAlignEdited: onTextAlignEdited,
          ),
        ],
      ),
    );
  }
}

class _TextAlignEditor extends StatefulWidget {
  final TextAlign textAlign;
  final Function(TextAlign textAlign) onTextAlignEdited;

  const _TextAlignEditor({
    required this.onTextAlignEdited,
    this.textAlign = TextAlign.left,
  });

  @override
  _TextAlignEditorState createState() => _TextAlignEditorState();
}

class _TextAlignEditorState extends State<_TextAlignEditor> {
  late TextAlign _textAlign;

  @override
  void initState() {
    _textAlign = widget.textAlign;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _TextAlignOption(
          icon: Icons.format_align_left,
          isActive: _textAlign == TextAlign.left,
          onPressed: () {
            setState(() => _textAlign = TextAlign.left);
            widget.onTextAlignEdited(_textAlign);
          },
        ),
        _TextAlignOption(
          icon: Icons.format_align_center,
          isActive: _textAlign == TextAlign.center,
          onPressed: () {
            setState(() => _textAlign = TextAlign.center);
            widget.onTextAlignEdited(_textAlign);
          },
        ),
        _TextAlignOption(
          icon: Icons.format_align_right,
          isActive: _textAlign == TextAlign.right,
          onPressed: () {
            setState(() => _textAlign = TextAlign.right);
            widget.onTextAlignEdited(_textAlign);
          },
        ),
        _TextAlignOption(
          icon: Icons.format_align_justify,
          isActive: _textAlign == TextAlign.justify,
          onPressed: () {
            setState(() => _textAlign = TextAlign.justify);
            widget.onTextAlignEdited(_textAlign);
          },
        ),
      ],
    );
  }
}

class _TextAlignOption extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  final bool isActive;

  const _TextAlignOption({
    required this.icon,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 32,
      icon: Icon(icon),
      color: isActive
          ? Theme.of(context).iconTheme.color
          : Theme.of(context).disabledColor,
      onPressed: onPressed,
    );
  }
}

class _TextFormatEditor extends StatefulWidget {
  final Function(bool bold, bool italic) onFormatEdited;
  final Function(bool caps) onCpasLockTaggle;
  final bool bold;
  final bool italic;
  final bool caps;

  const _TextFormatEditor({
    required this.onFormatEdited,
    required this.onCpasLockTaggle,
    this.bold = false,
    this.italic = false,
    this.caps = false,
  });

  @override
  _TextFormatEditorState createState() => _TextFormatEditorState();
}

class _TextFormatEditorState extends State<_TextFormatEditor> {
  late bool _bold;
  late bool _italic;
  late bool _caps;

  @override
  void initState() {
    _bold = widget.bold;
    _italic = widget.italic;
    _caps = widget.caps;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _TextFormatOption(
          title: 'BOLD',
          icon: Icons.format_bold,
          isActive: _bold,
          onPressed: () {
            setState(() => _bold = !_bold);
            widget.onFormatEdited(_bold, _italic);
          },
        ),
        _TextFormatOption(
          title: 'ITALIC',
          icon: Icons.format_italic,
          isActive: _italic,
          onPressed: () {
            setState(() => _italic = !_italic);
            widget.onFormatEdited(_bold, _italic);
          },
        ),
        _TextFormatOption(
          title: 'CAPS',
          icon: Icons.keyboard_capslock,
          isActive: _caps,
          onPressed: () {
            setState(() => _caps = !_caps);
            widget.onCpasLockTaggle(_caps);
          },
        ),
      ],
    );
  }
}

class _TextFormatOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onPressed;
  final bool isActive;

  const _TextFormatOption({
    required this.title,
    required this.icon,
    required this.onPressed,
    this.isActive = false,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OptionButton(
          isActive: isActive,
          onPressed: onPressed,
          child: Icon(icon),
        ),
        const SizedBox(height: 12),
        Text(title),
      ],
    );
  }
}
