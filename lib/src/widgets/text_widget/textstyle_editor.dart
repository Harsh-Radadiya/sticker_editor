import 'package:flutter/material.dart';

import 'text_src/color_palette.dart';
import 'text_src/toolbar.dart';
import 'text_src/toolbar_action.dart';
import 'tools/background_color_tool.dart';
import 'tools/font_family_tool.dart';
import 'tools/font_size_tool.dart';
import 'tools/text_format_tool.dart';

/// Text style editor
/// A flutter widget that edit text style and text alignment
///
/// You can pass your text style or alignment to the widget
/// and then get the edited text style
class TextStyleEditor extends StatefulWidget {
  /// Editor's font families
  final List<String> fonts;

  /// The text style
  final TextStyle textStyle;

  /// The text alignment
  final TextAlign textAlign;

  /// The inithial editor tool
  final EditorToolbarAction initialTool;

  /// Editor's palette colors
  final List<Color>? paletteColors;

  /// [onTextStyleEdited] will be called after [textStyle] prop has changed
  final Function(TextStyle)? onTextStyleEdited;

  /// [onTextAlignEdited] will be called after [textAlingment] prop has changed
  final Function(TextAlign)? onTextAlignEdited;

  /// [onCpasLockTaggle] will be called after caps lock has changed
  final Function(bool)? onCpasLockTaggle;

  /// [onToolbarActionChanged] will be called after editor's tool has changed
  final Function(EditorToolbarAction)? onToolbarActionChanged;

  /// Create a [TextStyleEditor] widget
  ///
  /// [fonts] list of font families that you want to use in editor.
  /// [textStyle] initiate text style.
  /// [textAlign] initiate text alignment.
  ///
  /// [onTextStyleEdited] callback will be called every time [textStyle] has changed.
  /// [onTextAlignEdited] callback will be called every time [textAlign] has changed.
  /// [onCpasLockTaggle] callback will be called every time caps lock has changed to off or on.
  /// [onToolbarActionChanged] callback will be called every time editor's tool has changed.
  const TextStyleEditor({
    Key? key,
    required this.fonts,
    required this.textStyle,
    required this.textAlign,
    this.paletteColors,
    this.initialTool = EditorToolbarAction.fontFamilyTool,
    this.onTextStyleEdited,
    this.onTextAlignEdited,
    this.onCpasLockTaggle,
    this.onToolbarActionChanged,
  }) : super(key: key);

  @override
  _TextStyleEditorState createState() => _TextStyleEditorState();
}

class _TextStyleEditorState extends State<TextStyleEditor> {
  late EditorToolbarAction _currentTool;
  late TextStyle _textStyle;
  late TextAlign _textAlign;
  late List<Color> _paletteColors;

  @override
  void initState() {
    _currentTool = widget.initialTool;
    _textStyle = widget.textStyle;
    _textAlign = widget.textAlign;

    // Set default palette's colors
    _paletteColors = widget.paletteColors ??
        [
          Colors.black,
          Colors.white,
          Colors.red,
          Colors.blue,
          Colors.blueAccent,
          Colors.brown,
          Colors.green,
          Colors.indigoAccent,
          Colors.lime,
        ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Toolbar(
          initialTool: _currentTool,
          onToolSelect: (action) {
            setState(() => _currentTool = action);
            if (widget.onToolbarActionChanged != null) {
              widget.onToolbarActionChanged!(action);
            }
          },
        ),
        const Divider(),
        Expanded(
          child: SingleChildScrollView(
            child: () {
              // Choice tools
              switch (_currentTool) {
                case EditorToolbarAction.fontFamilyTool:
                  return FontFamilyTool(
                    fonts: widget.fonts,
                    selectedFont: _textStyle.fontFamily,
                    onSelectFont: (fontFamily) {
                      setState(() => _textStyle =
                          _textStyle.copyWith(fontFamily: fontFamily));

                      if (widget.onTextStyleEdited != null) {
                        widget.onTextStyleEdited!(_textStyle);
                      }
                    },
                  );
                case EditorToolbarAction.fontOptionTool:
                  return TextFormatTool(
                    bold: _textStyle.fontWeight == FontWeight.bold,
                    italic: _textStyle.fontStyle == FontStyle.italic,
                    textAlign: _textAlign,
                    onTextFormatEdited: (bold, italic) {
                      setState(() => _textStyle = _textStyle.copyWith(
                            fontWeight:
                                bold ? FontWeight.bold : FontWeight.normal,
                            fontStyle:
                                italic ? FontStyle.italic : FontStyle.normal,
                          ));

                      if (widget.onTextStyleEdited != null) {
                        widget.onTextStyleEdited!(_textStyle);
                      }
                    },
                    onTextAlignEdited: (align) {
                      setState(() => _textAlign = align);

                      if (widget.onTextAlignEdited != null) {
                        widget.onTextAlignEdited!(align);
                      }
                    },
                    onCpasLockTaggle: (caps) {
                      if (widget.onCpasLockTaggle != null) {
                        widget.onCpasLockTaggle!(caps);
                      }
                    },
                  );
                case EditorToolbarAction.fontSizeTool:
                  return FontSizeTool(
                    fontSize: _textStyle.fontSize ?? 0,
                    letterHeight: _textStyle.height ?? 1.2,
                    letterSpacing: _textStyle.letterSpacing ?? 1,
                    onFontSizeEdited: (
                      fontSize,
                      letterSpacing,
                      letterHeight,
                    ) {
                      setState(() => _textStyle = _textStyle.copyWith(
                            fontSize: fontSize,
                            height: letterHeight,
                            letterSpacing: letterSpacing,
                          ));

                      if (widget.onTextStyleEdited != null) {
                        widget.onTextStyleEdited!(_textStyle);
                      }
                    },
                  );
                case EditorToolbarAction.fontColorTool:
                  return BackgroundColorTool(
                    activeColor: _textStyle.color,
                    colors: _paletteColors,
                    onColorPicked: (color) {
                      setState(
                          () => _textStyle = _textStyle.copyWith(color: color));

                      if (widget.onTextStyleEdited != null) {
                        widget.onTextStyleEdited!(_textStyle);
                      }
                    },
                  );
                case EditorToolbarAction.backgroundColorTool:
                  return ColorPalette(
                    activeColor: _textStyle.backgroundColor,
                    colors: _paletteColors,
                    onColorPicked: (color) {
                      setState(() => _textStyle =
                          _textStyle.copyWith(backgroundColor: color));

                      if (widget.onTextStyleEdited != null) {
                        widget.onTextStyleEdited!(_textStyle);
                      }
                    },
                  );

                default:
                  return Container();
              }
            }(),
          ),
        ),
      ],
    );
  }
}
