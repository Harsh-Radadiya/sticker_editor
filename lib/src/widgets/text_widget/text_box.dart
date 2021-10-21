import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:stickereditor/constants_value.dart';
import 'package:stickereditor/src/model/text_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';

import 'textstyle_editor.dart';

// ignore: must_be_immutable
class TextEditingBox extends StatefulWidget {
  // TextModel for your text
  final TextModel newText;

  /// Your widget should be move within this [boundWidth]
  final double boundWidth;

  /// Your widget should be move within this [boundHeight]
  final double boundHeight;

  /// For Visibility of editing border
  bool isSelected;

  /// Total Colors option that you want to give to user
  List<Color>? palletColor;

  /// Total Fonts option that you want to give to user
  final List<String> fonts;

  /// If you use onTap then you Have to manage IsSelected field in TextModel and [isSelected]
  final Function()? onTap;

  /// If you use onCancel then you Have to manage IsSelected field in TextModel and [isSelected]
  final Function()? onCancel;

  /// Create a [TextEditingBox] widget
  ///
  /// [TextModel] detail of your picture
  /// [onTap] callback function that called when you tap on [TextEditingBox]
  /// [onCancel] callback function that called when you tap on Cross icon in [TextEditingBox] border
  TextEditingBox(
      {Key? key,
      required this.newText,
      required this.boundWidth,
      required this.boundHeight,
      required this.fonts,
      this.isSelected = false,
      this.onCancel,
      this.onTap,
      this.palletColor})
      : super(key: key);

  @override
  _TextEditingBoxState createState() => _TextEditingBoxState();
}

class _TextEditingBoxState extends State<TextEditingBox> {
  TextAlign selectedtextAlign = TextAlign.left;
  String selectedtextToShare = "Happy ${weekDays[today - 1]}!";
  Offset deltaOffset = const Offset(0, 0);
  double angle = 0.0;
  List<Color>? _palletColor;
  @override
  void initState() {
    if (widget.palletColor != null) {
      if (widget.palletColor!.isEmpty) {
        _palletColor = [
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
      } else {
        _palletColor = widget.palletColor;
      }
    } else {
      _palletColor = [
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
    }
    if (widget.isSelected) {
      widget.isSelected = false;
      widget.newText.isSelected = false;
    } else {
      widget.isSelected = true;
      widget.newText.isSelected = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.newText.top,
      left: widget.newText.left,
      child: Transform.scale(
        scale: widget.newText.scale,
        child: Transform.rotate(
          angle: angle,
          child: GestureDetector(
            onScaleStart: (tap) {
              setState(() => deltaOffset = const Offset(0, 0));
            },
            onScaleUpdate: (tap) {
              setState(() {
                if (tap.pointerCount == 2) {
                  widget.newText.scale = tap.scale;
                  angle = tap.rotation;
                }
                if ((widget.newText.left + tap.delta.dx - deltaOffset.dx) <=
                        widget.boundWidth &&
                    (widget.newText.left + tap.delta.dx - deltaOffset.dx) > 0) {
                  widget.newText.left += tap.delta.dx - deltaOffset.dx;
                }
                if ((widget.newText.top + tap.delta.dy - deltaOffset.dy) <
                        widget.boundHeight &&
                    (widget.newText.top + tap.delta.dy - deltaOffset.dy) > 0) {
                  widget.newText.top += tap.delta.dy - deltaOffset.dy;
                }

                deltaOffset = tap.delta;
              });
            },
            onTap: () {
              if (widget.onTap == null) {
                setState(() {
                  if (widget.isSelected) {
                    widget.isSelected = false;
                    widget.newText.isSelected = false;
                  } else {
                    widget.isSelected = true;
                    widget.newText.isSelected = true;
                  }
                });
                if (widget.isSelected == true) {
                  textModelBottomSheet(
                      context: context,
                      newText: widget.newText,
                      palletColor: _palletColor!);
                }
              } else {
                widget.onTap!();
                if (widget.isSelected == false) {
                  textModelBottomSheet(
                      context: context,
                      newText: widget.newText,
                      palletColor: _palletColor!);
                }
              }
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DottedBorder(
                    color: widget.isSelected
                        ? Colors.grey[600]!
                        : Colors.transparent,
                    padding: const EdgeInsets.all(4),
                    child: Text(widget.newText.name,
                        style: widget.newText.textStyle,
                        textAlign: widget.newText.textAlign,
                        textScaleFactor: widget.newText.scale),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      if (widget.onCancel != null) {
                        widget.onCancel!();
                      }

                      setState(() {
                        if (widget.isSelected) {
                          widget.isSelected = false;
                          widget.newText.isSelected = false;
                        } else {
                          widget.isSelected = true;
                          widget.newText.isSelected = true;
                        }
                      });
                    },
                    child: widget.isSelected
                        ? Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: const Icon(Icons.cancel_outlined,
                                color: Colors.black, size: 17),
                          )
                        : Container(),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () async {
                      await showEditBox(
                        context: context,
                        textModel: widget.newText,
                      );
                    },
                    child: widget.isSelected
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                shape: BoxShape.circle,
                                color: Colors.white),
                            child: const Icon(Icons.edit,
                                color: Colors.black, size: 10),
                          )
                        : Container(),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: GestureDetector(
                    onScaleUpdate: (detail) {
                      setState(() => angle = detail.delta.direction);
                    },
                    child: widget.isSelected
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                shape: BoxShape.circle,
                                color: Colors.white),
                            child: const Icon(Icons.rotate_right,
                                color: Colors.black, size: 10),
                          )
                        : Container(),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onPanUpdate: (tap) {
                      if (tap.delta.dx.isNegative &&
                          widget.newText.scale > .8) {
                        setState(() => widget.newText.scale -= 0.01);
                      } else if (!tap.delta.dx.isNegative &&
                          widget.newText.scale < 5) {
                        setState(() => widget.newText.scale += 0.01);
                      }
                    },
                    child: widget.isSelected
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                color: Colors.white,
                                shape: BoxShape.circle),
                            child: const Icon(Icons.crop,
                                color: Colors.black, size: 10),
                          )
                        : Container(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Model Bottom sheet
  Future textModelBottomSheet(
      {required BuildContext context,
      required TextModel newText,
      required List<Color> palletColor}) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return showModalBottomSheet(
        elevation: 15,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(4),
            height: height * .35,
            child: TextStyleEditor(
              fonts: widget.fonts,
              paletteColors: palletColor,
              textStyle: newText.textStyle,
              textAlign: newText.textAlign,
              onTextAlignEdited: (align) {
                setState(() => newText.textAlign = align);
              },
              onTextStyleEdited: (style) {
                setState(
                    () => newText.textStyle = newText.textStyle.merge(style));
              },
              onCpasLockTaggle: (caps) {},
            ),
          );
        });
  }

  // Text edit dailog box
  Future showEditBox({BuildContext? context, TextModel? textModel}) {
    return showDialog(
        context: context!,
        builder: (context) {
          final dailogTextController =
              TextEditingController(text: selectedtextToShare);
          return AlertDialog(
            backgroundColor: const Color.fromARGB(240, 200, 200, 200),
            title: const Text('Edit Text'),
            content: TextField(
                controller: dailogTextController,
                maxLines: 6,
                minLines: 1,
                autofocus: true,
                decoration: InputDecoration(hintText: selectedtextToShare)),
            actions: [
              ElevatedButton(
                child: const Text('Done'),
                onPressed: () {
                  setState(
                      () => widget.newText.name = dailogTextController.text);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
